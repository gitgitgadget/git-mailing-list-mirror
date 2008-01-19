From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH] parse_commit_buffer: don't parse invalid commits
Date: Sat, 19 Jan 2008 18:35:23 +0100
Message-ID: <1200764123283-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 19 18:36:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGHc0-0006x0-LR
	for gcvg-git-2@gmane.org; Sat, 19 Jan 2008 18:36:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751061AbYASRf0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jan 2008 12:35:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbYASRf0
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jan 2008 12:35:26 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:60840 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750990AbYASRfZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jan 2008 12:35:25 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id ADEF8680BEA3;
	Sat, 19 Jan 2008 18:35:23 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v9A1yvQGK3sD; Sat, 19 Jan 2008 18:35:23 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 920F7680BEA2; Sat, 19 Jan 2008 18:35:23 +0100 (CET)
X-Mailer: git-send-email 1.5.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71122>

* check, that the tree line ends with \n
* prevent parse_commit_date from reading beyond the buffer,
  - if author line does not end with \n
  - if committer line does not contain >
* verify in parse_commit_date, that the commiter line ends with \n

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
 commit.c |   27 ++++++++++++++++++++-------
 1 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/commit.c b/commit.c
index f074811..8b8fb04 100644
--- a/commit.c
+++ b/commit.c
@@ -48,19 +48,32 @@ struct commit *lookup_commit(const unsigned char *sha1)
 	return check_commit(obj, sha1, 0);
 }
 
-static unsigned long parse_commit_date(const char *buf)
+static unsigned long parse_commit_date(const char *buf, const char *tail)
 {
 	unsigned long date;
+	const char *dateptr;
 
+	if (buf + 6 >= tail)
+		return 0;
 	if (memcmp(buf, "author", 6))
 		return 0;
-	while (*buf++ != '\n')
+	while (buf < tail && *buf++ != '\n')
 		/* nada */;
+	if (buf + 9 >= tail)
+		return 0;
 	if (memcmp(buf, "committer", 9))
 		return 0;
-	while (*buf++ != '>')
+	while (buf < tail && *buf++ != '>')
 		/* nada */;
-	date = strtoul(buf, NULL, 10);
+	if (buf >= tail)
+		return 0;
+	dateptr = buf;
+	while (buf < tail && *buf++ != '\n')
+		/* nada */;
+	if (buf >= tail)
+		return 0;
+	/* dateptr < buf && buf[-1] == '\n', so strtoul will stop at buf-1 */
+	date = strtoul(dateptr, NULL, 10);
 	if (date == ULONG_MAX)
 		date = 0;
 	return date;
@@ -236,9 +249,9 @@ int parse_commit_buffer(struct commit *item, void *buffer, unsigned long size)
 		return 0;
 	item->object.parsed = 1;
 	tail += size;
-	if (tail <= bufptr + 5 || memcmp(bufptr, "tree ", 5))
+	if (tail <= bufptr + 46 || memcmp(bufptr, "tree ", 5) || bufptr[45] != '\n')
 		return error("bogus commit object %s", sha1_to_hex(item->object.sha1));
-	if (tail <= bufptr + 45 || get_sha1_hex(bufptr + 5, parent) < 0)
+	if (get_sha1_hex(bufptr + 5, parent) < 0)
 		return error("bad tree pointer in commit %s",
 			     sha1_to_hex(item->object.sha1));
 	item->tree = lookup_tree(parent);
@@ -275,7 +288,7 @@ int parse_commit_buffer(struct commit *item, void *buffer, unsigned long size)
 			n_refs++;
 		}
 	}
-	item->date = parse_commit_date(bufptr);
+	item->date = parse_commit_date(bufptr, tail);
 
 	if (track_object_refs) {
 		unsigned i = 0;
-- 
gitgui.0.9.1.g39b9
