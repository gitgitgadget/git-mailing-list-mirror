From: Michal Rokos <michal.rokos@nextsoft.cz>
Subject: [PATCH v5] autoconf: Test FREAD_READS_DIRECTORIES
Date: Thu, 6 Mar 2008 11:41:08 +0100
Organization: NextSoft
Message-ID: <200803061141.09050.michal.rokos@nextsoft.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
To: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 06 11:42:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXDYI-0007Eu-Cp
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 11:42:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761753AbYCFKlS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 05:41:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756191AbYCFKlS
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 05:41:18 -0500
Received: from holub.nextsoft.cz ([195.122.198.235]:60194 "EHLO
	holub.nextsoft.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759993AbYCFKlQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 05:41:16 -0500
Received: by holub.nextsoft.cz (Postfix, from userid 111)
	id 94C7B8E0; Thu,  6 Mar 2008 11:41:14 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by holub.nextsoft.cz (Postfix) with ESMTP id A3AB38D8
	for <git@vger.kernel.org>; Thu,  6 Mar 2008 11:41:13 +0100 (CET)
Received: from holub.nextsoft.cz ([127.0.0.1])
	by localhost (holub.nextsoft.cz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 10547-09 for <git@vger.kernel.org>;
	Thu, 6 Mar 2008 11:41:13 +0100 (CET)
Received: from 89-24-247-85.i4g.tmcz.cz (89-24-247-85.i4g.tmcz.cz [89.24.247.85])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by holub.nextsoft.cz (Postfix) with ESMTP id E7663126
	for <git@vger.kernel.org>; Thu,  6 Mar 2008 11:41:12 +0100 (CET)
Content-Disposition: inline
X-Bogosity: Ham, tests=bogofilter, spamicity=0.000000, version=1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76364>

Add test for FREAD_READS_DIRECTORIES to detect when fread() reads fopen'ed 
directory.

Signed-off-by: Michal Rokos <michal.rokos@nextsoft.cz>
Tested-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Tested-by: Mike Ralphson <mike@abacus.co.uk>

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
