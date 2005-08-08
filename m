From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] add *--no-merges* flag to suppress display of merge commits
Date: Mon, 8 Aug 2005 11:37:21 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0508081136210.31438@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Aug 08 11:38:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E244d-0005kC-3M
	for gcvg-git@gmane.org; Mon, 08 Aug 2005 11:37:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbVHHJhX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Aug 2005 05:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbVHHJhX
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Aug 2005 05:37:23 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:51670 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750789AbVHHJhW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2005 05:37:22 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id CDB89E244D
	for <git@vger.kernel.org>; Mon,  8 Aug 2005 11:37:21 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP id B11839C795
	for <git@vger.kernel.org>; Mon,  8 Aug 2005 11:37:21 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP id 9272D9C796
	for <git@vger.kernel.org>; Mon,  8 Aug 2005 11:37:21 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id 8901EE256C
	for <git@vger.kernel.org>; Mon,  8 Aug 2005 11:37:21 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

As requested by Junio (who suggested --single-parents-only, but this
could forget a no-parent root).

Also, adds a few missing options to the usage string.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 rev-list.c |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

4c24c4de403dcb658622590f6f6ef35232bbe709
diff --git a/rev-list.c b/rev-list.c
--- a/rev-list.c
+++ b/rev-list.c
@@ -15,12 +15,15 @@ static const char rev_list_usage[] =
 		      "  --max-count=nr\n"
 		      "  --max-age=epoch\n"
 		      "  --min-age=epoch\n"
+		      "  --parents\n"
 		      "  --bisect\n"
 		      "  --objects\n"
 		      "  --unpacked\n"
 		      "  --header\n"
 		      "  --pretty\n"
-		      "  --merge-order [ --show-breaks ]";
+		      "  --no-merges\n"
+		      "  --merge-order [ --show-breaks ]\n"
+		      "  --topo-order";
 
 static int unpacked = 0;
 static int bisect_list = 0;
@@ -39,6 +42,7 @@ static int merge_order = 0;
 static int show_breaks = 0;
 static int stop_traversal = 0;
 static int topo_order = 0;
+static int no_merges = 0;
 
 static void show_commit(struct commit *commit)
 {
@@ -82,6 +86,8 @@ static int filter_commit(struct commit *
 	}
 	if (max_count != -1 && !max_count--)
 		return STOP;
+	if (no_merges && (commit->parents && commit->parents->next))
+		return CONTINUE;
 	return DO;
 }
 
@@ -498,6 +504,10 @@ int main(int argc, char **argv)
 			verbose_header = 1;
 			hdr_termination = '\n';
 			prefix = "commit ";
+			continue;
+		}
+		if (!strncmp(arg, "--no-merges", 11)) {
+			no_merges = 1;
 			continue;
 		}
 		if (!strcmp(arg, "--parents")) {
