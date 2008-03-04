From: Michal Rokos <michal.rokos@nextsoft.cz>
Subject: [PATCH v2] Configure test for FREAD_READS_DIRECTORIES
Date: Tue, 4 Mar 2008 12:44:11 +0100
Organization: NextSoft
Message-ID: <200803041244.11315.michal.rokos@nextsoft.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
To: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 04 12:45:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWVZo-0006MD-Pl
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 12:44:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756299AbYCDLoT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 06:44:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756540AbYCDLoT
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 06:44:19 -0500
Received: from holub.nextsoft.cz ([195.122.198.235]:36695 "EHLO
	holub.nextsoft.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755703AbYCDLoS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 06:44:18 -0500
Received: by holub.nextsoft.cz (Postfix, from userid 111)
	id 0B5D28E3; Tue,  4 Mar 2008 12:44:17 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by holub.nextsoft.cz (Postfix) with ESMTP id 273AD8E2
	for <git@vger.kernel.org>; Tue,  4 Mar 2008 12:44:16 +0100 (CET)
Received: from holub.nextsoft.cz ([127.0.0.1])
	by localhost (holub.nextsoft.cz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 07929-09 for <git@vger.kernel.org>;
	Tue, 4 Mar 2008 12:44:16 +0100 (CET)
Received: from 89-24-113-79.i4g.tmcz.cz (89-24-113-79.i4g.tmcz.cz [89.24.113.79])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by holub.nextsoft.cz (Postfix) with ESMTP id 777256A9
	for <git@vger.kernel.org>; Tue,  4 Mar 2008 12:44:15 +0100 (CET)
User-Agent: KMail/1.9.9
Content-Disposition: inline
X-Bogosity: Ham, tests=bogofilter, spamicity=0.000000, version=1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76069>

Hello,

this patch adds missing tests for FREAD_READS_DIRECTORIES.

Could anyone volunteer to test it on different platforms?
So far I know it works well on Linux (no FREAD_READS_DIRECTORIES),
HP-UXes 11.11 and 11.23 (FREAD_READS_DIRECTORIES defined).

Thanks

MR

Signed-off-by: Michal Rokos <michal.rokos@nextsoft.cz>

diff --git a/Makefile b/Makefile
index ca5aad9..344ab49 100644
--- a/Makefile
+++ b/Makefile
@@ -526,6 +526,7 @@ ifeq ($(uname_S),HP-UX)
 	NO_UNSETENV = YesPlease
 	NO_HSTRERROR = YesPlease
 	NO_SYS_SELECT_H = YesPlease
+	FREAD_READS_DIRECTORIES = UnfortunatelyYes
 endif
 ifneq (,$(findstring arm,$(uname_M)))
 	ARM_SHA1 = YesPlease
diff --git a/config.mak.in b/config.mak.in
index ee6c33d..516c468 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -46,3 +46,4 @@ NO_MKDTEMP=@NO_MKDTEMP@
 NO_ICONV=@NO_ICONV@
 OLD_ICONV=@OLD_ICONV@
 NO_DEFLATE_BOUND=@NO_DEFLATE_BOUND@
+FREAD_READS_DIRECTORIES=@FREAD_READS_DIRECTORIES@
diff --git a/configure.ac b/configure.ac
index 85d7ef5..8f748a9 100644
--- a/configure.ac
+++ b/configure.ac
@@ -326,6 +326,27 @@ else
 	NO_C99_FORMAT=
 fi
 AC_SUBST(NO_C99_FORMAT)
+#
+# Define FREAD_READS_DIRECTORIES if your are on a system which succeeds
+# when attempting to read from an fopen'ed directory.
+AC_CACHE_CHECK([whether system succeeds to read fopen'ed directory],
+ [ac_cv_fread_reads_directories],
+[
+AC_RUN_IFELSE(
+	[AC_LANG_PROGRAM([AC_INCLUDES_DEFAULT],
+		[[char c;
+		FILE *f = fopen(".", "r");
+		if (! f) return 0;
+		if (f && fread(&c, 1, 1, f) > 0) return 1]])],
+	[ac_cv_fread_reads_directories=no],
+	[ac_cv_fread_reads_directories=yes])
+])
+if test $ac_cv_fread_reads_directories = yes; then
+	FREAD_READS_DIRECTORIES=UnfortunatelyYes
+else
+	FREAD_READS_DIRECTORIES=
+fi
+AC_SUBST(FREAD_READS_DIRECTORIES)
 
 
 ## Checks for library functions.

