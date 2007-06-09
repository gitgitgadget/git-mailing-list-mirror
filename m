From: Johan Herland <johan@herland.net>
Subject: [PATCH 3/7] Softrefs: Add git-softref, a builtin command for adding,
 listing and administering softrefs
Date: Sat, 09 Jun 2007 20:22:46 +0200
Message-ID: <200706092022.46933.johan@herland.net>
References: <200706040251.05286.johan@herland.net>
 <200706092019.13185.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 09 20:23:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hx5aQ-0004QP-Jx
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 20:22:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756086AbXFISWx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jun 2007 14:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755219AbXFISWw
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jun 2007 14:22:52 -0400
Received: from smtp.getmail.no ([84.208.20.33]:41376 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753809AbXFISWw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2007 14:22:52 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JJD00L17SE2VR00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 20:22:50 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJD00JMHSDZIH00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 20:22:47 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJD000S1SDYVD50@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 20:22:47 +0200 (CEST)
In-reply-to: <200706092019.13185.johan@herland.net>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49595>

git-softref is meant to be used from shell scripts that need to interact
with the softrefs database. The builtin command provides most of the
functionality present in the softrefs C API.

Documentation to follow in a subsequent patch.

Signed-off-by: Johan Herland <johan@herland.net>
---
 builtin-softref.c |  167 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 167 insertions(+), 0 deletions(-)
 create mode 100644 builtin-softref.c

diff --git a/builtin-softref.c b/builtin-softref.c
new file mode 100644
index 0000000..f95db4e
--- /dev/null
+++ b/builtin-softref.c
@@ -0,0 +1,167 @@
+/*
+ * git softref builtin command
+ *
+ * Add, list and administer soft references (softrefs)
+ *
+ * Copyright (c) 2007 Johan Herland
+ */
+
+#include "cache.h"
+#include "tag.h"
+#include "refs.h"
+#include "softrefs.h"
+
+static const char builtin_softref_usage[] =
+	"git-softref [ --list [<from-object>]"
+		" | --has <from-object> <to-object>"
+		" | --add <from-object> <to-object>"
+		" | --rebuild-tags"
+		" | --merge-unsorted [<softrefs-file>]"
+		" | --merge-sorted <softrefs-file> ]";
+
+static int list_helper(
+		const unsigned char *from_sha1,
+		const unsigned char *to_sha1,
+		void *cb_data)
+{
+	printf("%s %s\n", sha1_to_hex(from_sha1), sha1_to_hex(to_sha1));
+	return 0;
+}
+
+int rebuild_tags_helper(
+		const char *refname,
+		const unsigned char *sha1,
+		int flags,
+		void *cb_data)
+{
+	struct object *o = parse_object(sha1);
+	if (o && o->type == OBJ_TAG) {
+		struct tag *t = (struct tag *) o;
+		struct softref_list **prev = (struct softref_list **) cb_data;
+		struct softref_list *current = xmalloc(sizeof(struct softref_list));
+		current->next = *prev;
+		hashcpy(current->from_sha1, t->tagged->sha1);
+		hashcpy(current->to_sha1,   t->object.sha1);
+		*prev = current;
+	}
+	return 0;
+}
+
+int cmd_softref(int argc, const char **argv, const char *prefix)
+{
+	int i;
+	int show_usage = 0, list = 0, has = 0, add = 0, rebuild_tags = 0,
+	    merge_unsorted = 0, merge_sorted = 0;
+	const char *from_name = NULL, *to_name = NULL, *softrefs_file = NULL;
+	unsigned char from_sha1[20], to_sha1[20];
+
+	git_config(git_default_config);
+
+	for (i = 1; i < argc; i++) {
+		const char *arg = argv[i];
+		if (!strcmp(arg, "--list")) {
+			list = 1;
+			if (i + 1 < argc) /* <from-object> given */
+				from_name = argv[++i];
+		}
+		else if (!strcmp(arg, "--has")) {
+			has = 1;
+			if (i + 2 >= argc)
+				show_usage = error("--has needs two arguments: <from-object> and <to-object>");
+			else {
+				from_name = argv[++i];
+				to_name = argv[++i];
+			}
+		}
+		else if (!strcmp(arg, "--add")) {
+			add = 1;
+			if (i + 2 >= argc)
+				show_usage = error("--add needs two arguments: <from-object> and <to-object>");
+			else {
+				from_name = argv[++i];
+				to_name = argv[++i];
+			}
+		}
+		else if (!strcmp(arg, "--rebuild-tags"))
+			rebuild_tags = 1;
+		else if (!strcmp(arg, "--merge-unsorted")) {
+			merge_unsorted = 1;
+			if (i + 1 < argc) /* <softrefs-file> given */
+				softrefs_file = argv[++i];
+		}
+		else if (!strcmp(arg, "--merge-sorted")) {
+			merge_sorted = 1;
+			if (i + 1 >= argc)
+				show_usage = error("--merge-sorted needs one argument: <softrefs-file>");
+			else
+				softrefs_file = argv[++i];
+		}
+		else
+			show_usage = error("Unknown argument '%s'", arg);
+	}
+
+	/* default to --list if no command given; fail if more than one */
+	switch(list + has + add + rebuild_tags + merge_unsorted + merge_sorted) {
+		case 0: list = 1; break;
+		case 1: break;
+		default: show_usage = 1;
+	}
+	if (show_usage)
+		usage(builtin_softref_usage);
+
+	if (list) {
+		if (from_name) { /* show from_name's softrefs */
+			if (get_sha1(from_name, from_sha1))
+				die("Not a valid object name %s", from_name);
+			if (for_each_softref_with_from(from_sha1, list_helper, 0))
+				die("Error encountered while listing softrefs");
+		}
+		else if (for_each_softref(list_helper, 0)) /* show all softrefs */
+			die("Error encountered while listing softrefs");
+	}
+	else if (has) {
+		if (get_sha1(from_name, from_sha1) || !has_sha1_file(from_sha1))
+			die("Not a valid object name %s", from_name);
+		if (get_sha1(to_name, to_sha1) || !has_sha1_file(to_sha1))
+			die("Not a valid object name %s", to_name);
+		return has_softref(from_sha1, to_sha1);
+	}
+	else if (add) {
+		if (get_sha1(from_name, from_sha1) || !has_sha1_file(from_sha1))
+			die("Not a valid object name %s", from_name);
+		if (get_sha1(to_name, to_sha1) || !has_sha1_file(to_sha1))
+			die("Not a valid object name %s", to_name);
+		if (add_softref(from_sha1, to_sha1) < 0)
+			die("Failed to create softref from %s to %s",
+				from_name, to_name);
+	}
+	else if (rebuild_tags) {
+		/*
+		 * Find all tag objects, and add their corresponding softrefs
+		 *
+		 * For now, we'll have to settle for referenced tag objects as
+		 * it seems to be non-trivial to find _all_ the tag objects in
+		 * the db (including unreachables).
+		 */
+		struct softref_list *to_add = NULL;
+		struct softref_list **p = &to_add;
+		int ret;
+		if (for_each_tag_ref(rebuild_tags_helper, (void *) p)) {
+			delete_softref_list(to_add);
+			die("Failed to find tag objects");
+		}
+		ret = add_softrefs(to_add);
+		delete_softref_list(to_add);
+		if (ret < 0)
+			die("Failed to add softrefs for tag objects");
+		printf("Added %i missing softrefs for tag objects.\n", ret);
+	}
+	else if (merge_unsorted) {
+		return merge_unsorted_softrefs(softrefs_file, 1);
+	}
+	else if (merge_sorted) {
+		return merge_sorted_softrefs(softrefs_file);
+	}
+
+	return 0;
+}
-- 
1.5.2.1.144.gabc40
