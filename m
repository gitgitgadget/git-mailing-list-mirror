From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH v2 21/21] bisect: get back halfway shortcut
Date: Sun, 10 Apr 2016 15:24:52 +0200
Message-ID: <1460294692-7402-2-git-send-email-s-beyer@gmx.net>
References: <1460294354-7031-1-git-send-email-s-beyer@gmx.net>
 <1460294692-7402-1-git-send-email-s-beyer@gmx.net>
Cc: Stephan Beyer <s-beyer@gmx.net>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 10 15:25:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apFN3-0002PI-3B
	for gcvg-git-2@plane.gmane.org; Sun, 10 Apr 2016 15:25:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753116AbcDJNZ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2016 09:25:29 -0400
Received: from mout.gmx.net ([212.227.17.21]:58073 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751991AbcDJNZ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2016 09:25:26 -0400
Received: from fermat.fritz.box ([92.76.224.62]) by mail.gmx.com (mrgmx101)
 with ESMTPSA (Nemesis) id 0MZ8fw-1b5gJq0Cs8-00Kzl3; Sun, 10 Apr 2016 15:25:06
 +0200
X-Mailer: git-send-email 2.8.1.137.g522756c
In-Reply-To: <1460294692-7402-1-git-send-email-s-beyer@gmx.net>
X-Provags-ID: V03:K0:+owfRER/KHsNkV38xlgQNmSif0VjV8/+i3IfaCjtHgGAhMk8Yod
 wkBclpuSrVal851EED/3/efQBQ4QKC1RYRInX/X3fNhlHKQ+fIVjAIGRrBGG8YbUpmWfS7e
 uKbcSi3iEST9Xqdw4B+IBLKLWHfqHlOOxfwNnk0CgexrXg1oETeVzCwmoa4kZVDcV+yAnWg
 jY/2qqbofVjeVI6tVoMGQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4L6zz3jfQjM=:H/bu9pdADeVC5z1zN/N4n3
 6USKjWsi3bV3hlfBZbiKZW+SZAyU9PlDaftLBUsJzPHKNYYiD+qlr/G57SzEhQ6DVdWxWip0h
 LgHOgCyhN5YpMdLq0UewuvwA7ggoApjeanYANnDBQd1+G7h+JLJQo2Ad2s2nTtTpdOE5AR/NL
 bQQ+souiKcZEdbK+sL0FM7fT3lDxrcAhTnlfDWLrWh2CA94CV5TE4UZt53w7Jdud5VE2ta/02
 wCOmX99QUBJBD1GZv2JcQaugXVheP/quziL4ha+PyG4YVAvqejAWmccl/2O1Ytp/p6pIh7xOF
 6IepfCljchMOffV9xLncwe8E1Mf2aDkW56o49t32zTW3I+Zus1mxrHNygmogXwfR89BXC1JyL
 g31TTHtOFrC/zp/julviuK8QG5MSf3mpjVMLKjT176ZTRf7w0yqHR6pFXpIsX9v+Eu96383g6
 OYrJVNB+NZoD+E8fwp8U1/hCz0uQ0c9cOG3jtF7V7OMNtmRozQr35U1BFyvZ3coMgcZz+Lq2a
 aAvQEqfR7b4E5YMzdo7TVeEHdUqMhXisi81Wx4K3D3NdpttnJCwTT5AjTWvcomNkUaSWbAGrm
 QmdCHdNz+63T37N3g3KfEOXWMnWHYL5TkwYUAvsJIszRiORXXTsEAjUiK6nV12/zH5cR6rXnv
 tY6idHnPWrSSWREkzyYeXmVMb13IGnkegT936WGdsMr6s/aT5hnw7f+mIMNIUMibqUtZ01tbO
 82Me/P+6m8X3Qm1raKE0t0aeZCqDU+iqVCe+CVyRT840q15y2fSNyNSb5pw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291168>

The documentation says that when the maximum possible distance
is found, the algorithm stops immediately. That feature is
reestablished by this commit.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---

Notes:
    I plugged a memory leak here.

 bisect.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/bisect.c b/bisect.c
index 9f51d73..e583852 100644
--- a/bisect.c
+++ b/bisect.c
@@ -364,8 +364,8 @@ static inline void commit_list_insert_unique(struct commit *item,
 
 /* do a traversal on the reversed DAG (starting from commits in queue),
  * but stop at merge commits */
-static void traversal_up_to_merges(struct commit_list *queue,
-				   struct commit_list **merges)
+static int traversal_up_to_merges(struct commit_list *queue,
+				  struct commit_list **merges)
 {
 	assert(queue);
 	while (queue) {
@@ -391,7 +391,13 @@ static void traversal_up_to_merges(struct commit_list *queue,
 		}
 
 		update_best_bisection(top);
+		if (distance_direction(top) == 0) { // halfway
+			assert(!(top->object.flags & TREESAME));
+			free_commit_list(queue);
+			return 1;
+		}
 	}
+	return 0;
 }
 
 static inline int all_parents_are_visited(struct commit *merge)
@@ -455,10 +461,12 @@ static inline void compute_merge_weights(struct commit_list *merges)
 static void bottom_up_traversal(struct commit_list *queue)
 {
 	struct commit_list *merges = NULL;
-	traversal_up_to_merges(queue, &merges);
-	while (find_new_queue_from_merges(&queue, &merges)) {
+	int halfway_found = traversal_up_to_merges(queue, &merges);
+
+	while (!halfway_found
+	    && find_new_queue_from_merges(&queue, &merges)) {
 		compute_merge_weights(queue);
-		traversal_up_to_merges(queue, &merges);
+		halfway_found &= traversal_up_to_merges(queue, &merges);
 	}
 
 	/* cleanup */
-- 
2.8.1.137.g522756c
