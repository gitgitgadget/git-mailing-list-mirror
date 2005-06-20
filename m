From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 7/7] Fix for --merge-order, --max-age interaction issue
Date: Mon, 20 Jun 2005 12:29:41 +1000
Message-ID: <20050620022941.28662.qmail@blackcubes.dyndns.org>
Cc: torvalds@osdl.org, jon.seymour@gmail.com, paulus@samba.org
X-From: git-owner@vger.kernel.org Mon Jun 20 04:26:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DkBzW-0006xR-HE
	for gcvg-git@gmane.org; Mon, 20 Jun 2005 04:26:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261322AbVFTCcI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Jun 2005 22:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbVFTCcI
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Jun 2005 22:32:08 -0400
Received: from 203-166-247-224.dyn.iinet.net.au ([203.166.247.224]:20867 "HELO
	blackcubes.dyndns.org") by vger.kernel.org with SMTP
	id S261408AbVFTC3n (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2005 22:29:43 -0400
Received: (qmail 28672 invoked by uid 500); 20 Jun 2005 02:29:41 -0000
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

 rev-list.c |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/rev-list.c b/rev-list.c
--- a/rev-list.c
+++ b/rev-list.c
@@ -27,6 +27,7 @@ static int max_count = -1;
 static enum cmit_fmt commit_format = CMIT_FMT_RAW;
 static int merge_order = 0;
 static int show_breaks = 0;
+static int stop_traversal = 0;
 
 static void show_commit(struct commit *commit)
 {
@@ -57,12 +58,20 @@ static void show_commit(struct commit *c
 
 static int filter_commit(struct commit * commit)
 {
+	if (merge_order && stop_traversal && commit->object.flags & BOUNDARY)
+		return STOP;
 	if (commit->object.flags & (UNINTERESTING|SHOWN))
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
 	return DO;
------------
