From: Jeff King <peff@peff.net>
Subject: [PATCH 6/6] refname_is_safe: avoid expensive normalize_path_copy call
Date: Sat, 4 Apr 2015 21:15:57 -0400
Message-ID: <20150405011557.GF30127@peff.net>
References: <20150405010611.GA15901@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 05 03:16:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YeZAT-0004k6-SZ
	for gcvg-git-2@plane.gmane.org; Sun, 05 Apr 2015 03:16:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752555AbbDEBQA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Apr 2015 21:16:00 -0400
Received: from cloud.peff.net ([50.56.180.127]:42559 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752528AbbDEBQA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Apr 2015 21:16:00 -0400
Received: (qmail 19729 invoked by uid 102); 5 Apr 2015 01:16:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 04 Apr 2015 20:16:00 -0500
Received: (qmail 1967 invoked by uid 107); 5 Apr 2015 01:16:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 04 Apr 2015 21:16:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 04 Apr 2015 21:15:57 -0400
Content-Disposition: inline
In-Reply-To: <20150405010611.GA15901@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266795>

Usually refs are not allowed to contain a ".." component.
However, since d0f810f (refs.c: allow listing and deleting
badly named refs, 2014-09-03), we relax these rules in some
cases in order to help users examine and get rid of
badly-named refs. However, we do still check that these refs
cannot "escape" the refs hierarchy (e.g., "refs/../foo").

This check is implemented by calling normalize_path_copy,
which requires us to allocate a new buffer to hold the
result. But we don't care about the result; we only care
whether the "up" components outnumbered the "down".

We can therefore implement this check ourselves without
requiring any extra allocations. With this patch, running
"git rev-parse refs/heads/does-not-exist" on a repo with
large (1.6GB) packed-refs file went from:

  real    0m8.910s
  user    0m8.452s
  sys     0m0.468s

to:

  real    0m8.529s
  user    0m8.044s
  sys     0m0.492s

for a wall-clock speedup of 4%.

Signed-off-by: Jeff King <peff@peff.net>
---
This was a lot less than I was hoping for, especially considering that
going from d0f810f^ to d0f810f is more like a 15% slowdown (or in
absolute numbers, ~1.1s versus only 400ms here). What's doubly confusing
is that I think we were running check_ref_format before d0f810f, which
does way more than the check we're doing here. So we should have ended
up faster than either.

So this is certainly _an_ improvement, but I think there may be more
going on.

 cache.h |  7 +++++++
 path.c  | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 refs.c  | 16 ++--------------
 3 files changed, 73 insertions(+), 14 deletions(-)

diff --git a/cache.h b/cache.h
index 3d3244b..c2b3df4 100644
--- a/cache.h
+++ b/cache.h
@@ -836,6 +836,13 @@ char *strip_path_suffix(const char *path, const char *suffix);
 int daemon_avoid_alias(const char *path);
 extern int is_ntfs_dotgit(const char *name);
 
+/**
+ * Returns 1 if the path "escapes" its root (e.g., "foo/../../bar") and 0
+ * otherwise. Note that this is purely textual, and does not care about
+ * symlinks or other aspects of the filesystem.
+ */
+int check_path_escape(const char *path);
+
 /* object replacement */
 #define LOOKUP_REPLACE_OBJECT 1
 extern void *read_sha1_file_extended(const unsigned char *sha1, enum object_type *type, unsigned long *size, unsigned flag);
diff --git a/path.c b/path.c
index e608993..1127cbd 100644
--- a/path.c
+++ b/path.c
@@ -703,6 +703,70 @@ int normalize_path_copy(char *dst, const char *src)
 }
 
 /*
+ * We want to detect a path that "escapes" its root. The general strategy
+ * is to parse components left to right, keeping track of our depth,
+ * which is increased by non-empty components and decreased by ".."
+ * components.
+ */
+int check_path_escape(const char *path)
+{
+	int depth = 0;
+
+	while (*path) {
+		char ch = *path++;
+
+		/*
+		 * We always start our loop at the beginning of a path component. So
+		 * we can skip past any dir separators. This handles leading
+		 * "/", as well as any internal "////".
+		 */
+		if (is_dir_sep(ch))
+			continue;
+
+		/*
+		 * If we start with a dot, we care about the four cases
+		 * (similar to normalize_path_copy above):
+		 *
+		 *  (1)  "."  - does not affect depth; we are done
+		 *  (2)  "./" - does not affect depth; skip
+		 *  (3)  ".." - check depth and finish
+		 *  (4)  "../" - drop depth, check, and keep looking
+		 */
+		if (ch == '.') {
+			ch = *path++;
+
+			if (!ch)
+				return 1; /* case (1) */
+			if (is_dir_sep(ch))
+				continue; /* case (2) */
+			if (ch == '.') {
+				ch = *path++;
+				if (!ch)
+					return depth > 0; /* case (3) */
+				if (is_dir_sep(ch)) {
+					/* case (4) */
+					if (--depth < 0)
+						return 0;
+					continue;
+				}
+				/* otherwise, "..foo"; fall through */
+			}
+			/* otherwise ".foo"; fall through */
+		}
+
+		/*
+		 * We have a real component; inrement the depth and eat the
+		 * rest of the component
+		 */
+		depth++;
+		while (*path && !is_dir_sep(*path))
+			path++;
+	}
+
+	return 1;
+}
+
+/*
  * path = Canonical absolute path
  * prefixes = string_list containing normalized, absolute paths without
  * trailing slashes (except for the root directory, which is denoted by "/").
diff --git a/refs.c b/refs.c
index 47e4e53..daca499 100644
--- a/refs.c
+++ b/refs.c
@@ -312,20 +312,8 @@ static struct ref_dir *get_ref_dir(struct ref_entry *entry)
  */
 static int refname_is_safe(const char *refname)
 {
-	if (starts_with(refname, "refs/")) {
-		char *buf;
-		int result;
-
-		buf = xmalloc(strlen(refname) + 1);
-		/*
-		 * Does the refname try to escape refs/?
-		 * For example: refs/foo/../bar is safe but refs/foo/../../bar
-		 * is not.
-		 */
-		result = !normalize_path_copy(buf, refname + strlen("refs/"));
-		free(buf);
-		return result;
-	}
+	if (skip_prefix(refname, "refs/", &refname))
+		return check_path_escape(refname);
 	while (*refname) {
 		if (!isupper(*refname) && *refname != '_')
 			return 0;
-- 
2.4.0.rc0.363.gf9f328b
