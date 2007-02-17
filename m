From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/2] Teach name-rev to identify revisions containing a certain
 blob
Date: Sat, 17 Feb 2007 18:39:50 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702171838510.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, Mike Coleman <tutufan@gmail.com>,
	junkio@cox.net
X-From: git-owner@vger.kernel.org Sat Feb 17 18:39:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HITXP-00011M-VT
	for gcvg-git@gmane.org; Sat, 17 Feb 2007 18:39:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992964AbXBQRjx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Feb 2007 12:39:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992965AbXBQRjx
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 12:39:53 -0500
Received: from mail.gmx.net ([213.165.64.20]:55837 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S2992964AbXBQRjw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 12:39:52 -0500
Received: (qmail invoked by alias); 17 Feb 2007 17:39:50 -0000
X-Provags-ID: V01U2FsdGVkX1/1sl92fdP1UlyDa+S/eLOvEd/jVWw7tjmAOtWrHy
	ayYg==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39994>


If you want to know which revisions contained a certain version
of a file, just say

	git name-rev --file <filename>

which will read the file, and give you a list of revisions
containing a file with the same contents. If <filename> is "-",
it will read the contents from stdin. Of course, this is a really
expensive operation.

This feature was suggested by Mike Coleman.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin-name-rev.c |  118 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 117 insertions(+), 1 deletions(-)

diff --git a/builtin-name-rev.c b/builtin-name-rev.c
index 89ea95d..f08b065 100644
--- a/builtin-name-rev.c
+++ b/builtin-name-rev.c
@@ -3,10 +3,95 @@
 #include "commit.h"
 #include "tag.h"
 #include "refs.h"
+#include "tree-walk.h"
+#include "object-hash.h"
 #include <regex.h>
 
 static const char name_rev_usage[] =
-	"git-name-rev [--tags | --ref-filter=<regexp>] ( --all | --stdin | committish [committish...] )\n";
+	"git-name-rev [--tags | --ref-filter=<regexp>] ( --all | --stdin | committish [committish...] | --file <filename> )\n";
+
+static unsigned char *file_sha1;
+static struct object_hash file_trees = { 0, 0, NULL };
+static struct object_array file_commits = { 0, 0, NULL };
+#define CONTAINS_FILE (1u<<10)
+
+static int get_file(const char *path)
+{
+	int fd, ret;
+	struct stat st;
+
+	file_sha1 = xmalloc(20);
+	if (!strcmp(path, "-"))
+		ret = index_pipe(file_sha1, 0, "blob", 0);
+	else {
+		if ((fd = open(path, O_RDONLY)) < 0 || fstat(fd, &st) < 0)
+			return -1;
+		ret = index_fd(file_sha1, fd, &st, 0, "blob");
+	}
+	if (ret)
+		return ret;
+	if (!parse_object(file_sha1))
+		return error("Object not found for '%s'", path);
+	return 0;
+}
+
+struct object_name {
+	int len;
+	char *name;
+};
+
+static struct object_name *name_file(struct tree *tree)
+{
+	static struct object_name null_name = { 0, NULL };
+	struct object_name *name;
+	struct tree_desc desc;
+	struct name_entry entry;
+
+	if (!tree->object.parsed)
+		parse_tree(tree);
+	else if ((name = lookup_object_in_hash(&tree->object, &file_trees)))
+		return name->len ? name : NULL;
+
+	if (!tree->buffer) {
+		add_object_to_hash(&tree->object, &null_name, &file_trees);
+		return NULL;
+	}
+
+	desc.buf = tree->buffer;
+	desc.size = tree->size;
+
+	while (tree_entry(&desc, &entry))
+		if (!hashcmp(file_sha1, entry.sha1)) {
+			name = xcalloc(sizeof(struct object_name), 1);
+			name->len = entry.pathlen;
+			name->name = xstrdup(entry.path);
+			break;
+		} else if (S_ISDIR(entry.mode)) {
+			struct object *subtree = parse_object(entry.sha1);
+			struct object_name *subname;
+
+			/* just to be safe */
+			if (subtree->type != OBJ_TREE)
+				die("%s is not a tree?",
+						sha1_to_hex(entry.sha1));
+
+			subname = name_file((struct tree *)subtree);
+			if (!subname)
+				continue;
+			name = xcalloc(sizeof(struct object_name), 1);
+			name->len = entry.pathlen + 1 + subname->len;
+			name->name = xmalloc(name->len + 1);
+			memcpy(name->name, entry.path, entry.pathlen);
+			name->name[entry.pathlen] = '/';
+			strncpy(name->name + entry.pathlen + 1,
+					subname->name, subname->len);
+			break;
+		}
+	add_object_to_hash(&tree->object, name ? name : &null_name,
+			&file_trees);
+
+	return name;
+}
 
 typedef struct rev_name {
 	const char *tip_name;
@@ -23,6 +108,7 @@ static void name_rev(struct commit *commit,
 	struct rev_name *name = (struct rev_name *)commit->util;
 	struct commit_list *parents;
 	int parent_number = 1;
+	struct object_name *file_name;
 
 	if (!commit->object.parsed)
 		parse_commit(commit);
@@ -54,6 +140,12 @@ copy_data:
 	} else
 		return;
 
+	if (file_sha1 && !(commit->object.flags & CONTAINS_FILE) &&
+			(file_name = name_file(commit->tree))) {
+		commit->object.flags |= CONTAINS_FILE;
+		add_object_array(&commit->object, NULL, &file_commits);
+	}
+
 	for (parents = commit->parents;
 			parents;
 			parents = parents->next, parent_number++) {
@@ -175,6 +267,14 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 				transform_stdin = 1;
 				cutoff = 0;
 				continue;
+			} else if (!strcmp(*argv, "--file")) {
+				if (argc != 2)
+					usage(name_rev_usage);
+				if (get_file(argv[1]))
+					die("Could not read '%s'", argv[1]);
+				cutoff = 0;
+				argc = 1;
+				continue;
 			}
 			usage(name_rev_usage);
 		}
@@ -202,6 +302,22 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 
 	for_each_ref(name_ref, &data);
 
+	if (file_sha1) {
+		int i;
+		for (i = 0; i < file_commits.nr; i++) {
+			struct commit *commit =
+				(struct commit *)file_commits.objects[i].item;
+			struct rev_name *rev_name = commit->util;
+			struct object_name *obj_name = name_file(commit->tree);
+
+			printf("%s", rev_name->tip_name);
+			if (rev_name->generation)
+				printf("^%d", rev_name->generation);
+			printf(":%s\n", obj_name->name);
+		}
+		return 0;
+	}
+
 	if (transform_stdin) {
 		char buffer[2048];
 		char *p, *p_start;
-- 
1.5.0.2139.gdafc9-dirty
