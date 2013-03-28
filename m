From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2] Avoid loading commits twice in log with diffs
Date: Thu, 28 Mar 2013 09:19:34 +0100
Message-ID: <f519e4af34cecd6aa4c905aa48288a9c2c841ae1.1364458249.git.trast@inf.ethz.ch>
References: <7va9qlc690.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Thomas Rast <trast@inf.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 28 09:20:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UL84D-0004Px-Up
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 09:20:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755903Ab3C1ITo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 04:19:44 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:31077 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755762Ab3C1ITm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 04:19:42 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 28 Mar
 2013 09:19:34 +0100
Received: from linux-k42r.v.cablecom.net (129.132.209.32) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 28 Mar
 2013 09:19:39 +0100
X-Mailer: git-send-email 1.8.2.351.g867a5da
In-Reply-To: <7va9qlc690.fsf@alter.siamese.dyndns.org>
X-Originating-IP: [129.132.209.32]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219373>

If you run a log with diffs (such as -p, --raw, --stat etc.) the
current code ends up loading many objects twice.  For example, for
'log -3000 -p' my instrumentation said the objects loaded more than
once are distributed as follows:

  2008 blob
  2103 commit
  2678 tree

Fixing blobs and trees will be harder, because those are really used
within the diff engine and need some form of caching.

However, fixing the commits is easy at least at the band-aid level.
They are triggered by log_tree_diff() invoking diff_tree_sha1() on
commits, which duly loads the specified object to dereference it to a
tree.  Since log_tree_diff() knows that it works with commits and they
must have trees, we can simply pass through the trees.

We add some parse_commit() calls.  The ones for the parents are
required; we do not know at this stage if they have been looked at.
The one for the commit itself is pure paranoia, but has about the same
cost as an assertion on commit->object.parsed.

This has a quite dramatic effect on log --raw, though only a
negligible impact on log -p:

Test                      this tree         HEAD
--------------------------------------------------------------------
4000.2: log --raw -3000   0.50(0.43+0.06)   0.54(0.46+0.06) +7.0%***
4000.3: log -p -3000      2.34(2.20+0.13)   2.37(2.22+0.13) +1.2%
--------------------------------------------------------------------
Significance hints:  '.' 0.1  '*' 0.05  '**' 0.01  '***' 0.001

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
---

Adjusted for the concern that the commit might not be parsed yet.  I
think it's now more paranoid than the original code, since we cannot
look at commit->parents without parsing.  But it's really an almost
free check.


 log-tree.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 5dc45c4..8a34332 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -792,11 +792,14 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
 {
 	int showed_log;
 	struct commit_list *parents;
-	unsigned const char *sha1 = commit->object.sha1;
+	unsigned const char *sha1;
 
 	if (!opt->diff && !DIFF_OPT_TST(&opt->diffopt, EXIT_WITH_STATUS))
 		return 0;
 
+	parse_commit(commit);
+	sha1 = commit->tree->object.sha1;
+
 	/* Root commit? */
 	parents = commit->parents;
 	if (!parents) {
@@ -819,7 +822,9 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
 			 * parent, showing summary diff of the others
 			 * we merged _in_.
 			 */
-			diff_tree_sha1(parents->item->object.sha1, sha1, "", &opt->diffopt);
+			parse_commit(parents->item);
+			diff_tree_sha1(parents->item->tree->object.sha1,
+				       sha1, "", &opt->diffopt);
 			log_tree_diff_flush(opt);
 			return !opt->loginfo;
 		}
@@ -832,7 +837,9 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
 	for (;;) {
 		struct commit *parent = parents->item;
 
-		diff_tree_sha1(parent->object.sha1, sha1, "", &opt->diffopt);
+		parse_commit(parent);
+		diff_tree_sha1(parent->tree->object.sha1,
+			       sha1, "", &opt->diffopt);
 		log_tree_diff_flush(opt);
 
 		showed_log |= !opt->loginfo;
-- 
1.8.2.351.g867a5da
