From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] checkout: updates to tracking report
Date: Wed, 20 Feb 2008 19:42:53 -0800
Message-ID: <7vk5kzynya.fsf_-_@gitster.siamese.dyndns.org>
References: <46a038f90802072044u3329fd33w575c689cba2917ee@mail.gmail.com>
 <20080209030046.GA10470@coredump.intra.peff.net>
 <7vtzkihkx5.fsf@gitster.siamese.dyndns.org>
 <46a038f90802090350rc4780d1ted60c03b9abf1fc0@mail.gmail.com>
 <7vwspd5z1d.fsf@gitster.siamese.dyndns.org>
 <7vfxvs75kp.fsf_-_@gitster.siamese.dyndns.org>
 <46a038f90802190903g1a19e38i30198b368a800a89@mail.gmail.com>
 <7vy79f2pqk.fsf_-_@gitster.siamese.dyndns.org>
 <20080221014513.GA7185@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Martin Langhoff <martin.langhoff@gmail.com>,
	Steffen Prohaska <prohaska@zib.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 21 04:49:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JS2RN-0003Pj-VI
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 04:49:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753248AbYBUDtL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2008 22:49:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752480AbYBUDtK
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Feb 2008 22:49:10 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63510 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750985AbYBUDtI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2008 22:49:08 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id BF6EE44A1;
	Wed, 20 Feb 2008 22:49:03 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 2F42141FB; Wed, 20 Feb 2008 22:43:01 -0500 (EST)
In-Reply-To: <20080221014513.GA7185@coredump.intra.peff.net> (Jeff King's
 message of "Wed, 20 Feb 2008 20:45:13 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74589>

Jeff King <peff@peff.net> writes:

>>  	struct branch *branch = branch_get(NULL);
>
> Shouldn't this be branch_get(new->name)?

Perhaps.

> ...
> While not uncommon colloquially, "behind of" is not grammatically
> correct. "behind" is a preposition, so the "of" is redundant (it is
> necessary in the top string because "ahead" is an adverb).

Thanks.

-- >8 --

Ask branch_get() for the new branch explicitly instead of
letting it return a potentially stale information.

Tighten the logic to find the tracking branch to deal better
with misconfigured repositories (i.e. branch.*.merge can exist
but it may not have a refspec that fetches to .it)

Also fixes grammar in a message, as pointed out by Jeff King.

The function is about reporting and not automatically
fast-forwarding to the upstream, so stop calling it
"adjust-to".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-checkout.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin-checkout.c b/builtin-checkout.c
index f51b77a..19413eb 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -290,7 +290,7 @@ static int merge_working_tree(struct checkout_opts *opts,
 	return 0;
 }
 
-static void adjust_to_tracking(struct branch_info *new, struct checkout_opts *opts)
+static void report_tracking(struct branch_info *new, struct checkout_opts *opts)
 {
 	/*
 	 * We have switched to a new branch; is it building on
@@ -306,13 +306,13 @@ static void adjust_to_tracking(struct branch_info *new, struct checkout_opts *op
 	int rev_argc;
 	int num_ours, num_theirs;
 	const char *remote_msg;
-	struct branch *branch = branch_get(NULL);
+	struct branch *branch = branch_get(new->name);
 
 	/*
 	 * Nothing to report unless we are marked to build on top of
 	 * somebody else.
 	 */
-	if (!branch || !branch->merge)
+	if (!branch || !branch->merge || !branch->merge[0] || !branch->merge[0]->dst)
 		return;
 
 	/*
@@ -370,7 +370,7 @@ static void adjust_to_tracking(struct branch_info *new, struct checkout_opts *op
 		       remote_msg, base,
 		       num_ours, (num_ours == 1) ? "" : "s");
 	else if (!num_ours)
-		printf("Your branch is behind of the tracked%s branch '%s' "
+		printf("Your branch is behind the tracked%s branch '%s' "
 		       "by %d commit%s,\n"
 		       "and can be fast-forwarded.\n",
 		       remote_msg, base,
@@ -426,7 +426,7 @@ static void update_refs_for_switch(struct checkout_opts *opts,
 	remove_branch_state();
 	strbuf_release(&msg);
 	if (!opts->quiet && (new->path || !strcmp(new->name, "HEAD")))
-		adjust_to_tracking(new, opts);
+		report_tracking(new, opts);
 }
 
 static int switch_branches(struct checkout_opts *opts,
-- 
1.5.4.2.261.g851a5
