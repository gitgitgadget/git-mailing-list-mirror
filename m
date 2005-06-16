From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 2/2] Fix for --merge-order, --max-age interaction issue
Date: Fri, 17 Jun 2005 08:26:17 +1000
Message-ID: <20050616222617.18233.qmail@blackcubes.dyndns.org>
Cc: torvalds@osdl.org, jon.seymour@gmail.com, paulus@samba.org
X-From: git-owner@vger.kernel.org Fri Jun 17 00:22:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dj2k8-0000sz-Ok
	for gcvg-git@gmane.org; Fri, 17 Jun 2005 00:21:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261837AbVFPW05 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Jun 2005 18:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261836AbVFPW04
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jun 2005 18:26:56 -0400
Received: from 203-166-247-224.dyn.iinet.net.au ([203.166.247.224]:8067 "HELO
	blackcubes.dyndns.org") by vger.kernel.org with SMTP
	id S261835AbVFPW0T (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2005 18:26:19 -0400
Received: (qmail 18243 invoked by uid 500); 16 Jun 2005 22:26:17 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


This patch fixes a problem reported by Paul Mackerras regarding the interaction
of the --merge-order and --max-age switches of git-rev-list.

This patch applies to the current Linus HEAD. A cleaner fix for the same problem
in my current HEAD will follow later.

With this change, --merge-order produces the same result as no --merge-order
on the linux-2.6 git repository, to wit:

$> git-rev-list --max-age=1116330140 bcfff0b471a60df350338bcd727fc9b8a6aa54b2 | wc -l
655
$> git-rev-list --merge-order --max-age=1116330140 bcfff0b471a60df350338bcd727fc9b8a6aa54b2 | wc -l
655

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>


---

 rev-list.c |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/rev-list.c b/rev-list.c
--- a/rev-list.c
+++ b/rev-list.c
@@ -24,6 +24,7 @@ static int max_count = -1;
 static enum cmit_fmt commit_format = CMIT_FMT_RAW;
 static int merge_order = 0;
 static int show_breaks = 0;
+static int stop_traversal = 0;
 
 static void show_commit(struct commit *commit)
 {
@@ -53,15 +54,22 @@ static void show_commit(struct commit *c
 
 static int filter_commit(struct commit * commit)
 {
+	if (merge_order && stop_traversal && commit->object.flags & BOUNDARY)
+		return STOP;
 	if (commit->object.flags & UNINTERESTING)
 		return CONTINUE;
 	if (min_age != -1 && (commit->date > min_age))
 		return CONTINUE;
-	if (max_age != -1 && (commit->date < max_age))
-		return STOP;
+	if (max_age != -1 && (commit->date < max_age)) {
+		if (!merge_order)
+			return STOP;
+		else {
+			stop_traversal = 1;
+			return CONTINUE;
+		}
+	}
 	if (max_count != -1 && !max_count--)
 		return STOP;
-
 	return DO;
 }
 
------------
