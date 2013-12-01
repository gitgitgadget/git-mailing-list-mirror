From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3] gettext.c: detect the vsnprintf bug at runtime
Date: Sun,  1 Dec 2013 09:45:38 +0700
Message-ID: <1385865938-16392-1-git-send-email-pclouds@gmail.com>
References: <1385812884-23776-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Niedier <jrnieder@gmail.com>, vnwildman@gmail.com,
	schwab@linux-m68k.org, tboegi@web.de,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 01 03:41:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VmwyP-00007X-5W
	for gcvg-git-2@plane.gmane.org; Sun, 01 Dec 2013 03:41:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452Ab3LAClE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Nov 2013 21:41:04 -0500
Received: from mail-pb0-f52.google.com ([209.85.160.52]:45392 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751328Ab3LAClB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Nov 2013 21:41:01 -0500
Received: by mail-pb0-f52.google.com with SMTP id uo5so16637259pbc.11
        for <git@vger.kernel.org>; Sat, 30 Nov 2013 18:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=1I3X9/knhhZitD3QMkuj/f4l7UNR3tLN0Ut86yX94+M=;
        b=AxSHOU/DVw1wUbKYe3Uix8M7icNFkEUQ+b/+fNCcfzoVoizYVMCx1SjSlz2DWea0Xk
         oRjQjqmdM/k+9s0kUg+HhVzCYmOuoyxaZDZXlr0MTCkJsOXaOFrCWTl3hzp8UCHhJiXl
         +D58WPM6TdywUfqpnSOhcB2WyF6iSSoPlsxlssjBKTmWpcV3P9Qan0TdfoEHULIt+ECk
         2m4R+t+ei8CAgOhBtVNtFjxWx5n1vn3ybnwVw8SBCPAA9LHG9UqznIw6+Ar+7O2XnGsJ
         fyTNwp9w+YghT08caJxlTFfrLca7Clwxs4zjxdtIeGdJgjtaufOtcZz+cgfakdjfglgo
         UxeA==
X-Received: by 10.69.19.225 with SMTP id gx1mr24247721pbd.62.1385865660827;
        Sat, 30 Nov 2013 18:41:00 -0800 (PST)
Received: from lanh ([115.73.231.156])
        by mx.google.com with ESMTPSA id xe9sm127295303pab.0.2013.11.30.18.40.56
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 30 Nov 2013 18:40:59 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 01 Dec 2013 09:45:39 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1385812884-23776-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238577>

Bug 6530 [1] in glibc causes "git show v0.99.6~1" to fail with error
"your vsnprintf is broken". The workaround avoids that, but it
corrupts system error messages in non-C locales.

The bug has been fixed since 2.17. We could know running glibc version
with gnu_get_libc_version(). But version is not a sure way to detect
the bug because downstream may back port the fix to older versions. Do
a runtime test that immitates the call flow that leads to "your
vsnprintf is broken". Only enable the workaround if the test fails.

Tested on Gentoo Linux, glibc 2.16.0 and 2.17, amd64.

[1] http://sourceware.org/bugzilla/show_bug.cgi?id=3D6530

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 v3 goes with runtime test instead of version check.

 gettext.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/gettext.c b/gettext.c
index 71e9545..eed7c7f 100644
--- a/gettext.c
+++ b/gettext.c
@@ -29,6 +29,17 @@ int use_gettext_poison(void)
 #endif
=20
 #ifndef NO_GETTEXT
+static int test_vsnprintf(const char *fmt, ...)
+{
+	char buf[26];
+	int ret;
+	va_list ap;
+	va_start(ap, fmt);
+	ret =3D vsnprintf(buf, sizeof(buf), fmt, ap);
+	va_end(ap);
+	return ret;
+}
+
 static const char *charset;
 static void init_gettext_charset(const char *domain)
 {
@@ -99,9 +110,7 @@ static void init_gettext_charset(const char *domain)
 	   $ LANGUAGE=3D LANG=3Dde_DE.utf8 ./test
 	   test: Kein passendes Ger?t gefunden
=20
-	   In the long term we should probably see about getting that
-	   vsnprintf bug in glibc fixed, and audit our code so it won't
-	   fall apart under a non-C locale.
+	   The vsnprintf bug has been fixed since glibc 2.17.
=20
 	   Then we could simply set LC_CTYPE from the environment, which woul=
d
 	   make things like the external perror(3) messages work.
@@ -115,7 +124,9 @@ static void init_gettext_charset(const char *domain=
)
 	setlocale(LC_CTYPE, "");
 	charset =3D locale_charset();
 	bind_textdomain_codeset(domain, charset);
-	setlocale(LC_CTYPE, "C");
+	/* the string is taken from v0.99.6~1 */
+	if (test_vsnprintf("%.*s", 13, "David_K\345gedal") < 0)
+		setlocale(LC_CTYPE, "C");
 }
=20
 void git_setup_gettext(void)
--=20
1.8.2.83.gc99314b
