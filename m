From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] i18n: disable i18n for shell scripts if NO_GETTEXT defined
Date: Tue, 17 Jan 2012 14:42:01 +0100
Message-ID: <CALxABCZME-g++HxMsD4Nrn1J6s27vN7M_KQSVT3PeLWBqP7qJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=e89a8f6436f82ae55c04b6b98071
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 17 14:42:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rn9Iy-0004jd-Lk
	for gcvg-git-2@lo.gmane.org; Tue, 17 Jan 2012 14:42:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753558Ab2AQNmX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jan 2012 08:42:23 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:44784 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753293Ab2AQNmW (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Jan 2012 08:42:22 -0500
Received: by obcva7 with SMTP id va7so5849336obc.19
        for <git@vger.kernel.org>; Tue, 17 Jan 2012 05:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=ZAVa6nsFTqY9MHrqowP2cE4pTxiX2FRA3Tz02eF3v3A=;
        b=vt0AgVRPz69S41BXm3xYMYGq8/ccNw5T01W7rt2YMVPNL+X//PIZijXWHzgzKqXSxz
         khfTGyZmYedgc7CMyVD37BKvCdNJN1IkQnZYXQUSHZ+y9hg3LSUXI5MN3kDMhFPvLYOf
         Gt/mtWKEPAT+wo6pT0G3xwrnAi9Y/aqsLX+7Y=
Received: by 10.182.131.37 with SMTP id oj5mr15085132obb.63.1326807742342;
 Tue, 17 Jan 2012 05:42:22 -0800 (PST)
Received: by 10.182.226.41 with HTTP; Tue, 17 Jan 2012 05:42:01 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188706>

--e89a8f6436f82ae55c04b6b98071
Content-Type: text/plain; charset=UTF-8

Otherwise the i18n is used in the scripts even with NO_GETTEXT set.
It is very unexpected.

---

I usually disable i18n on my working systems as they are generally very
out-of-date and not supported by any sane developer. In particular the
gettext provided with this (very old) Cygwin distribution is fubar and
never produces any output.

 Makefile       |    1 +
 git-sh-i18n.sh |    4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index a782409..d82ea6a 100644
--- a/Makefile
+++ b/Makefile
@@ -1887,6 +1887,7 @@ sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
     -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
     -e 's|@@LOCALEDIR@@|$(localedir_SQ)|g' \
     -e 's/@@NO_CURL@@/$(NO_CURL)/g' \
+    -e 's/@@NO_GETTEXT@@/$(NO_GETTEXT)/g' \
     -e $(BROKEN_PATH_FIX) \
     $@.sh >$@+
 endef
diff --git a/git-sh-i18n.sh b/git-sh-i18n.sh
index b4575fb..7f7e32b 100644
--- a/git-sh-i18n.sh
+++ b/git-sh-i18n.sh
@@ -18,7 +18,7 @@ export TEXTDOMAINDIR

 if test -z "$GIT_GETTEXT_POISON"
 then
-	if test -z "$GIT_INTERNAL_GETTEXT_TEST_FALLBACKS" && type gettext.sh
>/dev/null 2>&1
+	if test -z "@@NO_GETTEXT@@" && test -z
"$GIT_INTERNAL_GETTEXT_TEST_FALLBACKS" && type gettext.sh >/dev/null
2>&1
 	then
 		# This is GNU libintl's gettext.sh, we don't need to do anything
 		# else than setting up the environment and loading gettext.sh
@@ -29,7 +29,7 @@ then
 		# can't.
 		. gettext.sh

-	elif test -z "$GIT_INTERNAL_GETTEXT_TEST_FALLBACKS" && test
"$(gettext -h 2>&1)" = "-h"
+	elif test -z "@@NO_GETTEXT@@" && test -z
"$GIT_INTERNAL_GETTEXT_TEST_FALLBACKS" && test "$(gettext -h 2>&1)" =
"-h"
 	then
 		# We don't have gettext.sh, but there's a gettext binary in our
 		# path. This is probably Solaris or something like it which has a
-- 
1.7.8.2.388.ge40c2

--e89a8f6436f82ae55c04b6b98071
Content-Type: text/x-patch; charset=US-ASCII; 
	name="0001-disable-i18n-for-shell-scripts-if-NO_GETTEXT-def.diff"
Content-Disposition: attachment; 
	filename="0001-disable-i18n-for-shell-scripts-if-NO_GETTEXT-def.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gxiyzb9r0

RnJvbSAzNmU3M2ZlMTRjYmVjZDA0NTEyYTZlOGEyMWI5ZWIxNGQyNzhkMWRjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgpEYXRl
OiBUdWUsIDE3IEphbiAyMDEyIDE0OjI1OjI0ICswMTAwClN1YmplY3Q6IFtQQVRDSF0gaTE4bjog
ZGlzYWJsZSBpMThuIGZvciBzaGVsbCBzY3JpcHRzIGlmIE5PX0dFVFRFWFQgZGVmaW5lZAoKT3Ro
ZXJ3aXNlIHRoZSBpMThuIGlzIHVzZWQgaW4gdGhlIHNjcmlwdHMgZXZlbiB3aXRoIE5PX0dFVFRF
WFQgc2V0LgpJdCBpcyB2ZXJ5IHVuZXhwZWN0ZWQuCgpJIGdlbmVyYWxseSBkaXNhYmxlIGkxOG4g
b24gbXkgd29ya2luZyBzeXN0ZW1zIGFzIHRoZXkgYXJlIGdlbmVyYWxseSB2ZXJ5Cm91dC1vZi1k
YXRlIGFuZCBub3Qgc3VwcG9ydGVkIGJ5IGFueSBzYW5lIGRldmVsb3Blci4gSW4gcGFydGljdWxh
ciB0aGUKZ2V0dGV4dCBwcm92aWRlZCB3aXRoIHRoaXMgKHZlcnkgb2xkKSBDeWd3aW4gZGlzdHJp
YnV0aW9uIGlzIGZ1YmFyIGFuZApuZXZlciBwcm9kdWNlcyBhbnkgb3V0cHV0LgotLS0KIE1ha2Vm
aWxlICAgICAgIHwgICAgMSArCiBnaXQtc2gtaTE4bi5zaCB8ICAgIDQgKystLQogMiBmaWxlcyBj
aGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvTWFr
ZWZpbGUgYi9NYWtlZmlsZQppbmRleCBhNzgyNDA5Li5kODJlYTZhIDEwMDY0NAotLS0gYS9NYWtl
ZmlsZQorKysgYi9NYWtlZmlsZQpAQCAtMTg4Nyw2ICsxODg3LDcgQEAgc2VkIC1lICcxc3wjIS4q
L3NofCMhJChTSEVMTF9QQVRIX1NRKXwnIFwKICAgICAtZSAncy9AQEdJVF9WRVJTSU9OQEAvJChH
SVRfVkVSU0lPTikvZycgXAogICAgIC1lICdzfEBATE9DQUxFRElSQEB8JChsb2NhbGVkaXJfU1Ep
fGcnIFwKICAgICAtZSAncy9AQE5PX0NVUkxAQC8kKE5PX0NVUkwpL2cnIFwKKyAgICAtZSAncy9A
QE5PX0dFVFRFWFRAQC8kKE5PX0dFVFRFWFQpL2cnIFwKICAgICAtZSAkKEJST0tFTl9QQVRIX0ZJ
WCkgXAogICAgICRALnNoID4kQCsKIGVuZGVmCmRpZmYgLS1naXQgYS9naXQtc2gtaTE4bi5zaCBi
L2dpdC1zaC1pMThuLnNoCmluZGV4IGI0NTc1ZmIuLjdmN2UzMmIgMTAwNjQ0Ci0tLSBhL2dpdC1z
aC1pMThuLnNoCisrKyBiL2dpdC1zaC1pMThuLnNoCkBAIC0xOCw3ICsxOCw3IEBAIGV4cG9ydCBU
RVhURE9NQUlORElSCiAKIGlmIHRlc3QgLXogIiRHSVRfR0VUVEVYVF9QT0lTT04iCiB0aGVuCi0J
aWYgdGVzdCAteiAiJEdJVF9JTlRFUk5BTF9HRVRURVhUX1RFU1RfRkFMTEJBQ0tTIiAmJiB0eXBl
IGdldHRleHQuc2ggPi9kZXYvbnVsbCAyPiYxCisJaWYgdGVzdCAteiAiQEBOT19HRVRURVhUQEAi
ICYmIHRlc3QgLXogIiRHSVRfSU5URVJOQUxfR0VUVEVYVF9URVNUX0ZBTExCQUNLUyIgJiYgdHlw
ZSBnZXR0ZXh0LnNoID4vZGV2L251bGwgMj4mMQogCXRoZW4KIAkJIyBUaGlzIGlzIEdOVSBsaWJp
bnRsJ3MgZ2V0dGV4dC5zaCwgd2UgZG9uJ3QgbmVlZCB0byBkbyBhbnl0aGluZwogCQkjIGVsc2Ug
dGhhbiBzZXR0aW5nIHVwIHRoZSBlbnZpcm9ubWVudCBhbmQgbG9hZGluZyBnZXR0ZXh0LnNoCkBA
IC0yOSw3ICsyOSw3IEBAIHRoZW4KIAkJIyBjYW4ndC4KIAkJLiBnZXR0ZXh0LnNoCiAKLQllbGlm
IHRlc3QgLXogIiRHSVRfSU5URVJOQUxfR0VUVEVYVF9URVNUX0ZBTExCQUNLUyIgJiYgdGVzdCAi
JChnZXR0ZXh0IC1oIDI+JjEpIiA9ICItaCIKKwllbGlmIHRlc3QgLXogIkBATk9fR0VUVEVYVEBA
IiAmJiB0ZXN0IC16ICIkR0lUX0lOVEVSTkFMX0dFVFRFWFRfVEVTVF9GQUxMQkFDS1MiICYmIHRl
c3QgIiQoZ2V0dGV4dCAtaCAyPiYxKSIgPSAiLWgiCiAJdGhlbgogCQkjIFdlIGRvbid0IGhhdmUg
Z2V0dGV4dC5zaCwgYnV0IHRoZXJlJ3MgYSBnZXR0ZXh0IGJpbmFyeSBpbiBvdXIKIAkJIyBwYXRo
LiBUaGlzIGlzIHByb2JhYmx5IFNvbGFyaXMgb3Igc29tZXRoaW5nIGxpa2UgaXQgd2hpY2ggaGFz
IGEKLS0gCjEuNy44LjIuMzg4LmdlNDBjMgoK
--e89a8f6436f82ae55c04b6b98071--
