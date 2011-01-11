From: Jeff King <peff@peff.net>
Subject: Re: bug? in checkout with ambiguous refnames
Date: Tue, 11 Jan 2011 15:00:38 -0500
Message-ID: <20110111200037.GA24777@sigill.intra.peff.net>
References: <20110107104650.GA5399@pengutronix.de>
 <20110107194909.GB6175@sigill.intra.peff.net>
 <20110107195417.GC6175@sigill.intra.peff.net>
 <20110111065509.GG10094@sigill.intra.peff.net>
 <20110111192020.GA15608@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 11 21:01:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PckOf-0005SX-HR
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 21:00:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932300Ab1AKUAp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jan 2011 15:00:45 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:51259 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932206Ab1AKUAn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jan 2011 15:00:43 -0500
Received: (qmail 15852 invoked by uid 111); 11 Jan 2011 20:00:40 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 11 Jan 2011 20:00:40 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Jan 2011 15:00:38 -0500
Content-Disposition: inline
In-Reply-To: <20110111192020.GA15608@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164986>

On Tue, Jan 11, 2011 at 02:20:20PM -0500, Jeff King wrote:

> Hmm. One other thing to note on these ambiguity tests.

I was starting to get confused with all the back-and-forth, so here is a
squashed patch that contains everything discussed so far: my original
tests, your squashed patches, my test fixups, and the less-subtle
resolve_ref thing.

I didn't bisect the breakage, so I'm not sure how far back it goes. But
this is potentially maint-worthy.

This doesn't include any tests or fixes for "git checkout -b newbranch
ambiguous". I'll work on that separately as a patch on top.

-- >8 --
From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] checkout: fix bug with ambiguous refs

The usual dwim_ref lookup prefers tags to branches. Because
checkout primarily works on branches, though, we switch that
behavior to prefer branches.

However, there was a bug in the implementation in which we
used lookup_commit_reference (which used the regular lookup
rules) to get the actual commit to checkout. Checking out an
ambiguous ref therefore ended up putting us in an extremely
broken state in which we wrote the branch ref into HEAD, but
actually checked out the tree for the tag.

This patch fixes the bug by always attempting to pull the
commit to be checked out from the branch-ified version of
the name we were given.

Patch by Junio, tests and commit message from Jeff King.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/checkout.c               |   23 ++++++++------
 t/t2019-checkout-amiguous-ref.sh |   59 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+), 10 deletions(-)
 create mode 100755 t/t2019-checkout-amiguous-ref.sh

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 757f9a0..d3cfaf0 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -678,7 +678,7 @@ static const char *unique_tracking_name(const char *name)
 int cmd_checkout(int argc, const char **argv, const char *prefix)
 {
 	struct checkout_opts opts;
-	unsigned char rev[20];
+	unsigned char rev[20], branch_rev[20];
 	const char *arg;
 	struct branch_info new;
 	struct tree *source_tree = NULL;
@@ -832,18 +832,21 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		argc--;
 
 		new.name = arg;
-		if ((new.commit = lookup_commit_reference_gently(rev, 1))) {
-			setup_branch_path(&new);
+		setup_branch_path(&new);
 
-			if ((check_ref_format(new.path) == CHECK_REF_FORMAT_OK) &&
-			    resolve_ref(new.path, rev, 1, NULL))
-				;
-			else
-				new.path = NULL;
+		if (check_ref_format(new.path) == CHECK_REF_FORMAT_OK &&
+		    resolve_ref(new.path, branch_rev, 1, NULL))
+			hashcpy(rev, branch_rev);
+		else
+			new.path = NULL; /* not an existing branch */
+
+		if (!(new.commit = lookup_commit_reference_gently(rev, 1))) {
+			/* not a commit */
+			source_tree = parse_tree_indirect(rev);
+		} else {
 			parse_commit(new.commit);
 			source_tree = new.commit->tree;
-		} else
-			source_tree = parse_tree_indirect(rev);
+		}
 
 		if (!source_tree)                   /* case (1): want a tree */
 			die("reference is not a tree: %s", arg);
diff --git a/t/t2019-checkout-amiguous-ref.sh b/t/t2019-checkout-amiguous-ref.sh
new file mode 100755
index 0000000..943541d
--- /dev/null
+++ b/t/t2019-checkout-amiguous-ref.sh
@@ -0,0 +1,59 @@
+#!/bin/sh
+
+test_description='checkout handling of ambiguous (branch/tag) refs'
+. ./test-lib.sh
+
+test_expect_success 'setup ambiguous refs' '
+	test_commit branch file &&
+	git branch ambiguity &&
+	git branch vagueness &&
+	test_commit tag file &&
+	git tag ambiguity &&
+	git tag vagueness HEAD:file &&
+	test_commit other file
+'
+
+test_expect_success 'checkout ambiguous ref succeeds' '
+	git checkout ambiguity >stdout 2>stderr
+'
+
+test_expect_success 'checkout produces ambiguity warning' '
+	grep "warning.*ambiguous" stderr
+'
+
+test_expect_success 'checkout chooses branch over tag' '
+	echo refs/heads/ambiguity >expect &&
+	git symbolic-ref HEAD >actual &&
+	test_cmp expect actual &&
+	echo branch >expect &&
+	test_cmp expect file
+'
+
+test_expect_success 'checkout reports switch to branch' '
+	grep "Switched to branch" stderr &&
+	! grep "^HEAD is now at" stderr
+'
+
+test_expect_success 'checkout vague ref succeeds' '
+	git checkout vagueness >stdout 2>stderr &&
+	test_set_prereq VAGUENESS_SUCCESS
+'
+
+test_expect_success VAGUENESS_SUCCESS 'checkout produces ambiguity warning' '
+	grep "warning.*ambiguous" stderr
+'
+
+test_expect_success VAGUENESS_SUCCESS 'checkout chooses branch over tag' '
+	echo refs/heads/vagueness >expect &&
+	git symbolic-ref HEAD >actual &&
+	test_cmp expect actual &&
+	echo branch >expect &&
+	test_cmp expect file
+'
+
+test_expect_success VAGUENESS_SUCCESS 'checkout reports switch to branch' '
+	grep "Switched to branch" stderr &&
+	! grep "^HEAD is now at" stderr
+'
+
+test_done
-- 
1.7.3.5.4.g0dc52
