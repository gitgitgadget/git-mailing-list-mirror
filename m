From: Linus Torvalds <torvalds@osdl.org>
Subject: Shrink "struct object" a bit
Date: Wed, 14 Jun 2006 16:45:13 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606141630570.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Jun 15 01:45:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fqf3E-0007rd-Ft
	for gcvg-git@gmane.org; Thu, 15 Jun 2006 01:45:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965040AbWFNXp3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Jun 2006 19:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965042AbWFNXp3
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jun 2006 19:45:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:37321 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965040AbWFNXp2 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Jun 2006 19:45:28 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5ENjKgt020530
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 14 Jun 2006 16:45:22 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5ENjDiB025652;
	Wed, 14 Jun 2006 16:45:16 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.76__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21873>


This shrinks "struct object" by a small amount, by getting rid of the 
"struct type *" pointer and replacing it with a 3-bit bitfield instead.

In addition, we merge the bitfields and the "flags" field, which 
incidentally should also remove a useless 4-byte padding from the object 
when in 64-bit mode.

Now, our "struct object" is still too damn large, but it's now less 
obviously bloated, and of the remaining fields, only the "util" (which is 
not used by most things) is clearly something that should be eventually 
discarded.

This shrinks the "git-rev-list --all" memory use by about 2.5% on the 
kernel archive (and, perhaps more importantly, on the larger mozilla 
archive). That may not sound like much, but I suspect it's more on a 
64-bit platform.

There are other remaining inefficiencies (the parent lists, for example, 
probably have horrible malloc overhead), but this was pretty obvious.

Most of the patch is just changing the comparison of the "type" pointer 
from one of the constant string pointers to the appropriate new TYPE_xxx 
small integer constant.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

NOTE! This shrinks the number of branches that git-show-branch can show 
further. It's now 25 instead of 29 (because the three bits required for 
the type field, and the previous two bits used for flags. I _think_ it 
should have been 30 before, so we really lost 5 bits of the word but 
because of the off-by-one, we only lost four branches).

diff --git a/blob.c b/blob.c
index c1fdd86..85deccc 100644
--- a/blob.c
+++ b/blob.c
@@ -10,14 +10,14 @@ struct blob *lookup_blob(const unsigned 
 	if (!obj) {
 		struct blob *ret = xcalloc(1, sizeof(struct blob));
 		created_object(sha1, &ret->object);
-		ret->object.type = blob_type;
+		ret->object.type = TYPE_BLOB;
 		return ret;
 	}
 	if (!obj->type)
-		obj->type = blob_type;
-	if (obj->type != blob_type) {
+		obj->type = TYPE_BLOB;
+	if (obj->type != TYPE_BLOB) {
 		error("Object %s is a %s, not a blob", 
-		      sha1_to_hex(sha1), obj->type);
+		      sha1_to_hex(sha1), typename(obj->type));
 		return NULL;
 	}
 	return (struct blob *) obj;
diff --git a/builtin-diff.c b/builtin-diff.c
index 27451d5..6ac3d4b 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -303,9 +303,9 @@ int cmd_diff(int argc, const char **argv
 		obj = deref_tag(obj, NULL, 0);
 		if (!obj)
 			die("invalid object '%s' given.", name);
-		if (!strcmp(obj->type, commit_type))
+		if (obj->type == TYPE_COMMIT)
 			obj = &((struct commit *)obj)->tree->object;
-		if (!strcmp(obj->type, tree_type)) {
+		if (obj->type == TYPE_TREE) {
 			if (ARRAY_SIZE(ent) <= ents)
 				die("more than %d trees given: '%s'",
 				    (int) ARRAY_SIZE(ent), name);
@@ -315,7 +315,7 @@ int cmd_diff(int argc, const char **argv
 			ents++;
 			continue;
 		}
-		if (!strcmp(obj->type, blob_type)) {
+		if (obj->type == TYPE_BLOB) {
 			if (2 <= blobs)
 				die("more than two blobs given: '%s'", name);
 			memcpy(blob[blobs].sha1, obj->sha1, 20);
diff --git a/builtin-grep.c b/builtin-grep.c
index 5fac570..9806499 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -630,10 +630,9 @@ static int grep_tree(struct grep_opt *op
 static int grep_object(struct grep_opt *opt, const char **paths,
 		       struct object *obj, const char *name)
 {
-	if (!strcmp(obj->type, blob_type))
+	if (obj->type == TYPE_BLOB)
 		return grep_sha1(opt, obj->sha1, name);
-	if (!strcmp(obj->type, commit_type) ||
-	    !strcmp(obj->type, tree_type)) {
+	if (obj->type == TYPE_COMMIT || obj->type == TYPE_TREE) {
 		struct tree_desc tree;
 		void *data;
 		int hit;
@@ -646,7 +645,7 @@ static int grep_object(struct grep_opt *
 		free(data);
 		return hit;
 	}
-	die("unable to grep from object of type %s", obj->type);
+	die("unable to grep from object of type %s", typename(obj->type));
 }
 
 static const char builtin_grep_usage[] =
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index e885624..2b298c4 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -158,16 +158,16 @@ static void show_commit_list(struct rev_
 		const char *name = pending->name;
 		if (obj->flags & (UNINTERESTING | SEEN))
 			continue;
-		if (obj->type == tag_type) {
+		if (obj->type == TYPE_TAG) {
 			obj->flags |= SEEN;
 			p = add_object(obj, p, NULL, name);
 			continue;
 		}
-		if (obj->type == tree_type) {
+		if (obj->type == TYPE_TREE) {
 			p = process_tree((struct tree *)obj, p, NULL, name);
 			continue;
 		}
-		if (obj->type == blob_type) {
+		if (obj->type == TYPE_BLOB) {
 			p = process_blob((struct blob *)obj, p, NULL, name);
 			continue;
 		}
diff --git a/builtin-show-branch.c b/builtin-show-branch.c
index 2895140..cf9c071 100644
--- a/builtin-show-branch.c
+++ b/builtin-show-branch.c
@@ -15,7 +15,7 @@ static const char **default_arg = NULL;
 #define UNINTERESTING	01
 
 #define REV_SHIFT	 2
-#define MAX_REVS	29 /* should not exceed bits_per_int - REV_SHIFT */
+#define MAX_REVS	(FLAG_BITS - REV_SHIFT) /* should not exceed bits_per_int - REV_SHIFT */
 
 static struct commit *interesting(struct commit_list *list)
 {
diff --git a/commit.c b/commit.c
index 94f470b..11fca55 100644
--- a/commit.c
+++ b/commit.c
@@ -56,10 +56,10 @@ static struct commit *check_commit(struc
 				   const unsigned char *sha1,
 				   int quiet)
 {
-	if (obj->type != commit_type) {
+	if (obj->type != TYPE_COMMIT) {
 		if (!quiet)
 			error("Object %s is a %s, not a commit",
-			      sha1_to_hex(sha1), obj->type);
+			      sha1_to_hex(sha1), typename(obj->type));
 		return NULL;
 	}
 	return (struct commit *) obj;
@@ -86,11 +86,11 @@ struct commit *lookup_commit(const unsig
 	if (!obj) {
 		struct commit *ret = xcalloc(1, sizeof(struct commit));
 		created_object(sha1, &ret->object);
-		ret->object.type = commit_type;
+		ret->object.type = TYPE_COMMIT;
 		return ret;
 	}
 	if (!obj->type)
-		obj->type = commit_type;
+		obj->type = TYPE_COMMIT;
 	return check_commit(obj, sha1, 0);
 }
 
diff --git a/describe.c b/describe.c
index 8a9cd5d..aa3434a 100644
--- a/describe.c
+++ b/describe.c
@@ -67,7 +67,7 @@ static int get_name(const char *path, co
 	 * Otherwise only annotated tags are used.
 	 */
 	if (!strncmp(path, "refs/tags/", 10)) {
-		if (object->type == tag_type)
+		if (object->type == TYPE_TAG)
 			prio = 2;
 		else
 			prio = 1;
diff --git a/fetch-pack.c b/fetch-pack.c
index 8daa93d..1d676bf 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -40,7 +40,7 @@ static int rev_list_insert_ref(const cha
 {
 	struct object *o = deref_tag(parse_object(sha1), path, 0);
 
-	if (o && o->type == commit_type)
+	if (o && o->type == TYPE_COMMIT)
 		rev_list_push((struct commit *)o, SEEN);
 
 	return 0;
@@ -235,14 +235,14 @@ static int mark_complete(const char *pat
 {
 	struct object *o = parse_object(sha1);
 
-	while (o && o->type == tag_type) {
+	while (o && o->type == TYPE_TAG) {
 		struct tag *t = (struct tag *) o;
 		if (!t->tagged)
 			break; /* broken repository */
 		o->flags |= COMPLETE;
 		o = parse_object(t->tagged->sha1);
 	}
-	if (o && o->type == commit_type) {
+	if (o && o->type == TYPE_COMMIT) {
 		struct commit *commit = (struct commit *)o;
 		commit->object.flags |= COMPLETE;
 		insert_by_date(commit, &complete);
@@ -336,7 +336,7 @@ static int everything_local(struct ref *
 		 * in sync with the other side at some time after
 		 * that (it is OK if we guess wrong here).
 		 */
-		if (o->type == commit_type) {
+		if (o->type == TYPE_COMMIT) {
 			struct commit *commit = (struct commit *)o;
 			if (!cutoff || cutoff < commit->date)
 				cutoff = commit->date;
@@ -355,7 +355,7 @@ static int everything_local(struct ref *
 		struct object *o = deref_tag(lookup_object(ref->old_sha1),
 					     NULL, 0);
 
-		if (!o || o->type != commit_type || !(o->flags & COMPLETE))
+		if (!o || o->type != TYPE_COMMIT || !(o->flags & COMPLETE))
 			continue;
 
 		if (!(o->flags & SEEN)) {
diff --git a/fetch.c b/fetch.c
index cf6c994..238032b 100644
--- a/fetch.c
+++ b/fetch.c
@@ -118,27 +118,27 @@ static struct object_list **process_queu
 
 static int process_object(struct object *obj)
 {
-	if (obj->type == commit_type) {
+	if (obj->type == TYPE_COMMIT) {
 		if (process_commit((struct commit *)obj))
 			return -1;
 		return 0;
 	}
-	if (obj->type == tree_type) {
+	if (obj->type == TYPE_TREE) {
 		if (process_tree((struct tree *)obj))
 			return -1;
 		return 0;
 	}
-	if (obj->type == blob_type) {
+	if (obj->type == TYPE_BLOB) {
 		return 0;
 	}
-	if (obj->type == tag_type) {
+	if (obj->type == TYPE_TAG) {
 		if (process_tag((struct tag *)obj))
 			return -1;
 		return 0;
 	}
 	return error("Unable to determine requirements "
 		     "of type %s for %s",
-		     obj->type, sha1_to_hex(obj->sha1));
+		     typename(obj->type), sha1_to_hex(obj->sha1));
 }
 
 static int process(struct object *obj)
@@ -179,9 +179,7 @@ static int loop(void)
 		 */
 		if (! (obj->flags & TO_SCAN)) {
 			if (fetch(obj->sha1)) {
-				report_missing(obj->type
-					       ? obj->type
-					       : "object", obj->sha1);
+				report_missing(typename(obj->type), obj->sha1);
 				return -1;
 			}
 		}
diff --git a/fsck-objects.c b/fsck-objects.c
index 33ce366..99b419e 100644
--- a/fsck-objects.c
+++ b/fsck-objects.c
@@ -34,7 +34,7 @@ static void objreport(struct object *obj
                       const char *err, va_list params)
 {
 	fprintf(stderr, "%s in %s %s: ",
-	        severity, obj->type, sha1_to_hex(obj->sha1));
+	        severity, typename(obj->type), sha1_to_hex(obj->sha1));
 	vfprintf(stderr, err, params);
 	fputs("\n", stderr);
 }
@@ -74,7 +74,7 @@ static void check_connectivity(void)
 				; /* it is in pack */
 			else
 				printf("missing %s %s\n",
-				       obj->type, sha1_to_hex(obj->sha1));
+				       typename(obj->type), sha1_to_hex(obj->sha1));
 			continue;
 		}
 
@@ -87,20 +87,20 @@ static void check_connectivity(void)
 				    (has_sha1_file(ref->sha1)))
 					continue;
 				printf("broken link from %7s %s\n",
-				       obj->type, sha1_to_hex(obj->sha1));
+				       typename(obj->type), sha1_to_hex(obj->sha1));
 				printf("              to %7s %s\n",
-				       ref->type, sha1_to_hex(ref->sha1));
+				       typename(ref->type), sha1_to_hex(ref->sha1));
 			}
 		}
 
 		if (show_unreachable && !(obj->flags & REACHABLE)) {
 			printf("unreachable %s %s\n",
-			       obj->type, sha1_to_hex(obj->sha1));
+			       typename(obj->type), sha1_to_hex(obj->sha1));
 			continue;
 		}
 
 		if (!obj->used) {
-			printf("dangling %s %s\n", obj->type, 
+			printf("dangling %s %s\n", typename(obj->type), 
 			       sha1_to_hex(obj->sha1));
 		}
 	}
@@ -282,7 +282,7 @@ static int fsck_tag(struct tag *tag)
 	if (!show_tags)
 		return 0;
 
-	printf("tagged %s %s", tagged->type, sha1_to_hex(tagged->sha1));
+	printf("tagged %s %s", typename(tagged->type), sha1_to_hex(tagged->sha1));
 	printf(" (%s) in %s\n", tag->tag, sha1_to_hex(tag->object.sha1));
 	return 0;
 }
@@ -295,16 +295,16 @@ static int fsck_sha1(unsigned char *sha1
 	if (obj->flags & SEEN)
 		return 0;
 	obj->flags |= SEEN;
-	if (obj->type == blob_type)
+	if (obj->type == TYPE_BLOB)
 		return 0;
-	if (obj->type == tree_type)
+	if (obj->type == TYPE_TREE)
 		return fsck_tree((struct tree *) obj);
-	if (obj->type == commit_type)
+	if (obj->type == TYPE_COMMIT)
 		return fsck_commit((struct commit *) obj);
-	if (obj->type == tag_type)
+	if (obj->type == TYPE_TAG)
 		return fsck_tag((struct tag *) obj);
 	/* By now, parse_object() would've returned NULL instead. */
-	return objerror(obj, "unknown type '%s' (internal fsck error)", obj->type);
+	return objerror(obj, "unknown type '%d' (internal fsck error)", obj->type);
 }
 
 /*
@@ -470,7 +470,7 @@ static int fsck_cache_tree(struct cache_
 		}
 		mark_reachable(obj, REACHABLE);
 		obj->used = 1;
-		if (obj->type != tree_type)
+		if (obj->type != TYPE_TREE)
 			err |= objerror(obj, "non-tree in cache-tree");
 	}
 	for (i = 0; i < it->subtree_nr; i++)
diff --git a/http-push.c b/http-push.c
index b39b36b..599929e 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1773,16 +1773,16 @@ static int get_delta(struct rev_info *re
 
 		if (obj->flags & (UNINTERESTING | SEEN))
 			continue;
-		if (obj->type == tag_type) {
+		if (obj->type == TYPE_TAG) {
 			obj->flags |= SEEN;
 			p = add_object(obj, p, NULL, name);
 			continue;
 		}
-		if (obj->type == tree_type) {
+		if (obj->type == TYPE_TREE) {
 			p = process_tree((struct tree *)obj, p, NULL, name);
 			continue;
 		}
-		if (obj->type == blob_type) {
+		if (obj->type == TYPE_BLOB) {
 			p = process_blob((struct blob *)obj, p, NULL, name);
 			continue;
 		}
@@ -1949,12 +1949,12 @@ static int ref_newer(const unsigned char
 	 * old.  Otherwise we require --force.
 	 */
 	o = deref_tag(parse_object(old_sha1), NULL, 0);
-	if (!o || o->type != commit_type)
+	if (!o || o->type != TYPE_COMMIT)
 		return 0;
 	old = (struct commit *) o;
 
 	o = deref_tag(parse_object(new_sha1), NULL, 0);
-	if (!o || o->type != commit_type)
+	if (!o || o->type != TYPE_COMMIT)
 		return 0;
 	new = (struct commit *) o;
 
@@ -2033,7 +2033,7 @@ static void add_remote_info_ref(struct r
 	fwrite_buffer(ref_info, 1, len, buf);
 	free(ref_info);
 
-	if (o->type == tag_type) {
+	if (o->type == TYPE_TAG) {
 		o = deref_tag(o, ls->dentry_name, 0);
 		if (o) {
 			len = strlen(ls->dentry_name) + 45;
diff --git a/name-rev.c b/name-rev.c
index bad8a53..1f0135f 100644
--- a/name-rev.c
+++ b/name-rev.c
@@ -84,14 +84,14 @@ static int name_ref(const char *path, co
 	if (tags_only && strncmp(path, "refs/tags/", 10))
 		return 0;
 
-	while (o && o->type == tag_type) {
+	while (o && o->type == TYPE_TAG) {
 		struct tag *t = (struct tag *) o;
 		if (!t->tagged)
 			break; /* broken repository */
 		o = parse_object(t->tagged->sha1);
 		deref = 1;
 	}
-	if (o && o->type == commit_type) {
+	if (o && o->type == TYPE_COMMIT) {
 		struct commit *commit = (struct commit *)o;
 
 		if (!strncmp(path, "refs/heads/", 11))
@@ -167,7 +167,7 @@ int main(int argc, char **argv)
 		}
 
 		o = deref_tag(parse_object(sha1), *argv, 0);
-		if (!o || o->type != commit_type) {
+		if (!o || o->type != TYPE_COMMIT) {
 			fprintf(stderr, "Could not get commit for %s. Skipping.\n",
 					*argv);
 			continue;
diff --git a/object.c b/object.c
index 9adc874..0f70890 100644
--- a/object.c
+++ b/object.c
@@ -9,6 +9,10 @@ struct object **objs;
 static int nr_objs;
 int obj_allocs;
 
+const char *type_names[] = {
+	"none", "blob", "tree", "commit", "bad"
+};
+
 int track_object_refs = 0;
 
 static int hashtable_index(const unsigned char *sha1)
@@ -50,7 +54,7 @@ void created_object(const unsigned char 
 
 	obj->parsed = 0;
 	memcpy(obj->sha1, sha1, 20);
-	obj->type = NULL;
+	obj->type = TYPE_NONE;
 	obj->refs = NULL;
 	obj->used = 0;
 
@@ -179,7 +183,7 @@ struct object *lookup_unknown_object(con
 	if (!obj) {
 		union any_object *ret = xcalloc(1, sizeof(*ret));
 		created_object(sha1, &ret->object);
-		ret->object.type = NULL;
+		ret->object.type = TYPE_NONE;
 		return &ret->object;
 	}
 	return obj;
diff --git a/object.h b/object.h
index e08afbd..a0762b6 100644
--- a/object.h
+++ b/object.h
@@ -12,12 +12,22 @@ struct object_refs {
 	struct object *ref[FLEX_ARRAY]; /* more */
 };
 
+#define TYPE_BITS   3
+#define FLAG_BITS  27
+
+#define TYPE_NONE   0
+#define TYPE_BLOB   1
+#define TYPE_TREE   2
+#define TYPE_COMMIT 3
+#define TYPE_TAG    4
+#define TYPE_BAD    5
+
 struct object {
 	unsigned parsed : 1;
 	unsigned used : 1;
-	unsigned int flags;
+	unsigned type : TYPE_BITS;
+	unsigned flags : FLAG_BITS;
 	unsigned char sha1[20];
-	const char *type;
 	struct object_refs *refs;
 	void *util;
 };
@@ -25,6 +35,12 @@ struct object {
 extern int track_object_refs;
 extern int obj_allocs;
 extern struct object **objs;
+extern const char *type_names[];
+
+static inline const char *typename(unsigned int type)
+{
+	return type_names[type > TYPE_TAG ? TYPE_BAD : type];
+}
 
 /** Internal only **/
 struct object *lookup_object(const unsigned char *sha1);
diff --git a/revision.c b/revision.c
index 6a6952c..f4b8826 100644
--- a/revision.c
+++ b/revision.c
@@ -140,7 +140,7 @@ static struct commit *handle_commit(stru
 	/*
 	 * Tag object? Look what it points to..
 	 */
-	while (object->type == tag_type) {
+	while (object->type == TYPE_TAG) {
 		struct tag *tag = (struct tag *) object;
 		if (revs->tag_objects && !(flags & UNINTERESTING))
 			add_pending_object(revs, object, tag->tag);
@@ -153,7 +153,7 @@ static struct commit *handle_commit(stru
 	 * Commit object? Just return it, we'll do all the complex
 	 * reachability crud.
 	 */
-	if (object->type == commit_type) {
+	if (object->type == TYPE_COMMIT) {
 		struct commit *commit = (struct commit *)object;
 		if (parse_commit(commit) < 0)
 			die("unable to parse commit %s", name);
@@ -169,7 +169,7 @@ static struct commit *handle_commit(stru
 	 * Tree object? Either mark it uniniteresting, or add it
 	 * to the list of objects to look at later..
 	 */
-	if (object->type == tree_type) {
+	if (object->type == TYPE_TREE) {
 		struct tree *tree = (struct tree *)object;
 		if (!revs->tree_objects)
 			return NULL;
@@ -184,7 +184,7 @@ static struct commit *handle_commit(stru
 	/*
 	 * Blob object? You know the drill by now..
 	 */
-	if (object->type == blob_type) {
+	if (object->type == TYPE_BLOB) {
 		struct blob *blob = (struct blob *)object;
 		if (!revs->blob_objects)
 			return NULL;
@@ -498,11 +498,11 @@ static int add_parents_only(struct rev_i
 		return 0;
 	while (1) {
 		it = get_reference(revs, arg, sha1, 0);
-		if (strcmp(it->type, tag_type))
+		if (it->type != TYPE_TAG)
 			break;
 		memcpy(sha1, ((struct tag*)it)->tagged->sha1, 20);
 	}
-	if (strcmp(it->type, commit_type))
+	if (it->type != TYPE_COMMIT)
 		return 0;
 	commit = (struct commit *)it;
 	for (parents = commit->parents; parents; parents = parents->next) {
diff --git a/send-pack.c b/send-pack.c
index 409f188..af93b11 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -151,12 +151,12 @@ static int ref_newer(const unsigned char
 	 * old.  Otherwise we require --force.
 	 */
 	o = deref_tag(parse_object(old_sha1), NULL, 0);
-	if (!o || o->type != commit_type)
+	if (!o || o->type != TYPE_COMMIT)
 		return 0;
 	old = (struct commit *) o;
 
 	o = deref_tag(parse_object(new_sha1), NULL, 0);
-	if (!o || o->type != commit_type)
+	if (!o || o->type != TYPE_COMMIT)
 		return 0;
 	new = (struct commit *) o;
 
diff --git a/server-info.c b/server-info.c
index 05bce7d..0eb5132 100644
--- a/server-info.c
+++ b/server-info.c
@@ -12,7 +12,7 @@ static int add_info_ref(const char *path
 	struct object *o = parse_object(sha1);
 
 	fprintf(info_ref_fp, "%s	%s\n", sha1_to_hex(sha1), path);
-	if (o->type == tag_type) {
+	if (o->type == TYPE_TAG) {
 		o = deref_tag(o, path, 0);
 		if (o)
 			fprintf(info_ref_fp, "%s	%s^{}\n",
diff --git a/sha1_name.c b/sha1_name.c
index fbbde1c..8463d4b 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -358,7 +358,7 @@ static int peel_onion(const char *name, 
 {
 	unsigned char outer[20];
 	const char *sp;
-	const char *type_string = NULL;
+	unsigned int expected_type = 0;
 	struct object *o;
 
 	/*
@@ -382,13 +382,13 @@ static int peel_onion(const char *name, 
 
 	sp++; /* beginning of type name, or closing brace for empty */
 	if (!strncmp(commit_type, sp, 6) && sp[6] == '}')
-		type_string = commit_type;
+		expected_type = TYPE_COMMIT;
 	else if (!strncmp(tree_type, sp, 4) && sp[4] == '}')
-		type_string = tree_type;
+		expected_type = TYPE_TREE;
 	else if (!strncmp(blob_type, sp, 4) && sp[4] == '}')
-		type_string = blob_type;
+		expected_type = TYPE_BLOB;
 	else if (sp[0] == '}')
-		type_string = NULL;
+		expected_type = TYPE_NONE;
 	else
 		return -1;
 
@@ -398,7 +398,7 @@ static int peel_onion(const char *name, 
 	o = parse_object(outer);
 	if (!o)
 		return -1;
-	if (!type_string) {
+	if (!expected_type) {
 		o = deref_tag(o, name, sp - name - 2);
 		if (!o || (!o->parsed && !parse_object(o->sha1)))
 			return -1;
@@ -413,18 +413,18 @@ static int peel_onion(const char *name, 
 		while (1) {
 			if (!o || (!o->parsed && !parse_object(o->sha1)))
 				return -1;
-			if (o->type == type_string) {
+			if (o->type == expected_type) {
 				memcpy(sha1, o->sha1, 20);
 				return 0;
 			}
-			if (o->type == tag_type)
+			if (o->type == TYPE_TAG)
 				o = ((struct tag*) o)->tagged;
-			else if (o->type == commit_type)
+			else if (o->type == TYPE_COMMIT)
 				o = &(((struct commit *) o)->tree->object);
 			else
 				return error("%.*s: expected %s type, but the object dereferences to %s type",
-					     len, name, type_string,
-					     o->type);
+					     len, name, typename(expected_type),
+					     typename(o->type));
 			if (!o->parsed)
 				parse_object(o->sha1);
 		}
diff --git a/tag.c b/tag.c
index f390ee7..24ea6f6 100644
--- a/tag.c
+++ b/tag.c
@@ -5,7 +5,7 @@ const char *tag_type = "tag";
 
 struct object *deref_tag(struct object *o, const char *warn, int warnlen)
 {
-	while (o && o->type == tag_type)
+	while (o && o->type == TYPE_TAG)
 		o = parse_object(((struct tag *)o)->tagged->sha1);
 	if (!o && warn) {
 		if (!warnlen)
@@ -21,14 +21,14 @@ struct tag *lookup_tag(const unsigned ch
         if (!obj) {
                 struct tag *ret = xcalloc(1, sizeof(struct tag));
                 created_object(sha1, &ret->object);
-                ret->object.type = tag_type;
+                ret->object.type = TYPE_TAG;
                 return ret;
         }
 	if (!obj->type)
-		obj->type = tag_type;
-        if (obj->type != tag_type) {
+		obj->type = TYPE_TAG;
+        if (obj->type != TYPE_TAG) {
                 error("Object %s is a %s, not a tree", 
-                      sha1_to_hex(sha1), obj->type);
+                      sha1_to_hex(sha1), typename(obj->type));
                 return NULL;
         }
         return (struct tag *) obj;
diff --git a/tree.c b/tree.c
index 9bbe2da..9277715 100644
--- a/tree.c
+++ b/tree.c
@@ -131,14 +131,14 @@ struct tree *lookup_tree(const unsigned 
 	if (!obj) {
 		struct tree *ret = xcalloc(1, sizeof(struct tree));
 		created_object(sha1, &ret->object);
-		ret->object.type = tree_type;
+		ret->object.type = TYPE_TREE;
 		return ret;
 	}
 	if (!obj->type)
-		obj->type = tree_type;
-	if (obj->type != tree_type) {
+		obj->type = TYPE_TREE;
+	if (obj->type != TYPE_TREE) {
 		error("Object %s is a %s, not a tree", 
-		      sha1_to_hex(sha1), obj->type);
+		      sha1_to_hex(sha1), typename(obj->type));
 		return NULL;
 	}
 	return (struct tree *) obj;
@@ -216,11 +216,11 @@ struct tree *parse_tree_indirect(const u
 	do {
 		if (!obj)
 			return NULL;
-		if (obj->type == tree_type)
+		if (obj->type == TYPE_TREE)
 			return (struct tree *) obj;
-		else if (obj->type == commit_type)
+		else if (obj->type == TYPE_COMMIT)
 			obj = &(((struct commit *) obj)->tree->object);
-		else if (obj->type == tag_type)
+		else if (obj->type == TYPE_TAG)
 			obj = ((struct tag *) obj)->tagged;
 		else
 			return NULL;
diff --git a/upload-pack.c b/upload-pack.c
index 47560c9..979e583 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -105,7 +105,7 @@ static int got_sha1(char *hex, unsigned 
 			o = parse_object(sha1);
 		if (!o)
 			die("oops (%s)", sha1_to_hex(sha1));
-		if (o->type == commit_type) {
+		if (o->type == TYPE_COMMIT) {
 			struct commit_list *parents;
 			if (o->flags & THEY_HAVE)
 				return 0;
@@ -234,7 +234,7 @@ static int send_ref(const char *refname,
 		o->flags |= OUR_REF;
 		nr_our_refs++;
 	}
-	if (o->type == tag_type) {
+	if (o->type == TYPE_TAG) {
 		o = deref_tag(o, refname, 0);
 		packet_write(1, "%s %s^{}\n", sha1_to_hex(o->sha1), refname);
 	}
