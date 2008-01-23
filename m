From: Kevin Ballard <kevin@sb.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Wed, 23 Jan 2008 12:19:02 -0500
Message-ID: <98F90EB6-1930-4643-8C6C-CA11CB123BAA@sb.org>
References: <34103945-2078-4983-B409-2D01EF071A8B@sb.org> <alpine.LFD.1.00.0801211846010.2957@woody.linux-foundation.org> <E3E4F5B3-1740-47E4-A432-C881830E2037@sb.org> <20080122133427.GB17804@mit.edu> <20080123000841.GA22704@mit.edu> <alpine.LFD.1.00.0801221625510.1741@woody.linux-foundation.org> <20080123013325.GB1320@mit.edu> <20080123064139.GC16297@glandium.org> <4697E0BA-7243-4C35-A384-0BD261EC21AF@sb.org> <20080123094052.GB6969@glandium.org> <20080123133802.GC7415@mit.edu> <alpine.LFD.1.00.0801230808440.1741@woody.linux-foundation.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: multipart/signed; boundary=Apple-Mail-63--536756936; micalg=sha1; protocol="application/pkcs7-signature"
Cc: Theodore Tso <tytso@MIT.EDU>, Mike Hommey <mh@glandium.org>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jan 23 18:19:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHjGF-0000jI-9k
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 18:19:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753024AbYAWRTJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2008 12:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752440AbYAWRTI
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jan 2008 12:19:08 -0500
Received: from sd-green-bigip-177.dreamhost.com ([208.97.132.177]:35756 "EHLO
	randymail-a2.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752210AbYAWRTG (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Jan 2008 12:19:06 -0500
Received: from KBALLARD.RES.WPI.NET (KBALLARD.RES.WPI.NET [130.215.239.91])
	by randymail-a2.g.dreamhost.com (Postfix) with ESMTP id 9D842EEE9E;
	Wed, 23 Jan 2008 09:19:03 -0800 (PST)
In-Reply-To: <alpine.LFD.1.00.0801230808440.1741@woody.linux-foundation.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71559>


--Apple-Mail-63--536756936
Content-Type: text/plain;
	charset=ISO-8859-1;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: quoted-printable

On Jan 23, 2008, at 11:16 AM, Linus Torvalds wrote:

> On Wed, 23 Jan 2008, Theodore Tso wrote:
>>
>> So this demonstrates that on my MacOS 10.4.11 system, on NFS, MacOS =20=

>> is
>> doing no normalization, as it is creating two files.  On HFS+, MacOS
>> is mapping both filenames to the same decomposed name.
>
> Well, it demonstrates that (a) the OS and (b) _perl_ don't mangle
> filenames on non-HFS+ filesystems.
>
> The problem is that since most native applications *expect* that name
> mangling, they'll probably do name mangling of their own =20
> (internally) just
> to compare the names!

Well yes, any context in which a string is treated as Unicode instead =20=

of an opaque sequence of bytes will probably lead to normalization at =20=

some point (e.g. when searching text, I'm going to want M=E4rchen and =20=

M=E4rchen to be treated as the same string). The Mac OS X APIs use NFD, =20=

and everybody else uses NFC, but either way it's still normalization.

> So I would not be surprised if the globbing libraries, for example, =20=

> will
> do NFD-mangling in order to glob "correctly", so even programs =20
> ported from
> real Unix might end up getting pathnames subtly changed into NFD as =20=

> part
> of some hot library-on-library action with UTF hackery inside.

Why would the globbing libraries have to do anything special to =20
understand NFD? In fact, I prefer that they don't - it's very handy to =20=

be able to type Ma* and have that match M=E4rchen, as the globbing =20
library sees Ma??rchen and is happy to match the ??rchen against *. =20
Were the filename in NFC, I couldn't do that. Similarly, Ma<tab> =20
autocompletes the name M=E4rchen for me. But the convenience is beside =20=

the point - what I'm trying to show here is that if the globbing =20
library were NFD-aware, it probably would decide Ma* shouldn't match =20
M=E4rchen, right?

I assume globbing libraries et al don't do UTF-8 hackery in Linux, =20
right? And yet using NFC-encoded filenames is fairly common? So why =20
should it be any different on OS X, especially since HFS+ isn't the =20
only option here (and thus doing NFD conversion in the library would =20
mess up other filesystems)?

In fact, probably the biggest reason the NFD-encoding was done at the =20=

HFS+ level is because they simply couldn't trust user-level libraries =20=

to always do the NFD conversion for pathnames. And I quote:

"I would prefer that case sensitivity and unicode normalization were =20
not the responsibility of the file system -- but I realize that we =20
cannot just ignore the problem and let the other layers sort it all =20
out."

> Things like the finder etc, which must be very aware of the fact that
> filenames get corrupted, would presumably internally always convert
> everything they get into NFD in order to compare names from different
> sources. And as part of that, programs may well corrupt the name =20
> before
> they then use it to create a pathname.

I don't get why you're still calling it corruption when, on an HFS+ =20
system, NFD-encoding is correct. It would be corruption for HFS+ to =20
write anything else but NFD.

> The fact that your perl program works under NFS, but creates NFD on =20=

> a VFAT
> volume, does imply that they probably used at least some of the same
> routines they use in HFS+ for VFAT. Not entirely surprising: doing =20
> case
> insensitive stuff with Unicode is nasty code, so why not share it =20
> (even if
> it's then incorrect for FAT)..
>
> Piece of crap it is, though. Apple has painted themselves into a nasty
> corner there.

There's no reason to assume that OS X is actually storing the NFD on =20
the volume. In fact, it's quite explicitly not:

"As far as storing exactly what was passed in,  its not just HFS =20
that's involved her.  In Mac OS X,  SMB, MSDOS, UDF, ISO 9660 =20
(Joliet), NTFS and ZFS file systems all store in one form -- NFC.  We =20=

store in NFC since that what is expected for these files systems.  If =20=

we were to allow KFD to pass through, it would cause problems when =20
these names were accessed outside of Mac OS X.  So this is not just an =20=

HFS issue but an interchange issue for Mac OS X.  We have the legacy =20
NFD use/expectation in our applications and we chose not to ignore the =20=

problem but make a conscience effort to have the appropriate form used =20=

(NFD in Mac OS X APIs, NFC elsewhere).  Its not perfect but neither is =20=

the agnostic approach where both forms can be used and you can have =20
duplicate filenames in your file system."

-Kevin Ballard

--=20
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com



--Apple-Mail-63--536756936
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
DxcNMDgwMTIzMTcxOTAyWjAjBgkqhkiG9w0BCQQxFgQU/3dv+TlRZda0AkOAFoPaoPg7dYYwgYUG
CSsGAQQBgjcQBDF4MHYwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5n
IChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENB
AhA7BvASr5axFtB1ASMViII1MIGHBgsqhkiG9w0BCRACCzF4oHYwYjELMAkGA1UEBhMCWkExJTAj
BgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJz
b25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAhA7BvASr5axFtB1ASMViII1MA0GCSqGSIb3DQEBAQUA
BIIBABU7sN2FgBDf691McP4SQ+Tdl65hCvLLY9YZEDu71s3CRTjq4xKV1ci+PgBQVAmtDUwR8R0I
h+ehyS7dcbBLWOGGPiYkKDd0VwCXbCb/ctveOixZViCrJH54nJZuLrIL6739K6xtwr4hUBk8Xznd
+ifFoPkhKfFgcsXySGeqSjT27PaL83Y8VN+TaTLv4kW0gAeRray+K5OeoKi6j4/wptP8BskkbfLc
HTiByONiVEA5lIqJAK9zIwQeIZkfK+92iWhadIJ8LVd3W6jWBAg4YPu8ieoLCCxb6r/3Gztt9DJE
TtPkfLS7nIzT+X2NyG/RDgNiCXhpRi4mFzZLGI8UWYMAAAAAAAA=

--Apple-Mail-63--536756936--
