From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] cache-tree: replace a sscanf() by two strtol() calls
Date: Tue, 2 May 2006 03:31:02 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0605020327400.31493@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue May 02 03:31:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FajjO-0002ZT-Bn
	for gcvg-git@gmane.org; Tue, 02 May 2006 03:31:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340AbWEBBbE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 May 2006 21:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932344AbWEBBbE
	(ORCPT <rfc822;git-outgoing>); Mon, 1 May 2006 21:31:04 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:21900 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932340AbWEBBbD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 May 2006 21:31:03 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 17B8AD74;
	Tue,  2 May 2006 03:31:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 0BA2BD71;
	Tue,  2 May 2006 03:31:02 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id EA094C18;
	Tue,  2 May 2006 03:31:01 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19396>


On one of my systems, sscanf() first calls strlen() on the buffer. But
this buffer is not terminated by NUL. So git crashed.

strtol() does not share that problem, as it stops reading after the
first non-digit.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	Maybe, a better solution would be to store the integers in 
	binary form. But I am not familiar with that part of git, and
	further, it would break setups which already have an index
	with cache-tree information.

 cache-tree.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

4325bb506d03a0e30a5d4dd197601a53f0375df9
diff --git a/cache-tree.c b/cache-tree.c
index 28b78f8..bd7c1aa 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -439,6 +439,7 @@ void *cache_tree_write(struct cache_tree
 static struct cache_tree *read_one(const char **buffer, unsigned long *size_p)
 {
 	const char *buf = *buffer;
+	char *endptr;
 	unsigned long size = *size_p;
 	struct cache_tree *it;
 	int i, subtree_nr;
@@ -453,8 +454,16 @@ static struct cache_tree *read_one(const
 		goto free_return;
 	buf++; size--;
 	it = cache_tree();
-	if (sscanf(buf, "%d %d\n", &it->entry_count, &subtree_nr) != 2)
+	it->entry_count = strtol(buf, &endptr, 10);
+	if (buf == endptr)
 		goto free_return;
+	size -= (endptr - buf);
+	buf = endptr + 1;
+	subtree_nr = strtol(buf, &endptr, 10);
+	if (buf == endptr)
+		goto free_return;
+	size -= (endptr - buf);
+	buf = endptr + 1;
 	while (size && *buf && *buf != '\n') {
 		size--;
 		buf++;
-- 
1.3.1.g5d53-dirty
