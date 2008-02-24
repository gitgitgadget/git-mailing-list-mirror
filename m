From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH 4/4] builtin-fsck: reports missing parent commits
Date: Sun, 24 Feb 2008 15:43:57 +0100
Message-ID: <12038642372833-git-send-email-mkoegler@auto.tuwien.ac.at>
References: <12038642373342-git-send-email-mkoegler@auto.tuwien.ac.at>
 <1203864237774-git-send-email-mkoegler@auto.tuwien.ac.at>
 <1203864237817-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Feb 24 15:45:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTI6G-00042C-Km
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 15:45:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbYBXOo2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2008 09:44:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbYBXOoE
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 09:44:04 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:34918 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751272AbYBXOn7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2008 09:43:59 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id D95806CF007B;
	Sun, 24 Feb 2008 15:43:57 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ML9-kBs+3p9e; Sun, 24 Feb 2008 15:43:57 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 8499C680BF95; Sun, 24 Feb 2008 15:43:57 +0100 (CET)
X-Mailer: git-send-email 1.5.3.1
In-Reply-To: <1203864237817-git-send-email-mkoegler@auto.tuwien.ac.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74936>

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
 builtin-fsck.c |   24 ++++++++++++++++++++++++
 commit.c       |    2 +-
 commit.h       |    1 +
 3 files changed, 26 insertions(+), 1 deletions(-)

diff --git a/builtin-fsck.c b/builtin-fsck.c
index 512346a..18a660f 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -394,6 +394,8 @@ static int fsck_commit(struct commit *commit)
 {
 	char *buffer = commit->buffer;
 	unsigned char tree_sha1[20], sha1[20];
+	struct commit_graft *graft;
+	int parents = 0;
 
 	if (verbose)
 		fprintf(stderr, "Checking commit %s\n",
@@ -411,6 +413,28 @@ static int fsck_commit(struct commit *commit)
 		if (get_sha1_hex(buffer+7, sha1) || buffer[47] != '\n')
 			return objerror(&commit->object, "invalid 'parent' line format - bad sha1");
 		buffer += 48;
+		parents++;
+	}
+	graft = lookup_commit_graft(commit->object.sha1);
+	if (graft) {
+		struct commit_list *p = commit->parents;
+		parents = 0;
+		while (p && parents) {
+			p = p->next;
+			parents -- ;
+		}
+		if (graft->nr_parent == -1 && !parents)
+			; /* shallow commit */
+		else if (graft->nr_parent != parents)
+			return objerror(&commit->object, "graft objects missing");
+	} else {
+		struct commit_list *p = commit->parents;
+		while (p && parents) {
+			p = p->next;
+			parents -- ;
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
index 80d65b9..a1e9591 100644
--- a/commit.h
+++ b/commit.h
@@ -116,6 +116,7 @@ struct commit_graft {
 struct commit_graft *read_graft_line(char *buf, int len);
 int register_commit_graft(struct commit_graft *, int);
 int read_graft_file(const char *graft_file);
+struct commit_graft *lookup_commit_graft(const unsigned char *sha1);
 
 extern struct commit_list *get_merge_bases(struct commit *rev1, struct commit *rev2, int cleanup);
 
-- 
1.5.4.2.gf624.dirty
