From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFH/PATCH] prefix_path(): disallow absolute paths
Date: Mon, 28 Jan 2008 17:23:12 -0800
Message-ID: <7vwspts9vj.fsf@gitster.siamese.dyndns.org>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Shawn Bohrer <shawn.bohrer@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 29 02:24:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJfCm-0008Eq-Ey
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 02:24:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752949AbYA2BXc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2008 20:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752672AbYA2BXc
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 20:23:32 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35313 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751785AbYA2BXb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 20:23:31 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id BCFA921B3;
	Mon, 28 Jan 2008 20:23:29 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 4D0AE21B0;
	Mon, 28 Jan 2008 20:23:24 -0500 (EST)
In-Reply-To: <alpine.LSU.1.00.0801281210440.23907@racer.site> (Johannes
	Schindelin's message of "Mon, 28 Jan 2008 12:33:48 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71910>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Without this fix, "git ls-files --others /" would list _all_ files,
> except for those tracked in the current repository.  Worse, "git clean /"
> would start removing them.
> ...
> 	This patch cannot be applied as-is: t3101 is failing (t7001 is 
> 	fixed by the builtin-mv.c part).
>
> 	The failure of t3101 has something to do with ls-tree filtering 
> 	out invalid paths; I maintain that this behaviour is wrong to 
> 	begin with.
>
> 	So the help I am requesting is this: so late in the game for 1.5.4 
> 	I would hate to introduce a change in prefix_path(), because it 
> 	affects apparently too much.  However, the "git clean /" bug is a 
> 	real one, and should at least be prevented.  What to do?
> ...
> diff --git a/setup.c b/setup.c
> index 2174e78..5a4aadc 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -13,6 +13,8 @@ const char *get_current_prefix()
>  const char *prefix_path(const char *prefix, int len, const char *path)
>  {
>  	const char *orig = path;
> +	if (is_absolute_path(path))
> +		die("no absolute paths allowed: '%s'", path);
>  	for (;;) {
>  		char c;
>  		if (*path != '.')

If we are touching the prefix_path(), I think we should try to
make its "ambiguous path rejection" more complete.

Currently, we:

 - Remove "." path component (i.e. the directory leading part
   specified) from the input;

 - Remove ".." path component and strip one level of the prefix;

only from the beginning.  So if you give nonsense pathspec from
the command line, you can end up calling prefix_path() with things
like "/README", "/absolute/path/to//repository/tracked/file", and
"fo//o/../o".

And not passing such ambiguous path like "fo//o" to the core
level but sanitizing matters.  Then core level can always do
memcmp() with "fo/o" to see they are talking about the same
path.

I suspect that the right approach might be something like the
attached patch.  It introduces a version of prefix_path() that
sanitizes path (but not prefix part, which comes from git itself
and hopefully there should not be a need to sanitize it) while
doing the prefixing.  It also strips the leading absolute path
to the repository by comparing it with the value of work_tree.

A few things to note.

 * Your mv fix is rolled in.

 * This allows you to name a in-repository file as `pwd`/file,
   or `pwd`//file (iow, double-slash is also sanitized).  It may
   kill the bird in another thread nearby.

 * get_pathspec() drops paths outside of repository, so the
   caller may end up getting a smaller number of paths than it
   originally gave it.  If an existing caller expects the same
   number of paths to come back, it needs to be adjusted (I did
   not check).  We could alternatively die() but I couldn't
   decide which one is a better behaviour.

This is not to be applied (especially before auditing the
callers), but to be thought about.  Although it passes all the
tests...



 builtin-mv.c |    4 +-
 setup.c      |  152 ++++++++++++++++++++++++++++++++++++++++++----------------
 2 files changed, 112 insertions(+), 44 deletions(-)

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
index adede16..fdc6459 100644
--- a/setup.c
+++ b/setup.c
@@ -4,51 +4,114 @@
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
+		if (strncmp(sanitized, work_tree, len) ||
+		    (sanitized[len] != '\0' && sanitized[len] != '/')) {
+		error_out:
+			error("'%s' is outside repository", orig);
+			free(sanitized);
+			return NULL;
+		}
+	}
+	return sanitized;
 }
 
 /*
@@ -114,7 +177,7 @@ void verify_non_filename(const char *prefix, const char *arg)
 const char **get_pathspec(const char *prefix, const char **pathspec)
 {
 	const char *entry = *pathspec;
-	const char **p;
+	const char **src, **dst;
 	int prefixlen;
 
 	if (!prefix && !entry)
@@ -128,12 +191,17 @@ const char **get_pathspec(const char *prefix, const char **pathspec)
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
+	return pathspec;
 }
 
 /*
