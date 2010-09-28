From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH] gettext: use libcharset when available
Date: Tue, 28 Sep 2010 18:05:26 +0200
Message-ID: <1285689926-5048-1-git-send-email-kusmabite@gmail.com>
Cc: git@vger.kernel.org, Erik Faye-Lund <kusmabite@gmail.com>
To: avarab@gmail.com
X-From: git-owner@vger.kernel.org Tue Sep 28 18:05:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0cgl-0008JL-3T
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 18:05:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754534Ab0I1QFu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Sep 2010 12:05:50 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:51068 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751302Ab0I1QFt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Sep 2010 12:05:49 -0400
Received: by eyb6 with SMTP id 6so1862247eyb.19
        for <git@vger.kernel.org>; Tue, 28 Sep 2010 09:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=x+r3Qo8XGgyX2k3Yam3Pc17DfJLKDQepz9GjOavT7Ww=;
        b=XH6KPN7DNhObWMeH27cB1YhkAp+2OAFXlLV7tTIKW0DMOdQOfY5DUi6TWyFcRkDy4d
         vM6fIzgjgZpQ00PMA6C1pGo32KjmDJNYMkvSRGJHHDYuV6t6JpdsC7FW6Dm2drqDaiDn
         09ycaB5mCpCxXOccGi+xocIWx0NyeiaBmQORo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=gZ1DBspEzJy9TIhGS9d5OOz9WGyGvjAAVA9i6RsEFY7wzL/Cp+Y+Mq67IQvIPg7qpu
         oxnXVrXpQ2Ro7xZCYaMdLzT53rweqZvjVAg2dsF48c4Wn5xoMZpcvdtTv+VNpn2T7sDt
         03DakPIjt2W277aPOR0gw0qWijnYFAhpaUPD4=
Received: by 10.213.10.198 with SMTP id q6mr373551ebq.8.1285689948294;
        Tue, 28 Sep 2010 09:05:48 -0700 (PDT)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id v59sm10665889eeh.16.2010.09.28.09.05.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 28 Sep 2010 09:05:47 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.165.gdfe39.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157440>

libcharset provides an even more portable way of quering the charset
of the current locale.

Use that instead of nl_langinfo unless NO_LIBCHARSET is set.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---

Windows doesn't have langinfo.h and nl_langinfo(), but libcharset was
invented for this very purpose. With this patch on top, ab/i18n
compiles without errors in msysGit.

There's still a bunch of lower-level issues on Windows, like gettext
ending up overloading our winansi-wrappings for printf and friends,
but let's take thinks one step at the time :)

 configure.ac |    6 ++++++
 gettext.c    |   10 +++++++++-
 2 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/configure.ac b/configure.ac
index 1821d89..d3139cd 100644
--- a/configure.ac
+++ b/configure.ac
@@ -810,6 +810,12 @@ AC_CHECK_HEADER([libintl.h],
 [NO_GETTEXT=YesPlease])
 AC_SUBST(NO_GETTEXT)
 #
+# Define NO_LIBCHARSET if you don't have libcharset.h
+AC_CHECK_HEADER([libcharset.h],
+[NO_LIBCHARSET=],
+[NO_LIBCHARSET=YesPlease])
+AC_SUBST(NO_LIBCHARSET)
+#
 # Define NO_STRCASESTR if you don't have strcasestr.
 GIT_CHECK_FUNC(strcasestr,
 [NO_STRCASESTR=],
diff --git a/gettext.c b/gettext.c
index 8644098..902268c 100644
--- a/gettext.c
+++ b/gettext.c
@@ -1,13 +1,17 @@
 #include "exec_cmd.h"
 #include <locale.h>
 #include <libintl.h>
+#ifndef NO_LIBCHARSET
+#include <libcharset.h>
+#else
 #include <langinfo.h>
+#endif
 #include <stdlib.h>
 
 extern void git_setup_gettext(void) {
 	char *podir;
 	char *envdir = getenv("GIT_TEXTDOMAINDIR");
-	char *charset;
+	const char *charset;
 
 	if (envdir) {
 		(void)bindtextdomain("git", envdir);
@@ -20,7 +24,11 @@ extern void git_setup_gettext(void) {
 
 	(void)setlocale(LC_MESSAGES, "");
 	(void)setlocale(LC_CTYPE, "");
+#ifndef NO_LIBCHARSET
+	charset = locale_charset();
+#else
 	charset = nl_langinfo(CODESET);
+#endif
 	(void)bind_textdomain_codeset("git", charset);
 	(void)setlocale(LC_CTYPE, "C");
 	(void)textdomain("git");
-- 
1.7.3.165.gdfe39.dirty
