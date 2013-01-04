From: "Pyeron, Jason J CTR (US)" <jason.j.pyeron.ctr@mail.mil>
Subject: RE: Lockless Refs?  (Was [PATCH] refs: do not use cached refs in
 repack_without_ref)
Date: Fri, 4 Jan 2013 17:52:43 +0000
Message-ID: <871B6C10EBEFE342A772D1159D1320853A011469@umechphj.easf.csd.disa.mil>
References: <20121221080449.GA21741@sigill.intra.peff.net>
 <201212271611.52203.mfick@codeaurora.org>
 <201212310330.53835.mfick@codeaurora.org>
 <201301031652.44982.mfick@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
	micalg=SHA1; boundary="----=_NextPart_000_0043_01CDEA79.DBCEFBD0"
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 04 18:52:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrBRa-0004rf-Ve
	for gcvg-git-2@plane.gmane.org; Fri, 04 Jan 2013 18:52:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755283Ab3ADRwN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2013 12:52:13 -0500
Received: from edge-mech.mail.mil ([214.21.82.11]:33277 "EHLO
	edge-mech.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755238Ab3ADRwK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2013 12:52:10 -0500
Received: from umechpja.easf.csd.disa.mil (214.21.83.154) by
 umechpjj.easf.csd.disa.mil (214.21.82.11) with Microsoft SMTP Server (TLS) id
 14.2.309.2; Fri, 4 Jan 2013 17:52:44 +0000
Received: from UMECHPHJ.easf.csd.disa.mil ([169.254.5.12]) by
 UMECHPJA.easf.csd.disa.mil ([214.21.83.154]) with mapi id 14.02.0309.003;
 Fri, 4 Jan 2013 17:52:44 +0000
Thread-Topic: Lockless Refs?  (Was [PATCH] refs: do not use cached refs in
 repack_without_ref)
Thread-Index: AQHN5IfBlcBbO6vu/kSQnS40HNOdaJgyusKAgAWXBwCAASxKgA==
In-Reply-To: <201301031652.44982.mfick@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [214.21.83.188]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212634>

------=_NextPart_000_0043_01CDEA79.DBCEFBD0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit

> From: Martin Fick
> Sent: Thursday, January 03, 2013 6:53 PM
> 
> Any thoughts on this idea?  Is it flawed?  I am trying to
> write it up in a more formal generalized manner and was
> hoping to get at least one "it seems sane" before I do.

If you are assuming that atomic renames, etc. are available, then you should identify a test case and a degrade operation path when it is not available.

> 
> Thanks,
> 
> -Martin
> 
> On Monday, December 31, 2012 03:30:53 am Martin Fick wrote:
> > On Thursday, December 27, 2012 04:11:51 pm Martin Fick
> wrote:
> > > It concerns me that git uses any locking at all, even
> > > for refs since it has the potential to leave around
> > > stale locks.
> > > ...
> > > [a previous not so great attempt to fix this]
> > > ...
> >
> > I may have finally figured out a working loose ref update
> > mechanism which I think can avoid stale locks.
> > Unfortunately it requires atomic directory renames and
> > universally unique identifiers (uuids).  These may be
> > no-go criteria?  But I figure it is worth at least
> > exploring this idea because of the potential benefits?
> >
> > The general approach is to setup a transaction and either
> > commit or abort it.  A transaction can be setup by
> > renaming an appropriately setup directory to the
> > "ref.lock" name.  If the rename succeeds, the transaction
> > is begun.  Any actor can abort the transaction (up until
> > it is committed) by simply deleting the "ref.lock"
> > directory, so it is not at risk of going stale.  However,
> > once the actor who sets up the transaction commits it,
> > deleting the "ref.lock" directory simply aids in cleaning
> > it up for the next transaction (instead of aborting it).
> >
> > One important piece of the transaction is the use of
> > uuids. The uuids provide a mechanism to tie the atomic
> > commit pieces to the transactions and thus to prevent
> > long sleeping process from inadvertently performing
> > actions which could be out of date when they wake finally
> > up.  In each case, the atomic commit piece is the
> > renaming of a file.   For the create and update pieces, a
> > file is renamed from the "ref.lock" dir to the "ref" file
> > resulting in an update to the sha for the ref. However,
> > in the delete case, the "ref" file is instead renamed to
> > end up in the "ref.lock" directory resulting in a delete
> > of the ref.  This scheme does not affect the way refs are
> > read today,
> >
> > To prepare for a transaction, an actor first generates a
> > uuid (an exercise I will delay for now).  Next, a tmp
> > directory named after the uuid is generated in the parent
> > directory for the ref to be updated, perhaps something
> > like:  ".lock_uuid". In this directory is places either a
> > file or a directory named after the uuid, something like:
> > ".lock_uuid/,uuid".  In the case of a create or an
> > update, the new sha is written to this file.  In the case
> > of a delete, it is a directory.
> >
> > Once the tmp directory is setup, the initiating actor
> > attempts to start the transaction by renaming the tmp
> > directory to "ref.lock".  If the rename fails, the update
> > fails. If the rename succeeds, the actor can then attempt
> > to commit the transaction (before another actor aborts
> > it).
> >
> > In the case of a create, the actor verifies that "ref"
> > does not currently exist, and then renames the now named
> > "ref.lock/uuid" file to "ref". On success, the ref was
> > created.
> >
> > In the case of an update, the actor verifies that "ref"
> > currently contains the old sha, and then also renames the
> > now named "ref.lock/uuid" file to "ref". On success, the
> > ref was updated.
> >
> > In the case of a delete, the actor may verify that "ref"
> > currently contains the sha to "prune" if it needs to, and
> > then renames the "ref" file to "ref.lock/uuid/delete". On
> > success, the ref was deleted.
> >
> > Whether successful or not, the actor may now simply delete
> > the "ref.lock" directory, clearing the way for a new
> > transaction.  Any other actor may delete this directory at
> > any time also, likely either on conflict (if they are
> > attempting to initiate a transaction), or after a grace
> > period just to cleanup the FS.  Any actor may also safely
> > cleanup the tmp directories, preferably also after a grace
> > period.
> >
> > One neat part about this scheme is that I believe it would
> > be backwards compatible with the current locking
> > mechanism since the transaction directory will simply
> > appear to be a lock to older clients.  And the old lock
> > file should continue to lock out these newer
> > transactions.
> >
> > Due to this backwards compatibility, I believe that this
> > could be incrementally employed today without affecting
> > very much.  It could be deployed in place of any updates
> > which only hold ref.locks to update the loose ref.  So
> > for example I think it could replace step 4a below from
> > Michael Haggerty's description of today's loose ref
> > pruning during
> >
> > ref packing:
> > > * Pack references:
> > ...
> >
> > > 4. prune_refs(): for each ref in the ref_to_prune list,
> > >
> > > call  prune_ref():
> > >     a. Lock the reference using lock_ref_sha1(),
> > >     verifying that the recorded SHA1 is still valid.  If
> > >     it is, unlink the loose reference file then free
> > >     the lock; otherwise leave the loose reference file
> > >     untouched.
> >
> > I think it would also therefore be able to replace the
> > loose ref locking in Michael's new ref-packing scheme as
> > well as the locking in Michael's new ref deletion scheme
> > (again steps
> >
> > 4):
> > > * Delete reference foo:
> > ...
> >
> > >   4. Delete loose ref for "foo":
> > >      a. Acquire the lock $GIT_DIR/refs/heads/foo.lock
> > >
> > >      b. Unlink $GIT_DIR/refs/heads/foo if it is
> > >      unchanged.
> > >
> > >  If it is changed, leave it untouched.  If it is
> > >  deleted,
> > >
> > > that is OK too.
> > >
> > >      c. Release lock $GIT_DIR/refs/heads/foo.lock
> >
> > ...
> >
> > > * Pack references:
> > ...
> >
> > >   4. prune_refs(): for each ref in the ref_to_prune
> > >   list,
> > >
> > > call prune_ref():
> > >      a. Lock the loose reference using lock_ref_sha1(),
> > >
> > > verifying that the recorded SHA1 is still valid
> > >
> > >      b. If it is, unlink the loose reference file
> > >
> > > (otherwise, leave it untouched)
> > >
> > >      c. Release the lock on the loose reference
> >
> > To be honest, I suspect I missed something obvious because
> > this seems almost too simple to work.  I am ashamed that
> > it took me so long to come up with (of course, I will be
> > even more ashamed :( when it is shown to be flawed!)
> > This scheme also feels extensible. if there are no
> > obvious flaws in it, I will try to post solutions for ref
> > packing and for multiple repository/ref transactions also
> > soon.
> >
> > I welcome any comments/criticisms,
> >
> > -Martin
> > --
> > To unsubscribe from this list: send the line "unsubscribe
> > git" in the body of a message to
> > majordomo@vger.kernel.org More majordomo info at
> > http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

------=_NextPart_000_0043_01CDEA79.DBCEFBD0
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIISfzCCA3Aw
ggJYoAMCAQICAQUwDQYJKoZIhvcNAQEFBQAwWzELMAkGA1UEBhMCVVMxGDAWBgNVBAoTD1UuUy4g
R292ZXJubWVudDEMMAoGA1UECxMDRG9EMQwwCgYDVQQLEwNQS0kxFjAUBgNVBAMTDURvRCBSb290
IENBIDIwHhcNMDQxMjEzMTUwMDEwWhcNMjkxMjA1MTUwMDEwWjBbMQswCQYDVQQGEwJVUzEYMBYG
A1UEChMPVS5TLiBHb3Zlcm5tZW50MQwwCgYDVQQLEwNEb0QxDDAKBgNVBAsTA1BLSTEWMBQGA1UE
AxMNRG9EIFJvb3QgQ0EgMjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMAswfaNO6z/
PzzWcb64dCIH7HBBFfyrQOMHqsHD2J/+2kw6vz/I2Ch7SzYBwKxFJcPSDgqPhRhkED0aE3Aqb47X
3I2Ts0EPOCHNravCPSoF01cRNw3NjFH5k+PMRkkhjhS0zcsUPjjNcjHuqxLyZeo0LlZd/+5jdctt
upE0/J7z9C0cvlDEQt9ZiP9qs/qobD3LVnFxBZa7n4DlgEVZZ0Gw68OtYKSAdQYXnA70Q+CZDhv7
f/WzzLKBgrH9MsG4vkGkZLVgOlpRMIzO3kEsGUdcSRBkuXSph0GvfW66wbihv2UxOgRn+bW7jpKK
AGO4seaMOF+D/1DVO6Jda7IQzGMCAwEAAaM/MD0wHQYDVR0OBBYEFEl0uwxeunr+AlTve6DGlcYJ
gHCWMAsGA1UdDwQEAwIBhjAPBgNVHRMBAf8EBTADAQH/MA0GCSqGSIb3DQEBBQUAA4IBAQCYkY0/
ici79cBpcyk7Nay6swh2PXAJkumERCEBfRR2G+5RbB2NFTctezFp9JpEuK9GzDT6I8sDJxnSgyF1
K+fgG5km3IRAleio0sz2WFxm7z9KlxCCHboKot1bBiudp2RO6y4BNaS0PxOtVeTVc6hpmxHxmPIx
Hm9A1Ph4n46RoG9wBJBmqgYrzuF6krV94eDRluehOi3MsZ0fBUTth5nTTRpwOcEEDOV+2fGv1yAO
8SJ6JaRzmcw/pAcnlqiile2CuRbTnguHwsHyiPVi32jfx7xpUe2xXNxUVCkPCTmarAPB2wxNrm8K
ehZJ8b+R0jiU0/aVLLdsyUK2jcqQjYXZMIIEsTCCA5mgAwIBAgIDItsRMA0GCSqGSIb3DQEBBQUA
MF0xCzAJBgNVBAYTAlVTMRgwFgYDVQQKEw9VLlMuIEdvdmVybm1lbnQxDDAKBgNVBAsTA0RvRDEM
MAoGA1UECxMDUEtJMRgwFgYDVQQDEw9ET0QgRU1BSUwgQ0EtMzAwHhcNMTIxMDMxMDAwMDAwWhcN
MTMxMDE2MjM1OTU5WjB8MQswCQYDVQQGEwJVUzEYMBYGA1UEChMPVS5TLiBHb3Zlcm5tZW50MQww
CgYDVQQLEwNEb0QxDDAKBgNVBAsTA1BLSTETMBEGA1UECxMKQ09OVFJBQ1RPUjEiMCAGA1UEAxMZ
UFlFUk9OLkpBU09OLkouMTI5MTE0NzcxOTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEB
AMTucq9WguqSQd8yTE9X+QQggJ6szuAKjN3OgUhvt5VzV3fHmjxf6gZ6VkzR+QBX/nFwgh2lIrMN
c39FQ28m7UMlmnKo8slM7Y78izNROGDuAM2LwvANFGJ/amRNOyepBVjmzSTHMTzH3aseRRRMCw+C
XTt8Vg51BcMz96L+U0boDeO5X33s/DT74UJ0nUrQKxwCfzqR5O9/z/LpFV2ALcNm/ttiJeU26FAp
DnIq4TQGHn4/DLnJdcuNg4I/fu2M1LazISXogoC7rhX/qvz0rf6wQUv6L4B5hcH8XBxCdSmSd2+U
a122ZNhyEPgIDxwT1lUah7je5stFs+Pgo6MqLpUCAwEAAaOCAVkwggFVMB8GA1UdIwQYMBaAFDVh
ZigJvFYlW4vMv4FeYSwwOdMhMDoGA1UdHwQzMDEwL6AtoCuGKWh0dHA6Ly9jcmwuZGlzYS5taWwv
Y3JsL0RPREVNQUlMQ0FfMzAuY3JsMA4GA1UdDwEB/wQEAwIFIDAjBgNVHSAEHDAaMAsGCWCGSAFl
AgELCTALBglghkgBZQIBCxMwHQYDVR0OBBYEFBdBDT69m6y6DbxTcytWNG4snBcWMGgGCCsGAQUF
BwEBBFwwWjA2BggrBgEFBQcwAoYqaHR0cDovL2NybC5kaXNhLm1pbC9zaWduL0RPREVNQUlMQ0Ff
MzAuY2VyMCAGCCsGAQUFBzABhhRodHRwOi8vb2NzcC5kaXNhLm1pbDAbBgNVHREEFDASgRBqcHll
cm9uQHBkaW5jLnVzMBsGA1UdCQQUMBIwEAYIKwYBBQUHCQQxBBMCVVMwDQYJKoZIhvcNAQEFBQAD
ggEBAF9wRrj6n+lHeZjOh/9k1O6mnQWD/Rp8Nh3wo5xRS03UQiNFQY5GEd+FF2ZheeWZQvmnfgnT
1LcA1bSsfYj9thRJaG3sHdOfVZSdAwsewoadYHIKEPS4dArCE3L7RowT0qLXG5+ef8On3m0udhlw
aMjgVpW5twl1ONDR5+BpRO4X6h1SWck6QOI7qR8/FBJjQRsRGhBkxTLmOMcFhl+NyfDCSst3GKjv
rp81//x4HhSesfPg7qYbtWI5pk2N/Berh2SKWpdwVlOOC0v0gYaHGTRrITyrpFZI86BHn7fIObwe
die80InGfXmjalT25cyGjJyYuQl4FSFmzgOSLbWBLnkwggT8MIID5KADAgECAgMi2w4wDQYJKoZI
hvcNAQEFBQAwXTELMAkGA1UEBhMCVVMxGDAWBgNVBAoTD1UuUy4gR292ZXJubWVudDEMMAoGA1UE
CxMDRG9EMQwwCgYDVQQLEwNQS0kxGDAWBgNVBAMTD0RPRCBFTUFJTCBDQS0zMDAeFw0xMjEwMzEw
MDAwMDBaFw0xMzEwMTYyMzU5NTlaMHwxCzAJBgNVBAYTAlVTMRgwFgYDVQQKEw9VLlMuIEdvdmVy
bm1lbnQxDDAKBgNVBAsTA0RvRDEMMAoGA1UECxMDUEtJMRMwEQYDVQQLEwpDT05UUkFDVE9SMSIw
IAYDVQQDExlQWUVST04uSkFTT04uSi4xMjkxMTQ3NzE5MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8A
MIIBCgKCAQEAsp1wMFihSoBi//dttUG9IFChK61Vcf6VfgsNsbJzaMKd/niw63SuuOZfDMuAxNN9
LwQn4zpgWG8bYPRlv8CvFyQzP1eLZuGEWHt/yToILsKfE13kHKLNLykbefOFfdzSIG3ZBHD1c1dn
hSKn3raYVxrkDJVT3BfZXIPqNgxKZE0vZgjOH7t9MmzY4oJQ+5jF70w9y7JspHCDmvkL1xG8cBcC
sbKAzpxqsJYSdgMJRoOuAgTVEf96gHpWux58zLLaIT/BqqsZ5uhVmZICOl8aPiGVoffXV2QrG0KX
6DtRvIyDSNssXHaiyO/c+/ujo+LJLggbSXSQKA+1zlUx+FGz2QIDAQABo4IBpDCCAaAwHwYDVR0j
BBgwFoAUNWFmKAm8ViVbi8y/gV5hLDA50yEwOgYDVR0fBDMwMTAvoC2gK4YpaHR0cDovL2NybC5k
aXNhLm1pbC9jcmwvRE9ERU1BSUxDQV8zMC5jcmwwDgYDVR0PAQH/BAQDAgbAMCMGA1UdIAQcMBow
CwYJYIZIAWUCAQsJMAsGCWCGSAFlAgELEzAdBgNVHQ4EFgQUM3GHPTQkuRGIhT+/FQiOQVQcVdgw
aAYIKwYBBQUHAQEEXDBaMDYGCCsGAQUFBzAChipodHRwOi8vY3JsLmRpc2EubWlsL3NpZ24vRE9E
RU1BSUxDQV8zMC5jZXIwIAYIKwYBBQUHMAGGFGh0dHA6Ly9vY3NwLmRpc2EubWlsMDsGA1UdEQQ0
MDKBEGpweWVyb25AcGRpbmMudXOgHgYKKwYBBAGCNxQCA6AQDA4xMjkxMTQ3NzE5QG1pbDAbBgNV
HQkEFDASMBAGCCsGAQUFBwkEMQQTAlVTMCkGA1UdJQQiMCAGCisGAQQBgjcUAgIGCCsGAQUFBwMC
BggrBgEFBQcDBDANBgkqhkiG9w0BAQUFAAOCAQEADS5wnQsNfn3I/Q6QR61tF/JB6IlWh0N9bHQ1
aFsoyKyg+doMYvA2chufOTNOK6+ptZp3gukb84LnaJZFzWssD/D3v3TiipJsQThTm/PwwLfS8dw3
1+4Lyo6w/iEpwZHklvTP2UCoMOL3ZK9x/5KtLKDfIAh4+V6h0xiXxodpTAgUyQhXOSRIUn5nHsNK
5cjWHNVGSSX/qnkIRapHFHdikZfgSlxCfmNjOJUAp0u1uCu1czqmjfifnRM7Zc9Gxcqt1jWUS1nS
aeMINrw6E+0o33cF0Y3khSxhHajKqY0AozHShZLzzDtb6pF2GtVrzDcg5eipCpVViH6bG9fyaarn
9zCCBVIwggQ6oAMCAQICAgG5MA0GCSqGSIb3DQEBBQUAMFsxCzAJBgNVBAYTAlVTMRgwFgYDVQQK
Ew9VLlMuIEdvdmVybm1lbnQxDDAKBgNVBAsTA0RvRDEMMAoGA1UECxMDUEtJMRYwFAYDVQQDEw1E
b0QgUm9vdCBDQSAyMB4XDTExMDkwODE2MDMwOFoXDTE3MDkwODE2MDMwOFowXTELMAkGA1UEBhMC
VVMxGDAWBgNVBAoTD1UuUy4gR292ZXJubWVudDEMMAoGA1UECxMDRG9EMQwwCgYDVQQLEwNQS0kx
GDAWBgNVBAMTD0RPRCBFTUFJTCBDQS0zMDCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEB
AOYpItQUJtGYGlJexYSDc37BYLOz0JS+/RyUVb/2hCybycB0c+/MwpnymcltyhTTdP++EPL3Lb/L
uwaj7phQQWUB4VcstsvkyhysflI0DrGOByY+MjWvo2EKxeUIthJ5jFTBeunxUB9dgzpnMLMp2x06
TDkhUNgYLI0Gde5jcnhorWKcdaSUBtMyaxKvBgcpvhOgwKfwJU+3/h+3V+AYEo0hahW5WlT7d2XY
TD/1ujzAN+EGfsK+niOMKNGa18ZnONdzyb0HHYVv1ZUKmtzaOk4o8KXrCd/l2wvNR6+KzbtvlEDj
WZxQn8kOqXECudzpaYA6iTtFBSIYBYS1EvA8wIECAwEAAaOCAhwwggIYMA4GA1UdDwEB/wQEAwIB
hjAfBgNVHSMEGDAWgBRJdLsMXrp6/gJU73ugxpXGCYBwljAdBgNVHQ4EFgQUNWFmKAm8ViVbi8y/
gV5hLDA50yEwEgYDVR0TAQH/BAgwBgEB/wIBADAMBgNVHSQEBTADgAEAMGYGA1UdIARfMF0wCwYJ
YIZIAWUCAQsFMAsGCWCGSAFlAgELCTALBglghkgBZQIBCxEwCwYJYIZIAWUCAQsSMAsGCWCGSAFl
AgELEzAMBgpghkgBZQMCAQMaMAwGCmCGSAFlAwIBAxswNwYDVR0fBDAwLjAsoCqgKIYmaHR0cDov
L2NybC5kaXNhLm1pbC9jcmwvRE9EUk9PVENBMi5jcmwwggEBBggrBgEFBQcBAQSB9DCB8TA6Bggr
BgEFBQcwAoYuaHR0cDovL2NybC5kaXNhLm1pbC9pc3N1ZWR0by9ET0RST09UQ0EyX0lULnA3YzAg
BggrBgEFBQcwAYYUaHR0cDovL29jc3AuZGlzYS5taWwwgZAGCCsGAQUFBzAChoGDbGRhcDovL2Ny
bC5nZHMuZGlzYS5taWwvY24lM2REb0QlMjBSb290JTIwQ0ElMjAyJTJjb3UlM2RQS0klMmNvdSUz
ZERvRCUyY28lM2RVLlMuJTIwR292ZXJubWVudCUyY2MlM2RVUz9jcm9zc0NlcnRpZmljYXRlUGFp
cjtiaW5hcnkwDQYJKoZIhvcNAQEFBQADggEBAAqIVhylVyZaYst10N2GxVLiL/O8EWQ/jC8+EfyY
YEDygA0ogppo/uBISyfTOgp7lfYDDIEUkUI6YGziK1Mt7N8RrvVUF/AB+ZcHp5urC9usl4kJxu/5
BzQWAKh+EVOefC+hOKKZeTk0QW59uFgwVoie5KpkRdmgRGI6t+Ux05GA8RsQsmdw1VurWbRaSBZC
xAJM2mxoylAdMb43mcfPU8xCKVbDnRfKA+cQWvE5PBzM+xuXCibzMd/gq1wknZ7eOH0CUWdG+ZNw
he0KVcL0wWhanwjJHXubdtxU7zmMGOUMRO73BrIf9cvmDr3Uof/U+ZEHIlJ5t8D97LL4hfRE+1wx
ggMyMIIDLgIBATBkMF0xCzAJBgNVBAYTAlVTMRgwFgYDVQQKEw9VLlMuIEdvdmVybm1lbnQxDDAK
BgNVBAsTA0RvRDEMMAoGA1UECxMDUEtJMRgwFgYDVQQDEw9ET0QgRU1BSUwgQ0EtMzACAyLbDjAJ
BgUrDgMCGgUAoIIBozAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0x
MzAxMDQxNzQ4NTZaMCMGCSqGSIb3DQEJBDEWBBT2EQMqgbeQzIWb5cusyeVKTpQ4ezBYBgkqhkiG
9w0BCQ8xSzBJMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDAHBgUrDgMCBzANBggqhkiG9w0D
AgIBKDAHBgUrDgMCGjAKBggqhkiG9w0CBTBzBgkrBgEEAYI3EAQxZjBkMF0xCzAJBgNVBAYTAlVT
MRgwFgYDVQQKEw9VLlMuIEdvdmVybm1lbnQxDDAKBgNVBAsTA0RvRDEMMAoGA1UECxMDUEtJMRgw
FgYDVQQDEw9ET0QgRU1BSUwgQ0EtMzACAyLbETB1BgsqhkiG9w0BCRACCzFmoGQwXTELMAkGA1UE
BhMCVVMxGDAWBgNVBAoTD1UuUy4gR292ZXJubWVudDEMMAoGA1UECxMDRG9EMQwwCgYDVQQLEwNQ
S0kxGDAWBgNVBAMTD0RPRCBFTUFJTCBDQS0zMAIDItsRMA0GCSqGSIb3DQEBAQUABIIBADeqnFkq
PX+APe0IM+5B3a6OGgWQbjKaVQQy3OxqiTCQc49CRagJw2Ecjk8gbUn2yTtsfeBm5tMH1zk0I+4W
k6RsovW8ueL7eVnnPMuiV9qlvoBcHR9oUQrmlC4mvm0cTVMvSWKhwXFHGMV4gmURvm08/WaiJG10
M4OM1mo4lN36T96Xmd1BuIDhc8cgW0H7FnEHcoV2Wni+h2ZAY/6nj7EDAkTQRizjzQTlfSv8cfKH
6u8DxmXY2pDf7zqRYkw6BpIuhTsepZKEUE1I/sk5ZYQFbHdTXcGFoYoRWsCDiOF8jYrUcNzOIhkY
J3BV0NeBfqW8dXKaoKmQyFm0ik5hsfYAAAAAAAA=

------=_NextPart_000_0043_01CDEA79.DBCEFBD0--
