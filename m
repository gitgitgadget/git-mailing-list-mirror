From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [OT] Your branch is ahead of the tracked remote branch
 'origin/master' by 50 commits.
Date: Tue, 01 Jul 2008 12:16:49 -0700
Message-ID: <7vlk0lmn32.fsf@gitster.siamese.dyndns.org>
References: <20080701091347.GA11817@elte.hu> <80iqvq2bw0.fsf@tiny.isode.net>
 <20080701101414.GG31309@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bruce Stephens <bruce.stephens@isode.com>, git@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Tue Jul 01 21:18:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDlMc-0005Z0-LO
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 21:18:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752655AbYGATRI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2008 15:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752646AbYGATRH
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jul 2008 15:17:07 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38726 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752565AbYGATRF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2008 15:17:05 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6264D2300F;
	Tue,  1 Jul 2008 15:17:02 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 15A312300A; Tue,  1 Jul 2008 15:16:56 -0400 (EDT)
In-Reply-To: <20080701101414.GG31309@elte.hu> (Ingo Molnar's message of "Tue,
 1 Jul 2008 12:14:15 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 48DFFC8A-47A2-11DD-B859-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87062>

Ingo Molnar <mingo@elte.hu> writes:

> * Bruce Stephens <bruce.stephens@isode.com> wrote:
> ...
>> It feels logical for "git status" to offer the same information (when 
>> the information is appropriate).
>> 
>> [...]
>
> i have a tip-curr (shortcut: 'tc') scriptlet to answer the "where I am 
> amongst 100+ branches" question:

Perhaps like this, but be warned this is untested except for compilation
testing.

 builtin-checkout.c |   39 +++++++++++++++++++++------------------
 wt-status.c        |   22 ++++++++++++++++++++++
 2 files changed, 43 insertions(+), 18 deletions(-)

diff --git a/builtin-checkout.c b/builtin-checkout.c
index 93ea69b..2cbc39c 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -305,7 +305,7 @@ static int merge_working_tree(struct checkout_opts *opts,
 	return 0;
 }
 
-static void report_tracking(struct branch_info *new, struct checkout_opts *opts)
+void report_tracking(FILE *fp, const char *name, struct commit *commit)
 {
 	/*
 	 * We have switched to a new branch; is it building on
@@ -321,7 +321,7 @@ static void report_tracking(struct branch_info *new, struct checkout_opts *opts)
 	int rev_argc;
 	int num_ours, num_theirs;
 	const char *remote_msg;
-	struct branch *branch = branch_get(new->name);
+	struct branch *branch = branch_get(name);
 
 	/*
 	 * Nothing to report unless we are marked to build on top of
@@ -339,7 +339,7 @@ static void report_tracking(struct branch_info *new, struct checkout_opts *opts)
 		return;
 
 	theirs = lookup_commit(sha1);
-	ours = new->commit;
+	ours = commit;
 	if (!hashcmp(sha1, ours->object.sha1))
 		return; /* we are the same */
 
@@ -380,22 +380,25 @@ static void report_tracking(struct branch_info *new, struct checkout_opts *opts)
 	}
 
 	if (!num_theirs)
-		printf("Your branch is ahead of the tracked%s branch '%s' "
-		       "by %d commit%s.\n",
-		       remote_msg, base,
-		       num_ours, (num_ours == 1) ? "" : "s");
+		fprintf(fp,
+			"Your branch is ahead of the tracked%s branch '%s' "
+			"by %d commit%s.\n",
+			remote_msg, base,
+			num_ours, (num_ours == 1) ? "" : "s");
 	else if (!num_ours)
-		printf("Your branch is behind the tracked%s branch '%s' "
-		       "by %d commit%s,\n"
-		       "and can be fast-forwarded.\n",
-		       remote_msg, base,
-		       num_theirs, (num_theirs == 1) ? "" : "s");
+		fprintf(fp,
+			"Your branch is behind the tracked%s branch '%s' "
+			"by %d commit%s,\n"
+			"and can be fast-forwarded.\n",
+			remote_msg, base,
+			num_theirs, (num_theirs == 1) ? "" : "s");
 	else
-		printf("Your branch and the tracked%s branch '%s' "
-		       "have diverged,\nand respectively "
-		       "have %d and %d different commit(s) each.\n",
-		       remote_msg, base,
-		       num_ours, num_theirs);
+		fprintf(fp,
+			"Your branch and the tracked%s branch '%s' "
+			"have diverged,\nand respectively "
+			"have %d and %d different commit(s) each.\n",
+			remote_msg, base,
+			num_ours, num_theirs);
 }
 
 static void update_refs_for_switch(struct checkout_opts *opts,
@@ -441,7 +444,7 @@ static void update_refs_for_switch(struct checkout_opts *opts,
 	remove_branch_state();
 	strbuf_release(&msg);
 	if (!opts->quiet && (new->path || !strcmp(new->name, "HEAD")))
-		report_tracking(new, opts);
+		report_tracking(stdout, new->name, new->commit);
 }
 
 static int switch_branches(struct checkout_opts *opts, struct branch_info *new)
diff --git a/wt-status.c b/wt-status.c
index 28c9e63..e02171a 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -315,6 +315,26 @@ static void wt_status_print_verbose(struct wt_status *s)
 	run_diff_index(&rev, 1);
 }
 
+/* NEEDSWORK */
+extern void report_tracking(FILE *fp, const char *name, struct commit *commit);
+
+static void wt_status_print_tracking(struct wt_status *s)
+{
+	unsigned char sha1[20];
+	struct commit *commit;
+
+	assert(s->branch && !s->is_initial);
+
+	if (prefixcmp(s->branch, "refs/heads/") ||
+	    !resolve_ref(s->branch, sha1, 1, NULL))
+		return;
+	commit = lookup_commit(sha1);
+	if (!commit)
+		return;
+	fprintf(s->fp, "# ");
+	report_tracking(s->fp, s->branch + 11, commit);
+}
+
 void wt_status_print(struct wt_status *s)
 {
 	unsigned char sha1[20];
@@ -333,6 +353,8 @@ void wt_status_print(struct wt_status *s)
 		}
 		color_fprintf(s->fp, color(WT_STATUS_HEADER), "# ");
 		color_fprintf_ln(s->fp, branch_color, "%s%s", on_what, branch_name);
+		if (!s->is_initial)
+			wt_status_print_tracking(s);
 	}
 
 	if (s->is_initial) {
