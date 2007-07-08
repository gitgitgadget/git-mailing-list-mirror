From: skimo@liacs.nl
Subject: [PATCH 2/4] export add_ref_decoration
Date: Sun,  8 Jul 2007 18:23:25 +0200
Message-ID: <11839118083737-git-send-email-skimo@liacs.nl>
References: <11839118073186-git-send-email-skimo@liacs.nl>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 08 18:23:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7ZY2-0003Nk-Ir
	for gcvg-git@gmane.org; Sun, 08 Jul 2007 18:23:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754456AbXGHQXp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jul 2007 12:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754604AbXGHQXj
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jul 2007 12:23:39 -0400
Received: from rhodium.liacs.nl ([132.229.131.16]:60201 "EHLO rhodium.liacs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754560AbXGHQXh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2007 12:23:37 -0400
Received: from pc117b.liacs.nl (pc117b.liacs.nl [132.229.129.143])
	by rhodium.liacs.nl (8.13.0/8.13.0/LIACS 1.4) with ESMTP id l68GNSj6031440;
	Sun, 8 Jul 2007 18:23:33 +0200
Received: by pc117b.liacs.nl (Postfix, from userid 17122)
	id 6E7C93C00C; Sun,  8 Jul 2007 18:23:28 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.rc0.63.gc956
In-Reply-To: <11839118073186-git-send-email-skimo@liacs.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51890>

From: Sven Verdoolaege <skimo@kotnet.org>

add_ref_decoration is also useful outside of git-log.
Since the name_decoration declaration appears in commit.h,
the function is moved to commit.c.

Signed-off-by: Sven Verdoolaege <skimo@kotnet.org>
---
 builtin-log.c |   25 -------------------------
 commit.c      |   27 +++++++++++++++++++++++++++
 commit.h      |    3 +++
 log-tree.c    |    2 --
 4 files changed, 30 insertions(+), 27 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 13bae31..c14eea5 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -21,31 +21,6 @@ static const char *fmt_patch_subject_prefix = "PATCH";
 /* this is in builtin-diff.c */
 void add_head(struct rev_info *revs);
 
-static void add_name_decoration(const char *prefix, const char *name, struct object *obj)
-{
-	int plen = strlen(prefix);
-	int nlen = strlen(name);
-	struct name_decoration *res = xmalloc(sizeof(struct name_decoration) + plen + nlen);
-	memcpy(res->name, prefix, plen);
-	memcpy(res->name + plen, name, nlen + 1);
-	res->next = add_decoration(&name_decoration, obj, res);
-}
-
-static int add_ref_decoration(const char *refname, const unsigned char *sha1, int flags, void *cb_data)
-{
-	struct object *obj = parse_object(sha1);
-	if (!obj)
-		return 0;
-	add_name_decoration("", refname, obj);
-	while (obj->type == OBJ_TAG) {
-		obj = ((struct tag *)obj)->tagged;
-		if (!obj)
-			break;
-		add_name_decoration("tag: ", refname, obj);
-	}
-	return 0;
-}
-
 static void cmd_log_init(int argc, const char **argv, const char *prefix,
 		      struct rev_info *rev)
 {
diff --git a/commit.c b/commit.c
index 03436b1..24d7dd4 100644
--- a/commit.c
+++ b/commit.c
@@ -1553,3 +1553,30 @@ int in_merge_bases(struct commit *commit, struct commit **reference, int num)
 	free_commit_list(bases);
 	return ret;
 }
+
+struct decoration name_decoration = { "object names" };
+
+static void add_name_decoration(const char *prefix, const char *name, struct object *obj)
+{
+	int plen = strlen(prefix);
+	int nlen = strlen(name);
+	struct name_decoration *res = xmalloc(sizeof(struct name_decoration) + plen + nlen);
+	memcpy(res->name, prefix, plen);
+	memcpy(res->name + plen, name, nlen + 1);
+	res->next = add_decoration(&name_decoration, obj, res);
+}
+
+int add_ref_decoration(const char *refname, const unsigned char *sha1, int flags, void *cb_data)
+{
+	struct object *obj = parse_object(sha1);
+	if (!obj)
+		return 0;
+	add_name_decoration("", refname, obj);
+	while (obj->type == OBJ_TAG) {
+		obj = ((struct tag *)obj)->tagged;
+		if (!obj)
+			break;
+		add_name_decoration("tag: ", refname, obj);
+	}
+	return 0;
+}
diff --git a/commit.h b/commit.h
index 467872e..bf23535 100644
--- a/commit.h
+++ b/commit.h
@@ -122,4 +122,7 @@ extern struct commit_list *get_shallow_commits(struct object_array *heads,
 		int depth, int shallow_flag, int not_shallow_flag);
 
 int in_merge_bases(struct commit *, struct commit **, int);
+
+extern int add_ref_decoration(const char *refname, const unsigned char *sha1, int flags, void *cb_data);
+
 #endif /* COMMIT_H */
diff --git a/log-tree.c b/log-tree.c
index 8624d5a..b69f029 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -4,8 +4,6 @@
 #include "log-tree.h"
 #include "reflog-walk.h"
 
-struct decoration name_decoration = { "object names" };
-
 static void show_parents(struct commit *commit, int abbrev)
 {
 	struct commit_list *p;
-- 
1.5.3.rc0.68.geec71-dirty
