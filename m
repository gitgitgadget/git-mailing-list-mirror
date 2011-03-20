From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] checkout: clear commit marks after detached-orphan check
Date: Sun, 20 Mar 2011 05:09:18 -0400
Message-ID: <20110320090918.GB15948@sigill.intra.peff.net>
References: <20110320090111.GA15641@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 20 10:09:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1Eda-0005VU-7w
	for gcvg-git-2@lo.gmane.org; Sun, 20 Mar 2011 10:09:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751637Ab1CTJJW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2011 05:09:22 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50161
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751580Ab1CTJJU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2011 05:09:20 -0400
Received: (qmail 24675 invoked by uid 107); 20 Mar 2011 09:09:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 20 Mar 2011 05:09:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 20 Mar 2011 05:09:18 -0400
Content-Disposition: inline
In-Reply-To: <20110320090111.GA15641@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169494>

When leaving a detached HEAD, we do a revision walk to make
sure the commit we are leaving isn't being orphaned.
However, this leaves crufty marks in the commit objects
which can confuse later walkers, like the one in
stat_tracking_info.

Let's clean up after ourselves to prevent this conflict.

Signed-off-by: Jeff King <peff@peff.net>
---
This uses for_each_ref to re-find the list of commits we touched in our
traversal, which feels a little hacky. prepare_revision_walk already
generates the exact list of tips, but unfortunately writes it
into revs->commits, which then gets munged by limit_list in the second
half of prepare_revision_walk. I wonder if it should keep a copy
elsewhere in revs, and then we could add:

  clear_all_commit_marks(&revs);

to let callers clean up after themselves easily.

I also just clear all marks; we could do just the ones that the revision
walker marks, but this seemed more future-proof to me than a set list of
marks.

 builtin/checkout.c         |   13 +++++++++++++
 t/t2020-checkout-detach.sh |   13 +++++++++++++
 2 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2bf02f2..f88d2c8 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -603,6 +603,16 @@ static int add_one_ref_to_rev_list_arg(const char *refname,
 	return 0;
 }
 
+static int clear_commit_marks_from_one_ref(const char *refname,
+				      const unsigned char *sha1,
+				      int flags,
+				      void *cb_data)
+{
+	struct commit *commit = lookup_commit_reference_gently(sha1, 1);
+	if (commit)
+		clear_commit_marks(commit, -1);
+	return 0;
+}
 
 static void describe_one_orphan(struct strbuf *sb, struct commit *commit)
 {
@@ -674,6 +684,9 @@ static void orphaned_commit_warning(struct commit *commit)
 		suggest_reattach(commit, &revs);
 	else
 		describe_detached_head("Previous HEAD position was", commit);
+
+	clear_commit_marks(commit, -1);
+	for_each_ref(clear_commit_marks_from_one_ref, NULL);
 }
 
 static int switch_branches(struct checkout_opts *opts, struct branch_info *new)
diff --git a/t/t2020-checkout-detach.sh b/t/t2020-checkout-detach.sh
index bfeb2a6..569b27f 100755
--- a/t/t2020-checkout-detach.sh
+++ b/t/t2020-checkout-detach.sh
@@ -126,4 +126,17 @@ test_expect_success 'checkout does not warn leaving reachable commit' '
 	check_no_orphan_warning stderr
 '
 
+cat >expect <<'EOF'
+Your branch is behind 'master' by 1 commit, and can be fast-forwarded.
+EOF
+test_expect_success 'tracking count is accurate after orphan check' '
+	reset &&
+	git branch child master^ &&
+	git config branch.child.remote . &&
+	git config branch.child.merge refs/heads/master &&
+	git checkout child^ &&
+	git checkout child >stdout &&
+	test_cmp expect stdout
+'
+
 test_done
-- 
1.7.2.5.10.g62fe7
