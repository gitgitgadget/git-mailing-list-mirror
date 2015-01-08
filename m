From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: [PATCH v2] gettext.h: add parentheses around N_ expansion if supported
Date: Thu,  8 Jan 2015 00:46:55 -0800
Message-ID: <aea96640a01b65776eb0474aaceded5@74d39fa044aa309eaea14b9f57fe79c>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 08 09:51:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y98kK-0008Rh-Kg
	for gcvg-git-2@plane.gmane.org; Thu, 08 Jan 2015 09:47:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755950AbbAHIrG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2015 03:47:06 -0500
Received: from mail-pa0-f50.google.com ([209.85.220.50]:36544 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754641AbbAHIrF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2015 03:47:05 -0500
Received: by mail-pa0-f50.google.com with SMTP id bj1so10443149pad.9
        for <git@vger.kernel.org>; Thu, 08 Jan 2015 00:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=HMwMFzlxZviZAEMFrAqCL9wWbbmIFf7yJ4OjPwgi8zo=;
        b=p9DrC3mJ38517K0YyEnN+WN5//qXsX+rb5Gv+/7fnfrTs8RS6AqydbZbM05lC6DmGa
         LmuGQs2kmopCXTAATxsqQtlJU6E9+E23yZyMKNWkDRjB+CuV3sLd9S2G4ZCp2zuxLsiW
         +m5MZJ3fXORiB/XVZO7HKFlvwCHuV1Z249JlzFP5DhV5gZRUbmP4XJZb7SkOkFXSwbVg
         g1Rp+UITAJq6w3ueLrpEStocvZ6d+0hcX6t5tUiXl5UiP7/H14Q6ndq5Hxoyb/eEjpeI
         xq6sfQgTZfGDK7a4RHBjZtcOESM8nIYfuNJWszbzUYBwggpImZZkVuHYgQHue2+AANJs
         c1Pw==
X-Received: by 10.70.37.79 with SMTP id w15mr12882199pdj.43.1420706824621;
        Thu, 08 Jan 2015 00:47:04 -0800 (PST)
Received: from localhost.localdomain (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id r1sm3840587pdb.24.2015.01.08.00.47.03
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 08 Jan 2015 00:47:03 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262185>

The N_ macro is used to mark strings for translation without
actually translating them.  At runtime the string is expected
to be passed to the gettext API for translation.

If two N_ macro invocations appear next to each other with only
whitespace (or nothing at all) between them, the two separate
strings will be marked for translation, but the preprocessor
will then combine the strings into one and at runtime the
string passed to gettext will not match the strings that were
translated.

Avoid this by adding parentheses around the expansion of the
N_ macro so that instead of ending up with two adjacent strings
that are then combined by the preprocessor, two adjacent strings
surrounded by parentheses result instead which causes a compile
error so the mistake can be quickly found and corrected.

However, since these string literals are typically assigned to
static variables and not all compilers support parenthesized
string literal assignments, only add the parentheses when the
compiler is known to support the syntax.

For now only __GNUC__ is tested which covers both gcc and clang
which should result in early detection of any adjacent N_ macros.

Although the necessary #ifdef makes the header less elegant,
the benefit of avoiding propagation of a translation-marking
error to all the translation teams thus creating extra work
for them when the error is eventually detected and fixed would
seem to outweigh the minor inelegance the #ifdef introduces.

Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
---
 gettext.h | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/gettext.h b/gettext.h
index 7671d09d..80ec29b5 100644
--- a/gettext.h
+++ b/gettext.h
@@ -62,7 +62,19 @@ const char *Q_(const char *msgid, const char *plu, unsigned long n)
 	return ngettext(msgid, plu, n);
 }
 
-/* Mark msgid for translation but do not translate it. */
+/* Mark msgid for translation but do not translate it.
+ *
+ * In order to prevent accidents where two adjacent N_ macros
+ * are mistakenly used, this macro is defined with parentheses
+ * when the compiler is known to support parenthesized string
+ * literal assignments.  This guarantees a compiler error in
+ * such a case rather than a silent conjoining of the strings
+ * by the preprocessor which results in translation failures.
+ */
+#ifdef __GNUC__
+#define N_(msgid) (msgid)
+#else
 #define N_(msgid) msgid
+#endif
 
 #endif
-- 
2.1.4
