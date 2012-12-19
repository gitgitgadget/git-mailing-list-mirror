From: Jeff King <peff@peff.net>
Subject: [PATCH] add core.pathspecGlob config option
Date: Wed, 19 Dec 2012 15:34:49 -0500
Message-ID: <20121219203449.GA10001@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 19 21:35:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlQMC-0004YA-Bw
	for gcvg-git-2@plane.gmane.org; Wed, 19 Dec 2012 21:35:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751622Ab2LSUey (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2012 15:34:54 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:58757 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751521Ab2LSUex (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2012 15:34:53 -0500
Received: (qmail 32722 invoked by uid 107); 19 Dec 2012 20:35:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 19 Dec 2012 15:35:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Dec 2012 15:34:49 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211845>

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

This patch introduces a config option to turn all pathspecs
into literal strings. This makes it easy to turn off the
globbing behavior for a whole environment (e.g., if you are
serving repos via a web interface that is only going to
use literal programmatic pathspecs), or for a particular run
(by using "git -c" to set the option for this run).

It cannot turn off globbing for particular pathspecs. That
could eventually be done with a ":(noglob)" magic pathspec
prefix. However, that level of granularity is not often
needed, and doing ":(noglob)" right would mean converting
the whole codebase to use "struct pathspec", as the usual
"const char **pathspec" cannot represent extra per-item
flags.

Signed-off-by: Jeff King <peff@peff.net>
---
Part of me thinks this is just gross, because ":(noglob)" is the right
solution. But after spending a few hours trying it this morning, there
is a ton of refactoring required to make it work correctly everywhere
(although we could die() if we see it in places that are not using
init_pathspec, so at least we could say "not supported yet" and not just
silently ignore it).

Still, this is so easy to do, and the lack of granularity does not hurt
my use cases at all (which, if you have not guessed, are improving
corner cases in scripted calls on GitHub). And I do not think it is just
me, or just GitHub. Any server-side porcelain would be better off with
such an option (for example, I think gitweb has the same issues; it is
just that they are pretty rare, because most people do not put glob
metacharacters into their filenames).

So I think this is a nice, simple approach for sites that want it, and
noglob magic can come later (and will not be any harder to implement as
a result of this patch).

 cache.h                    |  1 +
 config.c                   |  5 +++++
 dir.c                      | 12 +++++-----
 environment.c              |  1 +
 t/t6130-pathspec-noglob.sh | 56 ++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 70 insertions(+), 5 deletions(-)
 create mode 100755 t/t6130-pathspec-noglob.sh

diff --git a/cache.h b/cache.h
index 18fdd18..0725a33 100644
--- a/cache.h
+++ b/cache.h
@@ -555,6 +555,7 @@ extern int precomposed_unicode;
 extern int core_preload_index;
 extern int core_apply_sparse_checkout;
 extern int precomposed_unicode;
+extern int core_pathspec_glob;
 
 enum branch_track {
 	BRANCH_TRACK_UNSPECIFIED = -1,
diff --git a/config.c b/config.c
index fb3f868..8a96ba7 100644
--- a/config.c
+++ b/config.c
@@ -760,6 +760,11 @@ static int git_default_core_config(const char *var, const char *value)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.pathspecglob")) {
+		core_pathspec_glob = git_config_bool(var, value);
+		return 0;
+	}
+
 	/* Add other config variables here and to Documentation/config.txt. */
 	return 0;
 }
diff --git a/dir.c b/dir.c
index 5a83aa7..6e81d4f 100644
--- a/dir.c
+++ b/dir.c
@@ -126,7 +126,7 @@ static int match_one(const char *match, const char *name, int namelen)
 		for (;;) {
 			unsigned char c1 = tolower(*match);
 			unsigned char c2 = tolower(*name);
-			if (c1 == '\0' || is_glob_special(c1))
+			if (c1 == '\0' || (core_pathspec_glob && is_glob_special(c1)))
 				break;
 			if (c1 != c2)
 				return 0;
@@ -138,7 +138,7 @@ static int match_one(const char *match, const char *name, int namelen)
 		for (;;) {
 			unsigned char c1 = *match;
 			unsigned char c2 = *name;
-			if (c1 == '\0' || is_glob_special(c1))
+			if (c1 == '\0' || (core_pathspec_glob && is_glob_special(c1)))
 				break;
 			if (c1 != c2)
 				return 0;
@@ -148,14 +148,16 @@ static int match_one(const char *match, const char *name, int namelen)
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
+		if (!core_pathspec_glob)
+			return 0;
 		return !fnmatch_icase(match, name, 0) ? MATCHED_FNMATCH : 0;
+	}
 
 	if (namelen == matchlen)
 		return MATCHED_EXACTLY;
@@ -1429,7 +1431,7 @@ int init_pathspec(struct pathspec *pathspec, const char **paths)
 
 		item->match = path;
 		item->len = strlen(path);
-		item->use_wildcard = !no_wildcard(path);
+		item->use_wildcard = core_pathspec_glob && !no_wildcard(path);
 		if (item->use_wildcard)
 			pathspec->has_wildcard = 1;
 	}
diff --git a/environment.c b/environment.c
index 85edd7f..d0d30a0 100644
--- a/environment.c
+++ b/environment.c
@@ -59,6 +59,7 @@ int precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
 int core_apply_sparse_checkout;
 int merge_log_config = -1;
 int precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
+int core_pathspec_glob = 1;
 struct startup_info *startup_info;
 unsigned long pack_size_limit_cfg;
 
diff --git a/t/t6130-pathspec-noglob.sh b/t/t6130-pathspec-noglob.sh
new file mode 100755
index 0000000..bb962ac
--- /dev/null
+++ b/t/t6130-pathspec-noglob.sh
@@ -0,0 +1,56 @@
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
+test_expect_success 'no-glob config matches literally (vanilla)' '
+	echo vanilla >expect &&
+	git -c core.pathspecglob=false log --format=%s -- foo >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'no-glob config matches literally (star)' '
+	echo star >expect &&
+	git -c core.pathspecglob=false log --format=%s -- "f*" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'no-glob config matches literally (bracket)' '
+	echo bracket >expect &&
+	git -c core.pathspecglob=false log --format=%s -- "f[o][o]" >actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
1.8.1.rc2.24.gf3bad77
