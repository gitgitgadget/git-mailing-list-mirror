From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/3] sha1_file: add the ability to parse objects in "pack
 file format"
Date: Tue, 11 Jul 2006 20:45:31 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607111755180.5623@g5.osdl.org>
References: <20060710230132.GA11132@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.64.0607101623230.5623@g5.osdl.org> <20060711145527.GA32468@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.64.0607111004360.5623@g5.osdl.org> <Pine.LNX.4.64.0607111010320.5623@g5.osdl.org>
 <44B4172B.3070503@stephan-feder.de> <Pine.LNX.4.64.0607111449190.5623@g5.osdl.org>
 <7vejwr3ftl.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0607111656250.5623@g5.osdl.org>
 <Pine.LNX.4.63.0607120226210.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, sf <sf-gmane@stephan-feder.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 12 05:45:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0VfY-0001ls-4h
	for gcvg-git@gmane.org; Wed, 12 Jul 2006 05:45:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932366AbWGLDpp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Jul 2006 23:45:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932372AbWGLDpp
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Jul 2006 23:45:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48776 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932366AbWGLDpo (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Jul 2006 23:45:44 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k6C3jXnW016197
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 11 Jul 2006 20:45:33 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k6C3jVXx022655;
	Tue, 11 Jul 2006 20:45:32 -0700
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0607120226210.29667@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=-6 required=5 tests=PATCH_UNIFIED_DIFF_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.85__
X-MIMEDefang-Filter: osdl$Revision: 1.140 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23757>



On Wed, 12 Jul 2006, Johannes Schindelin wrote:
>> 
> I completely forgot to mention that type_names[] is already declared in 
> object.h. Obviously, it is not really important, but maybe it would be 
> better to obey the DRY principle (think addition of "bind" object type).

Actually, the type_names[] array in object.h is _totally_ different. That 
one is indexed by TYPE_xxx, not OBJ_xxxx.

And yeah, it's stupid to have two different numberings for the same thing, 
and we really really shouldn't. But the OBJ_xxx numbering was originally a 
a totally internal implementation detail to just the pack-files. 

I shouldn't have introduced the new TYPE_xxx macros. I should just have 
used the same OBJ_xxx macros that we use in the pack-file.

Junio: this patch is totally independent from the other patches, and is on 
top of you current "master". It gets rid of TYPE_xxx in favor of the 
OBJ_xxx enums, which are moved from pack.h into object.h.

That way, we can't have people mixing up the two different kinds of type 
enumeration.

(Eventually, I want to get rid of passing around the "type strings" 
entirely, and this will help - no confusion about two different integer 
enumeration).

		Linus

----
diff --git a/blob.c b/blob.c
index 496f270..d1af2e6 100644
--- a/blob.c
+++ b/blob.c
@@ -10,12 +10,12 @@ struct blob *lookup_blob(const unsigned 
 	if (!obj) {
 		struct blob *ret = alloc_blob_node();
 		created_object(sha1, &ret->object);
-		ret->object.type = TYPE_BLOB;
+		ret->object.type = OBJ_BLOB;
 		return ret;
 	}
 	if (!obj->type)
-		obj->type = TYPE_BLOB;
-	if (obj->type != TYPE_BLOB) {
+		obj->type = OBJ_BLOB;
+	if (obj->type != OBJ_BLOB) {
 		error("Object %s is a %s, not a blob",
 		      sha1_to_hex(sha1), typename(obj->type));
 		return NULL;
diff --git a/builtin-diff.c b/builtin-diff.c
index ae901dd..cb38f44 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -285,9 +285,9 @@ int cmd_diff(int argc, const char **argv
 		obj = deref_tag(obj, NULL, 0);
 		if (!obj)
 			die("invalid object '%s' given.", name);
-		if (obj->type == TYPE_COMMIT)
+		if (obj->type == OBJ_COMMIT)
 			obj = &((struct commit *)obj)->tree->object;
-		if (obj->type == TYPE_TREE) {
+		if (obj->type == OBJ_TREE) {
 			if (ARRAY_SIZE(ent) <= ents)
 				die("more than %d trees given: '%s'",
 				    (int) ARRAY_SIZE(ent), name);
@@ -297,7 +297,7 @@ int cmd_diff(int argc, const char **argv
 			ents++;
 			continue;
 		}
-		if (obj->type == TYPE_BLOB) {
+		if (obj->type == OBJ_BLOB) {
 			if (2 <= blobs)
 				die("more than two blobs given: '%s'", name);
 			memcpy(blob[blobs].sha1, obj->sha1, 20);
diff --git a/builtin-fmt-merge-msg.c b/builtin-fmt-merge-msg.c
index 6527482..b3c4f98 100644
--- a/builtin-fmt-merge-msg.c
+++ b/builtin-fmt-merge-msg.c
@@ -177,7 +177,7 @@ static void shortlog(const char *name, u
 	int flags = UNINTERESTING | TREECHANGE | SEEN | SHOWN | ADDED;
 
 	branch = deref_tag(parse_object(sha1), sha1_to_hex(sha1), 40);
-	if (!branch || branch->type != TYPE_COMMIT)
+	if (!branch || branch->type != OBJ_COMMIT)
 		return;
 
 	setup_revisions(0, NULL, rev, NULL);
diff --git a/builtin-grep.c b/builtin-grep.c
index 4c2f7df..a79bac3 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -891,9 +891,9 @@ static int grep_tree(struct grep_opt *op
 static int grep_object(struct grep_opt *opt, const char **paths,
 		       struct object *obj, const char *name)
 {
-	if (obj->type == TYPE_BLOB)
+	if (obj->type == OBJ_BLOB)
 		return grep_sha1(opt, obj->sha1, name);
-	if (obj->type == TYPE_COMMIT || obj->type == TYPE_TREE) {
+	if (obj->type == OBJ_COMMIT || obj->type == OBJ_TREE) {
 		struct tree_desc tree;
 		void *data;
 		int hit;
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 63bad0e..8f32871 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -167,16 +167,16 @@ static void show_commit_list(struct rev_
 		const char *name = pending->name;
 		if (obj->flags & (UNINTERESTING | SEEN))
 			continue;
-		if (obj->type == TYPE_TAG) {
+		if (obj->type == OBJ_TAG) {
 			obj->flags |= SEEN;
 			add_object_array(obj, name, &objects);
 			continue;
 		}
-		if (obj->type == TYPE_TREE) {
+		if (obj->type == OBJ_TREE) {
 			process_tree((struct tree *)obj, &objects, NULL, name);
 			continue;
 		}
-		if (obj->type == TYPE_BLOB) {
+		if (obj->type == OBJ_BLOB) {
 			process_blob((struct blob *)obj, &objects, NULL, name);
 			continue;
 		}
diff --git a/commit.c b/commit.c
index c6bf10d..46d5867 100644
--- a/commit.c
+++ b/commit.c
@@ -56,7 +56,7 @@ static struct commit *check_commit(struc
 				   const unsigned char *sha1,
 				   int quiet)
 {
-	if (obj->type != TYPE_COMMIT) {
+	if (obj->type != OBJ_COMMIT) {
 		if (!quiet)
 			error("Object %s is a %s, not a commit",
 			      sha1_to_hex(sha1), typename(obj->type));
@@ -86,11 +86,11 @@ struct commit *lookup_commit(const unsig
 	if (!obj) {
 		struct commit *ret = alloc_commit_node();
 		created_object(sha1, &ret->object);
-		ret->object.type = TYPE_COMMIT;
+		ret->object.type = OBJ_COMMIT;
 		return ret;
 	}
 	if (!obj->type)
-		obj->type = TYPE_COMMIT;
+		obj->type = OBJ_COMMIT;
 	return check_commit(obj, sha1, 0);
 }
 
diff --git a/describe.c b/describe.c
index 8e68d5d..324ca89 100644
--- a/describe.c
+++ b/describe.c
@@ -67,7 +67,7 @@ static int get_name(const char *path, co
 	 * Otherwise only annotated tags are used.
 	 */
 	if (!strncmp(path, "refs/tags/", 10)) {
-		if (object->type == TYPE_TAG)
+		if (object->type == OBJ_TAG)
 			prio = 2;
 		else
 			prio = 1;
diff --git a/fetch-pack.c b/fetch-pack.c
index f2c51eb..b7824db 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -46,7 +46,7 @@ static int rev_list_insert_ref(const cha
 {
 	struct object *o = deref_tag(parse_object(sha1), path, 0);
 
-	if (o && o->type == TYPE_COMMIT)
+	if (o && o->type == OBJ_COMMIT)
 		rev_list_push((struct commit *)o, SEEN);
 
 	return 0;
@@ -256,14 +256,14 @@ static int mark_complete(const char *pat
 {
 	struct object *o = parse_object(sha1);
 
-	while (o && o->type == TYPE_TAG) {
+	while (o && o->type == OBJ_TAG) {
 		struct tag *t = (struct tag *) o;
 		if (!t->tagged)
 			break; /* broken repository */
 		o->flags |= COMPLETE;
 		o = parse_object(t->tagged->sha1);
 	}
-	if (o && o->type == TYPE_COMMIT) {
+	if (o && o->type == OBJ_COMMIT) {
 		struct commit *commit = (struct commit *)o;
 		commit->object.flags |= COMPLETE;
 		insert_by_date(commit, &complete);
@@ -357,7 +357,7 @@ static int everything_local(struct ref *
 		 * in sync with the other side at some time after
 		 * that (it is OK if we guess wrong here).
 		 */
-		if (o->type == TYPE_COMMIT) {
+		if (o->type == OBJ_COMMIT) {
 			struct commit *commit = (struct commit *)o;
 			if (!cutoff || cutoff < commit->date)
 				cutoff = commit->date;
@@ -376,7 +376,7 @@ static int everything_local(struct ref *
 		struct object *o = deref_tag(lookup_object(ref->old_sha1),
 					     NULL, 0);
 
-		if (!o || o->type != TYPE_COMMIT || !(o->flags & COMPLETE))
+		if (!o || o->type != OBJ_COMMIT || !(o->flags & COMPLETE))
 			continue;
 
 		if (!(o->flags & SEEN)) {
diff --git a/fsck-objects.c b/fsck-objects.c
index ef54a8a..e167f41 100644
--- a/fsck-objects.c
+++ b/fsck-objects.c
@@ -297,13 +297,13 @@ static int fsck_sha1(unsigned char *sha1
 	if (obj->flags & SEEN)
 		return 0;
 	obj->flags |= SEEN;
-	if (obj->type == TYPE_BLOB)
+	if (obj->type == OBJ_BLOB)
 		return 0;
-	if (obj->type == TYPE_TREE)
+	if (obj->type == OBJ_TREE)
 		return fsck_tree((struct tree *) obj);
-	if (obj->type == TYPE_COMMIT)
+	if (obj->type == OBJ_COMMIT)
 		return fsck_commit((struct commit *) obj);
-	if (obj->type == TYPE_TAG)
+	if (obj->type == OBJ_TAG)
 		return fsck_tag((struct tag *) obj);
 	/* By now, parse_object() would've returned NULL instead. */
 	return objerror(obj, "unknown type '%d' (internal fsck error)", obj->type);
@@ -472,7 +472,7 @@ static int fsck_cache_tree(struct cache_
 		}
 		mark_reachable(obj, REACHABLE);
 		obj->used = 1;
-		if (obj->type != TYPE_TREE)
+		if (obj->type != OBJ_TREE)
 			err |= objerror(obj, "non-tree in cache-tree");
 	}
 	for (i = 0; i < it->subtree_nr; i++)
diff --git a/http-push.c b/http-push.c
index f761584..4768619 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1784,16 +1784,16 @@ static int get_delta(struct rev_info *re
 
 		if (obj->flags & (UNINTERESTING | SEEN))
 			continue;
-		if (obj->type == TYPE_TAG) {
+		if (obj->type == OBJ_TAG) {
 			obj->flags |= SEEN;
 			p = add_one_object(obj, p);
 			continue;
 		}
-		if (obj->type == TYPE_TREE) {
+		if (obj->type == OBJ_TREE) {
 			p = process_tree((struct tree *)obj, p, NULL, name);
 			continue;
 		}
-		if (obj->type == TYPE_BLOB) {
+		if (obj->type == OBJ_BLOB) {
 			p = process_blob((struct blob *)obj, p, NULL, name);
 			continue;
 		}
@@ -1960,12 +1960,12 @@ static int ref_newer(const unsigned char
 	 * old.  Otherwise we require --force.
 	 */
 	o = deref_tag(parse_object(old_sha1), NULL, 0);
-	if (!o || o->type != TYPE_COMMIT)
+	if (!o || o->type != OBJ_COMMIT)
 		return 0;
 	old = (struct commit *) o;
 
 	o = deref_tag(parse_object(new_sha1), NULL, 0);
-	if (!o || o->type != TYPE_COMMIT)
+	if (!o || o->type != OBJ_COMMIT)
 		return 0;
 	new = (struct commit *) o;
 
@@ -2044,7 +2044,7 @@ static void add_remote_info_ref(struct r
 	fwrite_buffer(ref_info, 1, len, buf);
 	free(ref_info);
 
-	if (o->type == TYPE_TAG) {
+	if (o->type == OBJ_TAG) {
 		o = deref_tag(o, ls->dentry_name, 0);
 		if (o) {
 			len = strlen(ls->dentry_name) + 45;
diff --git a/name-rev.c b/name-rev.c
index 083d067..f92f14e 100644
--- a/name-rev.c
+++ b/name-rev.c
@@ -84,14 +84,14 @@ static int name_ref(const char *path, co
 	if (tags_only && strncmp(path, "refs/tags/", 10))
 		return 0;
 
-	while (o && o->type == TYPE_TAG) {
+	while (o && o->type == OBJ_TAG) {
 		struct tag *t = (struct tag *) o;
 		if (!t->tagged)
 			break; /* broken repository */
 		o = parse_object(t->tagged->sha1);
 		deref = 1;
 	}
-	if (o && o->type == TYPE_COMMIT) {
+	if (o && o->type == OBJ_COMMIT) {
 		struct commit *commit = (struct commit *)o;
 
 		if (!strncmp(path, "refs/heads/", 11))
@@ -111,7 +111,7 @@ static const char* get_rev_name(struct o
 	struct rev_name *n;
 	struct commit *c;
 
-	if (o->type != TYPE_COMMIT)
+	if (o->type != OBJ_COMMIT)
 		return "undefined";
 	c = (struct commit *) o;
 	n = c->util;
@@ -172,7 +172,7 @@ int main(int argc, char **argv)
 		}
 
 		o = deref_tag(parse_object(sha1), *argv, 0);
-		if (!o || o->type != TYPE_COMMIT) {
+		if (!o || o->type != OBJ_COMMIT) {
 			fprintf(stderr, "Could not get commit for %s. Skipping.\n",
 					*argv);
 			continue;
diff --git a/object.c b/object.c
index 37277f9..e7ca56e 100644
--- a/object.c
+++ b/object.c
@@ -19,7 +19,8 @@ struct object *get_indexed_object(unsign
 }
 
 const char *type_names[] = {
-	"none", "blob", "tree", "commit", "bad"
+	"none", "commit", "tree", "blob", "tag", 
+	"bad type 5", "bad type 6", "delta", "bad",
 };
 
 static unsigned int hash_obj(struct object *obj, unsigned int n)
@@ -88,7 +89,7 @@ void created_object(const unsigned char 
 {
 	obj->parsed = 0;
 	obj->used = 0;
-	obj->type = TYPE_NONE;
+	obj->type = OBJ_NONE;
 	obj->flags = 0;
 	memcpy(obj->sha1, sha1, 20);
 
@@ -131,7 +132,7 @@ struct object *lookup_unknown_object(con
 	if (!obj) {
 		union any_object *ret = xcalloc(1, sizeof(*ret));
 		created_object(sha1, &ret->object);
-		ret->object.type = TYPE_NONE;
+		ret->object.type = OBJ_NONE;
 		return &ret->object;
 	}
 	return obj;
diff --git a/object.h b/object.h
index e0125e1..7893e94 100644
--- a/object.h
+++ b/object.h
@@ -24,12 +24,19 @@ struct object_array {
 #define TYPE_BITS   3
 #define FLAG_BITS  27
 
-#define TYPE_NONE   0
-#define TYPE_BLOB   1
-#define TYPE_TREE   2
-#define TYPE_COMMIT 3
-#define TYPE_TAG    4
-#define TYPE_BAD    5
+/*
+ * The object type is stored in 3 bits.
+ */
+enum object_type {
+	OBJ_NONE = 0,
+	OBJ_COMMIT = 1,
+	OBJ_TREE = 2,
+	OBJ_BLOB = 3,
+	OBJ_TAG = 4,
+	/* 5/6 for future expansion */
+	OBJ_DELTA = 7,
+	OBJ_BAD,
+};
 
 struct object {
 	unsigned parsed : 1;
@@ -40,14 +47,14 @@ struct object {
 };
 
 extern int track_object_refs;
-extern const char *type_names[];
+extern const char *type_names[9];
 
 extern unsigned int get_max_object_index(void);
 extern struct object *get_indexed_object(unsigned int);
 
 static inline const char *typename(unsigned int type)
 {
-	return type_names[type > TYPE_TAG ? TYPE_BAD : type];
+	return type_names[type > OBJ_TAG ? OBJ_BAD : type];
 }
 
 extern struct object_refs *lookup_object_refs(struct object *);
diff --git a/pack-check.c b/pack-check.c
diff --git a/pack.h b/pack.h
index 694e0c5..eb07b03 100644
--- a/pack.h
+++ b/pack.h
@@ -1,20 +1,7 @@
 #ifndef PACK_H
 #define PACK_H
 
-/*
- * The packed object type is stored in 3 bits.
- * The type value 0 is a reserved prefix if ever there is more than 7
- * object types, or any future format extensions.
- */
-enum object_type {
-	OBJ_EXT = 0,
-	OBJ_COMMIT = 1,
-	OBJ_TREE = 2,
-	OBJ_BLOB = 3,
-	OBJ_TAG = 4,
-	/* 5/6 for future expansion */
-	OBJ_DELTA = 7,
-};
+#include "object.h"
 
 /*
  * Packed object header
diff --git a/revision.c b/revision.c
index 7df9089..874e349 100644
--- a/revision.c
+++ b/revision.c
@@ -135,7 +135,7 @@ static struct commit *handle_commit(stru
 	/*
 	 * Tag object? Look what it points to..
 	 */
-	while (object->type == TYPE_TAG) {
+	while (object->type == OBJ_TAG) {
 		struct tag *tag = (struct tag *) object;
 		if (revs->tag_objects && !(flags & UNINTERESTING))
 			add_pending_object(revs, object, tag->tag);
@@ -148,7 +148,7 @@ static struct commit *handle_commit(stru
 	 * Commit object? Just return it, we'll do all the complex
 	 * reachability crud.
 	 */
-	if (object->type == TYPE_COMMIT) {
+	if (object->type == OBJ_COMMIT) {
 		struct commit *commit = (struct commit *)object;
 		if (parse_commit(commit) < 0)
 			die("unable to parse commit %s", name);
@@ -164,7 +164,7 @@ static struct commit *handle_commit(stru
 	 * Tree object? Either mark it uniniteresting, or add it
 	 * to the list of objects to look at later..
 	 */
-	if (object->type == TYPE_TREE) {
+	if (object->type == OBJ_TREE) {
 		struct tree *tree = (struct tree *)object;
 		if (!revs->tree_objects)
 			return NULL;
@@ -179,7 +179,7 @@ static struct commit *handle_commit(stru
 	/*
 	 * Blob object? You know the drill by now..
 	 */
-	if (object->type == TYPE_BLOB) {
+	if (object->type == OBJ_BLOB) {
 		struct blob *blob = (struct blob *)object;
 		if (!revs->blob_objects)
 			return NULL;
@@ -494,11 +494,11 @@ static int add_parents_only(struct rev_i
 		return 0;
 	while (1) {
 		it = get_reference(revs, arg, sha1, 0);
-		if (it->type != TYPE_TAG)
+		if (it->type != OBJ_TAG)
 			break;
 		memcpy(sha1, ((struct tag*)it)->tagged->sha1, 20);
 	}
-	if (it->type != TYPE_COMMIT)
+	if (it->type != OBJ_COMMIT)
 		return 0;
 	commit = (struct commit *)it;
 	for (parents = commit->parents; parents; parents = parents->next) {
diff --git a/send-pack.c b/send-pack.c
index 4019a4b..10bc8bc 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -151,12 +151,12 @@ static int ref_newer(const unsigned char
 	 * old.  Otherwise we require --force.
 	 */
 	o = deref_tag(parse_object(old_sha1), NULL, 0);
-	if (!o || o->type != TYPE_COMMIT)
+	if (!o || o->type != OBJ_COMMIT)
 		return 0;
 	old = (struct commit *) o;
 
 	o = deref_tag(parse_object(new_sha1), NULL, 0);
-	if (!o || o->type != TYPE_COMMIT)
+	if (!o || o->type != OBJ_COMMIT)
 		return 0;
 	new = (struct commit *) o;
 
diff --git a/server-info.c b/server-info.c
index fdfe05a..7df628f 100644
--- a/server-info.c
+++ b/server-info.c
@@ -12,7 +12,7 @@ static int add_info_ref(const char *path
 	struct object *o = parse_object(sha1);
 
 	fprintf(info_ref_fp, "%s	%s\n", sha1_to_hex(sha1), path);
-	if (o->type == TYPE_TAG) {
+	if (o->type == OBJ_TAG) {
 		o = deref_tag(o, path, 0);
 		if (o)
 			fprintf(info_ref_fp, "%s	%s^{}\n",
diff --git a/sha1_name.c b/sha1_name.c
index f2cbafa..5fe8e5d 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -381,13 +381,13 @@ static int peel_onion(const char *name, 
 
 	sp++; /* beginning of type name, or closing brace for empty */
 	if (!strncmp(commit_type, sp, 6) && sp[6] == '}')
-		expected_type = TYPE_COMMIT;
+		expected_type = OBJ_COMMIT;
 	else if (!strncmp(tree_type, sp, 4) && sp[4] == '}')
-		expected_type = TYPE_TREE;
+		expected_type = OBJ_TREE;
 	else if (!strncmp(blob_type, sp, 4) && sp[4] == '}')
-		expected_type = TYPE_BLOB;
+		expected_type = OBJ_BLOB;
 	else if (sp[0] == '}')
-		expected_type = TYPE_NONE;
+		expected_type = OBJ_NONE;
 	else
 		return -1;
 
@@ -416,9 +416,9 @@ static int peel_onion(const char *name, 
 				memcpy(sha1, o->sha1, 20);
 				return 0;
 			}
-			if (o->type == TYPE_TAG)
+			if (o->type == OBJ_TAG)
 				o = ((struct tag*) o)->tagged;
-			else if (o->type == TYPE_COMMIT)
+			else if (o->type == OBJ_COMMIT)
 				o = &(((struct commit *) o)->tree->object);
 			else
 				return error("%.*s: expected %s type, but the object dereferences to %s type",
diff --git a/tag.c b/tag.c
index 74d0dab..864ac1b 100644
--- a/tag.c
+++ b/tag.c
@@ -5,7 +5,7 @@ const char *tag_type = "tag";
 
 struct object *deref_tag(struct object *o, const char *warn, int warnlen)
 {
-	while (o && o->type == TYPE_TAG)
+	while (o && o->type == OBJ_TAG)
 		o = parse_object(((struct tag *)o)->tagged->sha1);
 	if (!o && warn) {
 		if (!warnlen)
@@ -21,12 +21,12 @@ struct tag *lookup_tag(const unsigned ch
         if (!obj) {
                 struct tag *ret = alloc_tag_node();
                 created_object(sha1, &ret->object);
-                ret->object.type = TYPE_TAG;
+                ret->object.type = OBJ_TAG;
                 return ret;
         }
 	if (!obj->type)
-		obj->type = TYPE_TAG;
-        if (obj->type != TYPE_TAG) {
+		obj->type = OBJ_TAG;
+        if (obj->type != OBJ_TAG) {
                 error("Object %s is a %s, not a tree",
                       sha1_to_hex(sha1), typename(obj->type));
                 return NULL;
diff --git a/tree.c b/tree.c
index 1023655..a6032e3 100644
--- a/tree.c
+++ b/tree.c
@@ -131,12 +131,12 @@ struct tree *lookup_tree(const unsigned 
 	if (!obj) {
 		struct tree *ret = alloc_tree_node();
 		created_object(sha1, &ret->object);
-		ret->object.type = TYPE_TREE;
+		ret->object.type = OBJ_TREE;
 		return ret;
 	}
 	if (!obj->type)
-		obj->type = TYPE_TREE;
-	if (obj->type != TYPE_TREE) {
+		obj->type = OBJ_TREE;
+	if (obj->type != OBJ_TREE) {
 		error("Object %s is a %s, not a tree",
 		      sha1_to_hex(sha1), typename(obj->type));
 		return NULL;
@@ -216,11 +216,11 @@ struct tree *parse_tree_indirect(const u
 	do {
 		if (!obj)
 			return NULL;
-		if (obj->type == TYPE_TREE)
+		if (obj->type == OBJ_TREE)
 			return (struct tree *) obj;
-		else if (obj->type == TYPE_COMMIT)
+		else if (obj->type == OBJ_COMMIT)
 			obj = &(((struct commit *) obj)->tree->object);
-		else if (obj->type == TYPE_TAG)
+		else if (obj->type == OBJ_TAG)
 			obj = ((struct tag *) obj)->tagged;
 		else
 			return NULL;
diff --git a/upload-pack.c b/upload-pack.c
index b18eb9b..2e820c9 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -326,7 +326,7 @@ static int got_sha1(char *hex, unsigned 
 			o = parse_object(sha1);
 		if (!o)
 			die("oops (%s)", sha1_to_hex(sha1));
-		if (o->type == TYPE_COMMIT) {
+		if (o->type == OBJ_COMMIT) {
 			struct commit_list *parents;
 			if (o->flags & THEY_HAVE)
 				return 0;
@@ -457,7 +457,7 @@ static int send_ref(const char *refname,
 		o->flags |= OUR_REF;
 		nr_our_refs++;
 	}
-	if (o->type == TYPE_TAG) {
+	if (o->type == OBJ_TAG) {
 		o = deref_tag(o, refname, 0);
 		packet_write(1, "%s %s^{}\n", sha1_to_hex(o->sha1), refname);
 	}
