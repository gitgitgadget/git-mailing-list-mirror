From: Michal Rokos <michal.rokos@nextsoft.cz>
Subject: [PATCH v4] autoconf: Test FREAD_READS_DIRECTORIES
Date: Wed, 5 Mar 2008 09:39:16 +0100
Organization: NextSoft
Message-ID: <200803050939.16177.michal.rokos@nextsoft.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
To: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 05 09:40:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWpAS-0003R2-3h
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 09:40:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757108AbYCEIjX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 03:39:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756752AbYCEIjX
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 03:39:23 -0500
Received: from holub.nextsoft.cz ([195.122.198.235]:38623 "EHLO
	holub.nextsoft.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757017AbYCEIjW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 03:39:22 -0500
Received: by holub.nextsoft.cz (Postfix, from userid 111)
	id 58C8F8E3; Wed,  5 Mar 2008 09:39:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by holub.nextsoft.cz (Postfix) with ESMTP id 4219F8E4
	for <git@vger.kernel.org>; Wed,  5 Mar 2008 09:39:20 +0100 (CET)
Received: from holub.nextsoft.cz ([127.0.0.1])
	by localhost (holub.nextsoft.cz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 22313-03 for <git@vger.kernel.org>;
	Wed, 5 Mar 2008 09:39:20 +0100 (CET)
Received: from 89-24-238-42.i4g.tmcz.cz (89-24-238-42.i4g.tmcz.cz [89.24.238.42])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by holub.nextsoft.cz (Postfix) with ESMTP id A4870756
	for <git@vger.kernel.org>; Wed,  5 Mar 2008 09:39:19 +0100 (CET)
User-Agent: KMail/1.9.9
Content-Disposition: inline
X-Bogosity: Ham, tests=bogofilter, spamicity=0.000000, version=1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76194>

Add test for FREAD_READS_DIRECTORIES to configure script.

When "." could be opened and fread reads more than 0 items, 
FREAD_READS_DIRECTORIES will be set.

Signed-off-by: Michal Rokos <michal.rokos@nextsoft.cz>

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
index 85d7ef5..2deeb44 100644
--- a/configure.ac
+++ b/configure.ac
@@ -326,6 +326,26 @@ else
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
+		return f && fread(&c, 1, 1, f)]])],
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
