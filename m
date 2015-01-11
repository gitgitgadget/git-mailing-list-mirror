From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: [PATCH v3] gettext.h: add parentheses around N_ expansion if supported
Date: Sun, 11 Jan 2015 12:09:22 -0800
Message-ID: <47914a9078cc9d272204ec00825d67f@74d39fa044aa309eaea14b9f57fe79c>
Cc: Git mailing list <git@vger.kernel.org>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 11 21:09:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YAOpM-0005b2-QY
	for gcvg-git-2@plane.gmane.org; Sun, 11 Jan 2015 21:09:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751651AbbAKUJc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2015 15:09:32 -0500
Received: from mail-pa0-f48.google.com ([209.85.220.48]:50340 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750825AbbAKUJb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2015 15:09:31 -0500
Received: by mail-pa0-f48.google.com with SMTP id rd3so28321917pab.7
        for <git@vger.kernel.org>; Sun, 11 Jan 2015 12:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=1fzyZiDlS5amQEY6/xDNNskNk1khPnp9eIhr8i2pHbM=;
        b=C2mW7IJPtPgVZwlkfv1jMGDaz/Br0P+PTqwzztwAn/yNhflAhQtW9J3IS+JyKTEHN9
         gYdCTQjA4IOUfKwCaWRTChdlyU7W12kNhEjjCwuHh8QIc5h7N8Ax/0eowALrzAus4uA9
         fdrwFO57zuo+6X6Jpt80KyH+vbVK0gAL7ONgxSZIObcPe5NmskclL6/Vp9TQxSRbYsi1
         1u+ZwO0xrsOBYXq41260Bc6s7FfYJAClg9EnPFgSqIAMunC/SHUKw7VYMg3ucbg3zBr1
         S2VuLFFGVMJGDuA2ZAO5g2I9IBNA0SllapbCJPNDVKDAl7/wsEj5nT8uNQ9xBc/g2hRV
         eOJA==
X-Received: by 10.66.159.202 with SMTP id xe10mr32170576pab.46.1421006970855;
        Sun, 11 Jan 2015 12:09:30 -0800 (PST)
Received: from localhost.localdomain (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id e2sm12504180pdo.11.2015.01.11.12.09.29
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 11 Jan 2015 12:09:30 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262283>

The gettext N_ macro is used to mark strings for translation
without actually translating them.  At runtime the string is
expected to be passed to the gettext API for translation.

If two N_ macro invocations appear next to each other with only
whitespace (or nothing at all) between them, the two separate
strings will be marked for translation, but the preprocessor
will then silently combine the strings into one and at runtime
the string passed to gettext will not match the strings that
were translated so no translation will actually occur.

Avoid this by adding parentheses around the expansion of the
N_ macro so that instead of ending up with two adjacent strings
that are then combined by the preprocessor, two adjacent strings
surrounded by parentheses result instead which causes a compile
error so the mistake can be quickly found and corrected.

However, since these string literals are typically assigned to
static variables and not all compilers support parenthesized
string literal assignments, allow this to be controlled by the
Makefile with the default only enabled when the compiler is
known to support the syntax.

For now only __GNUC__ enables this by default which covers both
gcc and clang which should result in early detection of any
adjacent N_ macros.

Although the necessary tests make the affected files a bit less
elegant, the benefit of avoiding propagation of a translation-
marking error to all the translation teams thus creating extra
work for them when the error is eventually detected and fixed
would seem to outweigh the minor inelegance the additional
configuration tests introduce.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
---

The "yes", "no", "auto" settings for the new Makefile configuration
variable "USE_PARENS_AROUND_GETTEXT_N" are based on the way the
Makefile variable "COMPUTE_HEADER_DEPENDENCIES" works.  So I used
"yes" and "no" for consistency instead of "Yes" and "No".

 Makefile          | 17 +++++++++++++++++
 gettext.h         | 24 ++++++++++++++++++++++++
 git-compat-util.h |  4 ++++
 3 files changed, 45 insertions(+)

diff --git a/Makefile b/Makefile
index 06e5d243..0f3fbccf 100644
--- a/Makefile
+++ b/Makefile
@@ -343,6 +343,15 @@ all::
 # return NULL when it receives a bogus time_t.
 #
 # Define HAVE_CLOCK_GETTIME if your platform has clock_gettime in librt.
+#
+# Define USE_PARENS_AROUND_GETTEXT_N to "yes" if your compiler happily
+# compiles the following initialization:
+#
+#   static const char s[] = ("FOO");
+#
+# and define it to "no" if you need to remove the parentheses () around the
+# constant.  The default is "auto", which means to use parentheses if your
+# compiler is detected to support it.
 
 GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -950,6 +959,14 @@ ifneq (,$(SOCKLEN_T))
 	BASIC_CFLAGS += -Dsocklen_t=$(SOCKLEN_T)
 endif
 
+ifeq (yes,$(USE_PARENS_AROUND_GETTEXT_N))
+	BASIC_CFLAGS += -DUSE_PARENS_AROUND_GETTEXT_N=1
+else
+ifeq (no,$(USE_PARENS_AROUND_GETTEXT_N))
+	BASIC_CFLAGS += -DUSE_PARENS_AROUND_GETTEXT_N=0
+endif
+endif
+
 ifeq ($(uname_S),Darwin)
 	ifndef NO_FINK
 		ifeq ($(shell test -d /sw/lib && echo y),y)
diff --git a/gettext.h b/gettext.h
index 7671d09d..dc1722dd 100644
--- a/gettext.h
+++ b/gettext.h
@@ -63,6 +63,30 @@ const char *Q_(const char *msgid, const char *plu, unsigned long n)
 }
 
 /* Mark msgid for translation but do not translate it. */
+#if !USE_PARENS_AROUND_GETTEXT_N
 #define N_(msgid) msgid
+#else
+/*
+ * Strictly speaking, this will lead to invalid C when
+ * used this way:
+ *	static const char s[] = N_("FOO");
+ * which will expand to
+ *	static const char s[] = ("FOO");
+ * and in valid C, the initializer on the right hand side must
+ * be without the parentheses.  But many compilers do accept it
+ * as a language extension and it will allow us to catch mistakes
+ * like:
+ *	static const char *msgs[] = {
+ *		N_("one")
+ *		N_("two"),
+ *		N_("three"),
+ *		NULL
+ *	};
+ * (notice the missing comma on one of the lines) by forcing
+ * a compilation error, because parenthesised ("one") ("two")
+ * will not get silently turned into ("onetwo").
+ */
+#define N_(msgid) (msgid)
+#endif
 
 #endif
diff --git a/git-compat-util.h b/git-compat-util.h
index dcecd857..107e68e1 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -867,4 +867,8 @@ struct tm *git_gmtime_r(const time_t *, struct tm *);
 #define gmtime_r git_gmtime_r
 #endif
 
+#if !defined(USE_PARENS_AROUND_GETTEXT_N) && defined(__GNUC__)
+#define USE_PARENS_AROUND_GETTEXT_N 1
+#endif
+
 #endif
-- 
2.1.4
