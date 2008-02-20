From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] checkout: tone down the "forked status" diagnostic messages
Date: Wed, 20 Feb 2008 15:05:23 -0800
Message-ID: <7vy79f2pqk.fsf_-_@gitster.siamese.dyndns.org>
References: <46a038f90802072044u3329fd33w575c689cba2917ee@mail.gmail.com>
 <20080209030046.GA10470@coredump.intra.peff.net>
 <7vtzkihkx5.fsf@gitster.siamese.dyndns.org>
 <46a038f90802090350rc4780d1ted60c03b9abf1fc0@mail.gmail.com>
 <7vwspd5z1d.fsf@gitster.siamese.dyndns.org>
 <7vfxvs75kp.fsf_-_@gitster.siamese.dyndns.org>
 <46a038f90802190903g1a19e38i30198b368a800a89@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Martin Langhoff" <martin.langhoff@gmail.com>,
	"Jeff King" <peff@peff.net>, "Steffen Prohaska" <prohaska@zib.de>,
	"Daniel Barkalow" <barkalow@iabervon.org>,
	"Johannes Schindelin" <johannes.schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 21 00:07:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRy1R-0008Vf-Vy
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 00:06:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754918AbYBTXGG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2008 18:06:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753544AbYBTXGF
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Feb 2008 18:06:05 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45802 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752729AbYBTXGE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2008 18:06:04 -0500
Received: from .pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 5CA85787B;
	Wed, 20 Feb 2008 18:05:53 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 A23EC7877; Wed, 20 Feb 2008 18:05:43 -0500 (EST)
In-Reply-To: <46a038f90802190903g1a19e38i30198b368a800a89@mail.gmail.com>
 (Martin Langhoff's message of "Wed, 20 Feb 2008 06:03:01 +1300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74563>

When checking out a branch that is behind or forked from a
branch you are building on top of, we used to show full
left-right log but if you already _know_ you have long history
since you forked, it is a bit too much.

This tones down the message quite a bit, by only showing the
number of commits each side has since they diverged.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This obviously comes on top of the earlier patch of mine,
   which in turn is on top of Daniel's "checkout written in C".

 builtin-checkout.c |  102 ++++++++++++++++++++++++++++++++--------------------
 1 files changed, 63 insertions(+), 39 deletions(-)

diff --git a/builtin-checkout.c b/builtin-checkout.c
index 5291f72..261f67f 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -301,64 +301,88 @@ static void adjust_to_tracking(struct branch_info *new, struct checkout_opts *op
 	char *base;
 	unsigned char sha1[20];
 	struct commit *ours, *theirs;
-	const char *msgfmt;
 	char symmetric[84];
-	int show_log;
+	struct rev_info revs;
+	const char *rev_argv[10];
+	int rev_argc;
+	int num_ours, num_theirs;
+	const char *remote_msg;
 	struct branch *branch = branch_get(NULL);
 
+	/*
+	 * Nothing to report unless we are marked to build on top of
+	 * somebody else.
+	 */
 	if (!branch || !branch->merge)
 		return;
 
-	base = branch->merge[0]->dst;
-
-	ours = new->commit;
-
-	sprintf(symmetric, "%s", sha1_to_hex(ours->object.sha1));
-
 	/*
-	 * Ok, it is tracking base; is it ahead of us?
+	 * If what we used to build on no longer exists, there is
+	 * nothing to report.
 	 */
+	base = branch->merge[0]->dst;
 	if (!resolve_ref(base, sha1, 1, NULL))
 		return;
-	theirs = lookup_commit(sha1);
-
-	sprintf(symmetric + 40, "...%s", sha1_to_hex(sha1));
 
+	theirs = lookup_commit(sha1);
+	ours = new->commit;
 	if (!hashcmp(sha1, ours->object.sha1))
 		return; /* we are the same */
 
-	show_log = 1;
-	if (in_merge_bases(theirs, &ours, 1)) {
-		msgfmt = "You are ahead of the tracked branch '%s'\n";
-		show_log = 0;
+	/* Run "rev-list --left-right ours...theirs" internally... */
+	rev_argc = 0;
+	rev_argv[rev_argc++] = NULL;
+	rev_argv[rev_argc++] = "--left-right";
+	rev_argv[rev_argc++] = symmetric;
+	rev_argv[rev_argc++] = "--";
+	rev_argv[rev_argc] = NULL;
+
+	strcpy(symmetric, sha1_to_hex(ours->object.sha1));
+	strcpy(symmetric + 40, "...");
+	strcpy(symmetric + 43, sha1_to_hex(theirs->object.sha1));
+
+	init_revisions(&revs, NULL);
+	setup_revisions(rev_argc, rev_argv, &revs, NULL);
+	prepare_revision_walk(&revs);
+
+	/* ... and count the commits on each side. */
+	num_ours = 0;
+	num_theirs = 0;
+	while (1) {
+		struct commit *c = get_revision(&revs);
+		if (!c)
+			break;
+		if (c->object.flags & SYMMETRIC_LEFT)
+			num_ours++;
+		else
+			num_theirs++;
 	}
-	else if (in_merge_bases(ours, &theirs, 1))
-		msgfmt = "Your branch can be fast-forwarded to the tracked branch '%s'\n";
-	else
-		msgfmt = "Both your branch and the tracked branch '%s' have own changes, you would eventually need to merge\n";
 
-	if (!prefixcmp(base, "refs/remotes/"))
+	if (!prefixcmp(base, "refs/remotes/")) {
+		remote_msg = " remote";
 		base += strlen("refs/remotes/");
-	fprintf(stderr, msgfmt, base);
-
-	if (show_log) {
-		const char *args[32];
-		int ac;
-
-		ac = 0;
-		args[ac++] = "log";
-		args[ac++] = "--pretty=oneline";
-		args[ac++] = "--abbrev-commit";
-		args[ac++] = "--left-right";
-		args[ac++] = "--boundary";
-		args[ac++] = symmetric;
-		args[ac++] = "--";
-		args[ac] = NULL;
-
-		run_command_v_opt(args, RUN_GIT_CMD);
+	} else {
+		remote_msg = "";
 	}
-}
 
+	if (!num_theirs)
+		printf("Your branch is ahead of the tracked%s branch '%s' "
+		       "by %d commit%s.\n",
+		       remote_msg, base,
+		       num_ours, (num_ours == 1) ? "" : "s");
+	else if (!num_ours)
+		printf("Your branch is behind of the tracked%s branch '%s' "
+		       "by %d commit%s,\n"
+		       "and can be fast-forwarded.\n",
+		       remote_msg, base,
+		       num_theirs, (num_theirs == 1) ? "" : "s");
+	else
+		printf("Your branch and the tracked%s branch '%s' "
+		       "have diverged,\nand respectively "
+		       "have %d and %d different commit(s) each.\n",
+		       remote_msg, base,
+		       num_ours, num_theirs);
+}
 
 static void update_refs_for_switch(struct checkout_opts *opts,
 				   struct branch_info *old,
