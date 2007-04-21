From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH 2/4] add support for storing the mode in object_array
Date: Sat, 21 Apr 2007 14:26:18 +0200
Message-ID: <11771583802243-git-send-email-mkoegler@auto.tuwien.ac.at>
References: 20070421122348.GA29174@auto.tuwien.ac.at <1177158380197-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Apr 21 14:26:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfEfh-0000Vy-G6
	for gcvg-git@gmane.org; Sat, 21 Apr 2007 14:26:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030782AbXDUM0Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Apr 2007 08:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030805AbXDUM0Z
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Apr 2007 08:26:25 -0400
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:37238 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030782AbXDUM0X (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Apr 2007 08:26:23 -0400
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 4FDB273EA3DF;
	Sat, 21 Apr 2007 14:26:22 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3DSIA6dk2L9U; Sat, 21 Apr 2007 14:26:20 +0200 (CEST)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 7862273E0A25; Sat, 21 Apr 2007 14:26:20 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.5
In-Reply-To: <1177158380197-git-send-email-mkoegler@auto.tuwien.ac.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45169>

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
 builtin-bundle.c   |    2 +-
 builtin-grep.c     |    2 +-
 builtin-log.c      |    2 +-
 builtin-name-rev.c |    2 +-
 builtin-reflog.c   |    8 ++++----
 list-objects.c     |    2 +-
 object.c           |    3 ++-
 object.h           |    3 ++-
 revision.c         |    6 +++---
 shallow.c          |    2 +-
 upload-pack.c      |    8 ++++----
 11 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/builtin-bundle.c b/builtin-bundle.c
index d1635a0..97cce9e 100644
--- a/builtin-bundle.c
+++ b/builtin-bundle.c
@@ -155,7 +155,7 @@ static int verify_bundle(struct bundle_header *header, int verbose)
 	memset(&refs, 0, sizeof(struct object_array));
 	for (i = 0; i < revs.pending.nr; i++) {
 		struct object_array_entry *e = revs.pending.objects + i;
-		add_object_array(e->item, e->name, &refs);
+		add_object_array(e->item, e->name, S_IFINVALID, &refs);
 	}
 
 	prepare_revision_walk(&revs);
diff --git a/builtin-grep.c b/builtin-grep.c
index f2ee20f..3690f7e 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -677,7 +677,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			struct object *object = parse_object(sha1);
 			if (!object)
 				die("bad object %s", arg);
-			add_object_array(object, arg, &list);
+			add_object_array(object, arg, S_IFINVALID, &list);
 			continue;
 		}
 		if (!strcmp(arg, "--")) {
diff --git a/builtin-log.c b/builtin-log.c
index 1ca3aa9..ca12791 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -202,7 +202,7 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 		case OBJ_COMMIT:
 			rev.pending.nr = rev.pending.alloc = 0;
 			rev.pending.objects = NULL;
-			add_object_array(o, name, &rev.pending);
+			add_object_array(o, name, S_IFINVALID, &rev.pending);
 			ret = cmd_log_walk(&rev);
 			break;
 		default:
diff --git a/builtin-name-rev.c b/builtin-name-rev.c
index 0351185..748cc0c 100644
--- a/builtin-name-rev.c
+++ b/builtin-name-rev.c
@@ -202,7 +202,7 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 		if (cutoff > commit->date)
 			cutoff = commit->date;
 
-		add_object_array((struct object *)commit, *argv, &revs);
+		add_object_array((struct object *)commit, *argv, S_IFINVALID, &revs);
 	}
 
 	for_each_ref(name_ref, &data);
diff --git a/builtin-reflog.c b/builtin-reflog.c
index 4c39f1d..a346e8e 100644
--- a/builtin-reflog.c
+++ b/builtin-reflog.c
@@ -101,8 +101,8 @@ static int commit_is_complete(struct commit *commit)
 	 */
 	memset(&study, 0, sizeof(study));
 	memset(&found, 0, sizeof(found));
-	add_object_array(&commit->object, NULL, &study);
-	add_object_array(&commit->object, NULL, &found);
+	add_object_array(&commit->object, NULL, S_IFINVALID, &study);
+	add_object_array(&commit->object, NULL, S_IFINVALID, &found);
 	commit->object.flags |= STUDYING;
 	while (study.nr) {
 		struct commit *c;
@@ -123,8 +123,8 @@ static int commit_is_complete(struct commit *commit)
 			if (p->object.flags & STUDYING)
 				continue;
 			p->object.flags |= STUDYING;
-			add_object_array(&p->object, NULL, &study);
-			add_object_array(&p->object, NULL, &found);
+			add_object_array(&p->object, NULL, S_IFINVALID, &study);
+			add_object_array(&p->object, NULL, S_IFINVALID, &found);
 		}
 	}
 	if (!is_incomplete) {
diff --git a/list-objects.c b/list-objects.c
index 2ba2c95..1f862bc 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -118,7 +118,7 @@ void traverse_commit_list(struct rev_info *revs,
 			continue;
 		if (obj->type == OBJ_TAG) {
 			obj->flags |= SEEN;
-			add_object_array(obj, name, &objects);
+			add_object_array(obj, name, S_IFINVALID, &objects);
 			continue;
 		}
 		if (obj->type == OBJ_TREE) {
diff --git a/object.c b/object.c
index 78a44a6..11c614e 100644
--- a/object.c
+++ b/object.c
@@ -238,7 +238,7 @@ int object_list_contains(struct object_list *list, struct object *obj)
 	return 0;
 }
 
-void add_object_array(struct object *obj, const char *name, struct object_array *array)
+void add_object_array(struct object *obj, const char *name, unsigned mode, struct object_array *array)
 {
 	unsigned nr = array->nr;
 	unsigned alloc = array->alloc;
@@ -252,5 +252,6 @@ void add_object_array(struct object *obj, const char *name, struct object_array
 	}
 	objects[nr].item = obj;
 	objects[nr].name = name;
+	objects[nr].mode = mode;
 	array->nr = ++nr;
 }
diff --git a/object.h b/object.h
index bdbbc18..b29268a 100644
--- a/object.h
+++ b/object.h
@@ -17,6 +17,7 @@ struct object_array {
 	struct object_array_entry {
 		struct object *item;
 		const char *name;
+		unsigned mode;
 	} *objects;
 };
 
@@ -76,6 +77,6 @@ unsigned object_list_length(struct object_list *list);
 int object_list_contains(struct object_list *list, struct object *obj);
 
 /* Object array handling .. */
-void add_object_array(struct object *obj, const char *name, struct object_array *array);
+void add_object_array(struct object *obj, const char *name, unsigned mode, struct object_array *array);
 
 #endif /* OBJECT_H */
diff --git a/revision.c b/revision.c
index 8f0ed77..b2df974 100644
--- a/revision.c
+++ b/revision.c
@@ -39,7 +39,7 @@ void add_object(struct object *obj,
 		struct name_path *path,
 		const char *name)
 {
-	add_object_array(obj, path_name(path, name), p);
+	add_object_array(obj, path_name(path, name), S_IFINVALID, p);
 }
 
 static void mark_blob_uninteresting(struct blob *blob)
@@ -118,7 +118,7 @@ void add_pending_object(struct rev_info *revs, struct object *obj, const char *n
 {
 	if (revs->no_walk && (obj->flags & UNINTERESTING))
 		die("object ranges do not make sense when not walking revisions");
-	add_object_array(obj, name, &revs->pending);
+	add_object_array(obj, name, S_IFINVALID, &revs->pending);
 	if (revs->reflog_info && obj->type == OBJ_COMMIT)
 		add_reflog_for_walk(revs->reflog_info,
 				(struct commit *)obj, name);
@@ -1461,7 +1461,7 @@ struct commit *get_revision(struct rev_info *revs)
 			continue;
 		p->flags |= CHILD_SHOWN;
 		gc_boundary(&revs->boundary_commits);
-		add_object_array(p, NULL, &revs->boundary_commits);
+		add_object_array(p, NULL, S_IFINVALID, &revs->boundary_commits);
 	}
 
 	return c;
diff --git a/shallow.c b/shallow.c
index d178689..d320a13 100644
--- a/shallow.c
+++ b/shallow.c
@@ -87,7 +87,7 @@ struct commit_list *get_shallow_commits(struct object_array *heads, int depth,
 			if (cur_depth < depth) {
 				if (p->next)
 					add_object_array(&p->item->object,
-							NULL, &stack);
+							NULL, S_IFINVALID, &stack);
 				else {
 					commit = p->item;
 					cur_depth = *(int *)commit->util;
diff --git a/upload-pack.c b/upload-pack.c
index 9c39231..1f12d29 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -378,7 +378,7 @@ static int got_sha1(char *hex, unsigned char *sha1)
 			parents->item->object.flags |= THEY_HAVE;
 	}
 	if (!we_knew_they_have) {
-		add_object_array(o, NULL, &have_obj);
+		add_object_array(o, NULL, S_IFINVALID, &have_obj);
 		return 1;
 	}
 	return 0;
@@ -523,7 +523,7 @@ static void receive_needs(void)
 			if (!object)
 				die("did not find object for %s", line);
 			object->flags |= CLIENT_SHALLOW;
-			add_object_array(object, NULL, &shallows);
+			add_object_array(object, NULL, S_IFINVALID, &shallows);
 			continue;
 		}
 		if (!prefixcmp(line, "deepen ")) {
@@ -564,7 +564,7 @@ static void receive_needs(void)
 			die("git-upload-pack: not our ref %s", line+5);
 		if (!(o->flags & WANTED)) {
 			o->flags |= WANTED;
-			add_object_array(o, NULL, &want_obj);
+			add_object_array(o, NULL, S_IFINVALID, &want_obj);
 		}
 	}
 	if (depth == 0 && shallows.nr == 0)
@@ -598,7 +598,7 @@ static void receive_needs(void)
 				parents = ((struct commit *)object)->parents;
 				while (parents) {
 					add_object_array(&parents->item->object,
-							NULL, &want_obj);
+							NULL, S_IFINVALID, &want_obj);
 					parents = parents->next;
 				}
 			}
-- 
1.4.4.4
