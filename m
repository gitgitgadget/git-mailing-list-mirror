From: Kevin Ballard <kevin@sb.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Wed, 23 Jan 2008 03:15:02 -0500
Message-ID: <4697E0BA-7243-4C35-A384-0BD261EC21AF@sb.org>
References: <F663E088-BCAD-4C5D-89D5-EAF97A29C1DE@sb.org> <alpine.LFD.1.00.0801211656130.2957@woody.linux-foundation.org> <alpine.LFD.1.00.0801211702050.2957@woody.linux-foundati!on.org> <34103945-2078-4983-B409-2D01EF071A8B@sb.org> <alpine.LFD.1.00.0801211846010.2957@woody.linux-foundation.org> <E3E4F5B3-1740-47E4-A432-C881830E2037@sb.org> <20080122133427.GB17804@mit.edu> <20080123000841.GA22704@mit.edu> <alpine.LFD.1.00.0801221625510.1741@woody.linux-foundation.org> <20080123013325.GB1320@mit.edu> <20080123064139.GC16297@glandium.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: multipart/signed; boundary=Apple-Mail-60--569396072; micalg=sha1; protocol="application/pkcs7-signature"
Cc: Theodore Tso <tytso@MIT.EDU>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Wed Jan 23 09:15:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHalt-0004a0-O9
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 09:15:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752684AbYAWIPO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2008 03:15:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751578AbYAWIPN
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jan 2008 03:15:13 -0500
Received: from sd-green-bigip-74.dreamhost.com ([208.97.132.74]:47084 "EHLO
	randymail-a4.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751512AbYAWIPM (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Jan 2008 03:15:12 -0500
Received: from KBALLARD.RES.WPI.NET (KBALLARD.RES.WPI.NET [130.215.239.91])
	by randymail-a4.g.dreamhost.com (Postfix) with ESMTP id EC0EC195942;
	Wed, 23 Jan 2008 00:15:09 -0800 (PST)
In-Reply-To: <20080123064139.GC16297@glandium.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71517>


--Apple-Mail-60--569396072
Content-Type: text/plain;
	charset=ISO-8859-1;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: quoted-printable

On Jan 23, 2008, at 1:41 AM, Mike Hommey wrote:

> On Tue, Jan 22, 2008 at 08:33:25PM -0500, Theodore Tso wrote:
>> On Tue, Jan 22, 2008 at 04:38:37PM -0800, Linus Torvalds wrote:
>>> One thing I'd like somebody to check: what _does_ happen with OS X =20=

>>> and NFS
>>> (OS X as a client, not server)? In particular:
>>>
>>> - Is it suddenly sane and case-sensitive?
>>
>> Using a Linux server, and a OS X client, over NFS, it is in
>> case-sensitive.  This is not unexpected, since you can mount UFS
>> partitions on Mac OS X, or reformat HFS+ filesystems and make them be
>> case-sensitive.
>>
>>> - Does the NFS client do any unicode conversion?
>>
>> Nope:
>>
>> # perl -CO -e 'print pack("U",0x00C4)."\n"'  | xargs touch
>> # ls -l | cat -v
>> total 0
>> 0 -rw-r--r--   1 nobody  nobody  0 Jan 22 20:30 M-CM-^D
>>
>> It's pretty clear the Unicode conversion is being done in HFS+, not =20=

>> in
>> the VFS layer of Mac OS X.
>
> There must be something at the VFS layer, or some other layer:
> - IIRC, Joliet iso9660 volumes end up being mounted with files names =20=

> in
>  NFS when the real file names are NFC on the disk.

I assume you mean NFD, not NFS, but here's what one of the HFS+ =20
engineers had to say:

"In Mac OS X,  SMB, MSDOS, UDF, ISO 9660 (Joliet), NTFS and ZFS file =20
systems all store in one form -- NFC.  We store in NFC since that what =20=

is expected for these files systems."

> - Likewise for Samba shares.

See above.

> - When I had my problems with iso9660 rockridge volumes using NFC (you
>  can create that just fine with mkisofs), the volume is mounted =20
> without
>  normalisation, i.e. if you get to a shell and want to access files,
>  you must use NFC, but at least the Finder does transliteration at =20
> some
>  stage, because going into the mount point and opening some files fail
>  because it's trying to open the file with the name transliterated to
>  NFD. I just hope the same doesn't happen with other filesystems.

Can you produce a reproducible set of steps for this? Because the =20
Finder shouldn't be doing any of this work on its own, all the =20
normalization stuff happens directly in HFS+.

> Also, OSX using NFD widely, a file created from non Unix applications
> may end up being named in NFD on any file system. File contents, too,
> may end up being transliterated whenever a file is modified with non
> Unix applications, introducing unwanted changes.
> Typing file names in the Terminal might also make them encoded in NFD,
> too.

Entirely possible, though renormalizing file contents seems a bit less =20=

likely. I will point out that the text input system in OS X seems to =20
default to producing NFC (at least, typing `echo 'M=E4rchen' | xxd` in =20=

the Terminal shows that the input string there is NFC). So user input =20=

will most likely produce NFC, the only way you're probably going to =20
end up with NFD is if you move a file from HFS+ to another filesystem.

-Kevin Ballard

--=20
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com



--Apple-Mail-60--569396072
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIGMjCCAusw
ggJUoAMCAQICEDsG8BKvlrEW0HUBIxWIgjUwDQYJKoZIhvcNAQEFBQAwYjELMAkGA1UEBhMCWkEx
JTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQ
ZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMB4XDTA3MDQyMzIxMjM0OVoXDTA4MDQyMjIxMjM0
OVowVzEQMA4GA1UEBBMHQmFsbGFyZDEOMAwGA1UEKhMFS2V2aW4xFjAUBgNVBAMTDUtldmluIEJh
bGxhcmQxGzAZBgkqhkiG9w0BCQEWDGtldmluQHNiLm9yZzCCASIwDQYJKoZIhvcNAQEBBQADggEP
ADCCAQoCggEBAN/koURrN2ndrAiuAuHHrdFz+hLGQ7ZsXloGnObjALGOFY3Kmk2FCwAJPIha5GfM
YFmZIoqxs+DbOWOn6KZ9hcQ5wf4EOgokayrEs3G72T+G8ZE4aXrw0CWJzKLjaIQeDZNZoHA44jlZ
dG70wtZske898IoPz6YHpkcXiulllATfd8Pa7EgjPri5hKFiRXKI52OsOQTX6cNMMZJUIm8DvfQ5
jmDyAtywNZGSGeUAMbWnpuLq7H18zpye2Q1hr+p4kucazMb+i7OHXPvX7yx2jMjhN5jw/gYkuzQQ
JExp1fJyAZQ/av/ZgaxWchhhi4ziFXIlX3B09DTlOQlF53P3fi0CAwEAAaMpMCcwFwYDVR0RBBAw
DoEMa2V2aW5Ac2Iub3JnMAwGA1UdEwEB/wQCMAAwDQYJKoZIhvcNAQEFBQADgYEAw/qc6zq+0Qy2
XaodDlt2L6Vq1DzaVWjV152BFjidmsyhyCkCuyYdAcDp17opIfrNCBbOX5DdY6cpFpnSCxCZeIEB
PDc3TaaFPtzr8qrpcNDohRSdt+qFLUeMHzlidAiAjvjI3tPKv3JLTakWdQR/XPHsg4mWoaVQU2hM
HOQBw8EwggM/MIICqKADAgECAgENMA0GCSqGSIb3DQEBBQUAMIHRMQswCQYDVQQGEwJaQTEVMBMG
A1UECBMMV2VzdGVybiBDYXBlMRIwEAYDVQQHEwlDYXBlIFRvd24xGjAYBgNVBAoTEVRoYXd0ZSBD
b25zdWx0aW5nMSgwJgYDVQQLEx9DZXJ0aWZpY2F0aW9uIFNlcnZpY2VzIERpdmlzaW9uMSQwIgYD
VQQDExtUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgQ0ExKzApBgkqhkiG9w0BCQEWHHBlcnNvbmFs
LWZyZWVtYWlsQHRoYXd0ZS5jb20wHhcNMDMwNzE3MDAwMDAwWhcNMTMwNzE2MjM1OTU5WjBiMQsw
CQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UE
AxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0EwgZ8wDQYJKoZIhvcNAQEBBQAD
gY0AMIGJAoGBAMSmPFVzVftOucqZWh5owHUEcJ3f6f+jHuy9zfVb8hp2vX8MOmHyv1HOAdTlUAow
1wJjWiyJFXCO3cnwK4Vaqj9xVsuvPAsH5/EfkTYkKhPPK9Xzgnc9A74r/rsYPge/QIACZNenpruf
ZdHFKlSFD0gEf6e20TxhBEAeZBlyYLf7AgMBAAGjgZQwgZEwEgYDVR0TAQH/BAgwBgEB/wIBADBD
BgNVHR8EPDA6MDigNqA0hjJodHRwOi8vY3JsLnRoYXd0ZS5jb20vVGhhd3RlUGVyc29uYWxGcmVl
bWFpbENBLmNybDALBgNVHQ8EBAMCAQYwKQYDVR0RBCIwIKQeMBwxGjAYBgNVBAMTEVByaXZhdGVM
YWJlbDItMTM4MA0GCSqGSIb3DQEBBQUAA4GBAEiM0VCD6gsuzA2jZqxnD3+vrL7CF6FDlpSdf0wh
uPg2H6otnzYvwPQcUCCTcDz9reFhYsPZOhl+hLGZGwDFGguCdJ4lUJRix9sncVcljd2pnDmOjCBP
ZV+V2vf3h9bGCE6u9uo05RAaWzVNd+NWIXiC3CEZNd4ksdMdRv9dX2VPMYIDEDCCAwwCAQEwdjBi
MQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoG
A1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0ECEDsG8BKvlrEW0HUBIxWI
gjUwCQYFKw4DAhoFAKCCAW8wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUx
DxcNMDgwMTIzMDgxNTAzWjAjBgkqhkiG9w0BCQQxFgQUR1dBWOIqhfmtT7XEKlsa8oVt3HswgYUG
CSsGAQQBgjcQBDF4MHYwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5n
IChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENB
AhA7BvASr5axFtB1ASMViII1MIGHBgsqhkiG9w0BCRACCzF4oHYwYjELMAkGA1UEBhMCWkExJTAj
BgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJz
b25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAhA7BvASr5axFtB1ASMViII1MA0GCSqGSIb3DQEBAQUA
BIIBAHFYyu9P4steOxPIF8++3QZJ+/e3DkQOKFzUoY6EWPX8nJjgx805RLCXCWzxnitDn9VVTods
Gk7YGI/YrOgdnyDK1vBcfBvP/1kEkNNNgnlYKsizLCade3WLULENq9gznV+OprcWtvyHIKd2/pj/
b0TaS3ik/B1VIZrigUwM2o7nJjGlFVwzNNOnQQbTD38DOekmeXCPD+iOaa89mSxy8WCEO7sJRQKJ
V6i22zyDCJEd2jJ7D0vdmOTnrgMp3FqJauU71rsC7aWMeWKhAFoWAeOLEPDMZ83KE3ADbjF56+9+
K8C4NjKegajrfZkbP5RKpRJYufGgF4xgNMvq5rz4gmcAAAAAAAA=

--Apple-Mail-60--569396072--
