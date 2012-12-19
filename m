From: Jeff King <peff@peff.net>
Subject: [PATCH] add GIT_PATHSPEC_GLOB environment variable
Date: Wed, 19 Dec 2012 16:50:09 -0500
Message-ID: <20121219215008.GA17908@sigill.intra.peff.net>
References: <20121219203449.GA10001@sigill.intra.peff.net>
 <7vk3sd930z.fsf@alter.siamese.dyndns.org>
 <20121219210919.GA11894@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 19 22:50:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlRX5-0004fw-D1
	for gcvg-git-2@plane.gmane.org; Wed, 19 Dec 2012 22:50:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342Ab2LSVuO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2012 16:50:14 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:58817 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751205Ab2LSVuM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2012 16:50:12 -0500
Received: (qmail 1118 invoked by uid 107); 19 Dec 2012 21:51:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 19 Dec 2012 16:51:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Dec 2012 16:50:09 -0500
Content-Disposition: inline
In-Reply-To: <20121219210919.GA11894@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211853>

On Wed, Dec 19, 2012 at 04:09:19PM -0500, Jeff King wrote:

> It's perhaps a better match to make it an environment variable. Then it
> is tied to a particular flow of execution, rather than having it be a
> property of a system, user, or repo (which is what config does). So for
> my restricted environment, it would be sufficient for me to set the
> environment variable for the user who runs the scripts. And people who
> want a command-line option can set it via the shell, or we can provide
> "git --no-pathspec-glob" to set it.

Here it is as an environment variable. I think this probably makes more
sense in the general case (it's a little more work for my use case, but
I think the intended use is much more obvious).

I included the common_prefix fix you mentioned (I do not think it
produced incorrect results as it was, but it did not take full advantage
of an optimization).

-- >8 --
Subject: add GIT_PATHSPEC_GLOB environment variable

Git takes pathspec arguments in many places to limit the
scope of an operation. These pathspecs are treated not as
literal paths, but as glob patterns that can be fed to
fnmatch. When a user is giving a specific pattern, this is a
nice feature.

However, when programatically providing pathspecs, it can be
a nuisance. For example, to find the latest revision which
modified "$foo", one can use "git rev-list -- $foo". But if
"$foo" contains glob characters (e.g., "f*"), it will
erroneously match more entries than desired. The caller
needs to quote the characters in $foo, and even then, the
results may not be exactly the same as with a literal
pathspec. For instance, the depth checks in
match_pathspec_depth do not kick in if we match via fnmatch.

This patch introduces an environment variable to turn all
pathspecs into literal strings. This makes it easy to turn
off the globbing behavior for a whole environment (e.g., if
you are serving repos via a web interface that is only going
to use literal programmatic pathspecs), or for a particular
run.

It cannot turn off globbing for particular pathspecs. That
could eventually be done with a ":(noglob)" magic pathspec
prefix. However, that level of granularity is not often
needed, and doing ":(noglob)" right would mean converting
the whole codebase to use "struct pathspec", as the usual
"const char **pathspec" cannot represent extra per-item
flags.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git.txt      | 15 +++++++++++
 cache.h                    |  3 +++
 dir.c                      | 24 +++++++++++++-----
 git.c                      |  8 ++++++
 t/t6130-pathspec-noglob.sh | 62 ++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 106 insertions(+), 6 deletions(-)
 create mode 100755 t/t6130-pathspec-noglob.sh

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 1d797f2..7008b4d 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -422,6 +422,10 @@ help ...`.
 	Do not use replacement refs to replace git objects. See
 	linkgit:git-replace[1] for more information.
 
+--no-pathspec-glob::
+	Do not treat pathspecs as glob patterns. See the section on
+	the `GIT_PATHSPEC_GLOB` environment variable below.
+
 
 GIT COMMANDS
 ------------
@@ -790,6 +794,17 @@ for further details.
 	as a file path and will try to write the trace messages
 	into it.
 
+GIT_PATHSPEC_GLOB::
+	Setting this variable to `0` will turn off the globbing features
+	of git's pathspecs. For example, running `GIT_PATHSPEC_GLOB=0 git
+	log -- '*.c'` will search for commits literally touching the
+	path `*.c`, not any paths that the glob `*.c` matches. You might
+	want this if you are feeding literal paths to git (e.g., paths
+	previously given to you by `git ls-tree`, `--raw` diff output,
+	etc). Setting it to `1` enables pathspec globbing (which is also
+	the default).
+
+
 Discussion[[Discussion]]
 ------------------------
 
diff --git a/cache.h b/cache.h
index 18fdd18..98af77c 100644
--- a/cache.h
+++ b/cache.h
@@ -362,6 +362,7 @@ static inline enum object_type object_type(unsigned int mode)
 #define GIT_NOTES_DISPLAY_REF_ENVIRONMENT "GIT_NOTES_DISPLAY_REF"
 #define GIT_NOTES_REWRITE_REF_ENVIRONMENT "GIT_NOTES_REWRITE_REF"
 #define GIT_NOTES_REWRITE_MODE_ENVIRONMENT "GIT_NOTES_REWRITE_MODE"
+#define GIT_PATHSPEC_GLOB_ENVIRONMENT "GIT_PATHSPEC_GLOB"
 
 /*
  * Repository-local GIT_* environment variables
@@ -490,6 +491,8 @@ extern int ce_path_match(const struct cache_entry *ce, const struct pathspec *pa
 extern void free_pathspec(struct pathspec *);
 extern int ce_path_match(const struct cache_entry *ce, const struct pathspec *pathspec);
 
+extern int allow_pathspec_glob(void);
+
 #define HASH_WRITE_OBJECT 1
 #define HASH_FORMAT_CHECK 2
 extern int index_fd(unsigned char *sha1, int fd, struct stat *st, enum object_type type, const char *path, unsigned flags);
diff --git a/dir.c b/dir.c
index 5a83aa7..a4d4321 100644
--- a/dir.c
+++ b/dir.c
@@ -38,6 +38,7 @@ static size_t common_prefix_len(const char **pathspec)
 {
 	const char *n, *first;
 	size_t max = 0;
+	int glob = allow_pathspec_glob();
 
 	if (!pathspec)
 		return max;
@@ -47,7 +48,7 @@ static size_t common_prefix_len(const char **pathspec)
 		size_t i, len = 0;
 		for (i = 0; first == n || i < max; i++) {
 			char c = n[i];
-			if (!c || c != first[i] || is_glob_special(c))
+			if (!c || c != first[i] || (glob && is_glob_special(c)))
 				break;
 			if (c == '/')
 				len = i + 1;
@@ -117,6 +118,7 @@ static int match_one(const char *match, const char *name, int namelen)
 static int match_one(const char *match, const char *name, int namelen)
 {
 	int matchlen;
+	int glob = allow_pathspec_glob();
 
 	/* If the match was just the prefix, we matched */
 	if (!*match)
@@ -126,7 +128,7 @@ static int match_one(const char *match, const char *name, int namelen)
 		for (;;) {
 			unsigned char c1 = tolower(*match);
 			unsigned char c2 = tolower(*name);
-			if (c1 == '\0' || is_glob_special(c1))
+			if (c1 == '\0' || (glob && is_glob_special(c1)))
 				break;
 			if (c1 != c2)
 				return 0;
@@ -138,7 +140,7 @@ static int match_one(const char *match, const char *name, int namelen)
 		for (;;) {
 			unsigned char c1 = *match;
 			unsigned char c2 = *name;
-			if (c1 == '\0' || is_glob_special(c1))
+			if (c1 == '\0' || (glob && is_glob_special(c1)))
 				break;
 			if (c1 != c2)
 				return 0;
@@ -148,14 +150,16 @@ static int match_one(const char *match, const char *name, int namelen)
 		}
 	}
 
-
 	/*
 	 * If we don't match the matchstring exactly,
 	 * we need to match by fnmatch
 	 */
 	matchlen = strlen(match);
-	if (strncmp_icase(match, name, matchlen))
+	if (strncmp_icase(match, name, matchlen)) {
+		if (!glob)
+			return 0;
 		return !fnmatch_icase(match, name, 0) ? MATCHED_FNMATCH : 0;
+	}
 
 	if (namelen == matchlen)
 		return MATCHED_EXACTLY;
@@ -1429,7 +1433,7 @@ int init_pathspec(struct pathspec *pathspec, const char **paths)
 
 		item->match = path;
 		item->len = strlen(path);
-		item->use_wildcard = !no_wildcard(path);
+		item->use_wildcard = allow_pathspec_glob() && !no_wildcard(path);
 		if (item->use_wildcard)
 			pathspec->has_wildcard = 1;
 	}
@@ -1445,3 +1449,11 @@ void free_pathspec(struct pathspec *pathspec)
 	free(pathspec->items);
 	pathspec->items = NULL;
 }
+
+int allow_pathspec_glob(void)
+{
+	static int flag = -1;
+	if (flag < 0)
+		flag = git_env_bool(GIT_PATHSPEC_GLOB_ENVIRONMENT, 1);
+	return flag;
+}
diff --git a/git.c b/git.c
index d33f9b3..db0496f 100644
--- a/git.c
+++ b/git.c
@@ -135,6 +135,14 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 			git_config_push_parameter((*argv)[1]);
 			(*argv)++;
 			(*argc)--;
+		} else if (!strcmp(cmd, "--pathspec-glob")) {
+			setenv(GIT_PATHSPEC_GLOB_ENVIRONMENT, "1", 1);
+			if (envchanged)
+				*envchanged = 1;
+		} else if (!strcmp(cmd, "--no-pathspec-glob")) {
+			setenv(GIT_PATHSPEC_GLOB_ENVIRONMENT, "0", 1);
+			if (envchanged)
+				*envchanged = 1;
 		} else {
 			fprintf(stderr, "Unknown option: %s\n", cmd);
 			usage(git_usage_string);
diff --git a/t/t6130-pathspec-noglob.sh b/t/t6130-pathspec-noglob.sh
new file mode 100755
index 0000000..835e730
--- /dev/null
+++ b/t/t6130-pathspec-noglob.sh
@@ -0,0 +1,62 @@
+#!/bin/sh
+
+test_description='test globbing (and noglob) of pathspec limiting'
+. ./test-lib.sh
+
+test_expect_success 'create commits with glob characters' '
+	test_commit unrelated bar &&
+	test_commit vanilla foo &&
+	test_commit star "f*" &&
+	test_commit bracket "f[o][o]"
+'
+
+test_expect_success 'vanilla pathspec matches literally' '
+	echo vanilla >expect &&
+	git log --format=%s -- foo >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'star pathspec globs' '
+	cat >expect <<-\EOF &&
+	bracket
+	star
+	vanilla
+	EOF
+	git log --format=%s -- "f*" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'bracket pathspec globs and matches literal brackets' '
+	cat >expect <<-\EOF &&
+	bracket
+	vanilla
+	EOF
+	git log --format=%s -- "f[o][o]" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'no-glob option matches literally (vanilla)' '
+	echo vanilla >expect &&
+	git --no-pathspec-glob log --format=%s -- foo >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'no-glob option matches literally (star)' '
+	echo star >expect &&
+	git --no-pathspec-glob log --format=%s -- "f*" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'no-glob option matches literally (bracket)' '
+	echo bracket >expect &&
+	git --no-pathspec-glob log --format=%s -- "f[o][o]" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'no-glob environment variable works' '
+	echo star >expect &&
+	GIT_PATHSPEC_GLOB=0 git log --format=%s -- "f*" >actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
1.8.1.rc2.24.gf3bad77
