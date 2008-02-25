From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH 04/10] builtin-fsck: reports missing parent commits
Date: Mon, 25 Feb 2008 22:54:54 +0100
Message-ID: <12039765002219-git-send-email-mkoegler@auto.tuwien.ac.at>
References: <12039765002329-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12039765004039-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12039765003484-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 25 22:56:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTlIn-0006Td-Am
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 22:56:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759839AbYBYVzX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 16:55:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758150AbYBYVzV
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 16:55:21 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:55598 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759506AbYBYVzE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 16:55:04 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id C800C680BF8C;
	Mon, 25 Feb 2008 22:55:00 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MAymf+sZC5wu; Mon, 25 Feb 2008 22:55:00 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 42F01680BF8F; Mon, 25 Feb 2008 22:55:00 +0100 (CET)
X-Mailer: git-send-email 1.5.3.1
In-Reply-To: <12039765003484-git-send-email-mkoegler@auto.tuwien.ac.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75078>

parse_commit ignores parent commits with certain errors
(eg. a non commit object is already loaded under the sha1 of
the parent). To make fsck reports such errors, it has to compare
the nummer of parent commits returned by parse commit with the
number of parent commits in the object or in the graft/shallow file.

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
 builtin-fsck.c |   24 ++++++++++++++++++++++++
 commit.c       |    2 +-
 commit.h       |    1 +
 3 files changed, 26 insertions(+), 1 deletions(-)

diff --git a/builtin-fsck.c b/builtin-fsck.c
index a2e6f53..198466c 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -398,6 +398,8 @@ static int fsck_commit(struct commit *commit)
 {
 	char *buffer = commit->buffer;
 	unsigned char tree_sha1[20], sha1[20];
+	struct commit_graft *graft;
+	int parents = 0;
 
 	if (verbose)
 		fprintf(stderr, "Checking commit %s\n",
@@ -415,6 +417,28 @@ static int fsck_commit(struct commit *commit)
 		if (get_sha1_hex(buffer+7, sha1) || buffer[47] != '\n')
 			return objerror(&commit->object, "invalid 'parent' line format - bad sha1");
 		buffer += 48;
+		parents++;
+	}
+	graft = lookup_commit_graft(commit->object.sha1);
+	if (graft) {
+		struct commit_list *p = commit->parents;
+		parents = 0;
+		while (p) {
+			p = p->next;
+			parents++;
+		}
+		if (graft->nr_parent == -1 && !parents)
+			; /* shallow commit */
+		else if (graft->nr_parent != parents)
+			return objerror(&commit->object, "graft objects missing");
+	} else {
+		struct commit_list *p = commit->parents;
+		while (p && parents) {
+			p = p->next;
+			parents--;
+		}
+		if (p || parents)
+			return objerror(&commit->object, "parent objects missing");
 	}
 	if (memcmp(buffer, "author ", 7))
 		return objerror(&commit->object, "invalid format - expected 'author' line");
diff --git a/commit.c b/commit.c
index 6684c4e..94d5b3d 100644
--- a/commit.c
+++ b/commit.c
@@ -193,7 +193,7 @@ static void prepare_commit_graft(void)
 	commit_graft_prepared = 1;
 }
 
-static struct commit_graft *lookup_commit_graft(const unsigned char *sha1)
+struct commit_graft *lookup_commit_graft(const unsigned char *sha1)
 {
 	int pos;
 	prepare_commit_graft();
diff --git a/commit.h b/commit.h
index 10e2b5d..3ad3dd9 100644
--- a/commit.h
+++ b/commit.h
@@ -101,6 +101,7 @@ struct commit_graft {
 struct commit_graft *read_graft_line(char *buf, int len);
 int register_commit_graft(struct commit_graft *, int);
 int read_graft_file(const char *graft_file);
+struct commit_graft *lookup_commit_graft(const unsigned char *sha1);
 
 extern struct commit_list *get_merge_bases(struct commit *rev1, struct commit *rev2, int cleanup);
 
-- 
1.5.4.3.g3c5f
