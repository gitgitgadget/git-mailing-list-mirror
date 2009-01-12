From: Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH 3/7] replace_object: add mechanism to replace objects
 found in "refs/replace/"
Date: Mon, 12 Jan 2009 18:44:03 +0100
Message-ID: <20090112184403.ebb99b75.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 12 18:44:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMQqE-0008QY-9J
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 18:44:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752189AbZALRnY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 12:43:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751936AbZALRnX
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 12:43:23 -0500
Received: from smtp1-g21.free.fr ([212.27.42.1]:53040 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751471AbZALRnW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 12:43:22 -0500
Received: from smtp1-g21.free.fr (localhost [127.0.0.1])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 206499403C8;
	Mon, 12 Jan 2009 18:43:14 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g21.free.fr (Postfix) with SMTP id 133239407C4;
	Mon, 12 Jan 2009 18:43:12 +0100 (CET)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.11; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105363>

The code implementing this mechanism has been copied from the commit
graft code.

This mechanism is used in "read_sha1_file". sha1 passed to this
function that match a ref name in "refs/replace/" are replaced by
the sha1 that has been read in the ref.

We "die" if the replacement recursion depth is too high or if we
can't read the replacement object.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Makefile         |    1 +
 commit.h         |    2 +
 replace_object.c |  116 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 sha1_file.c      |   14 +++++-
 4 files changed, 130 insertions(+), 3 deletions(-)
 create mode 100644 replace_object.c

diff --git a/Makefile b/Makefile
index dee97c1..7cf5d9a 100644
--- a/Makefile
+++ b/Makefile
@@ -471,6 +471,7 @@ LIB_OBJS += read-cache.o
 LIB_OBJS += reflog-walk.o
 LIB_OBJS += refs.o
 LIB_OBJS += remote.o
+LIB_OBJS += replace_object.o
 LIB_OBJS += rerere.o
 LIB_OBJS += revision.o
 LIB_OBJS += run-command.o
diff --git a/commit.h b/commit.h
index 3a7b06a..37aa763 100644
--- a/commit.h
+++ b/commit.h
@@ -122,6 +122,8 @@ struct commit_graft *read_graft_line(char *buf, int len);
 int register_commit_graft(struct commit_graft *, int);
 struct commit_graft *lookup_commit_graft(const unsigned char *sha1);
 
+const unsigned char *lookup_replace_object(const unsigned char *sha1);
+
 extern struct commit_list *get_merge_bases(struct commit *rev1, struct commit *rev2, int cleanup);
 extern struct commit_list *get_merge_bases_many(struct commit *one, int n, struct commit **twos, int cleanup);
 extern struct commit_list *get_octopus_merge_bases(struct commit_list *in);
diff --git a/replace_object.c b/replace_object.c
new file mode 100644
index 0000000..25b3ef3
--- /dev/null
+++ b/replace_object.c
@@ -0,0 +1,116 @@
+#include "cache.h"
+#include "refs.h"
+
+static struct replace_object {
+	unsigned char sha1[2][20];
+} **replace_object;
+
+static int replace_object_alloc, replace_object_nr;
+
+static int replace_object_pos(const unsigned char *sha1)
+{
+	int lo, hi;
+	lo = 0;
+	hi = replace_object_nr;
+	while (lo < hi) {
+		int mi = (lo + hi) / 2;
+		struct replace_object *rep = replace_object[mi];
+		int cmp = hashcmp(sha1, rep->sha1[0]);
+		if (!cmp)
+			return mi;
+		if (cmp < 0)
+			hi = mi;
+		else
+			lo = mi + 1;
+	}
+	return -lo - 1;
+}
+
+static int register_replace_object(struct replace_object *replace,
+				   int ignore_dups)
+{
+	int pos = replace_object_pos(replace->sha1[0]);
+
+	if (0 <= pos) {
+		if (ignore_dups)
+			free(replace);
+		else {
+			free(replace_object[pos]);
+			replace_object[pos] = replace;
+		}
+		return 1;
+	}
+	pos = -pos - 1;
+	if (replace_object_alloc <= ++replace_object_nr) {
+		replace_object_alloc = alloc_nr(replace_object_alloc);
+		replace_object = xrealloc(replace_object,
+					  sizeof(*replace_object) *
+					  replace_object_alloc);
+	}
+	if (pos < replace_object_nr)
+		memmove(replace_object + pos + 1,
+			replace_object + pos,
+			(replace_object_nr - pos - 1) *
+			sizeof(*replace_object));
+	replace_object[pos] = replace;
+	return 0;
+}
+
+static int register_replace_ref(const char *refname,
+				const unsigned char *sha1,
+				int flag, void *cb_data)
+{
+	/* Get sha1 from refname */
+	const char *slash = strrchr(refname, '/');
+	const char *hash = slash ? slash + 1 : refname;
+	struct replace_object * repl_obj = xmalloc(sizeof(*repl_obj));
+
+	if (strlen(hash) != 40 || get_sha1_hex(hash, repl_obj->sha1[0])) {
+		free(repl_obj);
+		warning("bad replace ref name: %s", refname);
+	}
+
+	/* Copy sha1 from the read ref */
+	hashcpy(repl_obj->sha1[1], sha1);
+
+	/* Register new object */
+	if (register_replace_object(repl_obj, 1))
+		warning("duplicate replace ref: %s", refname);
+
+	return 0;
+}
+
+static void prepare_replace_object(void)
+{
+	static int replace_object_prepared;
+
+	if (replace_object_prepared)
+		return;
+
+	for_each_replace_ref(register_replace_ref, NULL);
+	replace_object_prepared = 1;
+}
+
+/* We allow "recursive" replacement. Only within reason, though */
+#define MAXREPLACEDEPTH 5
+
+const unsigned char *lookup_replace_object(const unsigned char *sha1)
+{
+	int pos, depth = MAXREPLACEDEPTH;
+	const unsigned char *cur = sha1;
+
+	prepare_replace_object();
+
+	/* Try to recursively replace the object */
+	do {
+		if (--depth < 0)
+			die("replace depth too high for object %s",
+			    sha1_to_hex(sha1));
+
+		pos = replace_object_pos(cur);
+		if (0 <= pos)
+			cur = replace_object[pos]->sha1[1];
+	} while (0 <= pos);
+
+	return cur;
+}
diff --git a/sha1_file.c b/sha1_file.c
index f08493f..4f2fd10 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2163,10 +2163,18 @@ static void *read_object(const unsigned char *sha1, enum object_type *type,
 void *read_sha1_file(const unsigned char *sha1, enum object_type *type,
 		     unsigned long *size)
 {
-	void *data = read_object(sha1, type, size);
+	const unsigned char *repl = lookup_replace_object(sha1);
+	void *data = read_object(repl, type, size);
+
+	/* die if we replaced an object with one that does not exist */
+	if (!data && repl != sha1)
+		die("replacement %s not found for %s",
+		    sha1_to_hex(repl), sha1_to_hex(sha1));
+
 	/* legacy behavior is to die on corrupted objects */
-	if (!data && (has_loose_object(sha1) || has_packed_and_bad(sha1)))
-		die("object %s is corrupted", sha1_to_hex(sha1));
+	if (!data && (has_loose_object(repl) || has_packed_and_bad(repl)))
+		die("object %s is corrupted", sha1_to_hex(repl));
+
 	return data;
 }
 
-- 
1.6.1.83.g16e5
