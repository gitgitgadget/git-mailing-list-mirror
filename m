From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] git-mktree: reverse of git-ls-tree.
Date: Mon, 20 Feb 2006 22:37:05 -0800
Message-ID: <7vk6bp43qm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 21 07:37:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBR9E-0006ey-Rs
	for gcvg-git@gmane.org; Tue, 21 Feb 2006 07:37:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161419AbWBUGhQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Feb 2006 01:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161420AbWBUGhQ
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Feb 2006 01:37:16 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:35277 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1161419AbWBUGhO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2006 01:37:14 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060221063440.WRUI17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 21 Feb 2006 01:34:40 -0500
To: Tommi Virtanen <tv@debian.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16518>

This reads data in the format a (non recursive) ls-tree outputs
and writes a tree object to the object database.  The created
tree object name is output to the standard output.

For convenience, the input data does not need to be sorted; the
command sorts the input lines internally.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 * For the purposes of filesystem backend, I think completely
   bypassing the index and having a way to handcraft a tree
   object, especially if you are writing things in Python, would
   be much easier to use.  Hence this command.

   Comments?

 Makefile |    2 -
 mktree.c |  137 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 138 insertions(+), 1 deletions(-)
 create mode 100644 mktree.c

7e37266ced5edd9a70b03ea07b5eca0d7ee82039
diff --git a/Makefile b/Makefile
index 317be3c..2f73b86 100644
--- a/Makefile
+++ b/Makefile
@@ -143,7 +143,7 @@ PROGRAMS = \
 	git-diff-tree$X git-fetch-pack$X git-fsck-objects$X \
 	git-hash-object$X git-index-pack$X git-init-db$X \
 	git-local-fetch$X git-ls-files$X git-ls-tree$X git-merge-base$X \
-	git-merge-index$X git-mktag$X git-pack-objects$X git-patch-id$X \
+	git-merge-index$X git-mktag$X git-mktree$X git-pack-objects$X git-patch-id$X \
 	git-peek-remote$X git-prune-packed$X git-read-tree$X \
 	git-receive-pack$X git-rev-list$X git-rev-parse$X \
 	git-send-pack$X git-show-branch$X git-shell$X \
diff --git a/mktree.c b/mktree.c
new file mode 100644
index 0000000..f853585
--- /dev/null
+++ b/mktree.c
@@ -0,0 +1,137 @@
+/*
+ * GIT - the stupid content tracker
+ *
+ * Copyright (c) Junio C Hamano, 2006
+ */
+#include "cache.h"
+#include "strbuf.h"
+#include "quote.h"
+
+static struct treeent {
+	unsigned mode;
+	unsigned char sha1[20];
+	int len;
+	char name[FLEX_ARRAY];
+} **entries;
+static int alloc, used;
+
+static void append_to_tree(unsigned mode, unsigned char *sha1, char *path)
+{
+	struct treeent *ent;
+	int len = strlen(path);
+	if (strchr(path, '/'))
+		die("path %s contains slash", path);
+
+	if (alloc <= used) {
+		alloc = alloc_nr(used);
+		entries = xrealloc(entries, sizeof(*entries) * alloc);
+	}
+	ent = entries[used++] = xmalloc(sizeof(**entries) + len + 1);
+	ent->mode = mode;
+	ent->len = len;
+	memcpy(ent->sha1, sha1, 20);
+	memcpy(ent->name, path, len+1);
+}
+
+static int ent_compare(const void *a_, const void *b_)
+{
+	struct treeent *a = *(struct treeent **)a_;
+	struct treeent *b = *(struct treeent **)b_;
+	return base_name_compare(a->name, a->len, a->mode,
+				 b->name, b->len, b->mode);
+}
+
+static void write_tree(unsigned char *sha1)
+{
+	char *buffer;
+	unsigned long size, offset;
+	int i;
+
+	qsort(entries, used, sizeof(*entries), ent_compare);
+	size = 100;
+	for (size = i = 0; i < used; i++)
+		size += 32 + entries[i]->len;
+	buffer = xmalloc(size);
+	offset = 0;
+
+	for (i = 0; i < used; i++) {
+		struct treeent *ent = entries[i];
+
+		if (offset + ent->len + 100 < size) {
+			size = alloc_nr(offset + ent->len + 100);
+			buffer = xrealloc(buffer, size);
+		}
+		offset += sprintf(buffer + offset, "%o ", ent->mode);
+		offset += sprintf(buffer + offset, "%s", ent->name);
+		buffer[offset++] = 0;
+		memcpy(buffer + offset, ent->sha1, 20);
+		offset += 20;
+	}
+	write_sha1_file(buffer, offset, "tree", sha1);
+}
+
+static const char mktree_usage[] = "mktree [-z]";
+
+int main(int ac, char **av)
+{
+	struct strbuf sb;
+	unsigned char sha1[20];
+	int line_termination = '\n';
+
+	setup_git_directory();
+
+	while ((1 < ac) && av[1][0] == '-') {
+		char *arg = av[1];
+		if (!strcmp("-z", arg))
+			line_termination = 0;
+		else
+			usage(mktree_usage);
+		ac--;
+		av++;
+	}
+
+	strbuf_init(&sb);
+	while (1) {
+		int len;
+		char *ptr, *ntr;
+		unsigned mode;
+		char type[20];
+		char *path;
+
+		read_line(&sb, stdin, line_termination);
+		if (sb.eof)
+			break;
+		len = sb.len;
+		ptr = sb.buf;
+		/* Input is non-recursive ls-tree output format
+		 * mode SP type SP sha1 TAB name
+		 */
+		mode = strtoul(ptr, &ntr, 8);
+		if (ptr == ntr || !ntr || *ntr != ' ')
+			die("input format error: %s", sb.buf);
+		ptr = ntr + 1; /* type */
+		ntr = strchr(ptr, ' ');
+		if (!ntr || sb.buf + len <= ntr + 41 ||
+		    ntr[41] != '\t' ||
+		    get_sha1_hex(ntr + 1, sha1))
+			die("input format error: %s", sb.buf);
+		if (sha1_object_info(sha1, type, NULL))
+			die("object %s unavailable", sha1_to_hex(sha1));
+		*ntr++ = 0; /* now at the beginning of SHA1 */
+		if (strcmp(ptr, type))
+			die("object type %s mismatch (%s)", ptr, type);
+		ntr += 41; /* at the beginning of name */
+		if (line_termination && ntr[0] == '"')
+			path = unquote_c_style(ntr, NULL);
+		else
+			path = ntr;
+
+		append_to_tree(mode, sha1, path);
+
+		if (path != ntr)
+			free(path);
+	}
+	write_tree(sha1);
+	puts(sha1_to_hex(sha1));
+	exit(0);
+}
-- 
1.2.2.g9896
