From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] dir: convert to strbuf
Date: Tue, 01 May 2012 13:25:24 +0200
Message-ID: <4F9FC824.80403@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 01 13:25:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPBD2-0003hg-Jb
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 13:25:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755020Ab2EALZ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 May 2012 07:25:27 -0400
Received: from india601.server4you.de ([85.25.151.105]:57849 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754945Ab2EALZ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 07:25:26 -0400
Received: from [192.168.2.105] (p4FFDA315.dip.t-dialin.net [79.253.163.21])
	by india601.server4you.de (Postfix) with ESMTPSA id 9B1C92F805D
	for <git@vger.kernel.org>; Tue,  1 May 2012 13:25:24 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120420 Thunderbird/12.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196679>

The functions read_directory_recursive() and treat_leading_path() both
use buffers sized to fit PATH_MAX characters.  The latter can be made to
overrun its buffer, e.g. like this:

	$ a=0123456789abcdef
	$ a=$a$a$a$a$a$a$a$a
	$ a=$a$a$a$a$a$a$a$a
	$ a=$a$a$a$a$a$a$a$a
	$ git add $a/a

Instead of trying to add a check and potentionally forgetting to address
similar cases, convert the involved functions and their helpers to use
struct strbuf.  The patch is suprisingly large because the helpers
treat_path() and treat_one_path() modify the buffer as well and thus
need to be converted, too.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 dir.c |   76 ++++++++++++++++++++++++++++++++---------------------------------
 1 file changed, 37 insertions(+), 39 deletions(-)

diff --git a/dir.c b/dir.c
index e98760c..c6a98cc 100644
--- a/dir.c
+++ b/dir.c
@@ -873,14 +873,14 @@ enum path_treatment {
 };
 
 static enum path_treatment treat_one_path(struct dir_struct *dir,
-					  char *path, int *len,
+					  struct strbuf *path,
 					  const struct path_simplify *simplify,
 					  int dtype, struct dirent *de)
 {
-	int exclude = excluded(dir, path, &dtype);
+	int exclude = excluded(dir, path->buf, &dtype);
 	if (exclude && (dir->flags & DIR_COLLECT_IGNORED)
-	    && exclude_matches_pathspec(path, *len, simplify))
-		dir_add_ignored(dir, path, *len);
+	    && exclude_matches_pathspec(path->buf, path->len, simplify))
+		dir_add_ignored(dir, path->buf, path->len);
 
 	/*
 	 * Excluded? If we don't explicitly want to show
@@ -890,7 +890,7 @@ static enum path_treatment treat_one_path(struct dir_struct *dir,
 		return path_ignored;
 
 	if (dtype == DT_UNKNOWN)
-		dtype = get_dtype(de, path, *len);
+		dtype = get_dtype(de, path->buf, path->len);
 
 	/*
 	 * Do we want to see just the ignored files?
@@ -907,9 +907,8 @@ static enum path_treatment treat_one_path(struct dir_struct *dir,
 	default:
 		return path_ignored;
 	case DT_DIR:
-		memcpy(path + *len, "/", 2);
-		(*len)++;
-		switch (treat_directory(dir, path, *len, simplify)) {
+		strbuf_addch(path, '/');
+		switch (treat_directory(dir, path->buf, path->len, simplify)) {
 		case show_directory:
 			if (exclude != !!(dir->flags
 					  & DIR_SHOW_IGNORED))
@@ -930,26 +929,21 @@ static enum path_treatment treat_one_path(struct dir_struct *dir,
 
 static enum path_treatment treat_path(struct dir_struct *dir,
 				      struct dirent *de,
-				      char *path, int path_max,
+				      struct strbuf *path,
 				      int baselen,
-				      const struct path_simplify *simplify,
-				      int *len)
+				      const struct path_simplify *simplify)
 {
 	int dtype;
 
 	if (is_dot_or_dotdot(de->d_name) || !strcmp(de->d_name, ".git"))
 		return path_ignored;
-	*len = strlen(de->d_name);
-	/* Ignore overly long pathnames! */
-	if (*len + baselen + 8 > path_max)
-		return path_ignored;
-	memcpy(path + baselen, de->d_name, *len + 1);
-	*len += baselen;
-	if (simplify_away(path, *len, simplify))
+	strbuf_setlen(path, baselen);
+	strbuf_addstr(path, de->d_name);
+	if (simplify_away(path->buf, path->len, simplify))
 		return path_ignored;
 
 	dtype = DTYPE(de);
-	return treat_one_path(dir, path, len, simplify, dtype, de);
+	return treat_one_path(dir, path, simplify, dtype, de);
 }
 
 /*
@@ -969,19 +963,19 @@ static int read_directory_recursive(struct dir_struct *dir,
 	DIR *fdir = opendir(*base ? base : ".");
 	int contents = 0;
 	struct dirent *de;
-	char path[PATH_MAX + 1];
+	struct strbuf path = STRBUF_INIT;
 
 	if (!fdir)
 		return 0;
 
-	memcpy(path, base, baselen);
+	strbuf_add(&path, base, baselen);
 
 	while ((de = readdir(fdir)) != NULL) {
-		int len;
-		switch (treat_path(dir, de, path, sizeof(path),
-				   baselen, simplify, &len)) {
+		switch (treat_path(dir, de, &path, baselen, simplify)) {
 		case path_recurse:
-			contents += read_directory_recursive(dir, path, len, 0, simplify);
+			contents += read_directory_recursive(dir, path.buf,
+							     path.len, 0,
+							     simplify);
 			continue;
 		case path_ignored:
 			continue;
@@ -992,10 +986,11 @@ static int read_directory_recursive(struct dir_struct *dir,
 		if (check_only)
 			goto exit_early;
 		else
-			dir_add_name(dir, path, len);
+			dir_add_name(dir, path.buf, path.len);
 	}
 exit_early:
 	closedir(fdir);
+	strbuf_release(&path);
 
 	return contents;
 }
@@ -1058,8 +1053,8 @@ static int treat_leading_path(struct dir_struct *dir,
 			      const char *path, int len,
 			      const struct path_simplify *simplify)
 {
-	char pathbuf[PATH_MAX];
-	int baselen, blen;
+	struct strbuf sb = STRBUF_INIT;
+	int baselen, rc = 0;
 	const char *cp;
 
 	while (len && path[len - 1] == '/')
@@ -1074,19 +1069,22 @@ static int treat_leading_path(struct dir_struct *dir,
 			baselen = len;
 		else
 			baselen = cp - path;
-		memcpy(pathbuf, path, baselen);
-		pathbuf[baselen] = '\0';
-		if (!is_directory(pathbuf))
-			return 0;
-		if (simplify_away(pathbuf, baselen, simplify))
-			return 0;
-		blen = baselen;
-		if (treat_one_path(dir, pathbuf, &blen, simplify,
+		strbuf_setlen(&sb, 0);
+		strbuf_add(&sb, path, baselen);
+		if (!is_directory(sb.buf))
+			break;
+		if (simplify_away(sb.buf, sb.len, simplify))
+			break;
+		if (treat_one_path(dir, &sb, simplify,
 				   DT_DIR, NULL) == path_ignored)
-			return 0; /* do not recurse into it */
-		if (len <= baselen)
-			return 1; /* finished checking */
+			break; /* do not recurse into it */
+		if (len <= baselen) {
+			rc = 1;
+			break; /* finished checking */
+		}
 	}
+	strbuf_release(&sb);
+	return rc;
 }
 
 int read_directory(struct dir_struct *dir, const char *path, int len, const char **pathspec)
-- 
1.7.10
