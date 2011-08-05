From: Pascal Obry <pascal@obry.net>
Subject: [PATCH 1/2] git-compat-util: add generic find_last_dir_sep that respects is_dir_sep
Date: Fri,  5 Aug 2011 18:10:13 +0200
Message-ID: <1312560614-20772-2-git-send-email-pascal@obry.net>
References: <1312560614-20772-1-git-send-email-pascal@obry.net>
Cc: Theo Niessink <theo@taletn.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 05 18:11:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpMzG-0003iL-2y
	for gcvg-git-2@lo.gmane.org; Fri, 05 Aug 2011 18:11:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756722Ab1HEQK4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Aug 2011 12:10:56 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:56382 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753623Ab1HEQKz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2011 12:10:55 -0400
Received: by wwg11 with SMTP id 11so598836wwg.1
        for <git@vger.kernel.org>; Fri, 05 Aug 2011 09:10:54 -0700 (PDT)
Received: by 10.227.130.104 with SMTP id r40mr1975884wbs.73.1312560654029;
        Fri, 05 Aug 2011 09:10:54 -0700 (PDT)
Received: from pascal.homeobry.net (AVelizy-154-1-101-151.w90-2.abo.wanadoo.fr [90.2.59.151])
        by mx.google.com with ESMTPS id gb1sm2405886wbb.20.2011.08.05.09.10.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 05 Aug 2011 09:10:53 -0700 (PDT)
Received: from obry by pascal.homeobry.net with local (Exim 4.76)
	(envelope-from <obry@pascal.homeobry.net>)
	id 1QpMz5-0005Pz-Iw; Fri, 05 Aug 2011 18:10:51 +0200
X-Mailer: git-send-email 1.7.6.404.g5d2fc
In-Reply-To: <1312560614-20772-1-git-send-email-pascal@obry.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178800>

From: Theo Niessink <theo@taletn.com>

Move MinGW's find_last_dir_sep to git-compat-util.h, so it can also be used
on other platforms that define is_dir_sep, e.g. Cygwin.

Signed-off-by: Theo Niessink <theo@taletn.com>
Acked-by: Pascal Obry <pascal@obry.net>
---
 compat/mingw.h    |    9 ---------
 git-compat-util.h |   12 ++++++++++++
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/compat/mingw.h b/compat/mingw.h
index ce9dd98..547568b 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -300,15 +300,6 @@ int winansi_fprintf(FILE *stream, const char *format, ...) __attribute__((format
 
 #define has_dos_drive_prefix(path) (isalpha(*(path)) && (path)[1] == ':')
 #define is_dir_sep(c) ((c) == '/' || (c) == '\\')
-static inline char *mingw_find_last_dir_sep(const char *path)
-{
-	char *ret = NULL;
-	for (; *path; ++path)
-		if (is_dir_sep(*path))
-			ret = (char *)path;
-	return ret;
-}
-#define find_last_dir_sep mingw_find_last_dir_sep
 #define PATH_SEP ';'
 #define PRIuMAX "I64u"
 
diff --git a/git-compat-util.h b/git-compat-util.h
index ddfbf77..c2c94cd 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -211,6 +211,18 @@ extern char *gitbasename(char *);
 #define has_dos_drive_prefix(path) 0
 #endif
 
+#if !defined(find_last_dir_sep) && defined(is_dir_sep)
+static inline char *compat_find_last_dir_sep(const char *path)
+{
+	char *ret = NULL;
+	for (; *path; ++path)
+		if (is_dir_sep(*path))
+			ret = (char *)path;
+	return ret;
+}
+#define find_last_dir_sep compat_find_last_dir_sep
+#endif
+
 #ifndef is_dir_sep
 #define is_dir_sep(c) ((c) == '/')
 #endif
-- 
1.7.6.404.g5d2fc
