From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/3] list-objects: pass callback data to show_objects()
Date: Thu,  1 Sep 2011 15:43:33 -0700
Message-ID: <1314917015-3587-2-git-send-email-gitster@pobox.com>
References: <7vpqjkw3nb.fsf@alter.siamese.dyndns.org>
 <1314917015-3587-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 02 00:43:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzFz5-0000co-Eo
	for gcvg-git-2@lo.gmane.org; Fri, 02 Sep 2011 00:43:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932567Ab1IAWnk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Sep 2011 18:43:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39904 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932202Ab1IAWnj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Sep 2011 18:43:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DB1AB5242
	for <git@vger.kernel.org>; Thu,  1 Sep 2011 18:43:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Ffzv
	NVVZPPTjmfr2BUcT25CQBFw=; b=YFO9G2ETKFSiX+AyjV+Jekv59Hr5DgixUsU2
	64VXpv8Y9rrzO1s9IlzAcEfkWWwmbcseesojYURa/5p3pQPXlWHbx4Q+FuD/v4do
	cqlB9GE4DwO7vJ/fFP7u+9c9mkZaYG7M3llLjQE0yr+/GBQvoF+USAy6BkbDuK6Q
	tiWxUtc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=hJppmz
	Ng0j2nlUf6l+UG58DltvQUcbmYe09neOoShTDJC4Me0G31cJZCUY8aYDxsap53zy
	Pqq3FyJluSnzzgH675Of53s7MEi8MK+CSDwZCb/+o7u56xzloNOiQuz18N/IrpLX
	PNH3Q+bD7Zc123bZOnFjVZ21IYjPw1RW1X1fU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D395D5241
	for <git@vger.kernel.org>; Thu,  1 Sep 2011 18:43:38 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2F16D5240 for
 <git@vger.kernel.org>; Thu,  1 Sep 2011 18:43:38 -0400 (EDT)
X-Mailer: git-send-email 1.7.7.rc0.72.g4b5ea
In-Reply-To: <1314917015-3587-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: D54BC3C8-D4EB-11E0-A503-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180579>

The traverse_commit_list() API takes two callback functions, one to show
commit objects, and the other to show other kinds of objects. Even though
the former has a callback data parameter, so that the callback does not
have to rely on global state, the latter does not.

Give the show_objects() callback the same callback data parameter.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/pack-objects.c |    4 +++-
 builtin/rev-list.c     |   10 +++++++---
 list-objects.c         |   28 +++++++++++++++++-----------
 list-objects.h         |    5 ++---
 upload-pack.c          |    4 +++-
 5 files changed, 32 insertions(+), 19 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index f402a84..fca6cb5 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1936,7 +1936,9 @@ static void show_commit(struct commit *commit, void *data)
 	commit->object.flags |= OBJECT_ADDED;
 }
 
-static void show_object(struct object *obj, const struct name_path *path, const char *last)
+static void show_object(struct object *obj,
+			const struct name_path *path, const char *last,
+			void *data)
 {
 	char *name = path_name(path, last);
 
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index f5ce487..920b91c 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -168,15 +168,19 @@ static void finish_commit(struct commit *commit, void *data)
 	commit->buffer = NULL;
 }
 
-static void finish_object(struct object *obj, const struct name_path *path, const char *name)
+static void finish_object(struct object *obj,
+			  const struct name_path *path, const char *name,
+			  void *cb_data)
 {
 	if (obj->type == OBJ_BLOB && !has_sha1_file(obj->sha1))
 		die("missing blob object '%s'", sha1_to_hex(obj->sha1));
 }
 
-static void show_object(struct object *obj, const struct name_path *path, const char *component)
+static void show_object(struct object *obj,
+			const struct name_path *path, const char *component,
+			void *cb_data)
 {
-	finish_object(obj, path, component);
+	finish_object(obj, path, component, cb_data);
 	show_object_with_name(stdout, obj, path, component);
 }
 
diff --git a/list-objects.c b/list-objects.c
index 0fb44e7..39d80c0 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -12,7 +12,8 @@ static void process_blob(struct rev_info *revs,
 			 struct blob *blob,
 			 show_object_fn show,
 			 struct name_path *path,
-			 const char *name)
+			 const char *name,
+			 void *cb_data)
 {
 	struct object *obj = &blob->object;
 
@@ -23,7 +24,7 @@ static void process_blob(struct rev_info *revs,
 	if (obj->flags & (UNINTERESTING | SEEN))
 		return;
 	obj->flags |= SEEN;
-	show(obj, path, name);
+	show(obj, path, name, cb_data);
 }
 
 /*
@@ -52,7 +53,8 @@ static void process_gitlink(struct rev_info *revs,
 			    const unsigned char *sha1,
 			    show_object_fn show,
 			    struct name_path *path,
-			    const char *name)
+			    const char *name,
+			    void *cb_data)
 {
 	/* Nothing to do */
 }
@@ -62,7 +64,8 @@ static void process_tree(struct rev_info *revs,
 			 show_object_fn show,
 			 struct name_path *path,
 			 struct strbuf *base,
-			 const char *name)
+			 const char *name,
+			 void *cb_data)
 {
 	struct object *obj = &tree->object;
 	struct tree_desc desc;
@@ -80,7 +83,7 @@ static void process_tree(struct rev_info *revs,
 	if (parse_tree(tree) < 0)
 		die("bad tree object %s", sha1_to_hex(obj->sha1));
 	obj->flags |= SEEN;
-	show(obj, path, name);
+	show(obj, path, name, cb_data);
 	me.up = path;
 	me.elem = name;
 	me.elem_len = strlen(name);
@@ -106,14 +109,17 @@ static void process_tree(struct rev_info *revs,
 		if (S_ISDIR(entry.mode))
 			process_tree(revs,
 				     lookup_tree(entry.sha1),
-				     show, &me, base, entry.path);
+				     show, &me, base, entry.path,
+				     cb_data);
 		else if (S_ISGITLINK(entry.mode))
 			process_gitlink(revs, entry.sha1,
-					show, &me, entry.path);
+					show, &me, entry.path,
+					cb_data);
 		else
 			process_blob(revs,
 				     lookup_blob(entry.sha1),
-				     show, &me, entry.path);
+				     show, &me, entry.path,
+				     cb_data);
 	}
 	strbuf_setlen(base, baselen);
 	free(tree->buffer);
@@ -185,17 +191,17 @@ void traverse_commit_list(struct rev_info *revs,
 			continue;
 		if (obj->type == OBJ_TAG) {
 			obj->flags |= SEEN;
-			show_object(obj, NULL, name);
+			show_object(obj, NULL, name, data);
 			continue;
 		}
 		if (obj->type == OBJ_TREE) {
 			process_tree(revs, (struct tree *)obj, show_object,
-				     NULL, &base, name);
+				     NULL, &base, name, data);
 			continue;
 		}
 		if (obj->type == OBJ_BLOB) {
 			process_blob(revs, (struct blob *)obj, show_object,
-				     NULL, name);
+				     NULL, name, data);
 			continue;
 		}
 		die("unknown pending object %s (%s)",
diff --git a/list-objects.h b/list-objects.h
index d65dbf0..3db7bb6 100644
--- a/list-objects.h
+++ b/list-objects.h
@@ -2,11 +2,10 @@
 #define LIST_OBJECTS_H
 
 typedef void (*show_commit_fn)(struct commit *, void *);
-typedef void (*show_object_fn)(struct object *, const struct name_path *, const char *);
-typedef void (*show_edge_fn)(struct commit *);
-
+typedef void (*show_object_fn)(struct object *, const struct name_path *, const char *, void *);
 void traverse_commit_list(struct rev_info *, show_commit_fn, show_object_fn, void *);
 
+typedef void (*show_edge_fn)(struct commit *);
 void mark_edges_uninteresting(struct commit_list *, struct rev_info *, show_edge_fn);
 
 #endif
diff --git a/upload-pack.c b/upload-pack.c
index 970a1eb..6be6259 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -83,7 +83,9 @@ static void show_commit(struct commit *commit, void *data)
 	commit->buffer = NULL;
 }
 
-static void show_object(struct object *obj, const struct name_path *path, const char *component)
+static void show_object(struct object *obj,
+			const struct name_path *path, const char *component,
+			void *cb_data)
 {
 	show_object_with_name(pack_pipe, obj, path, component);
 }
-- 
1.7.7.rc0.72.g4b5ea
