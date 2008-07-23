From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 2/2] git-checkout: improve error messages, detect ambiguities.
Date: Wed, 23 Jul 2008 12:15:33 +0200
Message-ID: <1216808133-31919-3-git-send-email-madcoder@debian.org>
References: <1216774940-4955-1-git-send-email-madcoder@debian.org>
 <1216808133-31919-1-git-send-email-madcoder@debian.org>
 <1216808133-31919-2-git-send-email-madcoder@debian.org>
Cc: gitster@pobox.com, Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 23 12:16:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLbOf-0001Ja-QR
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 12:16:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751557AbYGWKPi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 06:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751790AbYGWKPi
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 06:15:38 -0400
Received: from pan.madism.org ([88.191.52.104]:54298 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750961AbYGWKPg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 06:15:36 -0400
Received: from madism.org (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 195903A5A6;
	Wed, 23 Jul 2008 12:15:34 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 783CC1426F0; Wed, 23 Jul 2008 12:15:33 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.rc0.153.ge8bf3
In-Reply-To: <1216808133-31919-2-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89622>

The patch is twofold: it moves the option consistency checks just under
the parse_options call so that it doesn't get in the way of the tree
reference vs. pathspecs desambiguation.

The other part rewrites the way to understand arguments so that when
git-checkout fails it does with an understandable message. Compared to the
previous behavior we now have:

  - a better error message when doing:
        git checkout <blob reference> --
    now complains about the reference not pointing to a tree, instead of
    things like:
        error: pathspec <blob reference> did not match any file(s) known to git.
        error: pathspec '--' did not match any file(s) known to git.

    you what it spitted before.

  - a better error message when doing:
        git checkout <path> --
    It now complains about <path> not being a reference instead of the
    completely obscure:
        error: pathspec '--' did not match any file(s) known to git.

  - an error when -- wasn't used and the first argument is ambiguous.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 builtin-checkout.c            |   71 +++++++++++++++++++++++++++++++----------
 t/t2010-checkout-ambiguous.sh |   39 ++++++++++++++++++++++
 2 files changed, 93 insertions(+), 17 deletions(-)
 create mode 100755 t/t2010-checkout-ambiguous.sh

diff --git a/builtin-checkout.c b/builtin-checkout.c
index 9cadf9c..e9ae834 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -430,6 +430,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		OPT_BOOLEAN('m', NULL, &opts.merge, "merge"),
 		OPT_END(),
 	};
+	int has_dash_dash;
 
 	memset(&opts, 0, sizeof(opts));
 	memset(&new, 0, sizeof(new));
@@ -440,11 +441,52 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, options, checkout_usage,
 			     PARSE_OPT_KEEP_DASHDASH);
+
+	if (!opts.new_branch && (opts.track != git_branch_track))
+		die("git checkout: --track and --no-track require -b");
+
+	if (opts.force && opts.merge)
+		die("git checkout: -f and -m are incompatible");
+
+	/*
+	 * case 1: git checkout <ref> -- [<paths>]
+	 *
+	 *   <ref> must be a valid tree, everything after the '--' must be
+	 *   a path.
+	 *
+	 * case 2: git checkout -- [<paths>]
+	 *
+	 *   everything after the '--' must be paths.
+	 *
+	 * case 3: git checkout <something> [<paths>]
+	 *
+	 *   <something> shall not be ambiguous.
+	 *   - If it's *only* a reference, treat it like case (1).
+	 *   - If it's only a path, treat it like case (2).
+	 *   - else: fail.
+	 *
+	 */
 	if (argc) {
+		if (!strcmp(argv[0], "--")) {       /* case (2) */
+			argv++;
+			argc--;
+			goto no_reference;
+		}
+		
 		arg = argv[0];
-		if (get_sha1(arg, rev))
-			;
-		else if ((new.commit = lookup_commit_reference_gently(rev, 1))) {
+		has_dash_dash = argc > 1 && !strcmp(argv[1], "--");
+
+		if (get_sha1(arg, rev)) {
+			if (has_dash_dash)          /* case (1) */
+				die("invalid reference: %s", arg);
+			goto no_reference;          /* case (3 -> 2) */
+		}
+
+		/* we can't end up being in (2) anymore, eat the argument */
+		argv++;
+		argc--;
+
+		if ((new.commit = lookup_commit_reference_gently(rev, 1))) {
 			new.name = arg;
 			setup_branch_path(&new);
 			if (resolve_ref(new.path, rev, 1, NULL))
@@ -453,25 +495,20 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 				new.path = NULL;
 			parse_commit(new.commit);
 			source_tree = new.commit->tree;
-			argv++;
-			argc--;
-		} else if ((source_tree = parse_tree_indirect(rev))) {
+		} else
+			source_tree = parse_tree_indirect(rev);
+
+		if (!source_tree)                   /* case (1): want a tree */
+			die("reference is not a tree: %s", arg);
+		if (!has_dash_dash)                 /* case (3 -> 1) */
+			verify_non_filename(NULL, arg);
+		else {
 			argv++;
 			argc--;
 		}
 	}
 
-	if (argc && !strcmp(argv[0], "--")) {
-		argv++;
-		argc--;
-	}
-
-	if (!opts.new_branch && (opts.track != git_branch_track))
-		die("git checkout: --track and --no-track require -b");
-
-	if (opts.force && opts.merge)
-		die("git checkout: -f and -m are incompatible");
-
+no_reference:
 	if (argc) {
 		const char **pathspec = get_pathspec(prefix, argv);
 
diff --git a/t/t2010-checkout-ambiguous.sh b/t/t2010-checkout-ambiguous.sh
new file mode 100755
index 0000000..50d1f43
--- /dev/null
+++ b/t/t2010-checkout-ambiguous.sh
@@ -0,0 +1,39 @@
+#!/bin/sh
+
+test_description='checkout and pathspecs/refspecs ambiguities'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	echo hello >world &&
+	echo hello >all &&
+	git add all world &&
+	git commit -m initial &&
+	git branch world
+'
+
+test_expect_success 'reference must be a tree' '
+	test_must_fail git checkout $(git hash-object ./all) --
+'
+
+test_expect_success 'branch switching' '
+	test "refs/heads/master" = "$(git symbolic-ref HEAD)" &&
+	git checkout world -- &&
+	test "refs/heads/world" = "$(git symbolic-ref HEAD)"
+'
+
+test_expect_success 'checkout world from the index' '
+	echo bye > world &&
+	git checkout -- world &&
+	git diff --exit-code --quiet
+'
+
+test_expect_success 'non ambiguous call' '
+	git checkout all
+'
+
+test_expect_success 'ambiguous call' '
+	test_must_fail git checkout world
+'
+
+test_done
-- 
1.6.0.rc0.155.g8e50b
