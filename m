From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 3/4] Speed up git notes lookup
Date: Sat, 20 Dec 2008 00:35:45 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0812200035360.30769@pacific.mpi-cbg.de>
References: <5d46db230812160015t55b4ff2fubbf1e2f826a97b98@mail.gmail.com> <20081216085108.GA3031@coredump.intra.peff.net> <alpine.DEB.1.00.0812192347261.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Govind Salinas <govind@sophiasuchtig.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 20 00:29:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDomJ-0005Kg-G8
	for gcvg-git-2@gmane.org; Sat, 20 Dec 2008 00:29:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755647AbYLSX1q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2008 18:27:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755633AbYLSX1q
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Dec 2008 18:27:46 -0500
Received: from mail.gmx.net ([213.165.64.20]:58355 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755581AbYLSX1o (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2008 18:27:44 -0500
Received: (qmail invoked by alias); 19 Dec 2008 23:27:42 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp061) with SMTP; 20 Dec 2008 00:27:42 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/RYCF4JWnR2MZ4ALGnz6zUI0dXhtQACADBeARkzm
	nYoIkj6JmomJ51
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.00.0812192347261.30769@pacific.mpi-cbg.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.47
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103603>


To avoid looking up each and every commit in the notes ref's tree
object, which is very expensive, speed things up by slurping the tree
object's contents into a hash_map.

The idea fo the hashmap singleton is from David Reiss, initial
benchmarking by Jeff King.

Note: the implementation allows for arbitrary entries in the notes
tree object, ignoring those that do not reference a valid object.  This
allows you to annotate arbitrary branches, or objects.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 notes.c |  113 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++------
 1 files changed, 102 insertions(+), 11 deletions(-)

diff --git a/notes.c b/notes.c
index 91ec77f..68bcb24 100644
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
+	unsigned *mode;
+	struct tree_desc desc;
+	struct name_entry entry;
+	void *buf;
+
+	if (!notes_ref_name || read_ref(notes_ref_name, commit_sha1) ||
+			get_tree_entry(commit_sha1, "", sha1, mode))
+		return;
+
+	buf = fill_tree_descriptor(&desc, sha1);
+	if (!buf)
+		die ("Could not read %s for notes-index", sha1_to_hex(sha1));
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
 	char *msg;
 	unsigned long msgoffset, msglen;
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
1.6.1.rc3.368.g63acc
