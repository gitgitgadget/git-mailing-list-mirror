From: Johan Herland <johan@herland.net>
Subject: [PATCH 3/5] Speed up git notes lookup
Date: Sat, 16 May 2009 03:45:06 +0200
Message-ID: <03f4b437b69cc92e049b6df54858dcb7d6911c86.1242437696.git.johan@herland.net>
References: <cover.1242437696.git.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de,
	trast@student.ethz.ch, tavestbo@trolltech.com, johan@herland.net,
	git@drmicha.warpmail.net, chriscool@tuxfamily.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat May 16 03:48:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5916-0004xV-5i
	for gcvg-git-2@gmane.org; Sat, 16 May 2009 03:48:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754863AbZEPBrl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2009 21:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754904AbZEPBrl
	(ORCPT <rfc822;git-outgoing>); Fri, 15 May 2009 21:47:41 -0400
Received: from mx.getmail.no ([84.208.15.66]:45389 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754337AbZEPBrk (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 May 2009 21:47:40 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KJP00HY7RNH4X10@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Sat, 16 May 2009 03:47:41 +0200 (MEST)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KJP0047TRKAYOH0@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Sat, 16 May 2009 03:47:40 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.5.16.13426
X-Mailer: git-send-email 1.6.3.rc0.1.gf800
In-reply-to: <cover.1242437696.git.johan@herland.net>
In-reply-to: <cover.1242437696.git.johan@herland.net>
References: <cover.1242437696.git.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119314>

From: Johannes Schindelin <Johannes.Schindelin@gmx.de>

To avoid looking up each and every commit in the notes ref's tree
object, which is very expensive, speed things up by slurping the tree
object's contents into a hash_map.

The idea for the hashmap singleton is from David Reiss, initial
benchmarking by Jeff King.

Note: the implementation allows for arbitrary entries in the notes
tree object, ignoring those that do not reference a valid object.  This
allows you to annotate arbitrary branches, or objects.

[jc: fixed an obvious error in initialize_hash_map()]

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Johan Herland <johan@herland.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 notes.c |  113 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++------
 1 files changed, 102 insertions(+), 11 deletions(-)

diff --git a/notes.c b/notes.c
index b0cf553..bd73784 100644
--- a/notes.c
+++ b/notes.c
@@ -4,16 +4,112 @@
 #include "refs.h"
 #include "utf8.h"
 #include "strbuf.h"
+#include "tree-walk.h"
+
+struct entry {
+	unsigned char commit_sha1[20];
+	unsigned char notes_sha1[20];
+};
+
+struct hash_map {
+	struct entry *entries;
+	off_t count, size;
+};
 
 static int initialized;
+static struct hash_map hash_map;
+
+static int hash_index(struct hash_map *map, const unsigned char *sha1)
+{
+	int i = ((*(unsigned int *)sha1) % map->size);
+
+	for (;;) {
+		unsigned char *current = map->entries[i].commit_sha1;
+
+		if (!hashcmp(sha1, current))
+			return i;
+
+		if (is_null_sha1(current))
+			return -1 - i;
+
+		if (++i == map->size)
+			i = 0;
+	}
+}
+
+static void add_entry(const unsigned char *commit_sha1,
+		const unsigned char *notes_sha1)
+{
+	int index;
+
+	if (hash_map.count + 1 > hash_map.size >> 1) {
+		int i, old_size = hash_map.size;
+		struct entry *old = hash_map.entries;
+
+		hash_map.size = old_size ? old_size << 1 : 64;
+		hash_map.entries = (struct entry *)
+			xcalloc(sizeof(struct entry), hash_map.size);
+
+		for (i = 0; i < old_size; i++)
+			if (!is_null_sha1(old[i].commit_sha1)) {
+				index = -1 - hash_index(&hash_map,
+						old[i].commit_sha1);
+				memcpy(hash_map.entries + index, old + i,
+					sizeof(struct entry));
+			}
+		free(old);
+	}
+
+	index = hash_index(&hash_map, commit_sha1);
+	if (index < 0) {
+		index = -1 - index;
+		hash_map.count++;
+	}
+
+	hashcpy(hash_map.entries[index].commit_sha1, commit_sha1);
+	hashcpy(hash_map.entries[index].notes_sha1, notes_sha1);
+}
+
+static void initialize_hash_map(const char *notes_ref_name)
+{
+	unsigned char sha1[20], commit_sha1[20];
+	unsigned mode;
+	struct tree_desc desc;
+	struct name_entry entry;
+	void *buf;
+
+	if (!notes_ref_name || read_ref(notes_ref_name, commit_sha1) ||
+	    get_tree_entry(commit_sha1, "", sha1, &mode))
+		return;
+
+	buf = fill_tree_descriptor(&desc, sha1);
+	if (!buf)
+		die("Could not read %s for notes-index", sha1_to_hex(sha1));
+
+	while (tree_entry(&desc, &entry))
+		if (!get_sha1(entry.path, commit_sha1))
+			add_entry(commit_sha1, entry.sha1);
+	free(buf);
+}
+
+static unsigned char *lookup_notes(const unsigned char *commit_sha1)
+{
+	int index;
+
+	if (!hash_map.size)
+		return NULL;
+
+	index = hash_index(&hash_map, commit_sha1);
+	if (index < 0)
+		return NULL;
+	return hash_map.entries[index].notes_sha1;
+}
 
 void get_commit_notes(const struct commit *commit, struct strbuf *sb,
 		const char *output_encoding)
 {
 	static const char *utf8 = "utf-8";
-	struct strbuf name = STRBUF_INIT;
-	const char *hex;
-	unsigned char sha1[20];
+	unsigned char *sha1;
 	char *msg, *msg_p;
 	unsigned long linelen, msglen;
 	enum object_type type;
@@ -24,17 +120,12 @@ void get_commit_notes(const struct commit *commit, struct strbuf *sb,
 			notes_ref_name = getenv(GIT_NOTES_REF_ENVIRONMENT);
 		else if (!notes_ref_name)
 			notes_ref_name = GIT_NOTES_DEFAULT_REF;
-		if (notes_ref_name && read_ref(notes_ref_name, sha1))
-			notes_ref_name = NULL;
+		initialize_hash_map(notes_ref_name);
 		initialized = 1;
 	}
 
-	if (!notes_ref_name)
-		return;
-
-	strbuf_addf(&name, "%s:%s", notes_ref_name,
-			sha1_to_hex(commit->object.sha1));
-	if (get_sha1(name.buf, sha1))
+	sha1 = lookup_notes(commit->object.sha1);
+	if (!sha1)
 		return;
 
 	if (!(msg = read_sha1_file(sha1, &type, &msglen)) || !msglen ||
-- 
1.6.3.rc0.1.gf800
