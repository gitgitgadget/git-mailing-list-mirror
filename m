From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/3] Refactor "tracking statistics" code used by "git
 checkout"
Date: Wed, 02 Jul 2008 00:51:18 -0700
Message-ID: <7vvdzoenbd.fsf@gitster.siamese.dyndns.org>
References: <20080701091347.GA11817@elte.hu> <80iqvq2bw0.fsf@tiny.isode.net>
 <20080701101414.GG31309@elte.hu> <7vlk0lmn32.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bruce Stephens <bruce.stephens@isode.com>, git@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Wed Jul 02 09:52:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDx90-0004aW-PV
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 09:52:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751726AbYGBHvx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 03:51:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751538AbYGBHvx
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 03:51:53 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40935 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751451AbYGBHvw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 03:51:52 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C3BED284AD;
	Wed,  2 Jul 2008 03:51:50 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 2F0A6284AA; Wed,  2 Jul 2008 03:51:42 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BADD7BDC-480B-11DD-B5E1-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87095>

People seem to like "Your branch is ahead by N commit" report made by
"git checkout", but the interface into the statistics function was a bit
clunky.  This splits the function into three parts:

 * The core "commit counting" function that takes "struct branch" and
   returns number of commits to show if we are ahead, behind or forked;

 * Convenience "stat formating" function that takes "struct branch" and
   formats the report into a given strbuf, using the above function;

 * "checkout" specific function that takes "branch_info" (type that is
   internal to checkout implementation), calls the above function and
   print the formatted result.

in the hope that the former two can be more easily reusable.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-checkout.c |   94 +++----------------------------------------
 remote.c           |  113 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 remote.h           |    4 ++
 3 files changed, 123 insertions(+), 88 deletions(-)

diff --git a/builtin-checkout.c b/builtin-checkout.c
index 93ea69b..d6641c2 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -305,97 +305,15 @@ static int merge_working_tree(struct checkout_opts *opts,
 	return 0;
 }
 
-static void report_tracking(struct branch_info *new, struct checkout_opts *opts)
+static void report_tracking(struct branch_info *new)
 {
-	/*
-	 * We have switched to a new branch; is it building on
-	 * top of another branch, and if so does that other branch
-	 * have changes we do not have yet?
-	 */
-	char *base;
-	unsigned char sha1[20];
-	struct commit *ours, *theirs;
-	char symmetric[84];
-	struct rev_info revs;
-	const char *rev_argv[10];
-	int rev_argc;
-	int num_ours, num_theirs;
-	const char *remote_msg;
+	struct strbuf sb = STRBUF_INIT;
 	struct branch *branch = branch_get(new->name);
 
-	/*
-	 * Nothing to report unless we are marked to build on top of
-	 * somebody else.
-	 */
-	if (!branch || !branch->merge || !branch->merge[0] || !branch->merge[0]->dst)
-		return;
-
-	/*
-	 * If what we used to build on no longer exists, there is
-	 * nothing to report.
-	 */
-	base = branch->merge[0]->dst;
-	if (!resolve_ref(base, sha1, 1, NULL))
+	if (!format_tracking_info(branch, &sb))
 		return;
-
-	theirs = lookup_commit(sha1);
-	ours = new->commit;
-	if (!hashcmp(sha1, ours->object.sha1))
-		return; /* we are the same */
-
-	/* Run "rev-list --left-right ours...theirs" internally... */
-	rev_argc = 0;
-	rev_argv[rev_argc++] = NULL;
-	rev_argv[rev_argc++] = "--left-right";
-	rev_argv[rev_argc++] = symmetric;
-	rev_argv[rev_argc++] = "--";
-	rev_argv[rev_argc] = NULL;
-
-	strcpy(symmetric, sha1_to_hex(ours->object.sha1));
-	strcpy(symmetric + 40, "...");
-	strcpy(symmetric + 43, sha1_to_hex(theirs->object.sha1));
-
-	init_revisions(&revs, NULL);
-	setup_revisions(rev_argc, rev_argv, &revs, NULL);
-	prepare_revision_walk(&revs);
-
-	/* ... and count the commits on each side. */
-	num_ours = 0;
-	num_theirs = 0;
-	while (1) {
-		struct commit *c = get_revision(&revs);
-		if (!c)
-			break;
-		if (c->object.flags & SYMMETRIC_LEFT)
-			num_ours++;
-		else
-			num_theirs++;
-	}
-
-	if (!prefixcmp(base, "refs/remotes/")) {
-		remote_msg = " remote";
-		base += strlen("refs/remotes/");
-	} else {
-		remote_msg = "";
-	}
-
-	if (!num_theirs)
-		printf("Your branch is ahead of the tracked%s branch '%s' "
-		       "by %d commit%s.\n",
-		       remote_msg, base,
-		       num_ours, (num_ours == 1) ? "" : "s");
-	else if (!num_ours)
-		printf("Your branch is behind the tracked%s branch '%s' "
-		       "by %d commit%s,\n"
-		       "and can be fast-forwarded.\n",
-		       remote_msg, base,
-		       num_theirs, (num_theirs == 1) ? "" : "s");
-	else
-		printf("Your branch and the tracked%s branch '%s' "
-		       "have diverged,\nand respectively "
-		       "have %d and %d different commit(s) each.\n",
-		       remote_msg, base,
-		       num_ours, num_theirs);
+	fputs(sb.buf, stdout);
+	strbuf_release(&sb);
 }
 
 static void update_refs_for_switch(struct checkout_opts *opts,
@@ -441,7 +359,7 @@ static void update_refs_for_switch(struct checkout_opts *opts,
 	remove_branch_state();
 	strbuf_release(&msg);
 	if (!opts->quiet && (new->path || !strcmp(new->name, "HEAD")))
-		report_tracking(new, opts);
+		report_tracking(new);
 }
 
 static int switch_branches(struct checkout_opts *opts, struct branch_info *new)
diff --git a/remote.c b/remote.c
index ff2c802..bd5c3be 100644
--- a/remote.c
+++ b/remote.c
@@ -1,6 +1,9 @@
 #include "cache.h"
 #include "remote.h"
 #include "refs.h"
+#include "commit.h"
+#include "diff.h"
+#include "revision.h"
 
 static struct refspec s_tag_refspec = {
 	0,
@@ -1222,3 +1225,113 @@ int resolve_remote_symref(struct ref *ref, struct ref *list)
 		}
 	return 1;
 }
+
+/*
+ * Return true if there is anything to report, otherwise false.
+ */
+int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs)
+{
+	unsigned char sha1[20];
+	struct commit *ours, *theirs;
+	char symmetric[84];
+	struct rev_info revs;
+	const char *rev_argv[10], *base;
+	int rev_argc;
+
+	/*
+	 * Nothing to report unless we are marked to build on top of
+	 * somebody else.
+	 */
+	if (!branch ||
+	    !branch->merge || !branch->merge[0] || !branch->merge[0]->dst)
+		return 0;
+
+	/*
+	 * If what we used to build on no longer exists, there is
+	 * nothing to report.
+	 */
+	base = branch->merge[0]->dst;
+	if (!resolve_ref(base, sha1, 1, NULL))
+		return 0;
+	theirs = lookup_commit(sha1);
+	if (!theirs)
+		return 0;
+
+	if (!resolve_ref(branch->refname, sha1, 1, NULL))
+		return 0;
+	ours = lookup_commit(sha1);
+	if (!ours)
+		return 0;
+
+	/* are we the same? */
+	if (theirs == ours)
+		return 0;
+
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
+	*num_ours = 0;
+	*num_theirs = 0;
+	while (1) {
+		struct commit *c = get_revision(&revs);
+		if (!c)
+			break;
+		if (c->object.flags & SYMMETRIC_LEFT)
+			(*num_ours)++;
+		else
+			(*num_theirs)++;
+	}
+	return 1;
+}
+
+/*
+ * Return true when there is anything to report, otherwise false.
+ */
+int format_tracking_info(struct branch *branch, struct strbuf *sb)
+{
+	int num_ours, num_theirs;
+	const char *base, *remote_msg;
+
+	if (!stat_tracking_info(branch, &num_ours, &num_theirs))
+		return 0;
+
+	base = branch->merge[0]->dst;
+	if (!prefixcmp(base, "refs/remotes/")) {
+		remote_msg = " remote";
+		base += strlen("refs/remotes/");
+	} else {
+		remote_msg = "";
+	}
+	if (!num_theirs)
+		strbuf_addf(sb, "Your branch is ahead of the tracked%s branch '%s' "
+			    "by %d commit%s.\n",
+			    remote_msg, base,
+			    num_ours, (num_ours == 1) ? "" : "s");
+	else if (!num_ours)
+		strbuf_addf(sb, "Your branch is behind the tracked%s branch '%s' "
+			    "by %d commit%s,\n"
+			    "and can be fast-forwarded.\n",
+			    remote_msg, base,
+			    num_theirs, (num_theirs == 1) ? "" : "s");
+	else
+		strbuf_addf(sb, "Your branch and the tracked%s branch '%s' "
+			    "have diverged,\nand respectively "
+			    "have %d and %d different commit(s) each.\n",
+			    remote_msg, base,
+			    num_ours, num_theirs);
+	return 1;
+}
diff --git a/remote.h b/remote.h
index 8eed87b..091b1d0 100644
--- a/remote.h
+++ b/remote.h
@@ -129,4 +129,8 @@ enum match_refs_flags {
 	MATCH_REFS_MIRROR	= (1 << 1),
 };
 
+/* Reporting of tracking info */
+int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs);
+int format_tracking_info(struct branch *branch, struct strbuf *sb);
+
 #endif
-- 
1.5.6.1.156.ge903b
