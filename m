From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2] rev-list: estimate number of bisection step left
Date: Thu, 19 Feb 2009 08:03:52 +0100
Message-ID: <20090219080352.9b07fca0.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
	John Tapsell <johnflux@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 08:06:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1La2yv-00034U-GW
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 08:06:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752441AbZBSHEh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 02:04:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751967AbZBSHEh
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 02:04:37 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:58010 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751928AbZBSHEg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 02:04:36 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 09E0781804B;
	Thu, 19 Feb 2009 08:04:26 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with SMTP id D72FB81809C;
	Thu, 19 Feb 2009 08:04:23 +0100 (CET)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.11; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110633>

This patch teaches "git rev-list --bisect-vars" to output an estimate
of the number of bisection step left _after the current one_ along with
the other variables it already outputs.

This patch also makes "git-bisect.sh" display this number of steps left
_after the current one_, along with the estimate of the number of
revisions left to test (after the current one).

Here is a table to help analyse what should be the best estimate for
the number of bisect steps left.

N : linear case                    --> probabilities --> best
-------------------------------------------------------------
1 : G-B                            --> 0             --> 0
2 : G-U1-B                         --> 0             --> 0
3 : G-U1-U2-B                      --> 0(1/3) 1(2/3) --> 1
4 : G-U1-U2-U3-B                   --> 1             --> 1
5 : G-U1-U2-U3-U4-B                --> 1(3/5) 2(2/5) --> 1
6 : G-U1-U2-U3-U4-U5-B             --> 1(2/6) 2(4/6) --> 2
7 : G-U1-U2-U3-U4-U5-U6-B          --> 1(1/7) 2(6/7) --> 2
8 : G-U1-U2-U3-U4-U5-U6-U7-B       --> 2             --> 2
9 : G-U1-U2-U3-U4-U5-U6-U7-U8-B    --> 2(7/9) 3(2/9) --> 2
10: G-U1-U2-U3-U4-U5-U6-U7-U8-U9-B --> 2(6/10)3(4/10)--> 2

In the column "N", there is the number of revisions that could _now_
be the first bad commit we are looking for.

The "linear case" column describes the linear history corresponding to
the number in column N. G means good, B means bad, and Ux means
unknown. Note that the first bad revision we are looking for can be
any Ux or B.

In the "probabilities" column, there are the different outcomes in
number of steps with the odds of each outcome in parenthesis
corresponding to the linear case.

The "best" column gives the most accurate estimate among the different
outcomes in the "probabilities" column.

We have the following:

best(2^n) == n - 1

and for any x between 0 included and 2^n excluded, the probability for
n - 1 steps left looks like:

P(2^n + x) == (2^n - x) / (2^n + x)

and P(2^n + x) < 0.5 means 2^n < 3x

So the algorithm used in this patch calculates 2^n and x, and then
choose between returning n - 1 and n.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin-rev-list.c |   45 +++++++++++++++++++++++++++++++++++++++++++--
 git-bisect.sh      |    2 +-
 2 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 436afa4..9dfffac 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -574,6 +574,45 @@ static struct commit_list *find_bisection(struct commit_list *list,
 	return best;
 }
 
+static inline int log2i(int n)
+{
+	int log2 = 0;
+
+	for (; n > 1; n >>= 1)
+		log2++;
+
+	return log2;
+}
+
+static inline int exp2i(int n)
+{
+	return 1 << n;
+}
+
+/*
+ * Estimate the number of bisect steps left (after the current step)
+ *
+ * For any x between 0 included and 2^n excluded, the probability for
+ * n - 1 steps left looks like:
+ *
+ * P(2^n + x) == (2^n - x) / (2^n + x)
+ *
+ * and P(2^n + x) < 0.5 means 2^n < 3x
+ */
+static int estimate_bisect_steps(int all)
+{
+	int n, x, e;
+
+	if (all < 3)
+		return 0;
+
+	n = log2i(all);
+	e = exp2i(n);
+	x = all - e;
+
+	return (e < 3 * x) ? n : n - 1 ;
+}
+
 int cmd_rev_list(int argc, const char **argv, const char *prefix)
 {
 	struct commit_list *list;
@@ -688,12 +727,14 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 			       "bisect_nr=%d\n"
 			       "bisect_good=%d\n"
 			       "bisect_bad=%d\n"
-			       "bisect_all=%d\n",
+			       "bisect_all=%d\n"
+			       "bisect_steps=%d\n",
 			       hex,
 			       cnt - 1,
 			       all - reaches - 1,
 			       reaches - 1,
-			       all);
+			       all,
+			       estimate_bisect_steps(all));
 			return 0;
 		}
 	}
diff --git a/git-bisect.sh b/git-bisect.sh
index 85db4ba..9ea1cdc 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -500,7 +500,7 @@ bisect_next() {
 	# commit is also a "skip" commit (see above).
 	exit_if_skipped_commits "$bisect_rev"
 
-	bisect_checkout "$bisect_rev" "$bisect_nr revisions left to test after this"
+	bisect_checkout "$bisect_rev" "$bisect_nr revisions left to test after this (roughly $bisect_steps steps)"
 }
 
 bisect_visualize() {
-- 
1.6.2.rc0.98.g055ea
