From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH 16/16] bisect: get back halfway shortcut
Date: Fri, 26 Feb 2016 03:04:42 +0100
Message-ID: <1456452282-10325-17-git-send-email-s-beyer@gmx.net>
References: <1456452282-10325-1-git-send-email-s-beyer@gmx.net>
Cc: Stephan Beyer <s-beyer@gmx.net>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 26 03:05:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ7n4-0007NX-2r
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 03:05:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752553AbcBZCFz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 21:05:55 -0500
Received: from mout.gmx.net ([212.227.15.19]:58735 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752384AbcBZCFt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 21:05:49 -0500
Received: from fermat.fritz.box ([188.108.247.176]) by mail.gmx.com (mrgmx003)
 with ESMTPSA (Nemesis) id 0MGSgq-1amGvS2ky0-00DF4O; Fri, 26 Feb 2016 03:05:46
 +0100
X-Mailer: git-send-email 2.7.2.383.g3fb0654
In-Reply-To: <1456452282-10325-1-git-send-email-s-beyer@gmx.net>
X-Provags-ID: V03:K0:JIPld5EvlSfpdiAA849RFkKp1g+ou4wZWFG1ObEC98qHJjmt/k4
 BNC/YbqHt4ZEdBhxfkiv1Xsw7bZhVsBd7vTLh+8o7LpwGyL+0C1GbD/SuN9pAH58UkvnjrH
 fNWzoTz8aEzvhAS6bteCYh/0LRvUu/X6t2//y64BSoH269cXHaTUPZvh9rQYQRT2jFvmfHq
 lIMjPxBTkz9wSUXN4sFZw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:oErIaSV6vQ4=:lqnmvKEVKu2N6Wg6lK3+FY
 aUU/YBgzpLXDi3E7mFVQi9jMGkZSPtGtwevVdKtBJtbKOh064us/zDPMYWBoTVt24EJncJ238
 YyVTB2ECWAkaSh5XWbVfKUbCl0h/NGh7Ax9f6me7uiDAEmhaYq57QpxJP9+wPp8gL+28wGhr7
 I5MBdXNwHHpxSUQJsq/2fKortng960c1h+IT0jkTO9AJOAZ1lZ9BMDr0fqHMzWM1D7Ah7nSxR
 NHspvUWi0YSgdcv5lzfNNdwfyAyU+OQWHTHtkRg+0GV4n6H0XdhzAH8SzmtFIvavy9QcLjWx7
 Lw2V/a+DVxO0x3Im8B9lwpIpgoZVaULU9QeJ1OtZKk01kQM5hDWJJiZ1oAOl6a1y2LuWN0MdB
 EnfrfWq7R8jvv9uWtwzzeHIe1e6cT+Rp6LqoiC3PApacrgSvTj7vpyrOYCAtOht4e67RiuC/x
 9BnoMVw2Fura6c7ziSK/1l9ZsL7BMwJK/+umqvtRZ21hUFUP9n3BJgbHtsxV+YG9U5cps5YIr
 NAQgdxn5UrPx030Rva2zyC8AESvMNHKW25rTGJlVGa/j6M9RgJvb6xUvXvPojicGBuCdQiH2I
 vEOpz5/uQd4JjD9BUuEonhLSVf6X6HL/8NjBg7XHbfYxA9kD/dZIJYVUrvwfDwohmWY/crkra
 D9Yso5BxuHfPx/sYCwvMTj6JCggk+rJb4ql2JsMG+/jwemzSFbRv7jFCB1/jAPmYi0QBIsJ9J
 OaZ5zqedMG24aErog2Or21eta7SVFy0nCGIMSPE+bhrlS1c96FktDNdrbSE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287515>

The documentation says that when the maximum possible distance
is found, the algorithm stops immediately. That feature is
reestablished by this commit.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---

In my tests, I have not seen any gain of performance by
doing this... but it's fast now anyway, who cares ;-)

 bisect.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/bisect.c b/bisect.c
index 185a3cf..0153d9a 100644
--- a/bisect.c
+++ b/bisect.c
@@ -363,8 +363,8 @@ static void commit_list_insert_unique(struct commit *item,
 }
 
 /* do a BFS on the reversed DAG (starting from commits in queue), stop at merge commits */
-static void bfs_up_to_merges(struct commit_list *queue,
-			     struct commit_list **merges)
+static int bfs_up_to_merges(struct commit_list *queue,
+			    struct commit_list **merges)
 {
 	assert(queue);
 	struct commit_list **last;
@@ -391,8 +391,13 @@ static void bfs_up_to_merges(struct commit_list *queue,
 		}
 
 		update_best_bisection(top);
+		if (distance_direction(top) == 0) { // halfway
+			assert(!(top->object.flags & TREESAME));
+			return 1;
+		}
 		pop_commit(&queue);
 	}
+	return 0;
 }
 
 static int all_parents_are_visited(struct commit *merge)
@@ -456,10 +461,12 @@ static void compute_merge_weights(struct commit_list *merges)
 static void modified_bfs(struct commit_list *queue)
 {
 	struct commit_list *merges = NULL;
-	bfs_up_to_merges(queue, &merges);
-	while (find_new_queue_from_merges(&queue, &merges)) {
+	int halfway_found = bfs_up_to_merges(queue, &merges);
+
+	while (!halfway_found
+	    && find_new_queue_from_merges(&queue, &merges)) {
 		compute_merge_weights(queue);
-		bfs_up_to_merges(queue, &merges);
+		halfway_found &= bfs_up_to_merges(queue, &merges);
 	}
 }
 
-- 
2.7.1.354.gd492730.dirty
