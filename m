From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 3/5] bisect: move common bisect functionality in
 "bisect_common"
Date: Sun, 19 Apr 2009 11:55:57 +0200
Message-ID: <20090419115557.58efa4fe.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 19 11:58:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvTnb-0002MA-Q1
	for gcvg-git-2@gmane.org; Sun, 19 Apr 2009 11:58:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755475AbZDSJ5O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Apr 2009 05:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755220AbZDSJ5O
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Apr 2009 05:57:14 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:38784 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755120AbZDSJ5N (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Apr 2009 05:57:13 -0400
Received: from smtp5-g21.free.fr (localhost [127.0.0.1])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 0CEE2D48108;
	Sun, 19 Apr 2009 11:57:06 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp5-g21.free.fr (Postfix) with SMTP id 0EF1AD48002;
	Sun, 19 Apr 2009 11:57:04 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.12; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116890>

So we can easily reuse the code in a later patch.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 bisect.c |   24 +++++++++++++++---------
 1 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/bisect.c b/bisect.c
index 58f7e6f..0448eae 100644
--- a/bisect.c
+++ b/bisect.c
@@ -532,6 +532,20 @@ static void bisect_rev_setup(struct rev_info *revs, const char *prefix)
 	revs->limited = 1;
 }
 
+static void bisect_common(struct rev_info *revs, const char *prefix,
+			  int *reaches, int *all)
+{
+	bisect_rev_setup(revs, prefix);
+
+	if (prepare_revision_walk(revs))
+		die("revision walk setup failed");
+	if (revs->tree_objects)
+		mark_edges_uninteresting(revs->commits, revs, NULL);
+
+	revs->commits = find_bisection(revs->commits, reaches, all,
+				       !!skipped_sha1_nr);
+}
+
 int bisect_next_vars(const char *prefix)
 {
 	struct rev_info revs;
@@ -542,15 +556,7 @@ int bisect_next_vars(const char *prefix)
 	info.revs = &revs;
 	info.bisect_show_flags = BISECT_SHOW_TRIED | BISECT_SHOW_STRINGED;
 
-	bisect_rev_setup(&revs, prefix);
-
-	if (prepare_revision_walk(&revs))
-		die("revision walk setup failed");
-	if (revs.tree_objects)
-		mark_edges_uninteresting(revs.commits, &revs, NULL);
-
-	revs.commits = find_bisection(revs.commits, &reaches, &all,
-				      !!skipped_sha1_nr);
+	bisect_common(&revs, prefix, &reaches, &all);
 
 	return show_bisect_vars(&info, reaches, all);
 }
-- 
1.6.2.2.537.g3b83b
