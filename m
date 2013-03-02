From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] Avoid loading commits twice in log with diffs
Date: Sat, 2 Mar 2013 11:05:52 +0100
Message-ID: <3193c96cf5b036a91bc78b508b8b30ac87ca0f21.1362218700.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 02 11:06:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UBjKp-0004If-Ji
	for gcvg-git-2@plane.gmane.org; Sat, 02 Mar 2013 11:06:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751849Ab3CBKF5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Mar 2013 05:05:57 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:4589 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751697Ab3CBKFz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Mar 2013 05:05:55 -0500
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sat, 2 Mar
 2013 11:05:49 +0100
Received: from pctrast.v.cablecom.net (46.126.8.85) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sat, 2 Mar
 2013 11:05:52 +0100
X-Mailer: git-send-email 1.8.2.rc1.393.ga167915
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217323>

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

This has a quite dramatic effect on log --raw, though only a
negligible impact on log -p:

Test                      with patch        before
--------------------------------------------------------------------
4000.2: log --raw -3000   0.50(0.43+0.06)   0.54(0.46+0.06) +7.0%***
4000.3: log -p -3000      2.34(2.20+0.13)   2.37(2.22+0.13) +1.2%
--------------------------------------------------------------------
Significance hints:  '.' 0.1  '*' 0.05  '**' 0.01  '***' 0.001

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 log-tree.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index eb1a1b4..277a38f 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -715,7 +715,7 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
 {
 	int showed_log;
 	struct commit_list *parents;
-	unsigned const char *sha1 = commit->object.sha1;
+	unsigned const char *sha1 = commit->tree->object.sha1;
 
 	if (!opt->diff && !DIFF_OPT_TST(&opt->diffopt, EXIT_WITH_STATUS))
 		return 0;
@@ -742,7 +742,8 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
 			 * parent, showing summary diff of the others
 			 * we merged _in_.
 			 */
-			diff_tree_sha1(parents->item->object.sha1, sha1, "", &opt->diffopt);
+			parse_commit(parents->item);
+			diff_tree_sha1(parents->item->tree->object.sha1, sha1, "", &opt->diffopt);
 			log_tree_diff_flush(opt);
 			return !opt->loginfo;
 		}
@@ -755,7 +756,8 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
 	for (;;) {
 		struct commit *parent = parents->item;
 
-		diff_tree_sha1(parent->object.sha1, sha1, "", &opt->diffopt);
+		parse_commit(parent);
+		diff_tree_sha1(parent->tree->object.sha1, sha1, "", &opt->diffopt);
 		log_tree_diff_flush(opt);
 
 		showed_log |= !opt->loginfo;
-- 
1.8.2.rc1.393.ga167915
