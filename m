Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1EAC56202
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 21:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19348207D3
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 21:40:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731962AbgKJVks (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 16:40:48 -0500
Received: from cloud.peff.net ([104.130.231.41]:53574 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727275AbgKJVkU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 16:40:20 -0500
Received: (qmail 9513 invoked by uid 109); 10 Nov 2020 21:40:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 10 Nov 2020 21:40:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6129 invoked by uid 111); 10 Nov 2020 21:40:19 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 10 Nov 2020 16:40:19 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 10 Nov 2020 16:40:19 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Demi M. Obenour" <athena@invisiblethingslab.com>,
        Git <git@vger.kernel.org>
Subject: [PATCH 3/3] rev-parse: handle --end-of-options
Message-ID: <20201110214019.GC788740@coredump.intra.peff.net>
References: <20201110213544.GA3263091@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201110213544.GA3263091@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We taught rev-list a new way to separate options from revisions in
19e8789b23 (revision: allow --end-of-options to end option parsing,
2019-08-06), but rev-parse uses its own parser. It should know about
--end-of-options not only for consistency, but because it may be
presented with similarly ambiguous cases. E.g., if a caller does:

  git rev-parse "$rev" -- "$path"

to parse an untrusted input, then it will get confused if $rev contains
an option-like string like "--local-env-vars". Or even "--not-real",
which we'd keep as an option to pass along to rev-list.

Or even more importantly:

  git rev-parse --verify "$rev"

can be confused by options, even though its purpose is safely parsing
untrusted input. On the plus side, it will always fail the --verify
part, as it will not have parsed a revision, so the caller will
generally "fail closed" rather than continue to use the untrusted
string. But it will still trigger whatever option was in "$rev"; this
should be mostly harmless, since rev-parse options are all read-only,
but I didn't carefully audit all paths.

This patch lets callers write:

  git rev-parse --end-of-options "$rev" -- "$path"

and:

  git rev-parse --verify --end-of-options "$rev"

which will both treat "$rev" always as a revision parameter. The latter
is a bit clunky. It would be nicer if we had defined "--verify" to
require that its next argument be the revision. But we have not
historically done so, and:

  git rev-parse --verify -q "$rev"

does currently work. I added a test here to confirm that we didn't break
that.

A few implementation notes:

 - We don't document --end-of-options explicitly in commands, but rather
   in gitcli(7). So I didn't give it its own section in git-rev-parse(1).
   But I did call it out specifically in the --verify section, and
   include it in the examples, which should show best practices.

 - We don't have to re-indent the main option-parsing block, because we
   can combine our "did we see end of options" check with "does it start
   with a dash". The exception is the pre-setup options, which need
   their own block.

 - We do however have to pull the "--" parsing out of the "does it start
   with dash" block, because we want to parse it even if we've seen
   --end-of-options.

 - We'll leave "--end-of-options" in the output. This is probably not
   technically necessary, as a careful caller will do:

     git rev-parse --end-of-options $revs -- $paths

   and anything in $revs will be resolved to an object id. However, it
   does help a slightly less careful caller like:

     git rev-parse --end-of-options $revs_or_paths

   where a path "--foo" will remain in the output as long as it also
   exists on disk. In that case, it's helpful to retain --end-of-options
   to get passed along to rev-list, s it would otherwise see just
   "--foo".

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-rev-parse.txt |  8 +++--
 builtin/rev-parse.c             | 56 +++++++++++++++++++--------------
 t/t1503-rev-parse-verify.sh     | 13 ++++++++
 t/t1506-rev-parse-diagnosis.sh  | 16 ++++++++++
 4 files changed, 68 insertions(+), 25 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 19b12b6d43..5013daa6ef 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -109,6 +109,10 @@ names an existing object that is a commit-ish (i.e. a commit, or an
 annotated tag that points at a commit).  To make sure that `$VAR`
 names an existing object of any type, `git rev-parse "$VAR^{object}"`
 can be used.
++
+Note that if you are verifying a name from an untrusted source, it is
+wise to use `--end-of-options` so that the name argument is not mistaken
+for another option.
 
 -q::
 --quiet::
@@ -446,15 +450,15 @@ $ git rev-parse --verify HEAD
 * Print the commit object name from the revision in the $REV shell variable:
 +
 ------------
-$ git rev-parse --verify $REV^{commit}
+$ git rev-parse --verify --end-of-options $REV^{commit}
 ------------
 +
 This will error out if $REV is empty or not a valid revision.
 
 * Similar to above:
 +
 ------------
-$ git rev-parse --default master --verify $REV
+$ git rev-parse --default master --verify --end-of-options $REV
 ------------
 +
 but if $REV is empty, the commit object name from master will be printed.
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 79689286d8..69ba7326cf 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -595,6 +595,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 	struct object_context unused;
 	struct strbuf buf = STRBUF_INIT;
 	const int hexsz = the_hash_algo->hexsz;
+	int seen_end_of_options = 0;
 
 	if (argc > 1 && !strcmp("--parseopt", argv[1]))
 		return cmd_parseopt(argc - 1, argv + 1, prefix);
@@ -628,21 +629,23 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 
-		if (!strcmp(arg, "--local-env-vars")) {
-			int i;
-			for (i = 0; local_repo_env[i]; i++)
-				printf("%s\n", local_repo_env[i]);
-			continue;
-		}
-		if (!strcmp(arg, "--resolve-git-dir")) {
-			const char *gitdir = argv[++i];
-			if (!gitdir)
-				die("--resolve-git-dir requires an argument");
-			gitdir = resolve_gitdir(gitdir);
-			if (!gitdir)
-				die("not a gitdir '%s'", argv[i]);
-			puts(gitdir);
-			continue;
+		if (!seen_end_of_options) {
+			if (!strcmp(arg, "--local-env-vars")) {
+				int i;
+				for (i = 0; local_repo_env[i]; i++)
+					printf("%s\n", local_repo_env[i]);
+				continue;
+			}
+			if (!strcmp(arg, "--resolve-git-dir")) {
+				const char *gitdir = argv[++i];
+				if (!gitdir)
+					die("--resolve-git-dir requires an argument");
+				gitdir = resolve_gitdir(gitdir);
+				if (!gitdir)
+					die("not a gitdir '%s'", argv[i]);
+				puts(gitdir);
+				continue;
+			}
 		}
 
 		/* The rest of the options require a git repository. */
@@ -652,14 +655,15 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 			did_repo_setup = 1;
 		}
 
-		if (*arg == '-') {
-			if (!strcmp(arg, "--")) {
-				as_is = 2;
-				/* Pass on the "--" if we show anything but files.. */
-				if (filter & (DO_FLAGS | DO_REVS))
-					show_file(arg, 0);
-				continue;
-			}
+		if (!strcmp(arg, "--")) {
+			as_is = 2;
+			/* Pass on the "--" if we show anything but files.. */
+			if (filter & (DO_FLAGS | DO_REVS))
+				show_file(arg, 0);
+			continue;
+		}
+
+		if (!seen_end_of_options && *arg == '-') {
 			if (!strcmp(arg, "--git-path")) {
 				if (!argv[i + 1])
 					die("--git-path requires an argument");
@@ -937,6 +941,12 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				puts(the_hash_algo->name);
 				continue;
 			}
+			if (!strcmp(arg, "--end-of-options")) {
+				seen_end_of_options = 1;
+				if (filter & (DO_FLAGS | DO_REVS))
+					show_file(arg, 0);
+				continue;
+			}
 			if (show_flag(arg) && verify)
 				die_no_single_rev(quiet);
 			continue;
diff --git a/t/t1503-rev-parse-verify.sh b/t/t1503-rev-parse-verify.sh
index 492edffa9c..dc9fe3cbf1 100755
--- a/t/t1503-rev-parse-verify.sh
+++ b/t/t1503-rev-parse-verify.sh
@@ -144,4 +144,17 @@ test_expect_success SYMLINKS 'ref resolution not confused by broken symlinks' '
 	test_must_fail git rev-parse --verify broken
 '
 
+test_expect_success 'options can appear after --verify' '
+	git rev-parse --verify HEAD >expect &&
+	git rev-parse --verify -q HEAD >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'verify respects --end-of-options' '
+	git update-ref refs/heads/-tricky HEAD &&
+	git rev-parse --verify HEAD >expect &&
+	git rev-parse --verify --end-of-options -tricky >actual &&
+	test_cmp expect actual
+'
+
 test_done
diff --git a/t/t1506-rev-parse-diagnosis.sh b/t/t1506-rev-parse-diagnosis.sh
index 2ed5d50059..e2ae15a2cf 100755
--- a/t/t1506-rev-parse-diagnosis.sh
+++ b/t/t1506-rev-parse-diagnosis.sh
@@ -263,4 +263,20 @@ test_expect_success 'arg after dashdash not interpreted as option' '
 	test_cmp expect actual
 '
 
+test_expect_success 'arg after end-of-options not interpreted as option' '
+	test_must_fail git rev-parse --end-of-options --not-real -- 2>err &&
+	test_i18ngrep bad.revision.*--not-real err
+'
+
+test_expect_success 'end-of-options still allows --' '
+	cat >expect <<-EOF &&
+	--end-of-options
+	$(git rev-parse --verify HEAD)
+	--
+	path
+	EOF
+	git rev-parse --end-of-options HEAD -- path >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.29.2.640.g9e24689a4c
