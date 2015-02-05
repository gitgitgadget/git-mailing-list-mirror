From: Scott Schmit <i.grok@comcast.net>
Subject: [BUG] Move tracking in git diff is not as good as in git status
Date: Thu, 5 Feb 2015 01:11:42 -0500
Message-ID: <20150205061142.GA31599@odin.ulthar.us>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
	micalg=sha1; boundary="WIyZ46R2i8wDzkSu"
To: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 05 07:11:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YJFfL-0001P2-UM
	for gcvg-git-2@plane.gmane.org; Thu, 05 Feb 2015 07:11:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbbBEGLr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2015 01:11:47 -0500
Received: from resqmta-ch2-12v.sys.comcast.net ([69.252.207.44]:45167 "EHLO
	resqmta-ch2-12v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751182AbbBEGLq (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Feb 2015 01:11:46 -0500
Received: from resomta-ch2-11v.sys.comcast.net ([69.252.207.107])
	by resqmta-ch2-12v.sys.comcast.net with comcast
	id oWBm1p0012Ka2Q501WBm1h; Thu, 05 Feb 2015 06:11:46 +0000
Received: from odin.ulthar.us ([IPv6:2001:470:8c86:0:225:64ff:fe8b:c2f2])
	by resomta-ch2-11v.sys.comcast.net with comcast
	id oWBl1p00A2Ekl4801WBlZy; Thu, 05 Feb 2015 06:11:45 +0000
Received: from odin.ulthar.us (localhost [127.0.0.1])
	by odin.ulthar.us (8.14.8/8.14.5) with ESMTP id t156Bhgt031642
	for <git@vger.kernel.org>; Thu, 5 Feb 2015 01:11:43 -0500
Received: (from draco@localhost)
	by odin.ulthar.us (8.14.8/8.14.8/Submit) id t156BgmS031641
	for git@vger.kernel.org; Thu, 5 Feb 2015 01:11:42 -0500
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1423116706;
	bh=TpMZej+UkmiKymAx9q9k8EML8Qd0/d2S+cpxx2XiWEw=;
	h=Received:Received:Received:Received:Date:From:To:Subject:
	 Message-ID:MIME-Version:Content-Type;
	b=N3dWj9nUQlBoADRukqVqq0uDSjvtErgxwxLcLFSdbJ2IHbSIEqmK4L1yCCApvSLFy
	 9O3ke9713Ip/KtwARnenWIVWlc4EhXLhYaYs/gpYQpqLT3n8i6sjd3bNjI3ffCIYZS
	 7QAxCNm5vs6iq3q3Bs0SixxM65faiF7YGXjZKs39lflI+haL2jk+eJP/I9rbJCcr+L
	 RHlwvLY5Nvg7d9ml8TV9JpzwNssgfCf36WCWHciTbOG3qDDmkja8QhkZhOv+pSWI/d
	 i/b0xilRDy/E4aPp+NrV6cNAGS8H4hfYp+d7xUi2TAQRO7S0P7YUNCWKH1Pss1X+tC
	 WAsHEJOIJhBGA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263362>


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In my use of git, I've noticed that "git status" is a lot better at
tracking moves and renames than "git diff", and this has recently caused
me a lot of headaches because a large number of moves were made in a
single commit, and it was very difficult to figure out which moves were
right and which were wrong.

I was using a fairly old version of git (1.7.11), but was able to
reproduce it on git 2.2.1.

Here's a reproduction recipe:

#!/bin/sh -x

# Fill in your git.git working tree path here:
GIT_GIT_REPO=3D

if [ -z "$GIT_GIT_REPO" ]; then
    echo Fill in GIT_GIT_REPO
    exit 1
fi

git init mv-test
cd mv-test/

# Pick two sample files of non-trivial size, since files that are too small
# never get tracked as moves.
cp ${GIT_GIT_REPO}/Documentation/asciidoc.conf .
cp ${GIT_GIT_REPO}/Documentation/blame-options.txt .
git add *
git commit -m "Start with two files from git.git/Documentation"

# Now rename them to something. Using 1 & 2 because they're nice & short.
git mv asciidoc.conf 1
git mv blame-options.txt 2

# Status sees the rename
git status

# So does the summary on the commit
git commit -m "Rename both files"

# And move tracking works
git diff -M --stat --summary HEAD~..
git diff -C --stat --summary HEAD~..

# Now "shift" the files
git mv 2 3
git mv 1 2

# Status knows what's going on
git status

# So does commit
git commit -m "2=3D1;3=3D2;"

# Neither of these commands get it (but -C gets a glimmer of the truth)
git diff -M --stat --summary HEAD~..
git diff -C --stat --summary HEAD~..

# Swap the files in place
git mv 3 tmp
git mv 2 3
git mv tmp 2

# Status gets it
git status

# Commit understands
git commit -m "Swap 2 & 3"

# Diff has no idea
git diff -M --stat --summary HEAD~..
git diff -C --stat --summary HEAD~..

---

At first, I thought it was because the "git mv" command recorded
something in the index that's lost once the commit happens.

To check if that was so, I went back to the commit in question, did a
"git reset HEAD~1" and "git add -A ." and git status understood what was
going on just fine.

--=20
Scott Schmit

--WIyZ46R2i8wDzkSu
Content-Type: application/x-pkcs7-signature
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIIPLwYJKoZIhvcNAQcCoIIPIDCCDxwCAQExCzAJBgUrDgMCGgUAMAsGCSqGSIb3DQEHAaCC
DGAwggY0MIIEHKADAgECAgEeMA0GCSqGSIb3DQEBBQUAMH0xCzAJBgNVBAYTAklMMRYwFAYD
VQQKEw1TdGFydENvbSBMdGQuMSswKQYDVQQLEyJTZWN1cmUgRGlnaXRhbCBDZXJ0aWZpY2F0
ZSBTaWduaW5nMSkwJwYDVQQDEyBTdGFydENvbSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTAe
Fw0wNzEwMjQyMTAxNTVaFw0xNzEwMjQyMTAxNTVaMIGMMQswCQYDVQQGEwJJTDEWMBQGA1UE
ChMNU3RhcnRDb20gTHRkLjErMCkGA1UECxMiU2VjdXJlIERpZ2l0YWwgQ2VydGlmaWNhdGUg
U2lnbmluZzE4MDYGA1UEAxMvU3RhcnRDb20gQ2xhc3MgMSBQcmltYXJ5IEludGVybWVkaWF0
ZSBDbGllbnQgQ0EwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDHCYPMzi3YGrEp
pC4Tq5a+ijKDjKaIQZZVR63UbxIP6uq/I0fhCu+cQhoUfE6ERKKnu8zPf1Jwuk0tsvVCk6U9
b+0UjM0dLep3ZdE1gblK/1FwYT5Pipsu2yOMluLqwvsuz9/9f1+1PKHG/FaR/wpbfuIqu54q
zHDYeqiUfsYzoVflR80DAC7hmJ+SmZnNTWyUGHJbBpA8Q89lGxahNvuryGaC/o2/ceD2uYDX
9U8Eg5DpIpGQdcbQeGarV04WgAUjjXX5r/2dabmtxWMZwhZna//jdiSyrrSMTGKkDiXm6/3/
4ebfeZuCYKzN2P8O2F/Xe2AC/Y7zeEsnR7FOp+uXAgMBAAGjggGtMIIBqTAPBgNVHRMBAf8E
BTADAQH/MA4GA1UdDwEB/wQEAwIBBjAdBgNVHQ4EFgQUU3Ltkpzg2ssBXHx+ljVO8tS4UYIw
HwYDVR0jBBgwFoAUTgvvGqRAW6UXaYcwyjRoQ9BBrvIwZgYIKwYBBQUHAQEEWjBYMCcGCCsG
AQUFBzABhhtodHRwOi8vb2NzcC5zdGFydHNzbC5jb20vY2EwLQYIKwYBBQUHMAKGIWh0dHA6
Ly93d3cuc3RhcnRzc2wuY29tL3Nmc2NhLmNydDBbBgNVHR8EVDBSMCegJaAjhiFodHRwOi8v
d3d3LnN0YXJ0c3NsLmNvbS9zZnNjYS5jcmwwJ6AloCOGIWh0dHA6Ly9jcmwuc3RhcnRzc2wu
Y29tL3Nmc2NhLmNybDCBgAYDVR0gBHkwdzB1BgsrBgEEAYG1NwECATBmMC4GCCsGAQUFBwIB
FiJodHRwOi8vd3d3LnN0YXJ0c3NsLmNvbS9wb2xpY3kucGRmMDQGCCsGAQUFBwIBFihodHRw
Oi8vd3d3LnN0YXJ0c3NsLmNvbS9pbnRlcm1lZGlhdGUucGRmMA0GCSqGSIb3DQEBBQUAA4IC
AQAKgwh9eKssBly4Y4xerhy5I3dNoXHYfYa8PlVLL/qtXnkFgdtY1o95CfegFJTwqBBmf8py
TUnFsukDFUI22zF5bVHzuJ+GxhnSqN2sD1qetbYwBYK2iyYA5Pg7Er1A+hKMIzEzcduRkIMm
CeUTyMyikfbUFvIBivtvkR8ZFAk22BZy+pJfAoedO61HTz4qSfQoCRcLN5A0t4DkuVhTMXIz
uQ8CnykhExD6x4e6ebIbrjZLb7L+ocR0y4YjCl/Pd4MXU91y0vTipgr/O75CDUHDRHCCKBVm
z/Rzkc/b970MEeHt5LC3NiWTgBSvrLEuVzBKM586YoRD9Dy3OHQgWI270g+5MYA8GfgI/EPT
5G7xPbCDz+zjdH89PeR3U4So4lSXur6H6vp+m9TQXPF3a0LwZrp8MQ+Z77U1uL7TelWO5lAp
sbAonrqASfTpaprFVkL4nyGH+NHST2ZJPWIBk81i6Vw0ny0qZW2Niy/QvVNKbb43A43ny076
khXO7cNbBIRdJ/6qQNq9Bqb5C0Q5nEsFcj75oxQRqlKf6TcvGbjxkJh8BYtv9ePsXklAxtm8
J7GCUBthHSQgepbkOexhJ0wP8imUkyiPHQ0GvEnd83129fZjoEhdGwXV27ioRKbj/cIq7JRX
un0NbeY+UdMYu9jGfIpDLtUUGSgsg2zMGs5R4jCCBiQwggUMoAMCAQICAwo/3zANBgkqhkiG
9w0BAQsFADCBjDELMAkGA1UEBhMCSUwxFjAUBgNVBAoTDVN0YXJ0Q29tIEx0ZC4xKzApBgNV
BAsTIlNlY3VyZSBEaWdpdGFsIENlcnRpZmljYXRlIFNpZ25pbmcxODA2BgNVBAMTL1N0YXJ0
Q29tIENsYXNzIDEgUHJpbWFyeSBJbnRlcm1lZGlhdGUgQ2xpZW50IENBMB4XDTE0MDYxNjAw
NDQ1NVoXDTE1MDYxNjE3MzYyNFowQDEbMBkGA1UEAwwSaS5ncm9rQGNvbWNhc3QubmV0MSEw
HwYJKoZIhvcNAQkBFhJpLmdyb2tAY29tY2FzdC5uZXQwggEiMA0GCSqGSIb3DQEBAQUAA4IB
DwAwggEKAoIBAQC3HoziY3IySZbVkCfbjfgjTKO5CISA2+1GKzBNbzycTCXBWLnHvzrlFPlI
17z3noLux8ebSYz+TFiCUuVdwKkFOpN0WWxGzD6K/Hb0AJtKZp62YKtyRkCV51n5NrEepo28
hFkRhjgSkZA9t/4vtaWt0Ds8pIpUoQ1sNaUDWzjJ3UALl7m6b3XZmIouND+jq1AQv0ivMLuk
QNXO2a0KcuRVHDhAEdBvTi9LSePi8+Q8UWWBOeWmGhiKwL5X98Ne03GKxxQnLXDJbrX+cNcC
uaZIPdrmhbZCo+zegLfrApLRu9/6ox6/dnRsvmMpGcjNKLCgKoEh4cwyb+mhyzPXWlpXAgMB
AAGjggLYMIIC1DAJBgNVHRMEAjAAMAsGA1UdDwQEAwIEsDAdBgNVHSUEFjAUBggrBgEFBQcD
AgYIKwYBBQUHAwQwHQYDVR0OBBYEFKtASVM24m5BiMPABLNlKft1oxbCMB8GA1UdIwQYMBaA
FFNy7ZKc4NrLAVx8fpY1TvLUuFGCMB0GA1UdEQQWMBSBEmkuZ3Jva0Bjb21jYXN0Lm5ldDCC
AUwGA1UdIASCAUMwggE/MIIBOwYLKwYBBAGBtTcBAgMwggEqMC4GCCsGAQUFBwIBFiJodHRw
Oi8vd3d3LnN0YXJ0c3NsLmNvbS9wb2xpY3kucGRmMIH3BggrBgEFBQcCAjCB6jAnFiBTdGFy
dENvbSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTADAgEBGoG+VGhpcyBjZXJ0aWZpY2F0ZSB3
YXMgaXNzdWVkIGFjY29yZGluZyB0byB0aGUgQ2xhc3MgMSBWYWxpZGF0aW9uIHJlcXVpcmVt
ZW50cyBvZiB0aGUgU3RhcnRDb20gQ0EgcG9saWN5LCByZWxpYW5jZSBvbmx5IGZvciB0aGUg
aW50ZW5kZWQgcHVycG9zZSBpbiBjb21wbGlhbmNlIG9mIHRoZSByZWx5aW5nIHBhcnR5IG9i
bGlnYXRpb25zLjA2BgNVHR8ELzAtMCugKaAnhiVodHRwOi8vY3JsLnN0YXJ0c3NsLmNvbS9j
cnR1MS1jcmwuY3JsMIGOBggrBgEFBQcBAQSBgTB/MDkGCCsGAQUFBzABhi1odHRwOi8vb2Nz
cC5zdGFydHNzbC5jb20vc3ViL2NsYXNzMS9jbGllbnQvY2EwQgYIKwYBBQUHMAKGNmh0dHA6
Ly9haWEuc3RhcnRzc2wuY29tL2NlcnRzL3N1Yi5jbGFzczEuY2xpZW50LmNhLmNydDAjBgNV
HRIEHDAahhhodHRwOi8vd3d3LnN0YXJ0c3NsLmNvbS8wDQYJKoZIhvcNAQELBQADggEBALTg
t4rndUh0up2qJuskCTx4iRQd59+R0kOm7vJa94t+fSa8Wip4WeVOJZaHs1XIp17yoLTzcXN9
+L5lTC7HaHrBGOdB8su0muQyS///XwbDgn3/9+D0stPJZYLMrfRSm/FzQEk5j5McmODTCq8a
tQrlQilnBDcY00CYKBTKGAleOPjQ8yg/QVb/uqNuKE88+mfEdc6AKykYg7VXqxdL54ylqR3o
P8+PsP1YgCE2wqWWfGUp6hxIKa2XGtqVdHqL1yc5equX97TiUiIQ51j+nmU8tXTuR7OPRA1B
cHA+jx6rchpnZMEJn9DYPFOvkkC86mxOCax9r5HOtdidcw8uZSoxggKXMIICkwIBATCBlDCB
jDELMAkGA1UEBhMCSUwxFjAUBgNVBAoTDVN0YXJ0Q29tIEx0ZC4xKzApBgNVBAsTIlNlY3Vy
ZSBEaWdpdGFsIENlcnRpZmljYXRlIFNpZ25pbmcxODA2BgNVBAMTL1N0YXJ0Q29tIENsYXNz
IDEgUHJpbWFyeSBJbnRlcm1lZGlhdGUgQ2xpZW50IENBAgMKP98wCQYFKw4DAhoFAKCB2DAY
BgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xNTAyMDUwNjExNDJa
MCMGCSqGSIb3DQEJBDEWBBSZDpRXPBsNimODQ2XksjcaqP6/wTB5BgkqhkiG9w0BCQ8xbDBq
MAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMA4G
CCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDAN
BgkqhkiG9w0BAQEFAASCAQBG4HUjR63m/TLQlQY/rfw/XN9XiAj3QYV02lInFHp+IHuz9jnq
Nuu4vS2vtmDG1LLlOzNq+FHLz3r9XfBToPi+RwZKAKb4vG/oOUxXXxQ02DfBKbdep0vEq3xs
wBkn8mA2Hg6FaveBWajGrHgLKw3Gg0JnJChIXZPR1b8S9t0TUy3Z4T1kdhduuSSJBQhJ+HwR
tAkO/lMW0BsxO1F65ESb46d+hbs8kZjg3C4tjy1h9JDIWdwJ1Rd81N89b7F1171+T2GHhQC9
dR2vcEOUjt9QGV7AA1X26dzSGdlGS3SMlyOuXKZIv93df31AUAnF01RpG+am0tHISCQvKkG6
+b0w

--WIyZ46R2i8wDzkSu--
