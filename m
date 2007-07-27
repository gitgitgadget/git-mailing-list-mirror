From: Bradford C Smith <bradford.carl.smith@gmail.com>
Subject: [PATCH 1/2] added file path helper routines
Date: Fri, 27 Jul 2007 15:10:55 -0400
Message-ID: <11855634582686-git-send-email-bradford.carl.smith@gmail.com>
References: <11855634561516-git-send-email-bradford.carl.smith@gmail.com>
Cc: Junio C Hamano <gitster@pobox.como>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Bradford C. Smith" <bradford.carl.smith@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 27 21:11:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEVDd-0003AW-FO
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 21:11:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761904AbXG0TLH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 15:11:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761880AbXG0TLG
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 15:11:06 -0400
Received: from qb-out-0506.google.com ([72.14.204.226]:9181 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761521AbXG0TLB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 15:11:01 -0400
Received: by qb-out-0506.google.com with SMTP id e11so797986qbe
        for <git@vger.kernel.org>; Fri, 27 Jul 2007 12:11:00 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=JcoiUy7wdINfr9BGZkxGFy/gw/4UUJC3+PJksyWojGsmU93W4toqOhixcjc46j0tttbOLBw8Hx4O31HmVIlfpmxO81bddfqIZqtXZeA0uSJy04M4SyNCpK+hGKlczkbMlXUb5t8qPuKlT3KQflxhrYOogQWwzWTXayP9Tig2cfg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=jPNDiud8pBYr49aixLvMp7oExZhmqEpLb0tgwM979cgQr6I3FpzMxeuMC6pgQTtCePm8Wi5J8ayYoPsjnKhn1d0P2AMM0OUJe1TGvHTKvu82ec7gD7FYIIdrGi+QdzrqSlaIcjFvD9MmoFvxW+wjNbuD7cJnKfUwQlaS1XT2EWg=
Received: by 10.100.47.9 with SMTP id u9mr3194554anu.1185563460486;
        Fri, 27 Jul 2007 12:11:00 -0700 (PDT)
Received: from localhost ( [160.36.232.47])
        by mx.google.com with ESMTPS id d36sm44850and.2007.07.27.12.10.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 27 Jul 2007 12:11:00 -0700 (PDT)
X-Mailer: git-send-email 1.5.3.rc3.9.g9ef91
In-Reply-To: <11855634561516-git-send-email-bradford.carl.smith@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53950>

From: Bradford C. Smith <bradford.carl.smith@gmail.com>

Added the following routines:

is_absolute_path()
split_path()
join_path()
is_valid_path()
make_absolute_path()

Signed-off-by: Bradford C. Smith <bradford.carl.smith@gmail.com>
---
 cache.h |    5 ++
 path.c  |  247 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 252 insertions(+), 0 deletions(-)

diff --git a/cache.h b/cache.h
index 53801b8..8480716 100644
--- a/cache.h
+++ b/cache.h
@@ -356,6 +356,11 @@ enum sharedrepo {
 };
 int git_config_perm(const char *var, const char *value);
 int adjust_shared_perm(const char *path);
+int is_absolute_path(char *p);
+void split_path(const char *p, char *start, char *rest);
+void join_path(char *p, const char *start, const char *rest);
+int is_valid_path(const char *p);
+char *make_absolute_path(char *p);
 int safe_create_leading_directories(char *path);
 char *enter_repo(char *path, int strict);
 
diff --git a/path.c b/path.c
index dfff41f..2d14677 100644
--- a/path.c
+++ b/path.c
@@ -288,3 +288,250 @@ int adjust_shared_perm(const char *path)
 		return -2;
 	return 0;
 }
+
+
+int is_absolute_path(char *p)
+{
+	return p[0] == '/';
+}
+
+static void strip_trailing_slashes(char *p)
+{
+	char *r = strrchr(p, '/');
+
+	if (!r)
+		return; /* no slashes at all */
+	if (*(r + 1) != '\0')
+		return; /* last slash is not at the end */
+	/*
+	 * last character is a slash, back up overwriting slashes with
+	 * nulls until I find a non-null or the beginning of p, but
+	 * don't overwrite a '/' at the beginning of p.
+	 */
+	while (r > p && *r == '/') {
+		*r = '\0';
+		r--;
+	}
+}
+
+/*
+ * p = path name that will fit in a PATH_MAX size buffer
+ * start = NULL or PATH_MAX size buffer
+ * rest = NULL or PATH_MAX size buffer
+ *
+ * split p on the last slash that isn't a trailing slash.
+ * Copy everything before the slash into start if it is not NULL.  Copy
+ * everything after the slash, except trailing slashes, into rest if it
+ * is not NULL.  The slash itself isn't put in either one.
+ *
+ * If p contains no non-trailing slashes, all of p will be put into
+ * start and rest will be an empty string.
+ *
+ * This routine is meant to be the exact reverse of join_path() as long
+ * as p has no trailing slashes.  If p has trailing slashes, spliting
+ * and rejoining will cause them to disappear.
+ *
+ * NOTE: p is copied into a temporary buffer, so it is safe for start or
+ * rest to point into p.
+ * NOTE: if p is too big to fit in a PATH_MAX size buffer, it will be
+ * silently truncated when copied to the temporary buffer.
+ */
+void split_path(const char *p, char *start, char *rest)
+{
+	char buf[PATH_MAX];
+	char * last_slash;
+	const char * after_slash;
+
+	strncpy(buf, p, sizeof(buf));
+	buf[sizeof(buf) - 1] = '\0';
+	strip_trailing_slashes(buf);
+	last_slash = strrchr(buf, '/');
+	if (last_slash) {
+		*last_slash = '\0';
+		after_slash = last_slash + 1;
+	} else {
+		after_slash = "";
+	}
+	if (start) {
+		strcpy(start, buf);
+	}
+	if (rest) {
+		strcpy(rest, after_slash);
+	}
+}
+
+/*
+ * p = PATH_MAX size buffer to hold result
+ * start = beginning of a path (shorter than PATH_MAX)
+ * rest = end of a path (shorter than PATH_MAX)
+ *
+ * fill p with start + '/' + rest, removing any trailing slashes from
+ * the result.  If the result is too big to fit in a PATH_MAX size
+ * buffer, it will be silently truncated.
+ *
+ * NOTE: This routine uses a temporary buffer to hold the result, so it
+ *       is safe to have start or rest pointing into p.
+ */
+void join_path(char *p, const char *start, const char *rest)
+{
+	char buf[PATH_MAX];
+
+	snprintf(buf, sizeof(buf), "%s/%s", start, rest);
+	strip_trailing_slashes(buf);
+	strcpy(p, buf);
+}
+
+/*
+ * p = path that will fit in a PATH_MAX size buffer
+ *
+ * return true if p is a valid path, false otherwise
+ *
+ * p is considered valid if
+ * 1. stat(p) succeeds
+ *    OR
+ * 2. stat(p) fails with ENOENT and I can successfully stat() the
+ * directory part of p and see that it is a directory.
+ *
+ * NOTE: The caller must ensure that p will fit in a PATH_MAX size
+ *       buffer.
+ */
+int is_valid_path(const char *p)
+{
+	char dir[PATH_MAX];
+	struct stat st;
+
+	if (stat(p, &st) == 0) {
+		return 1;
+	}
+	if (errno != ENOENT) {
+		/*
+		 * there's something wrong with p other than it just not
+		 * existing
+		 */
+		return 0;
+	}
+	split_path(p, dir, NULL);
+	if (dir[0] == '\0') {
+		/* path is '/something' and '/' always exists */
+		return 1;
+	}
+	return (stat(dir, &st) == 0) && S_ISDIR(st.st_mode);
+}
+
+/*
+ * p = PATH_MAX size buffer containing a path that may specify a symlink
+ *
+ * If p is a symlink, overwrite p with the target of the symlink.  If
+ * the target would be too big to fit in a PATH_MAX size buffer, p will
+ * not be overwritten.
+ *
+ * Returns true if p is overwritten, false otherwise.
+ */
+static int expand_symlink(char *p)
+{
+	char buf[PATH_MAX];
+	size_t len;
+
+	/* don't try to expand a symlink in an invalid path */
+	if (!is_valid_path(p)) {
+		return 0;
+	}
+	len = readlink(p, buf, sizeof(buf));
+	if (len < 0) {
+		return 0; /* not a symlink or couldn't read it */
+	}
+	if (len >= sizeof(buf)) {
+		return 0; /* link too long to expand */
+	}
+	buf[len] = '\0'; /* readlink() doesn't null terminate */
+	if (is_absolute_path(buf)) {
+		strcpy(p, buf);
+		return 1;
+	} else {
+		/* replace basename with relative symlink */
+		char dir[PATH_MAX];
+
+		split_path(p, dir, NULL);
+		if ((strlen(dir) + 1 + strlen(buf)) < PATH_MAX) {
+			join_path(p, dir, buf);
+			return 1;
+		} else {
+			/* link too big to fit in p */
+			return 0;
+		}
+	}
+}
+
+/*
+ * p = absolute path in a PATH_MAX size buffer
+ *
+ * Attempt to replace contents of p with an equivalent absolute path
+ * containing no extra slashes, symlinks, '.', or '..' elements.  This
+ * is done recursively beginning with '/'.  Resolution of symlinks will
+ * stop at the first element in the path that doesn't exist or cannot be
+ * read/searched for some reason, but extra slashes, '.', and '..'
+ * elements will still be resolved after that point.
+ *
+ * Always returns p.
+ */
+static char *normalize_path(char *p)
+{
+	char start[PATH_MAX];
+	char rest[PATH_MAX];
+
+	/*
+	 * recursion stopping case: nothing to normalize in an empty
+	 * string (represents root directory)
+	 */
+	if (*p == '\0') {
+		return p;
+	}
+	split_path(p, start, rest);
+	normalize_path(start);
+	if (!strcmp(rest, ".")) {
+		/* "self" expands to nothing */
+		rest[0] = '\0';
+	}
+	if (!strcmp(rest, "..")) {
+		/*
+		 * "parent" expands to nothing and removes the last
+		 * element from start.
+		 */
+		rest[0] = '\0';
+		split_path(start, start, NULL);
+	}
+
+	/* put the path back together */
+	join_path(p, start, rest);
+
+	if (expand_symlink(p)) {
+		/* p was a symlink, so I must normalize its expansion */
+		normalize_path(p);
+	}
+	return p;
+}
+
+
+/*
+ * p = absolute or partial path in a PATH_MAX size buffer
+ *
+ * normalize p to an absolute path containing no symlinks and no . or ..
+ * directories.
+ *
+ * NOTE: If any of the path components do not exist or cannot be read/searched
+ * for some reason, this routine will only standardize the parts of the
+ * path up to the "bad" component.
+ *
+ * Always returns p.
+ */
+char *make_absolute_path(char *p)
+{
+	if (!is_absolute_path(p)) {
+		char cwd[PATH_MAX];
+
+		if (NULL == getcwd(cwd, sizeof(cwd)))
+			die("cannot get working directory");
+		join_path(p, cwd, p);
+	}
+	return normalize_path(p);
+}
-- 
1.5.3.rc3.9.g9ef91
