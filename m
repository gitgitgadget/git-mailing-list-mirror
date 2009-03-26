From: David Reitter <david.reitter@gmail.com>
Subject: Re: Importing Bzr revisions
Date: Wed, 25 Mar 2009 23:05:20 -0400
Message-ID: <055EE409-55A1-458F-883D-63CA76B991E3@gmail.com>
References: <90DBD254-1810-4B11-AA9F-C5661A028FA5@gmail.com>
	<7veiwo8xz7.fsf@gitster.siamese.dyndns.org>
	<03AC7EDA-2A9F-4626-A67B-CE9F2A88FC7D@gmail.com>
	<87zlfcz62g.fsf@iki.fi>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: multipart/signed; boundary=Apple-Mail-1--116000872; micalg=sha1;
	protocol="application/pkcs7-signature"
Cc: bazaar@lists.canonical.com, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Teemu Likonen <tlikonen@iki.fi>
X-From: bazaar-bounces@lists.canonical.com Thu Mar 26 04:07:05 2009
Return-path: <bazaar-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from chlorine.canonical.com ([91.189.94.204])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lmfvt-00082P-Cp
	for gcvbg-bazaar-ng@m.gmane.org; Thu, 26 Mar 2009 04:07:05 +0100
Received: from localhost ([127.0.0.1] helo=chlorine.canonical.com)
	by chlorine.canonical.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-bounces@lists.canonical.com>)
	id 1LmfuO-0003KC-Jx; Thu, 26 Mar 2009 03:05:32 +0000
Received: from mail-ew0-f179.google.com ([209.85.219.179])
	by chlorine.canonical.com with esmtp (Exim 4.60)
	(envelope-from <david.reitter@gmail.com>) id 1LmfuJ-0003Jp-Ry
	for bazaar@lists.canonical.com; Thu, 26 Mar 2009 03:05:27 +0000
Received: by ewy27 with SMTP id 27so387306ewy.6
	for <bazaar@lists.canonical.com>; Wed, 25 Mar 2009 20:05:27 -0700 (PDT)
Received: by 10.210.120.17 with SMTP id s17mr4655333ebc.72.1238036727574;
	Wed, 25 Mar 2009 20:05:27 -0700 (PDT)
Received: from ?192.168.1.42? (pool-72-65-195-138.pitbpa.east.verizon.net
	[72.65.195.138])
	by mx.google.com with ESMTPS id 5sm2419458eyh.51.2009.03.25.20.05.23
	(version=TLSv1/SSLv3 cipher=RC4-MD5);
	Wed, 25 Mar 2009 20:05:25 -0700 (PDT)
In-Reply-To: <87zlfcz62g.fsf@iki.fi>
X-Mailer: Apple Mail (2.930.3)
X-Topics: everythingelse
X-BeenThere: bazaar@lists.canonical.com
X-Mailman-Version: 2.1.8
Precedence: list
List-Id: bazaar discussion <bazaar.lists.canonical.com>
List-Unsubscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar>,
	<mailto:bazaar-request@lists.canonical.com?subject=unsubscribe>
List-Archive: <https://lists.ubuntu.com/archives/bazaar>
List-Post: <mailto:bazaar@lists.canonical.com>
List-Help: <mailto:bazaar-request@lists.canonical.com?subject=help>
List-Subscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar>,
	<mailto:bazaar-request@lists.canonical.com?subject=subscribe>
Sender: bazaar-bounces@lists.canonical.com
Errors-To: bazaar-bounces@lists.canonical.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114709>


--Apple-Mail-1--116000872
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit

On Mar 23, 2009, at 10:07 AM, Teemu Likonen wrote:

>> I'm just experimenting with "bzr fast-export", which converts to git,
>> and it seems to take about 4 minutes for 1000 revisions on our
>> (modern) server. That would be around 7 hours for my emacs  
>> repository;
>> I can't do that daily.
>>
>> I wonder if there's a way for (bzr) fast-export / (git) fast-import  
>> to
>> work incrementally, i.e. for selected or most recent revisions.
>
> They can or should work incrementally, and actually I have succesfully
> done that. The idea is to use --import-marks and --export-marks  
> options
> with "git fast-import" and --marks option with "bzr fast-export.
>
> I noticed some problems with newer versions of "bzr fast-export",  
> though
> (since it was converted to a proper Bzr command). It seems to corrupt
> the marks file when doing the first incremental export after the  
> initial
> export. At least the revisions are not in right order in the marks  
> file
> anymore. "git fast-import" can't continue to import from the same
> revision where it left last time and it seems to create alternative
> history -- or something.
>
> Really I don't know if this is a bug in Bzr or in Git and haven't
> figured out how to file a useful bug report.



I'm experiencing pretty much the same problem.

Looking at the code (marks_file.py) I don't see why the order would  
matter (even though it would be nicer if the order was consistent).  I  
actually changed this so that it's always sorted, just to help me debug.

Now, I'm getting these errors back from git:

fatal: mark :96985 not declared
fast-import: dumping crash report to .git/fast_import_crash_74262
bzr: broken pipe

I couldn't reproduce this with a simple repository.

However, if one inspects the output of bzr fast-export, one finds  
stuff like this:

commit refs/heads/master
mark :96984
committer <dann> 1237847130 +0000
data 205
....
from :96985
M 644 inline lisp/ChangeLog
data 741178
--- ... --- ... --- ... ---
commit refs/heads/master
mark :96985
committer <jhd> 1237849747 +0000
...
from :96984
M 644 inline src/gtkutil.c
data 135796

I'm not sure about the structure of these files, but my educated guess  
would be that this is a circular reference.
Strange.  One would think that this should never happen.

That said, I get the same errors in other cases as well without  
circular reference.

As an experiment, I deleted the last 1000 or so revisions from the bzr  
marks file, so that they would be output again.
A couple of minutes and 430MB in output later, I imported this on the  
git side, which, after a few seconds, came back with this:
---------------------------------------------------------------------
Alloc'd objects:     105000
Total objects:            5 (      5063 duplicates                  )
       blobs  :            0 (      1549 duplicates          0 deltas)
       trees  :            2 (      2505 duplicates          0 deltas)
       commits:            3 (      1009 duplicates          0 deltas)
       tags   :            0 (         0 duplicates          0 deltas)
Total branches:           1 (         1 loads     )
       marks:        1048576 (     97012 unique    )
       atoms:           1937
Memory total:          5380 KiB
        pools:          2098 KiB
      objects:          3281 KiB
---------------------------------------------------------------------
pack_report: getpagesize()            =       4096
pack_report: core.packedGitWindowSize =   33554432
pack_report: core.packedGitLimit      =  268435456
pack_report: pack_used_ctr            =     104764
pack_report: pack_mmap_calls          =          6
pack_report: pack_open_windows        =          4 /          4
pack_report: pack_mapped              =  100666262 /  100666262
---------------------------------------------------------------------

So, it seems like there were 3 commits that were missing from previous  
transfers.  The final lines of the marks files for bzr and git seem  
coherent.  Hard to identify the culprit.

Further changes resulted in good conversion so far.  Deleting a good  
number of the most recent marks entries seems to be the right thing to  
recover.

A "bzr uncommit" seemed not to make its way to the git side.  No  
good.   I wonder if that is going to create a lasting inconsistency. I  
did get this subsequently:
warning: Not updating refs/heads/master (new tip  
6c81ccc916026d020eadeb0ad6e5b12c18aeccd3 does not contain  
3222cfee5bc00412b6f5e52a420f93564f586ee9)
This "not contained" revision resolved to the uncommitted one - that  
makes sense.
But what consequences does the warning have...?




--Apple-Mail-1--116000872
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIFxDCCAn0w
ggHmoAMCAQICED6shx13jEDrq0eL8FRq5ykwDQYJKoZIhvcNAQEFBQAwYjELMAkGA1UEBhMCWkEx
JTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQ
ZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMB4XDTA4MTIwOTAyMDgwMVoXDTA5MTIwOTAyMDgw
MVowYjEQMA4GA1UEBBMHUmVpdHRlcjEOMAwGA1UEKhMFRGF2aWQxFjAUBgNVBAMTDURhdmlkIFJl
aXR0ZXIxJjAkBgkqhkiG9w0BCQEWF2RhdmlkLnJlaXR0ZXJAZ21haWwuY29tMIGfMA0GCSqGSIb3
DQEBAQUAA4GNADCBiQKBgQDOdo6kAwlkBxUb8dj4saMbYg4SVng8CUePFn3cjjWrakBTbUVa4Z0n
wlUxr7AitEeKhBy5nGhu96+jKUPrCwYNRCZ0l2ovvuGq4z1m1nZ5/c8WvFlVhieuxXMUfmb/O7D3
IojoX6iS8n5MNNU2IWNNT/AD3vOl6DKgOtOw4J9y+QIDAQABozQwMjAiBgNVHREEGzAZgRdkYXZp
ZC5yZWl0dGVyQGdtYWlsLmNvbTAMBgNVHRMBAf8EAjAAMA0GCSqGSIb3DQEBBQUAA4GBAIjI8yEW
wkiEfA9PMgpjnD6KyCXT0iZjHhW2PkR53yZZLUoTboHnKgsFwYp/gzzIL8J5cvZaRUyMUzXDufPP
dRmxxCs2jXXLDD/8bvdvOuMzqgYoFA73fAfsC8S6qUL1PayZ90J8CZHNhDwqWqOA56T+DdKUegJT
sqoHKh6OnypTMIIDPzCCAqigAwIBAgIBDTANBgkqhkiG9w0BAQUFADCB0TELMAkGA1UEBhMCWkEx
FTATBgNVBAgTDFdlc3Rlcm4gQ2FwZTESMBAGA1UEBxMJQ2FwZSBUb3duMRowGAYDVQQKExFUaGF3
dGUgQ29uc3VsdGluZzEoMCYGA1UECxMfQ2VydGlmaWNhdGlvbiBTZXJ2aWNlcyBEaXZpc2lvbjEk
MCIGA1UEAxMbVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIENBMSswKQYJKoZIhvcNAQkBFhxwZXJz
b25hbC1mcmVlbWFpbEB0aGF3dGUuY29tMB4XDTAzMDcxNzAwMDAwMFoXDTEzMDcxNjIzNTk1OVow
YjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAq
BgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMIGfMA0GCSqGSIb3DQEB
AQUAA4GNADCBiQKBgQDEpjxVc1X7TrnKmVoeaMB1BHCd3+n/ox7svc31W/Iadr1/DDph8r9RzgHU
5VAKMNcCY1osiRVwjt3J8CuFWqo/cVbLrzwLB+fxH5E2JCoTzyvV84J3PQO+K/67GD4Hv0CAAmTX
p6a7n2XRxSpUhQ9IBH+nttE8YQRAHmQZcmC3+wIDAQABo4GUMIGRMBIGA1UdEwEB/wQIMAYBAf8C
AQAwQwYDVR0fBDwwOjA4oDagNIYyaHR0cDovL2NybC50aGF3dGUuY29tL1RoYXd0ZVBlcnNvbmFs
RnJlZW1haWxDQS5jcmwwCwYDVR0PBAQDAgEGMCkGA1UdEQQiMCCkHjAcMRowGAYDVQQDExFQcml2
YXRlTGFiZWwyLTEzODANBgkqhkiG9w0BAQUFAAOBgQBIjNFQg+oLLswNo2asZw9/r6y+whehQ5aU
nX9MIbj4Nh+qLZ82L8D0HFAgk3A8/a3hYWLD2ToZfoSxmRsAxRoLgnSeJVCUYsfbJ3FXJY3dqZw5
jowgT2Vfldr394fWxghOrvbqNOUQGls1TXfjViF4gtwhGTXeJLHTHUb/XV9lTzGCAo8wggKLAgEB
MHYwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4x
LDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAhA+rIcdd4xA66tH
i/BUaucpMAkGBSsOAwIaBQCgggFvMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcN
AQkFMQ8XDTA5MDMyNjAzMDUyMFowIwYJKoZIhvcNAQkEMRYEFI9U0u9SDJvmSfNroiDST/9353+W
MIGFBgkrBgEEAYI3EAQxeDB2MGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3Vs
dGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWlu
ZyBDQQIQPqyHHXeMQOurR4vwVGrnKTCBhwYLKoZIhvcNAQkQAgsxeKB2MGIxCzAJBgNVBAYTAlpB
MSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUg
UGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQQIQPqyHHXeMQOurR4vwVGrnKTANBgkqhkiG9w0B
AQEFAASBgMSEQWdTKajugb9Z9pwejoZBbwh8gt8MNEVPTU3/t97LnmVI/iizwTaVE8KSg5HxEZrM
s533iY57kpv/fdhWtDyJL7DbJpw4B9woaXT34Xc2kSQGE6NORQ+6/9dbeYlzYoDhKsKg/bv2Fwn6
VAd0T9+YL8TWc8dj+B5AX0NW5yYWAAAAAAAA

--Apple-Mail-1--116000872--
