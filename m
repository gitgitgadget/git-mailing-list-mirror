From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/2] pack-objects: pass fullname down to add_object_entry()
Date: Sat, 19 May 2007 00:48:10 -0700
Message-ID: <11795608912129-git-send-email-junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 19 09:48:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpJfk-0006Ul-RG
	for gcvg-git@gmane.org; Sat, 19 May 2007 09:48:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754910AbXESHsN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 May 2007 03:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755570AbXESHsN
	(ORCPT <rfc822;git-outgoing>); Sat, 19 May 2007 03:48:13 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:43714 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754910AbXESHsM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2007 03:48:12 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070519074813.GXIP12190.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>
          for <git@vger.kernel.org>; Sat, 19 May 2007 03:48:13 -0400
Received: from localhost.localdomain ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 0voC1X0031kojtg0000000; Sat, 19 May 2007 03:48:12 -0400
X-Mailer: git-send-email 1.5.2.rc3.87.g404f
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47726>

Instead of giving a hash for grouping, pass fullname to add_object_entry().
I want to add "do not try deltifying this object" bit to object_entry based on
the settings in .gitattributes, and hashing the name down too early would
interfere with that plan.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 builtin-pack-objects.c |   27 ++++++++++++++-------------
 1 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 5fa9813..12d9685 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -721,6 +721,9 @@ static unsigned name_hash(const char *name)
 	unsigned char c;
 	unsigned hash = 0;
 
+	if (!name)
+		return 0;
+
 	/*
 	 * This effectively just creates a sortable number from the
 	 * last sixteen non-whitespace characters. Last characters
@@ -735,12 +738,13 @@ static unsigned name_hash(const char *name)
 }
 
 static int add_object_entry(const unsigned char *sha1, enum object_type type,
-			    unsigned hash, int exclude)
+			    const char *name, int exclude)
 {
 	struct object_entry *entry;
 	struct packed_git *p, *found_pack = NULL;
 	off_t found_offset = 0;
 	int ix;
+	unsigned hash = name_hash(name);
 
 	ix = nr_objects ? locate_object_entry_hash(sha1) : -1;
 	if (ix >= 0) {
@@ -929,10 +933,9 @@ static void add_pbase_object(struct tree_desc *tree,
 		if (cmp < 0)
 			return;
 		if (name[cmplen] != '/') {
-			unsigned hash = name_hash(fullname);
 			add_object_entry(entry.sha1,
 					 S_ISDIR(entry.mode) ? OBJ_TREE : OBJ_BLOB,
-					 hash, 1);
+					 fullname, 1);
 			return;
 		}
 		if (S_ISDIR(entry.mode)) {
@@ -992,10 +995,11 @@ static int check_pbase_path(unsigned hash)
 	return 0;
 }
 
-static void add_preferred_base_object(const char *name, unsigned hash)
+static void add_preferred_base_object(const char *name)
 {
 	struct pbase_tree *it;
 	int cmplen;
+	unsigned hash = name_hash(name);
 
 	if (!num_preferred_base || check_pbase_path(hash))
 		return;
@@ -1003,7 +1007,7 @@ static void add_preferred_base_object(const char *name, unsigned hash)
 	cmplen = name_cmp_len(name);
 	for (it = pbase_tree; it; it = it->next) {
 		if (cmplen == 0) {
-			add_object_entry(it->pcache.sha1, OBJ_TREE, 0, 1);
+			add_object_entry(it->pcache.sha1, OBJ_TREE, NULL, 1);
 		}
 		else {
 			struct tree_desc tree;
@@ -1434,7 +1438,6 @@ static void read_object_list_from_stdin(void)
 {
 	char line[40 + 1 + PATH_MAX + 2];
 	unsigned char sha1[20];
-	unsigned hash;
 
 	for (;;) {
 		if (!fgets(line, sizeof(line), stdin)) {
@@ -1457,22 +1460,20 @@ static void read_object_list_from_stdin(void)
 		if (get_sha1_hex(line, sha1))
 			die("expected sha1, got garbage:\n %s", line);
 
-		hash = name_hash(line+41);
-		add_preferred_base_object(line+41, hash);
-		add_object_entry(sha1, 0, hash, 0);
+		add_preferred_base_object(line+41);
+		add_object_entry(sha1, 0, line+41, 0);
 	}
 }
 
 static void show_commit(struct commit *commit)
 {
-	add_object_entry(commit->object.sha1, OBJ_COMMIT, 0, 0);
+	add_object_entry(commit->object.sha1, OBJ_COMMIT, NULL, 0);
 }
 
 static void show_object(struct object_array_entry *p)
 {
-	unsigned hash = name_hash(p->name);
-	add_preferred_base_object(p->name, hash);
-	add_object_entry(p->item->sha1, p->item->type, hash, 0);
+	add_preferred_base_object(p->name);
+	add_object_entry(p->item->sha1, p->item->type, p->name, 0);
 }
 
 static void show_edge(struct commit *commit)
-- 
1.5.2.rc3.87.g404f
