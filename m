From: Michal Rokos <michal.rokos@nextsoft.cz>
Subject: [PATCH v6] autoconf: Test FREAD_READS_DIRECTORIES
Date: Sun, 9 Mar 2008 21:44:04 +0100
Organization: NextSoft
Message-ID: <200803092144.04440.michal.rokos@nextsoft.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
To: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 09 21:45:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYSO8-0001bC-5j
	for gcvg-git-2@gmane.org; Sun, 09 Mar 2008 21:44:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753260AbYCIUoR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Mar 2008 16:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752878AbYCIUoR
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Mar 2008 16:44:17 -0400
Received: from holub.nextsoft.cz ([195.122.198.235]:57814 "EHLO
	holub.nextsoft.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751313AbYCIUoP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Mar 2008 16:44:15 -0400
Received: by holub.nextsoft.cz (Postfix, from userid 111)
	id 42A8287C; Sun,  9 Mar 2008 21:44:11 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by holub.nextsoft.cz (Postfix) with ESMTP id 557A787B
	for <git@vger.kernel.org>; Sun,  9 Mar 2008 21:44:10 +0100 (CET)
Received: from holub.nextsoft.cz ([127.0.0.1])
	by localhost (holub.nextsoft.cz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 00709-03 for <git@vger.kernel.org>;
	Sun, 9 Mar 2008 21:44:10 +0100 (CET)
Received: from b.rokos.cz (b.rokos.cz [88.83.237.35])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by holub.nextsoft.cz (Postfix) with ESMTP id 2ABBB4E0
	for <git@vger.kernel.org>; Sun,  9 Mar 2008 21:44:10 +0100 (CET)
Content-Disposition: inline
X-Bogosity: Ham, tests=bogofilter, spamicity=0.000000, version=1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76667>

Add test for FREAD_READS_DIRECTORIES to detect when fread() reads fopen'ed 
directory.

Signed-off-by: Michal Rokos <michal.rokos@nextsoft.cz>
Tested-by: Mike Ralphson <mike@abacus.co.uk>

diff --git a/config.mak.in b/config.mak.in
index 8e1cd5f..7868dfd 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -46,4 +46,5 @@ NO_MKDTEMP=@NO_MKDTEMP@
 NO_ICONV=@NO_ICONV@
 OLD_ICONV=@OLD_ICONV@
 NO_DEFLATE_BOUND=@NO_DEFLATE_BOUND@
+FREAD_READS_DIRECTORIES=@FREAD_READS_DIRECTORIES@
 SNPRINTF_RETURNS_BOGUS=@SNPRINTF_RETURNS_BOGUS@
diff --git a/configure.ac b/configure.ac
index 287149d..82584e9 100644
--- a/configure.ac
+++ b/configure.ac
@@ -327,6 +327,26 @@ else
 fi
 AC_SUBST(NO_C99_FORMAT)
 #
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
+#
 # Define SNPRINTF_RETURNS_BOGUS if your are on a system which snprintf()
 # or vsnprintf() return -1 instead of number of characters which would
 # have been written to the final string if enough space had been available.
