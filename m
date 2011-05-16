From: Rafael Gieschke <rafael@gieschke.de>
Subject: [PATCH] add Android support
Date: Mon, 16 May 2011 22:08:23 +0200
Message-ID: <D2F37FDB-20C2-401A-AA90-DB4A50C27123@gieschke.de>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon May 16 22:16:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QM4DI-0000fN-ES
	for gcvg-git-2@lo.gmane.org; Mon, 16 May 2011 22:16:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755290Ab1EPUQS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2011 16:16:18 -0400
Received: from smtp2.goneo.de ([212.90.139.82]:52246 "EHLO smtp2.goneo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752257Ab1EPUQQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 May 2011 16:16:16 -0400
X-Greylist: delayed 456 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 May 2011 16:16:16 EDT
Received: from smtp2.goneo.de (localhost [127.0.0.1])
	by scan.goneo.de (Postfix) with ESMTP id 451941D1FDC;
	Mon, 16 May 2011 22:08:44 +0200 (CEST)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -2.822
X-Spam-Level: 
X-Spam-Status: No, score=-2.822 tagged_above=-999 tests=[ALL_TRUSTED=-1,
	AWL=0.078, BAYES_00=-1.9] autolearn=ham
Received: from smtp2.goneo.de ([127.0.0.1])
	by smtp2.goneo.de (smtp2.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2pBLGsoHRF0j; Mon, 16 May 2011 22:08:43 +0200 (CEST)
Received: from [10.165.14.131] (unknown [89.204.137.131])
	by smtp2-587.goneo.de (Postfix) with ESMTPSA id A60231D1E3D;
	Mon, 16 May 2011 22:08:39 +0200 (CEST)
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173753>


Currently, it is not possible to compile git for Android as the C library (Bionic)
is neither providing getpass nor pw_gecos in struct passwd. Therefore,
NO_GETPASS and NO_PW_GECOS are defined in Makefile. As code for Android can only
be cross-compiled, ANDROID is defined.

Signed-off-by: Rafael Gieschke <rafael@gieschke.de>
---
 Makefile  |   27 +++++++++++++++++++++++++++
 connect.c |    4 ++++
 ident.c   |    7 ++++++-
 3 files changed, 37 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index c4db5af..e010efb 100644
--- a/Makefile
+++ b/Makefile
@@ -71,6 +71,11 @@ all::
 #
 # Define NO_STRTOK_R if you don't have strtok_r in the C library.
 #
+# Define NO_GETPASS if you don't have getpass in the C library.
+#
+# Define NO_PW_GECOS if you don't have pw_gecos in struct passwd
+# in the C library.
+#
 # Define NO_FNMATCH if you don't have fnmatch in the C library.
 #
 # Define NO_FNMATCH_CASEFOLD if your fnmatch function doesn't have the
@@ -248,6 +253,8 @@ all::
 # dependency rules.
 #
 # Define NATIVE_CRLF if your platform uses CRLF for line endings.
+#
+# Define ANDROID if you are cross-compiling for Android.
 
 GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -789,6 +796,20 @@ ifeq ($(uname_S),OSF1)
 	NO_STRTOULL = YesPlease
 	NO_NSEC = YesPlease
 endif
+ifdef ANDROID
+	uname_S := Linux
+	NO_GETPASS = YesPlease
+	NO_PW_GECOS = YesPlease
+	NO_NSEC = YesPlease
+	NO_MKDTEMP = YesPlease
+	NO_PTHREADS = YesPlease
+	NO_PERL = YesPlease
+	NO_OPENSSL = YesPlease
+	NO_CURL = YesPlease
+	NO_EXPAT = YesPlease
+	NO_TCLTK = YesPlease
+	NO_ICONV = YesPlease
+endif
 ifeq ($(uname_S),Linux)
 	NO_STRLCPY = YesPlease
 	NO_MKSTEMPS = YesPlease
@@ -1404,6 +1425,12 @@ ifdef NO_STRTOK_R
 	COMPAT_CFLAGS += -DNO_STRTOK_R
 	COMPAT_OBJS += compat/strtok_r.o
 endif
+ifdef NO_GETPASS
+	COMPAT_CFLAGS += -DNO_GETPASS
+endif
+ifdef NO_PW_GECOS
+	COMPAT_CFLAGS += -DNO_PW_GECOS
+endif
 ifdef NO_FNMATCH
 	COMPAT_CFLAGS += -Icompat/fnmatch
 	COMPAT_CFLAGS += -DNO_FNMATCH
diff --git a/connect.c b/connect.c
index 57dc20c..15b285e 100644
--- a/connect.c
+++ b/connect.c
@@ -632,7 +632,11 @@ char *git_getpass(const char *prompt)
 	if (!askpass)
 		askpass = getenv("SSH_ASKPASS");
 	if (!askpass || !(*askpass)) {
+		#ifndef NO_GETPASS
 		char *result = getpass(prompt);
+		#else
+		char *result = NULL;
+		#endif
 		if (!result)
 			die_errno("Could not read password");
 		return result;
diff --git a/ident.c b/ident.c
index 1c4adb0..76fa786 100644
--- a/ident.c
+++ b/ident.c
@@ -20,7 +20,12 @@ static void copy_gecos(const struct passwd *w, char *name, size_t sz)
 	 * with commas.  Also & stands for capitalized form of the login name.
 	 */
 
-	for (len = 0, dst = name, src = w->pw_gecos; len < sz; src++) {
+	#ifndef NO_PW_GECOS
+	src = w->pw_gecos;
+	#else
+	src = "&";
+	#endif
+	for (len = 0, dst = name; len < sz; src++) {
 		int ch = *src;
 		if (ch != '&') {
 			*dst++ = ch;
-- 
1.7.4
