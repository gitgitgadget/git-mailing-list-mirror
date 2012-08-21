From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] Build in gettext poison feature unconditionally
Date: Tue, 21 Aug 2012 11:39:30 +0700
Message-ID: <1345523970-14914-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 21 06:39:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3gFs-0001ta-PB
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 06:39:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751878Ab2HUEju convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Aug 2012 00:39:50 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:39824 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750952Ab2HUEjr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2012 00:39:47 -0400
Received: by pbbrr13 with SMTP id rr13so7922805pbb.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 21:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=roCbnfdSecWVAn/J/ZGt7f2PSkSLBtvYc6tWIl5pDhU=;
        b=zn8d1qQi1dkYm3zrvb88d6gpKOfRtyhaENVJnsq/HXNR36Bo3qjSglMqkTjonkSoD1
         71n7gz99pasfhnDTis3O2F8mwXS/Su5mFx3lMgoVAdsujYmRleXsuujAKWh96+h1fQId
         IPmGx5gddNmoCfqWeOC8derpYObthZ+pOqtPLRkT4424LS4QHQiel/SvH5mqdoU76IUK
         1x8TXdLmyF2GS4id2bYnNyLlJiNoNRBDmKBUFdU0CAh8Cu+zBD+qzHmtAMQm2rtoqZGD
         Mh4TJtMX7tVzV8KBZAJDiCYDsiPThbb7ol2wVNRtiWCTQ+/sgcQZ6YPLjNaJW1LB29jX
         RvUw==
Received: by 10.68.221.42 with SMTP id qb10mr40328361pbc.155.1345523987086;
        Mon, 20 Aug 2012 21:39:47 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id oc2sm577048pbb.69.2012.08.20.21.39.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 21:39:46 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 21 Aug 2012 11:39:31 +0700
X-Mailer: git-send-email 1.7.12.rc2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203934>

Making gettext poison second citizen makes it easy to forget to run
the test suite with it. This is step one to running test suite with
gettext poison by default.

The runtime cost should be small. "gcc -O2" inlines _() and
use_gettext_poison(). But even if it does not, performance should not
be impacted as _() calls are usually not on critical path. If some of
them are, we better fix there as gettext() may or may not be cheap
anyway.

A new target is added to run test with poisoned gettext: test-poison

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 I don't know the story behind this compile-time switch. The series [1]
 that introduces it does not say much.

 This at least makes it easier for me to run poison tests instead of
 building another binary, if I remember it. Next step could be make
 "make test" run both normal and poison modes, but I'm not sure how to
 do it nicely yet.

 [1] http://thread.gmane.org/gmane.comp.version-control.git/167307/focu=
s=3D167438

 Makefile  | 12 +++---------
 gettext.c | 10 ----------
 gettext.h | 12 +++++++-----
 po/README | 13 ++++---------
 4 files changed, 14 insertions(+), 33 deletions(-)

diff --git a/Makefile b/Makefile
index 6b0c961..8255fb9 100644
--- a/Makefile
+++ b/Makefile
@@ -258,11 +258,6 @@ all::
 # Define HAVE_DEV_TTY if your system can open /dev/tty to interact wit=
h the
 # user.
 #
-# Define GETTEXT_POISON if you are debugging the choice of strings mar=
ked
-# for translation.  In a GETTEXT_POISON build, you can turn all string=
s marked
-# for translation into gibberish by setting the GIT_GETTEXT_POISON var=
iable
-# (to any value) in your environment.
-#
 # Define JSMIN to point to JavaScript minifier that functions as
 # a filter to have gitweb.js minified.
 #
@@ -1594,9 +1589,6 @@ endif
 ifdef NO_SYMLINK_HEAD
 	BASIC_CFLAGS +=3D -DNO_SYMLINK_HEAD
 endif
-ifdef GETTEXT_POISON
-	BASIC_CFLAGS +=3D -DGETTEXT_POISON
-endif
 ifdef NO_GETTEXT
 	BASIC_CFLAGS +=3D -DNO_GETTEXT
 	USE_GETTEXT_SCHEME ?=3D fallthrough
@@ -2497,7 +2489,6 @@ ifdef GIT_TEST_CMP_USE_COPIED_CONTEXT
 	@echo GIT_TEST_CMP_USE_COPIED_CONTEXT=3DYesPlease >>$@
 endif
 	@echo NO_GETTEXT=3D\''$(subst ','\'',$(subst ','\'',$(NO_GETTEXT)))'\=
' >>$@
-	@echo GETTEXT_POISON=3D\''$(subst ','\'',$(subst ','\'',$(GETTEXT_POI=
SON)))'\' >>$@
 ifdef GIT_PERF_REPEAT_COUNT
 	@echo GIT_PERF_REPEAT_COUNT=3D\''$(subst ','\'',$(subst ','\'',$(GIT_=
PERF_REPEAT_COUNT)))'\' >>$@
 endif
@@ -2545,6 +2536,9 @@ export NO_SVN_TESTS
 test: all
 	$(MAKE) -C t/ all
=20
+poison-test: all
+	$(MAKE) POISON_GETTEXT=3DYesPlease -C t/ all
+
 perf: all
 	$(MAKE) -C t/perf/ all
=20
diff --git a/gettext.c b/gettext.c
index f75bca7..6aa822c 100644
--- a/gettext.c
+++ b/gettext.c
@@ -16,16 +16,6 @@
 #	endif
 #endif
=20
-#ifdef GETTEXT_POISON
-int use_gettext_poison(void)
-{
-	static int poison_requested =3D -1;
-	if (poison_requested =3D=3D -1)
-		poison_requested =3D getenv("GIT_GETTEXT_POISON") ? 1 : 0;
-	return poison_requested;
-}
-#endif
-
 #ifndef NO_GETTEXT
 static void init_gettext_charset(const char *domain)
 {
diff --git a/gettext.h b/gettext.h
index 57ba8bb..a77554f 100644
--- a/gettext.h
+++ b/gettext.h
@@ -36,11 +36,13 @@ static inline void git_setup_gettext(void)
 }
 #endif
=20
-#ifdef GETTEXT_POISON
-extern int use_gettext_poison(void);
-#else
-#define use_gettext_poison() 0
-#endif
+static inline int use_gettext_poison(void)
+{
+	static int poison_requested =3D -1;
+	if (poison_requested =3D=3D -1)
+		poison_requested =3D getenv("GIT_GETTEXT_POISON") ? 1 : 0;
+	return poison_requested;
+}
=20
 static inline FORMAT_PRESERVING(1) const char *_(const char *msgid)
 {
diff --git a/po/README b/po/README
index c1520e8..e25752b 100644
--- a/po/README
+++ b/po/README
@@ -270,16 +270,11 @@ something in the test suite might still depend on=
 the US English
 version of the strings, e.g. to grep some error message or other
 output.
=20
-To smoke out issues like these Git can be compiled with gettext poison
-support, at the top-level:
+To smoke out issues like these you should run the test suite with
+gettext poison support, which emits gibberish on every call to
+gettext:
=20
-    make GETTEXT_POISON=3DYesPlease
-
-That'll give you a git which emits gibberish on every call to
-gettext. It's obviously not meant to be installed, but you should run
-the test suite with it:
-
-    cd t && prove -j 9 ./t[0-9]*.sh
+    cd t && GETTEXT_POISON=3DYesPlease prove -j 9 ./t[0-9]*.sh
=20
 If tests break with it you should inspect them manually and see if
 what you're translating is sane, i.e. that you're not translating
--=20
1.7.12.rc2
