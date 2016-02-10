From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] check_filename: tighten dwim-wildcard ambiguity
Date: Wed, 10 Feb 2016 16:14:46 -0500
Message-ID: <20160210211446.GB5799@sigill.intra.peff.net>
References: <20160210211206.GA5755@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Kirill Likhodedov <kirill.likhodedov@jetbrains.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 10 22:14:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTc6A-0003E3-4v
	for gcvg-git-2@plane.gmane.org; Wed, 10 Feb 2016 22:14:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbcBJVOu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2016 16:14:50 -0500
Received: from cloud.peff.net ([50.56.180.127]:40000 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750819AbcBJVOt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2016 16:14:49 -0500
Received: (qmail 16076 invoked by uid 102); 10 Feb 2016 21:14:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Feb 2016 16:14:49 -0500
Received: (qmail 31709 invoked by uid 107); 10 Feb 2016 21:14:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Feb 2016 16:14:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Feb 2016 16:14:46 -0500
Content-Disposition: inline
In-Reply-To: <20160210211206.GA5755@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285930>

When specifying both revisions and pathnames, we allow
"<rev> -- <pathspec>" to be spelled without the "--" as long
as it is not ambiguous. The original logic was something
like:

  1. Resolve each item with get_sha1(). If successful,
     we know it can be a <rev>. Verify that it _isn't_ a
     filename, using verify_non_filename(), and complain of
     ambiguity otherwise.

  2. If get_sha1() didn't succeed, make sure that it _is_
     a file, using verify_filename(). If not, complain
     that it is neither a <rev> nor a <pathspec>.

Both verify_filename() and verify_non_filename() rely on
check_filename(), which definitely said "yes, this is a
file" or "no, it is not" using lstat().

Commit 28fcc0b (pathspec: avoid the need of "--" when
wildcard is used, 2015-05-02) introduced a convenience
feature: check_filename() will consider anything with
wildcard meta-characters as a possible filename, without
even checking the filesystem.

This works well for case 2. For such a wildcard, we would
previously have died and said "it is neither". Post-28fcc0b,
we assume it's a pathspec and proceed.

But it makes some instances of case 1 worse. We may have an
extended sha1 expression that contains meta-characters
(e.g., "HEAD^{/foo.*bar}"), and we now complain that it's
also a filename, due to the wildcard characters (even though
that wildcard would not match anything in the filesystem).

One solution would be to actually expand the pathname and
see if it matches anything on the filesystem. But that's
potentially expensive, and we do not have to be so rigorous
for this DWIM magic (if you want rigor, use "--").

Instead, we can just use different rules for cases 1 and 2.
When we know something is a rev, we will complain only if it
meets a much higher standard for "this is also a file";
namely that it actually exists in the filesystem. Case 2
remains the same: we use the looser "it could be a filename"
standard introduced by 28fcc0b.

We can accomplish this by pulling the wildcard logic out of
check_filename() and putting it into verify_filename(). Its
partner verify_non_filename() does not need a change, since
check_filename() goes back to implementing the "higher
standard".

Besides these two callers of check_filename(), there is one
other: git-checkout does a similar DWIM itself. It hits this
code path only after get_sha1() has returned failure, making
it case 2, which gets the special wildcard treatment.

Note that we drop the tests in t2019 in favor of a more
complete set in t6133. t2019 was not the right place for
them (it's about refname ambiguity, not dwim parsing
ambiguity), and the second test explicitly checked for the
opposite result of the case we are fixing here (which didn't
really make any sense; as shown by the test_must_fail in the
test, it would only serve to annoy people).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/checkout.c                |  3 ++-
 setup.c                           |  6 ++----
 t/t2019-checkout-ambiguous-ref.sh | 26 --------------------------
 t/t6133-pathspec-rev-dwim.sh      | 38 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 42 insertions(+), 31 deletions(-)
 create mode 100755 t/t6133-pathspec-rev-dwim.sh

diff --git a/builtin/checkout.c b/builtin/checkout.c
index f6a2809..cfa66e2 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -982,7 +982,8 @@ static int parse_branchname_arg(int argc, const char **argv,
 		 */
 		int recover_with_dwim = dwim_new_local_branch_ok;
 
-		if (!has_dash_dash && check_filename(NULL, arg))
+		if (!has_dash_dash &&
+		    (check_filename(NULL, arg) || !no_wildcard(arg)))
 			recover_with_dwim = 0;
 		/*
 		 * Accept "git checkout foo" and "git checkout foo --"
diff --git a/setup.c b/setup.c
index 2c4b22c..995e924 100644
--- a/setup.c
+++ b/setup.c
@@ -139,9 +139,7 @@ int check_filename(const char *prefix, const char *arg)
 		if (arg[2] == '\0') /* ":/" is root dir, always exists */
 			return 1;
 		name = arg + 2;
-	} else if (!no_wildcard(arg))
-		return 1;
-	else if (prefix)
+	} else if (prefix)
 		name = prefix_filename(prefix, strlen(prefix), arg);
 	else
 		name = arg;
@@ -202,7 +200,7 @@ void verify_filename(const char *prefix,
 {
 	if (*arg == '-')
 		die("bad flag '%s' used after filename", arg);
-	if (check_filename(prefix, arg))
+	if (check_filename(prefix, arg) || !no_wildcard(arg))
 		return;
 	die_verify_filename(prefix, arg, diagnose_misspelt_rev);
 }
diff --git a/t/t2019-checkout-ambiguous-ref.sh b/t/t2019-checkout-ambiguous-ref.sh
index 199b22d..b99d519 100755
--- a/t/t2019-checkout-ambiguous-ref.sh
+++ b/t/t2019-checkout-ambiguous-ref.sh
@@ -56,30 +56,4 @@ test_expect_success VAGUENESS_SUCCESS 'checkout reports switch to branch' '
 	test_i18ngrep ! "^HEAD is now at" stderr
 '
 
-test_expect_success 'wildcard ambiguation, paths win' '
-	git init ambi &&
-	(
-		cd ambi &&
-		echo a >a.c &&
-		git add a.c &&
-		echo b >a.c &&
-		git checkout "*.c" &&
-		echo a >expect &&
-		test_cmp expect a.c
-	)
-'
-
-test_expect_success !MINGW 'wildcard ambiguation, refs lose' '
-	git init ambi2 &&
-	(
-		cd ambi2 &&
-		echo a >"*.c" &&
-		git add . &&
-		test_must_fail git show :"*.c" &&
-		git show :"*.c" -- >actual &&
-		echo a >expect &&
-		test_cmp expect actual
-	)
-'
-
 test_done
diff --git a/t/t6133-pathspec-rev-dwim.sh b/t/t6133-pathspec-rev-dwim.sh
new file mode 100755
index 0000000..8e5b338
--- /dev/null
+++ b/t/t6133-pathspec-rev-dwim.sh
@@ -0,0 +1,38 @@
+#!/bin/sh
+
+test_description='test dwim of revs versus pathspecs in revision parser'
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_commit base &&
+	echo content >"br[ack]ets" &&
+	git add . &&
+	test_tick &&
+	git commit -m brackets
+'
+
+test_expect_success 'non-rev wildcard dwims to pathspec' '
+	git log -- "*.t" >expect &&
+	git log    "*.t" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'tree:path with metacharacters dwims to rev' '
+	git show "HEAD:br[ack]ets" -- >expect &&
+	git show "HEAD:br[ack]ets"    >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '^{foo} with metacharacters dwims to rev' '
+	git log "HEAD^{/b.*}" -- >expect &&
+	git log "HEAD^{/b.*}"    >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '@{foo} with metacharacters dwims to rev' '
+	git log "HEAD@{now [or thereabouts]}" -- >expect &&
+	git log "HEAD@{now [or thereabouts]}"    >actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
2.7.1.545.gfd1d4e5
