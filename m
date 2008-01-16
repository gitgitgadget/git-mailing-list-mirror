From: Kevin Ballard <kevin@sb.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Wed, 16 Jan 2008 18:11:31 -0500
Message-ID: <7652B11D-9B9F-45EA-9465-8294B701FE7C@sb.org>
References: <478E1FED.5010801@web.de> <m33asxn2gt.fsf@roke.D-201> <65026F2B-5CE8-4238-A9AB-D3545D336B41@sb.org> <200801162251.54219.jnareb@gmail.com> <1574A90A-8C45-46AD-9402-34AE6F582B3F@sb.org> <alpine.LFD.1.00.0801161424040.2806@woody.linux-foundation.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: multipart/signed; boundary=Apple-Mail-6-1027076012; micalg=sha1; protocol="application/pkcs7-signature"
Cc: Jakub Narebski <jnareb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mark Junker <mjscod@web.de>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jan 17 00:12:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFHQS-0002YV-PQ
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 00:12:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbYAPXLg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 18:11:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751405AbYAPXLg
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 18:11:36 -0500
Received: from sd-green-bigip-66.dreamhost.com ([208.97.132.66]:41546 "EHLO
	randymail-a9.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750917AbYAPXLf (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Jan 2008 18:11:35 -0500
Received: from KBALLARD.RES.WPI.NET (KBALLARD.RES.WPI.NET [130.215.239.91])
	by randymail-a9.g.dreamhost.com (Postfix) with ESMTP id 0F3B6EF2DC;
	Wed, 16 Jan 2008 15:11:32 -0800 (PST)
In-Reply-To: <alpine.LFD.1.00.0801161424040.2806@woody.linux-foundation.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70767>


--Apple-Mail-6-1027076012
Content-Type: text/plain;
	charset=ISO-8859-1;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: quoted-printable

On Jan 16, 2008, at 5:32 PM, Linus Torvalds wrote:

> On Wed, 16 Jan 2008, Kevin Ballard wrote:
>>
>> It's not using different encodings, it's all Unicode. However, it =20
>> accepts
>> different normalization variants of Unicode, since it can read them =20=

>> all and it
>> would be folly to require everybody to conform to its own special =20
>> internal
>> variant. But it does have to normalize them, otherwise how would it =20=

>> detect the
>> same filename using different normalizations?
>
> That's a singularly *stupid* argument.
>
> Here, let me rephrase that same idiotic argument:
>
>  "But it does have to uppercase them, otherwise how would it detect =20=

> the
>   same filename using different cases?"
>
> ..and if you don't see how that's *exactly* the same argument, you =20
> really
> are stupid.

You're right, it doesn't actually have to store the normalized form. =20
And yes, it's possible to compare without normalizing them. =20
Admittedly, I don't know much about the implementation details of =20
unicode, but I would assume that the easiest way to compare two =20
strings is to normalize them first. But in the case of the filesystem, =20=

normalization actually is important if you're thinking about filenames =20=

in terms of characters rather than bytes. When I feed the filesystem a =20=

given unicode string, it has to find the file I'm talking about - =20
should it do a relatively expensive unicode-sensitive comparison of =20
all the filenames with the one I gave it, or should it just normalize =20=

all names and do the much cheaper lookup that way? I don't know about =20=

you, but I'd prefer to let my filesystem normalize the name and run =20
faster.

> The fact is, normalization is wrong.
>
> It's wrong when you normalize upper/lower case (no, the word =20
> "Polish" is
> not the same as "polish"), and it's equally wrong when you normalize =20=

> for
> "looks similar".

There's a difference between "looks similar" as in "Polish" vs =20
"polish", and actually is the same string as in "Ma<UMLAUT =20
MODIFIER>rchen" vs "M<A WITH UMLAUT>rchen". Capitalization has a valid =20=

semantic meaning, normalization doesn't. The only way to argue that =20
normalization is wrong is by providing a good reason to preserve the =20
exact byte sequence, and so far the only reason I've seen is to help =20
git. Applications in general don't care one whit about the byte =20
sequence of the filename, they care about the underlying file the name =20=

represents. Additionally, it would be a terrible experience for a user =20=

to enter "M=E4rchen" and have the application say "sorry, I can't find =20=

this file" simply because the application used decomposed characters =20
and the filename used composed characters. Unless the user is =20
knowledgeable about the OS, filesystems, and unicode, they wouldn't =20
have a hope of figuring out what the problem was.

>
>> In other words, you're used to filenames as bytes, HFS+ treats =20
>> filenames
>> as strings.
>
> No. HFS+ treats users as idiots and thinks that it should "fix" the
> filename for them. And it causes problems.

How do you figure? When I type "M=E4rchen", I'm typing a string, not a =20=

byte sequence. I have no control over the normalization of the =20
characters. Therefore, depending on what program I'm typing the name =20
in, I might use the same normalization as the filename, or I might =20
miss. It's completely out of my control. This is why the filesystem =20
has to step in and say "You composed that character differently, but I =20=

know you were trying to specify this file".

> It causes problems for exactly the same reasons case-independence =20
> causes
> problems, because it's EXACTLY THE SAME ISSUE. People may think that =20=

> "but
> they are the same", but they aren't. Case matters. And so does "single
> character" vs "two character overlay".

There are valid reasons for case to matter, but what reason is there =20
for "single character" vs" two character overlay" to matter in =20
filenames? They're different representations of the exact same string, =20=

and that's what a filename is - a string.

It seems like your arguments stem from the assumption that the user =20
cares about the byte sequence that represents the filename, which is =20
wrong. The user has no idea what the byte sequence is - the user cares =20=

about the string. Normalization is meant to help computers, not users, =20=

and claiming that different normalizations of the same string produces =20=

different meaningful strings is complete bunk.

If you were to have two different files on your system, both of them =20
called "M=E4rchen", but one precomposed and one decomposed, how would =20=

you specify which one you wanted? Unless Linux has a special text =20
input system which gives the user control over the normalization of =20
their typed characters, you'd have to write out the UTF-8 bytes =20
manually.

I just don't understand this insistence on treating the specific byte =20=

sequence that makes up the filename as significant.

-Kevin Ballard

--=20
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com



--Apple-Mail-6-1027076012
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
DxcNMDgwMTE2MjMxMTMyWjAjBgkqhkiG9w0BCQQxFgQUsVe9l1NELskL0OC/UW8gfiQjDL4wgYUG
CSsGAQQBgjcQBDF4MHYwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5n
IChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENB
AhA7BvASr5axFtB1ASMViII1MIGHBgsqhkiG9w0BCRACCzF4oHYwYjELMAkGA1UEBhMCWkExJTAj
BgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJz
b25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAhA7BvASr5axFtB1ASMViII1MA0GCSqGSIb3DQEBAQUA
BIIBADTpQNFmZ8oRPUpwtSMDDVelCQ6o2ufAAs17tzo5bMK35SbnT5W4KTxAscQtRxxYNgknmNJG
Ib+88jffO+17Xs97bnWj46KA3B+5YIA9sCTpR41Wtk1ZynhzCbtG6TQhERdZxPTI9uUqXedCj8/t
weT2mwvu6Eo1v3OsiTZ4OvOTEcD6GCrrLEdDafrlMs9dVUOXyjBlMBbECFcQlAp2CWDskH/aM/4U
/A9B62KmYM5y3+rQ6a782DR0OrgBvY7UARoHNJYS/774+9VSUSr1GjdDHoEFNuDBNvSxs60CQUoa
JPp7jnyDj+ZEuwSNkiDRHkXSmgaUfJBq7i0BVVCRmeAAAAAAAAA=

--Apple-Mail-6-1027076012--
