From: Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH 2/3] replace_object: add mechanism to replace objects
 found in "refs/replace/"
Date: Wed, 7 Jan 2009 08:43:41 +0100
Message-ID: <20090107084341.1554d8cd.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 07 08:44:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKT5P-0000En-Ru
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 08:44:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751783AbZAGHm4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 02:42:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751768AbZAGHm4
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 02:42:56 -0500
Received: from smtp6-g21.free.fr ([212.27.42.6]:47322 "EHLO smtp6-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751767AbZAGHmz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 02:42:55 -0500
Received: from smtp6-g21.free.fr (localhost [127.0.0.1])
	by smtp6-g21.free.fr (Postfix) with ESMTP id BFCCCE08114;
	Wed,  7 Jan 2009 08:42:48 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp6-g21.free.fr (Postfix) with SMTP id BA581E08048;
	Wed,  7 Jan 2009 08:42:45 +0100 (CET)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.11; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104771>

The code of this mechanism has been copied from the commit graft code.

Currently this mechanism is only used from the "parse_commit_buffer"
function in "commit.c". It should probably be used from "fsck.c" too.

(For information, grafts are looked up only from "parse_commit_buffer"
function in "commit.c" and from "fsck_commit" in "fsck.c".)

In "parse_commit_buffer", the parent sha1s from the original commit
or from a commit graft that match a ref name in "refs/replace/" are
replaced by the commit sha1 that has been read in the ref.

This means that for example "git show <original commit sha1>" will
display information about the original commit. If the mechanism
had been called from "read_sha1_file" instead of when parents
are read, then "git show <original commit sha1>" would display
information about the commit that replaces the original one.
This may be seen as a feature or as a bug depending on the point
of view.

Anyway this implementation makes sure that the mechanism is
triggered only when commit graft could be triggered, so hopefully the
object reachability traverser will ignore this mechanism as it
ignores the graft mechanism.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Makefile         |    1 +
 commit.c         |    7 +++-
 commit.h         |    2 +
 replace_object.c |  102 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 110 insertions(+), 2 deletions(-)
 create mode 100644 replace_object.c

diff --git a/Makefile b/Makefile
index aabf013..f355e63 100644
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
diff --git a/commit.c b/commit.c
index c99db16..0014174 100644
--- a/commit.c
+++ b/commit.c
@@ -241,6 +241,7 @@ int parse_commit_buffer(struct commit *item, void *buffer, unsigned long size)
 	char *tail = buffer;
 	char *bufptr = buffer;
 	unsigned char parent[20];
+	const unsigned char *parent_sha1;
 	struct commit_list **pptr;
 	struct commit_graft *graft;
 
@@ -268,7 +269,8 @@ int parse_commit_buffer(struct commit *item, void *buffer, unsigned long size)
 		bufptr += 48;
 		if (graft)
 			continue;
-		new_parent = lookup_commit(parent);
+		parent_sha1 = lookup_replace_object(parent);
+		new_parent = lookup_commit(parent_sha1);
 		if (new_parent)
 			pptr = &commit_list_insert(new_parent, pptr)->next;
 	}
@@ -276,7 +278,8 @@ int parse_commit_buffer(struct commit *item, void *buffer, unsigned long size)
 		int i;
 		struct commit *new_parent;
 		for (i = 0; i < graft->nr_parent; i++) {
-			new_parent = lookup_commit(graft->parent[i]);
+			parent_sha1 = lookup_replace_object(graft->parent[i]);
+			new_parent = lookup_commit(parent_sha1);
 			if (!new_parent)
 				continue;
 			pptr = &commit_list_insert(new_parent, pptr)->next;
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
index 0000000..b50890d
--- /dev/null
+++ b/replace_object.c
@@ -0,0 +1,102 @@
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
+const unsigned char *lookup_replace_object(const unsigned char *sha1)
+{
+	int pos;
+
+	prepare_replace_object();
+	pos = replace_object_pos(sha1);
+
+	return (0 <= pos) ? replace_object[pos]->sha1[1] : sha1;
+}
-- 
1.6.1.162.g1cd53
