From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 1/9] pack-objects: optimize preferred base handling a bit
Date: Mon, 16 Apr 2007 12:14:50 -0400 (EDT)
Message-ID: <S1030820AbXDPQOx/20070416161453Z+1494@vger.kernel.org>
Content-Transfer-Encoding: 7BIT
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Mon Apr 16 18:15:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdTrQ-0002jZ-Ua
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 18:15:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030823AbXDPQOx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 12:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030820AbXDPQOx
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 12:14:53 -0400
Received: from relais.videotron.ca ([24.201.245.36]:39242 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030818AbXDPQOv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 12:14:51 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JGL00049MGQOKS0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 16 Apr 2007 12:14:51 -0400 (EDT)
Date-warning: Date header was inserted by VL-MH-MR001.ip.videotron.ca
Apparently-To: <nico@cam.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44657>

Let's avoid some cycles when there is no base to test against, and avoid
unnecessary object lookups.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 builtin-pack-objects.c |   27 ++++++++++++---------------
 1 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index bc5f232..62a011e 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -959,22 +959,21 @@ static void add_pbase_object(struct tree_desc *tree,
 			     const char *fullname)
 {
 	struct name_entry entry;
+	int cmp;
 
 	while (tree_entry(tree,&entry)) {
-		unsigned long size;
-		enum object_type type;
-
-		if (tree_entry_len(entry.path, entry.sha1) != cmplen ||
-		    memcmp(entry.path, name, cmplen) ||
-		    !has_sha1_file(entry.sha1) ||
-		    (type = sha1_object_info(entry.sha1, &size)) < 0)
+		cmp = tree_entry_len(entry.path, entry.sha1) != cmplen ? 1 :
+		      memcmp(name, entry.path, cmplen);
+		if (cmp > 0)
 			continue;
+		if (cmp < 0)
+			return;
 		if (name[cmplen] != '/') {
 			unsigned hash = name_hash(fullname);
 			add_object_entry(entry.sha1, hash, 1);
 			return;
 		}
-		if (type == OBJ_TREE) {
+		if (S_ISDIR(entry.mode)) {
 			struct tree_desc sub;
 			struct pbase_tree_cache *tree;
 			const char *down = name+cmplen+1;
@@ -1034,15 +1033,15 @@ static int check_pbase_path(unsigned hash)
 static void add_preferred_base_object(const char *name, unsigned hash)
 {
 	struct pbase_tree *it;
-	int cmplen = name_cmp_len(name);
+	int cmplen;
 
-	if (check_pbase_path(hash))
+	if (!num_preferred_base || check_pbase_path(hash))
 		return;
 
+	cmplen = name_cmp_len(name);
 	for (it = pbase_tree; it; it = it->next) {
 		if (cmplen == 0) {
-			hash = name_hash("");
-			add_object_entry(it->pcache.sha1, hash, 1);
+			add_object_entry(it->pcache.sha1, 0, 1);
 		}
 		else {
 			struct tree_desc tree;
@@ -1587,9 +1586,7 @@ static void read_object_list_from_stdin(void)
 
 static void show_commit(struct commit *commit)
 {
-	unsigned hash = name_hash("");
-	add_preferred_base_object("", hash);
-	add_object_entry(commit->object.sha1, hash, 0);
+	add_object_entry(commit->object.sha1, 0, 0);
 }
 
 static void show_object(struct object_array_entry *p)
-- 
1.5.1.1.781.g65e8
