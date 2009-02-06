From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] fix t1504 on Windows
Date: Fri, 06 Feb 2009 18:18:00 +0100
Message-ID: <498C70C8.1080009@lsrfire.ath.cx>
References: <498A1E1E.8010901@lsrfire.ath.cx> <498B3F6B.5080002@lsrfire.ath.cx> <498C3328.70804@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Feb 06 18:19:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVUMd-0001E3-4E
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 18:19:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752893AbZBFRSM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 12:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752514AbZBFRSK
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 12:18:10 -0500
Received: from india601.server4you.de ([85.25.151.105]:50298 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752564AbZBFRSJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 12:18:09 -0500
Received: from [10.0.1.101] (p57B7E1CE.dip.t-dialin.net [87.183.225.206])
	by india601.server4you.de (Postfix) with ESMTPSA id 3E3612F8056;
	Fri,  6 Feb 2009 18:18:05 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <498C3328.70804@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108763>

Johannes Sixt schrieb:
> I also need this to complete this test:
> 
> diff --git a/t/t1504-ceiling-dirs.sh b/t/t1504-ceiling-dirs.sh
> index 9c9c4c9..e377d48 100755
> --- a/t/t1504-ceiling-dirs.sh
> +++ b/t/t1504-ceiling-dirs.sh
> @@ -93,13 +93,13 @@ GIT_CEILING_DIRECTORIES="$TRASH_ROOT/subdi"
>  test_prefix subdir_ceil_at_subdi_slash "sub/dir/"
> 
> 
> -GIT_CEILING_DIRECTORIES="foo:$TRASH_ROOT/sub"
> +GIT_CEILING_DIRECTORIES="/foo:$TRASH_ROOT/sub"
>  test_fail second_of_two
> 
>  GIT_CEILING_DIRECTORIES="$TRASH_ROOT/sub:/bar"
>  test_fail first_of_two
> 
> -GIT_CEILING_DIRECTORIES="foo:$TRASH_ROOT/sub:bar"
> +GIT_CEILING_DIRECTORIES="/foo:$TRASH_ROOT/sub:/bar"
>  test_fail second_of_three

I don't, which makes me uneasy -- the tests shouldn't depend on details
in our setup. :-/

> That said, I'm in the process of preparing a series that includes your
> patch and that does the proper cleanup and code moving that you again
> didn't do :-/ But it turns out that this is non-trivial because of bash's
> (MSYS's) I-know-better-what-is-a-path-and-what-not behavior. It will take
> some time...

Glad to hear the first part, but what code moving do you mean?  Something
like the following?

-- snip! --
Remove the unused function normalize_absolute_path() and its tests.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 cache.h               |    1 -
 path.c                |   53 -------------------------------------------------
 t/t0060-path-utils.sh |   30 ---------------------------
 test-path-utils.c     |    7 ------
 4 files changed, 0 insertions(+), 91 deletions(-)

diff --git a/cache.h b/cache.h
index eeb774a..763bce7 100644
--- a/cache.h
+++ b/cache.h
@@ -624,7 +624,6 @@ int is_directory(const char *);
 const char *make_absolute_path(const char *path);
 const char *make_nonrelative_path(const char *path);
 const char *make_relative_path(const char *abs, const char *base);
-int normalize_absolute_path(char *buf, const char *path);
 int longest_ancestor_length(const char *path, const char *prefix_list);
 int sanitary_path_copy(char *dst, const char *src);
 
diff --git a/path.c b/path.c
index ea1913a..3fb9710 100644
--- a/path.c
+++ b/path.c
@@ -363,59 +363,6 @@ const char *make_relative_path(const char *abs, const char *base)
 }
 
 /*
- * path = absolute path
- * buf = buffer of at least max(2, strlen(path)+1) bytes
- * It is okay if buf == path, but they should not overlap otherwise.
- *
- * Performs the following normalizations on path, storing the result in buf:
- * - Removes trailing slashes.
- * - Removes empty components.
- * - Removes "." components.
- * - Removes ".." components, and the components the precede them.
- * "" and paths that contain only slashes are normalized to "/".
- * Returns the length of the output.
- *
- * Note that this function is purely textual.  It does not follow symlinks,
- * verify the existence of the path, or make any system calls.
- */
-int normalize_absolute_path(char *buf, const char *path)
-{
-	const char *comp_start = path, *comp_end = path;
-	char *dst = buf;
-	int comp_len;
-	assert(buf);
-	assert(path);
-
-	while (*comp_start) {
-		assert(*comp_start == '/');
-		while (*++comp_end && *comp_end != '/')
-			; /* nothing */
-		comp_len = comp_end - comp_start;
-
-		if (!strncmp("/",  comp_start, comp_len) ||
-		    !strncmp("/.", comp_start, comp_len))
-			goto next;
-
-		if (!strncmp("/..", comp_start, comp_len)) {
-			while (dst > buf && *--dst != '/')
-				; /* nothing */
-			goto next;
-		}
-
-		memmove(dst, comp_start, comp_len);
-		dst += comp_len;
-	next:
-		comp_start = comp_end;
-	}
-
-	if (dst == buf)
-		*dst++ = '/';
-
-	*dst = '\0';
-	return dst - buf;
-}
-
-/*
  * path = Canonical absolute path
  * prefix_list = Colon-separated list of absolute paths
  *
diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 6e7501f..9498f72 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -7,41 +7,11 @@ test_description='Test various path utilities'
 
 . ./test-lib.sh
 
-norm_abs() {
-	test_expect_success "normalize absolute" \
-	"test \$(test-path-utils normalize_absolute_path '$1') = '$2'"
-}
-
 ancestor() {
 	test_expect_success "longest ancestor" \
 	"test \$(test-path-utils longest_ancestor_length '$1' '$2') = '$3'"
 }
 
-norm_abs "" /
-norm_abs / /
-norm_abs // /
-norm_abs /// /
-norm_abs /. /
-norm_abs /./ /
-norm_abs /./.. /
-norm_abs /../. /
-norm_abs /./../.// /
-norm_abs /dir/.. /
-norm_abs /dir/sub/../.. /
-norm_abs /dir /dir
-norm_abs /dir// /dir
-norm_abs /./dir /dir
-norm_abs /dir/. /dir
-norm_abs /dir///./ /dir
-norm_abs /dir//sub/.. /dir
-norm_abs /dir/sub/../ /dir
-norm_abs //dir/sub/../. /dir
-norm_abs /dir/s1/../s2/ /dir/s2
-norm_abs /d1/s1///s2/..//../s3/ /d1/s3
-norm_abs /d1/s1//../s2/../../d2 /d2
-norm_abs /d1/.../d2 /d1/.../d2
-norm_abs /d1/..././../d2 /d1/d2
-
 ancestor / "" -1
 ancestor / / -1
 ancestor /foo "" -1
diff --git a/test-path-utils.c b/test-path-utils.c
index 2c0f5a3..a470ee4 100644
--- a/test-path-utils.c
+++ b/test-path-utils.c
@@ -2,13 +2,6 @@
 
 int main(int argc, char **argv)
 {
-	if (argc == 3 && !strcmp(argv[1], "normalize_absolute_path")) {
-		char *buf = xmalloc(PATH_MAX + 1);
-		int rv = normalize_absolute_path(buf, argv[2]);
-		assert(strlen(buf) == rv);
-		puts(buf);
-	}
-
 	if (argc >= 2 && !strcmp(argv[1], "make_absolute_path")) {
 		while (argc > 2) {
 			puts(make_absolute_path(argv[2]));
-- 
1.6.1.2.350.g88cc
