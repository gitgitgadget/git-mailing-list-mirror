From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] setup: sanitize absolute and funny paths in get_pathspec()
Date: Tue, 29 Jan 2008 00:29:11 -0800
Message-ID: <7vve5dox0o.fsf_-_@gitster.siamese.dyndns.org>
References: <47975FE6.4050709@viscovery.net>
	<1201463731-1963-1-git-send-email-shawn.bohrer@gmail.com>
	<alpine.LSU.1.00.0801272043040.23907@racer.site>
	<7v3asiyk2i.fsf@gitster.siamese.dyndns.org>
	<20080128003404.GA18276@lintop>
	<7vodb6wtix.fsf@gitster.siamese.dyndns.org>
	<479D805E.3000209@viscovery.net>
	<7vprvmuykw.fsf@gitster.siamese.dyndns.org>
	<479D9ADE.6010003@viscovery.net>
	<alpine.LSU.1.00.0801281210440.23907@racer.site>
	<7vwspts9vj.fsf@gitster.siamese.dyndns.org>
	<7vbq75s80t.fsf@gitster.siamese.dyndns.org>
	<7v7ihtqfm8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Shawn Bohrer <shawn.bohrer@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 29 09:29:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJlqs-0003M8-Um
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 09:29:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753170AbYA2I3W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2008 03:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752701AbYA2I3W
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jan 2008 03:29:22 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55735 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753150AbYA2I3V (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2008 03:29:21 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id CB2AF381A;
	Tue, 29 Jan 2008 03:29:19 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id F1D003815;
	Tue, 29 Jan 2008 03:29:13 -0500 (EST)
In-Reply-To: <7v7ihtqfm8.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 28 Jan 2008 23:02:07 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71963>

The prefix_path() function called from get_pathspec() is
responsible for translating list of user-supplied pathspecs to
list of pathspecs that is relative to the root of the work
tree.  When working inside a subdirectory, the user-supplied
pathspecs are taken to be relative to the current subdirectory.

Among special path components in pathspecs, we used to accept
and interpret only "." ("the directory", meaning a no-op) and
".."  ("up one level") at the beginning.  Everything else was
passed through as-is.

For example, if you are in Documentation/ directory of the
project, you can name Documentation/howto/maintain-git.txt as:

    howto/maintain-git.txt
    ../Documentation/howto/maitain-git.txt
    ../././Documentation/howto/maitain-git.txt

but not as:

    howto/./maintain-git.txt
    $(pwd)/howto/maintain-git.txt

This patch updates prefix_path() in several ways:

 - If the pathspec is not absolute, prefix (i.e. the current
   subdirectory relative to the root of the work tree, with
   terminating slash, if not empty) and the pathspec is
   concatenated first and used in the next step.  Otherwise,
   that absolute pathspec is used in the next step.

 - Then special path components "." (no-op) and ".." (up one
   level) are interpreted to simplify the path.  It is an error
   to have too many ".." to cause the intermediate result to
   step outside of the input to this step.

 - If the original pathspec was not absolute, the result from
   the previous step is the resulting "sanitized" pathspec.
   Otherwise, the result from the previous step is still
   absolute, and it is an error if it does not begin with the
   directory that corresponds to the root of the work tree.  The
   directory is stripped away from the result and is returned.

 - In any case, the resulting pathspec in the array
   get_pathspec() returns omit the ones that caused errors.

With this patch, the last two examples also behave as expected.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This is a squash of the handful patches I sent out with some
   clean-ups, to conclude the day for me.  Perhaps this will
   appear in 'pu' before 1.5.4 if I really am bored but not very
   likely.  I am pretty much bogged down with day-job these days
   during the week...

 builtin-ls-files.c |   11 +++-
 builtin-mv.c       |    4 +-
 setup.c            |  158 ++++++++++++++++++++++++++++++++++++++--------------
 t/t7010-setup.sh   |  117 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 245 insertions(+), 45 deletions(-)
 create mode 100755 t/t7010-setup.sh

diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index 0f0ab2d..3801cf4 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -572,8 +572,17 @@ int cmd_ls_files(int argc, const char **argv, const char *prefix)
 	pathspec = get_pathspec(prefix, argv + i);
 
 	/* Verify that the pathspec matches the prefix */
-	if (pathspec)
+	if (pathspec) {
+		if (argc != i) {
+			int cnt;
+			for (cnt = 0; pathspec[cnt]; cnt++)
+				;
+			if (cnt != (argc - i))
+				exit(1); /* error message already given */
+		}
 		prefix = verify_pathspec(prefix);
+	} else if (argc != i)
+		exit(1); /* error message already given */
 
 	/* Treat unmatching pathspec elements as errors */
 	if (pathspec && error_unmatch) {
diff --git a/builtin-mv.c b/builtin-mv.c
index 990e213..94f6dd2 100644
--- a/builtin-mv.c
+++ b/builtin-mv.c
@@ -164,7 +164,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 				}
 
 				dst = add_slash(dst);
-				dst_len = strlen(dst) - 1;
+				dst_len = strlen(dst);
 
 				for (j = 0; j < last - first; j++) {
 					const char *path =
@@ -172,7 +172,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 					source[argc + j] = path;
 					destination[argc + j] =
 						prefix_path(dst, dst_len,
-							path + length);
+							path + length + 1);
 					modes[argc + j] = INDEX;
 				}
 				argc += last - first;
diff --git a/setup.c b/setup.c
index adede16..23c9a11 100644
--- a/setup.c
+++ b/setup.c
@@ -4,51 +4,118 @@
 static int inside_git_dir = -1;
 static int inside_work_tree = -1;
 
-const char *prefix_path(const char *prefix, int len, const char *path)
+static int sanitary_path_copy(char *dst, const char *src)
 {
-	const char *orig = path;
+	char *dst0 = dst;
+
+	if (*src == '/') {
+		*dst++ = '/';
+		while (*src == '/')
+			src++;
+	}
+
 	for (;;) {
-		char c;
-		if (*path != '.')
-			break;
-		c = path[1];
-		/* "." */
-		if (!c) {
-			path++;
-			break;
+		char c = *src;
+
+		/*
+		 * A path component that begins with . could be
+		 * special:
+		 * (1) "." and ends   -- ignore and terminate.
+		 * (2) "./"           -- ignore them, eat slash and continue.
+		 * (3) ".." and ends  -- strip one and terminate.
+		 * (4) "../"          -- strip one, eat slash and continue.
+		 */
+		if (c == '.') {
+			switch (src[1]) {
+			case '\0':
+				/* (1) */
+				src++;
+				break;
+			case '/':
+				/* (2) */
+				src += 2;
+				while (*src == '/')
+					src++;
+				continue;
+			case '.':
+				switch (src[2]) {
+				case '\0':
+					/* (3) */
+					src += 2;
+					goto up_one;
+				case '/':
+					/* (4) */
+					src += 3;
+					while (*src == '/')
+						src++;
+					goto up_one;
+				}
+			}
 		}
-		/* "./" */
+
+		/* copy up to the next '/', and eat all '/' */
+		while ((c = *src++) != '\0' && c != '/')
+			*dst++ = c;
 		if (c == '/') {
-			path += 2;
-			continue;
-		}
-		if (c != '.')
+			*dst++ = c;
+			while (c == '/')
+				c = *src++;
+			src--;
+		} else if (!c)
 			break;
-		c = path[2];
-		if (!c)
-			path += 2;
-		else if (c == '/')
-			path += 3;
-		else
-			break;
-		/* ".." and "../" */
-		/* Remove last component of the prefix */
-		do {
-			if (!len)
-				die("'%s' is outside repository", orig);
-			len--;
-		} while (len && prefix[len-1] != '/');
 		continue;
+
+	up_one:
+		/*
+		 * dst0..dst is prefix portion, and dst[-1] is '/';
+		 * go up one level.
+		 */
+		dst -= 2; /* go past trailing '/' if any */
+		if (dst < dst0)
+			return -1;
+		while (1) {
+			if (dst <= dst0)
+				break;
+			c = *dst--;
+			if (c == '/') {
+				dst += 2;
+				break;
+			}
+		}
 	}
-	if (len) {
-		int speclen = strlen(path);
-		char *n = xmalloc(speclen + len + 1);
+	*dst = '\0';
+	return 0;
+}
 
-		memcpy(n, prefix, len);
-		memcpy(n + len, path, speclen+1);
-		path = n;
+const char *prefix_path(const char *prefix, int len, const char *path)
+{
+	const char *orig = path;
+	char *sanitized = xmalloc(len + strlen(path) + 1);
+	if (*orig == '/')
+		strcpy(sanitized, path);
+	else {
+		if (len)
+			memcpy(sanitized, prefix, len);
+		strcpy(sanitized + len, path);
 	}
-	return path;
+	if (sanitary_path_copy(sanitized, sanitized))
+		goto error_out;
+	if (*orig == '/') {
+		const char *work_tree = get_git_work_tree();
+		size_t len = strlen(work_tree);
+		size_t total = strlen(sanitized) + 1;
+		if (strncmp(sanitized, work_tree, len) ||
+		    (sanitized[len] != '\0' && sanitized[len] != '/')) {
+		error_out:
+			error("'%s' is outside repository", orig);
+			free(sanitized);
+			return NULL;
+		}
+		if (sanitized[len] == '/')
+			len++;
+		memmove(sanitized, sanitized + len, total - len);
+	}
+	return sanitized;
 }
 
 /*
@@ -114,7 +181,7 @@ void verify_non_filename(const char *prefix, const char *arg)
 const char **get_pathspec(const char *prefix, const char **pathspec)
 {
 	const char *entry = *pathspec;
-	const char **p;
+	const char **src, **dst;
 	int prefixlen;
 
 	if (!prefix && !entry)
@@ -128,12 +195,19 @@ const char **get_pathspec(const char *prefix, const char **pathspec)
 	}
 
 	/* Otherwise we have to re-write the entries.. */
-	p = pathspec;
+	src = pathspec;
+	dst = pathspec;
 	prefixlen = prefix ? strlen(prefix) : 0;
-	do {
-		*p = prefix_path(prefix, prefixlen, entry);
-	} while ((entry = *++p) != NULL);
-	return (const char **) pathspec;
+	while (*src) {
+		const char *p = prefix_path(prefix, prefixlen, *src);
+		if (p)
+			*(dst++) = p;
+		src++;
+	}
+	*dst = NULL;
+	if (!*pathspec)
+		return NULL;
+	return pathspec;
 }
 
 /*
diff --git a/t/t7010-setup.sh b/t/t7010-setup.sh
new file mode 100755
index 0000000..da20ba5
--- /dev/null
+++ b/t/t7010-setup.sh
@@ -0,0 +1,117 @@
+#!/bin/sh
+
+test_description='setup taking and sanitizing funny paths'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+
+	mkdir -p a/b/c a/e &&
+	D=$(pwd) &&
+	>a/b/c/d &&
+	>a/e/f
+
+'
+
+test_expect_success 'git add (absolute)' '
+
+	git add "$D/a/b/c/d" &&
+	git ls-files >current &&
+	echo a/b/c/d >expect &&
+	diff -u expect current
+
+'
+
+
+test_expect_success 'git add (funny relative)' '
+
+	rm -f .git/index &&
+	(
+		cd a/b &&
+		git add "../e/./f"
+	) &&
+	git ls-files >current &&
+	echo a/e/f >expect &&
+	diff -u expect current
+
+'
+
+test_expect_success 'git rm (absolute)' '
+
+	rm -f .git/index &&
+	git add a &&
+	git rm -f --cached "$D/a/b/c/d" &&
+	git ls-files >current &&
+	echo a/e/f >expect &&
+	diff -u expect current
+
+'
+
+test_expect_success 'git rm (funny relative)' '
+
+	rm -f .git/index &&
+	git add a &&
+	(
+		cd a/b &&
+		git rm -f --cached "../e/./f"
+	) &&
+	git ls-files >current &&
+	echo a/b/c/d >expect &&
+	diff -u expect current
+
+'
+
+test_expect_success 'git ls-files (absolute)' '
+
+	rm -f .git/index &&
+	git add a &&
+	git ls-files "$D/a/e/../b" >current &&
+	echo a/b/c/d >expect &&
+	diff -u expect current
+
+'
+
+test_expect_success 'git ls-files (relative #1)' '
+
+	rm -f .git/index &&
+	git add a &&
+	(
+		cd a/b &&
+		git ls-files "../b/c"
+	)  >current &&
+	echo c/d >expect &&
+	diff -u expect current
+
+'
+
+test_expect_success 'git ls-files (relative #2)' '
+
+	rm -f .git/index &&
+	git add a &&
+	(
+		cd a/b &&
+		git ls-files --full-name "../e/f"
+	)  >current &&
+	echo a/e/f >expect &&
+	diff -u expect current
+
+'
+
+test_expect_success 'git ls-files (relative #3)' '
+
+	rm -f .git/index &&
+	git add a &&
+	(
+		cd a/b &&
+		if git ls-files "../e/f"
+		then
+			echo Gaah, should have failed
+			exit 1
+		else
+			: happy
+		fi
+	)
+
+'
+
+test_done
-- 
1.5.4.rc5
