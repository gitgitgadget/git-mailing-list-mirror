From: jon@blackcubes.dyndns.org
Subject: [PATCH] Factor out filtering in rev-list.c
Date: 6 Jun 2005 07:17:28 -0000
Message-ID: <20050606071728.30223.qmail@blackcubes.dyndns.org>
Cc: jon.seymour@gmail.com, torvalds@osdl.org
X-From: git-owner@vger.kernel.org Mon Jun 06 09:17:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DfBrE-0001SI-Dm
	for gcvg-git@gmane.org; Mon, 06 Jun 2005 09:17:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261187AbVFFHTt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Jun 2005 03:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbVFFHTt
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Jun 2005 03:19:49 -0400
Received: from 203-166-247-224.dyn.iinet.net.au ([203.166.247.224]:41857 "HELO
	blackcubes.dyndns.org") by vger.kernel.org with SMTP
	id S261187AbVFFHRa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2005 03:17:30 -0400
Received: (qmail 30225 invoked by uid 500); 6 Jun 2005 07:17:28 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

[PATCH] Factor out filtering in rev-list.c

This patch:
   * factors out the filtering logic in show_commit_list into filter_commit.
   * groups calls to filter_commit and show_commit into process_commit.
   * replaces the body of the show_commit_list while loop with a call to process_commit.
   * fixes a compiler warning by adding a return statement to get_commit_format.

The purpose of these changes is to faciliate a future merge with Jon Seymour's --merge-order patch which
will pass pointer to process_commit to another module.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>

This patch can also be downloaded from: http://blackcubes.dyndns.org/epoch/rev-list.patch .

Diverged from 000182eacf99cde27d5916aa415921924b82972c by Linus Torvalds <torvalds@ppc970.osdl.org>
---
diff --git a/rev-list.c b/rev-list.c
--- a/rev-list.c
+++ b/rev-list.c
@@ -40,20 +40,48 @@ static void show_commit(struct commit *c
 	}
 }
 
+#define STOP     0
+#define CONTINUE 1
+#define DO       2
+
+static int filter_commit(struct commit * commit)
+{
+	if (commit->object.flags & UNINTERESTING)
+		return CONTINUE;
+	if (min_age != -1 && (commit->date > min_age))
+		return CONTINUE;
+	if (max_age != -1 && (commit->date < max_age))
+		return STOP;
+	if (max_count != -1 && !max_count--)
+		return STOP;
+
+	return DO;
+}
+
+static int process_commit(struct commit * commit)
+{
+	int action=filter_commit(commit);
+
+	if (action == STOP) {
+		return STOP;
+	}
+
+	if (action == CONTINUE) {
+		return CONTINUE;
+	}
+
+	show_commit(commit);
+
+	return CONTINUE;
+}
+
 static void show_commit_list(struct commit_list *list)
 {
 	while (list) {
 		struct commit *commit = pop_most_recent_commit(&list, SEEN);
 
-		if (commit->object.flags & UNINTERESTING)
-			continue;
-		if (min_age != -1 && (commit->date > min_age))
-			continue;
-		if (max_age != -1 && (commit->date < max_age))
+		if (process_commit(commit) == STOP)
 			break;
-		if (max_count != -1 && !max_count--)
-			break;
-		show_commit(commit);
 	}
 }
 
@@ -110,6 +138,8 @@ static enum cmit_fmt get_commit_format(c
 	if (!strcmp(arg, "=short"))
 		return CMIT_FMT_SHORT;
 	usage(rev_list_usage);	
+
+	return CMIT_FMT_DEFAULT;
 }			
 
 
