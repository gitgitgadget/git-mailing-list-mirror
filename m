From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Additional merge-base tests
Date: Tue, 04 Jul 2006 00:45:46 -0700
Message-ID: <7vpsgllsnp.fsf@assigned-by-dhcp.cox.net>
References: <44A9E6AE.10508@gmail.com>
	<7v3bdhoraa.fsf@assigned-by-dhcp.cox.net> <44AA0DAE.1060308@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 04 09:46:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxfbT-0004QW-GG
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 09:45:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbWGDHps (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Jul 2006 03:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbWGDHps
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Jul 2006 03:45:48 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:15788 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751191AbWGDHpr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jul 2006 03:45:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060704074547.BSUC6235.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 4 Jul 2006 03:45:47 -0400
To: gitzilla@gmail.com
In-Reply-To: <44AA0DAE.1060308@gmail.com> (A. Large Angry's message of "Mon,
	03 Jul 2006 23:41:50 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23264>

A Large Angry SCM <gitzilla@gmail.com> writes:

>> This is a good demonstration that merge-base may not give you
>> minimal set for pathological cases.  If you want to be through
>> you could traverse everything to make sure we do not say 'S' is
>> relevant, but that is quite expensive, so I think there will
>> always be artifacts of horizon effect like this no matter how
>> you try to catch it (didn't I keep saying that already?).
>
> The problem is in mark_reachable_commits(); it is either superfluous
> or it needs to parse_commit() those commits that haven't been parsed
> yet that it needs to traverse.

Yes, you could traverse everything.  But that is not practical.
We have known that the clean-up pass has this horizon effect,
and it is a compromise.

If you apply this testing patch on top of yours, you will see
that parsing more commits at that point makes the clean-up
pass go all the way down to the root commit.

We may alternatively not use the clean-up pass at all, but I
suspect that might give us many false positives.  I don't
remember the details but I think we added it while fixing
merge-base in the real life situation.

It may be interesting to run tests on real merges (I believe the
kernel repository has a handful merges that have more than one
merge bases) to see how effective the current clean-up pass is.
It may turn out to be ineffective in practice, in which case we
could kill it off.


diff --git a/t/t6010-merge-base.sh b/t/t6010-merge-base.sh
index 9a815bd..4c6ed5c 100755
--- a/t/t6010-merge-base.sh
+++ b/t/t6010-merge-base.sh
@@ -89,4 +89,33 @@ test_expect_success 'compute merge-base 
     'MB=$(git-merge-base --all PL PR) &&
      expr "$(git-name-rev "$MB")" : "[0-9a-f]* tags/C2"'
 
+# Setup third set
+# 
+# S-U0-U1-U2-U3-U4
+#  \           X
+#   D0-D1-D2-D3-D4
+
+U0=$(doit 1 U0 $S)
+D0=$(doit 1 D0 $S)
+U1=$(doit 2 U1 $U0)
+D1=$(doit 2 D1 $D0)
+U2=$(doit 3 U2 $U1)
+D2=$(doit 3 D2 $D1)
+U3=$(doit 4 U3 $U2)
+D3=$(doit 4 D3 $D2)
+U4=$(doit 5 U4 $U3 $D3)
+D4=$(doit 5 D4 $D3 $U3)
+
+test_expect_success 'compute merge-base' '
+
+	git merge-base --all U4 D4 >out 2>err 
+	if grep tags/S err
+	then
+		echo "went all the way down to S -- very unhappy"
+		false
+	else
+		echo "stopped before going too far"
+	fi
+'
+
 test_done
diff --git a/merge-base.c b/merge-base.c
index 4856ca0..daab296 100644
--- a/merge-base.c
+++ b/merge-base.c
@@ -6,8 +6,35 @@ #define PARENT1 1
 #define PARENT2 2
 #define UNINTERESTING 4
 
+static void debug_list(struct commit_list *l, const char *msg)
+{
+	fprintf(stderr, "%s\n", msg);
+	while (l) {
+		char buf[1024];
+		int parsed;
+		struct commit *commit = l->item;
+		l = l->next;
+		parsed = commit->object.parsed;
+
+		if (parsed) {
+			pretty_print_commit(CMIT_FMT_ONELINE, commit,
+					    ~0UL, buf, sizeof(buf), 7,
+					    NULL, NULL);
+		}
+		else {
+			sprintf(buf, "git-name-rev %s 1>&2",
+				sha1_to_hex(commit->object.sha1));
+			system(buf);
+			strcpy(buf, sha1_to_hex(commit->object.sha1));
+		}
+		fprintf(stderr, "%d %d %s\n", commit->object.flags,
+			parsed, buf);
+	}
+}
+
 static struct commit *interesting(struct commit_list *list)
 {
+	debug_list(list, "in interesting()");
 	while (list) {
 		struct commit *commit = list->item;
 		list = list->next;
@@ -134,6 +161,9 @@ static void mark_reachable_commits(struc
 	/*
 	 * Postprocess to fully contaminate the well.
 	 */
+	debug_list(list, "list at top of mark-reachable");
+	debug_list(result, "result at top of mark-reachable");
+
 	for (tmp = result; tmp; tmp = tmp->next) {
 		struct commit *c = tmp->item;
 		/* Reinject uninteresting ones to list,
@@ -142,10 +172,12 @@ static void mark_reachable_commits(struc
 		if (c->object.flags & UNINTERESTING)
 			commit_list_insert(c, &list);
 	}
+
 	while (list) {
 		struct commit *c = list->item;
 		struct commit_list *parents;
 
+		debug_list(list, "list in mark-reachable postprocessing");
 		tmp = list;
 		list = list->next;
 		free(tmp);
@@ -155,6 +187,15 @@ static void mark_reachable_commits(struc
 		 * parse new ones (we already parsed all the relevant
 		 * ones).
 		 */
+		
+		/* Parsing object here which is a disaster;
+		 * let's demonstrate it.
+		 */
+#if 1
+		if (!c->object.parsed)
+			parse_commit(c);
+#endif
+
 		parents = c->parents;
 		while (parents) {
 			struct commit *p = parents->item;
@@ -164,6 +205,7 @@ static void mark_reachable_commits(struc
 				commit_list_insert(p, &list);
 			}
 		}
+		debug_list(result, "result in mark-reachable postprocessing");
 	}
 }
 
@@ -196,6 +238,7 @@ static int merge_base(struct commit *rev
 		free(tmp);
 		if (flags == 3) {
 			insert_by_date(commit, &result);
+			debug_list(result, "a new result");
 
 			/* Mark parents of a found merge uninteresting */
 			flags |= UNINTERESTING;
@@ -218,6 +261,7 @@ static int merge_base(struct commit *rev
 	if (result->next && list)
 		mark_reachable_commits(result, list);
 
+	debug_list(result, "final result");
 	while (result) {
 		struct commit *commit = result->item;
 		result = result->next;
