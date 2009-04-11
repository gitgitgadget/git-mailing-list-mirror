From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] process_{tree,blob}: Remove useless xstrdup calls
Date: Fri, 10 Apr 2009 17:27:58 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0904101714420.4583@localhost.localdomain>
References: <20090408112854.GA8624@atjola.homenet> <alpine.LFD.2.00.0904101517520.4583@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, Jakub Narebski <jnareb@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, david@lang.hm,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Sebrecht <nicolas.s-dev@laposte.net>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Sat Apr 11 02:35:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LsRC5-000450-TQ
	for gcvg-git-2@gmane.org; Sat, 11 Apr 2009 02:35:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752705AbZDKAdx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Apr 2009 20:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753118AbZDKAdw
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Apr 2009 20:33:52 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:54590 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752478AbZDKAdv (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Apr 2009 20:33:51 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n3B0Rx1T008915
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 10 Apr 2009 17:28:30 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n3B0RwRv009345;
	Fri, 10 Apr 2009 17:27:58 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.00.0904101517520.4583@localhost.localdomain>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-5.445 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116282>



On Fri, 10 Apr 2009, Linus Torvalds wrote:
> 
> There's another easy 5% or so for the built-in object walker: once we've 
> created the hash from the name, the name isn't interesting any more, and 
> so something trivial like this can help a bit.

Hmm.

Here's a less trivial thing, and slightly more dubious one.

I was looking at that "struct object_array objects", and wondering why we 
do that. I have honestly totally forgotten. Why not just call the "show()" 
function as we encounter the objects? Rather than add the objects to the 
object_array, and then at the very end going through the array and doing a 
'show' on all, just do things more incrementally.

Now, there are possible downsides to this:

 - the "buffer using object_array" _can_ in theory result in at least 
   better I-cache usage (two tight loops rather than one more spread out 
   one). I don't think this is a real issue, but in theory..

 - this _does_ change the order of the objects printed. Instead of doing a 
   "process_tree(revs, commit->tree, &objects, NULL, "");" in the loop 
   over the commits (which puts all the root trees _first_ in the object 
   list, this patch just adds them to the list of pending objects, and 
   then we'll traverse them in that order (and thus show each root tree 
   object together with the objects we discover under it)

   I _think_ the new ordering actually makes more sense, but the object 
   ordering is actually a subtle thing when it comes to packing 
   efficiency, so any change in order is going to have implications for 
   packing. Good or bad, I dunno.

 - There may be some reason why we did it that odd way with the object 
   array, that I have simply forgotten.

Anyway, this includes the "free(name)" in builtin-pack-objects.c: 
show_object() logic, and now that we don't buffer up the objects before 
showing them that may actually result in lower memory usage during that 
whole traverse_commit_list() phase.

This is seriously not very deeply tested. It makes sense to me, it seems 
to pass all the tests, it looks ok, but...

Does anybody remember why we did that "object_array" thing? It used to be 
an "object_list" a long long time ago, but got changed into the array due 
to better memory usage patterns (those linked lists of obejcts are 
horrible from a memory allocation standpoint). But I wonder why we didn't 
do this back then. Maybe there's a reason for it.

Or maybe there _used_ to be a reason, and no longer is. 

			Linus

---
 builtin-pack-objects.c |   14 ++++++++++----
 builtin-rev-list.c     |   20 ++++++++++----------
 list-objects.c         |   35 ++++++++++++++++++-----------------
 list-objects.h         |    2 +-
 revision.c             |    2 +-
 revision.h             |    2 ++
 upload-pack.c          |   12 ++++++------
 7 files changed, 48 insertions(+), 39 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 9fc3b35..e028a02 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1907,11 +1907,17 @@ static void show_commit(struct commit *commit)
 	commit->object.flags |= OBJECT_ADDED;
 }
 
-static void show_object(struct object_array_entry *p)
+static void show_object(struct object *obj, const char *name)
 {
-	add_preferred_base_object(p->name);
-	add_object_entry(p->item->sha1, p->item->type, p->name, 0);
-	p->item->flags |= OBJECT_ADDED;
+	add_preferred_base_object(name);
+	add_object_entry(obj->sha1, obj->type, name, 0);
+	obj->flags |= OBJECT_ADDED;
+
+	/*
+	 * We will have generated the hash from the name,
+	 * but not saved a pointer to it - we can free it
+	 */
+	free(name);
 }
 
 static void show_edge(struct commit *commit)
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 40d5fcb..0815cf3 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -168,27 +168,27 @@ static void finish_commit(struct commit *commit)
 	commit->buffer = NULL;
 }
 
-static void finish_object(struct object_array_entry *p)
+static void finish_object(struct object *obj, const char *name)
 {
-	if (p->item->type == OBJ_BLOB && !has_sha1_file(p->item->sha1))
-		die("missing blob object '%s'", sha1_to_hex(p->item->sha1));
+	if (obj->type == OBJ_BLOB && !has_sha1_file(obj->sha1))
+		die("missing blob object '%s'", sha1_to_hex(obj->sha1));
 }
 
-static void show_object(struct object_array_entry *p)
+static void show_object(struct object *obj, const char *name)
 {
 	/* An object with name "foo\n0000000..." can be used to
 	 * confuse downstream "git pack-objects" very badly.
 	 */
-	const char *ep = strchr(p->name, '\n');
+	const char *ep = strchr(name, '\n');
 
-	finish_object(p);
+	finish_object(obj, name);
 	if (ep) {
-		printf("%s %.*s\n", sha1_to_hex(p->item->sha1),
-		       (int) (ep - p->name),
-		       p->name);
+		printf("%s %.*s\n", sha1_to_hex(obj->sha1),
+		       (int) (ep - name),
+		       name);
 	}
 	else
-		printf("%s %s\n", sha1_to_hex(p->item->sha1), p->name);
+		printf("%s %s\n", sha1_to_hex(obj->sha1), name);
 }
 
 static void show_edge(struct commit *commit)
diff --git a/list-objects.c b/list-objects.c
index dd243c7..5a4af62 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -10,7 +10,7 @@
 
 static void process_blob(struct rev_info *revs,
 			 struct blob *blob,
-			 struct object_array *p,
+			 show_object_fn show,
 			 struct name_path *path,
 			 const char *name)
 {
@@ -23,7 +23,7 @@ static void process_blob(struct rev_info *revs,
 	if (obj->flags & (UNINTERESTING | SEEN))
 		return;
 	obj->flags |= SEEN;
-	add_object(obj, p, path, name);
+	show(obj, path_name(path, name));
 }
 
 /*
@@ -50,7 +50,7 @@ static void process_blob(struct rev_info *revs,
  */
 static void process_gitlink(struct rev_info *revs,
 			    const unsigned char *sha1,
-			    struct object_array *p,
+			    show_object_fn show,
 			    struct name_path *path,
 			    const char *name)
 {
@@ -59,7 +59,7 @@ static void process_gitlink(struct rev_info *revs,
 
 static void process_tree(struct rev_info *revs,
 			 struct tree *tree,
-			 struct object_array *p,
+			 show_object_fn show,
 			 struct name_path *path,
 			 const char *name)
 {
@@ -77,7 +77,7 @@ static void process_tree(struct rev_info *revs,
 	if (parse_tree(tree) < 0)
 		die("bad tree object %s", sha1_to_hex(obj->sha1));
 	obj->flags |= SEEN;
-	add_object(obj, p, path, name);
+	show(obj, path_name(path, name));
 	me.up = path;
 	me.elem = name;
 	me.elem_len = strlen(name);
@@ -88,14 +88,14 @@ static void process_tree(struct rev_info *revs,
 		if (S_ISDIR(entry.mode))
 			process_tree(revs,
 				     lookup_tree(entry.sha1),
-				     p, &me, entry.path);
+				     show, &me, entry.path);
 		else if (S_ISGITLINK(entry.mode))
 			process_gitlink(revs, entry.sha1,
-					p, &me, entry.path);
+					show, &me, entry.path);
 		else
 			process_blob(revs,
 				     lookup_blob(entry.sha1),
-				     p, &me, entry.path);
+				     show, &me, entry.path);
 	}
 	free(tree->buffer);
 	tree->buffer = NULL;
@@ -134,16 +134,20 @@ void mark_edges_uninteresting(struct commit_list *list,
 	}
 }
 
+static void add_pending_tree(struct rev_info *revs, struct tree *tree)
+{
+	add_pending_object(revs, &tree->object, "");
+}
+
 void traverse_commit_list(struct rev_info *revs,
 			  void (*show_commit)(struct commit *),
-			  void (*show_object)(struct object_array_entry *))
+			  void (*show_object)(struct object *, const char *))
 {
 	int i;
 	struct commit *commit;
-	struct object_array objects = { 0, 0, NULL };
 
 	while ((commit = get_revision(revs)) != NULL) {
-		process_tree(revs, commit->tree, &objects, NULL, "");
+		add_pending_tree(revs, commit->tree);
 		show_commit(commit);
 	}
 	for (i = 0; i < revs->pending.nr; i++) {
@@ -154,25 +158,22 @@ void traverse_commit_list(struct rev_info *revs,
 			continue;
 		if (obj->type == OBJ_TAG) {
 			obj->flags |= SEEN;
-			add_object_array(obj, name, &objects);
+			show_object(obj, name);
 			continue;
 		}
 		if (obj->type == OBJ_TREE) {
-			process_tree(revs, (struct tree *)obj, &objects,
+			process_tree(revs, (struct tree *)obj, show_object,
 				     NULL, name);
 			continue;
 		}
 		if (obj->type == OBJ_BLOB) {
-			process_blob(revs, (struct blob *)obj, &objects,
+			process_blob(revs, (struct blob *)obj, show_object,
 				     NULL, name);
 			continue;
 		}
 		die("unknown pending object %s (%s)",
 		    sha1_to_hex(obj->sha1), name);
 	}
-	for (i = 0; i < objects.nr; i++)
-		show_object(&objects.objects[i]);
-	free(objects.objects);
 	if (revs->pending.nr) {
 		free(revs->pending.objects);
 		revs->pending.nr = 0;
diff --git a/list-objects.h b/list-objects.h
index 0f41391..13b0dd9 100644
--- a/list-objects.h
+++ b/list-objects.h
@@ -2,7 +2,7 @@
 #define LIST_OBJECTS_H
 
 typedef void (*show_commit_fn)(struct commit *);
-typedef void (*show_object_fn)(struct object_array_entry *);
+typedef void (*show_object_fn)(struct object *, const char *);
 typedef void (*show_edge_fn)(struct commit *);
 
 void traverse_commit_list(struct rev_info *revs, show_commit_fn, show_object_fn);
diff --git a/revision.c b/revision.c
index b6215cc..44a9ce2 100644
--- a/revision.c
+++ b/revision.c
@@ -15,7 +15,7 @@
 
 volatile show_early_output_fn_t show_early_output;
 
-static char *path_name(struct name_path *path, const char *name)
+char *path_name(struct name_path *path, const char *name)
 {
 	struct name_path *p;
 	char *n, *m;
diff --git a/revision.h b/revision.h
index 5adfc91..c89e8ff 100644
--- a/revision.h
+++ b/revision.h
@@ -146,6 +146,8 @@ struct name_path {
 	const char *elem;
 };
 
+char *path_name(struct name_path *path, const char *name);
+
 extern void add_object(struct object *obj,
 		       struct object_array *p,
 		       struct name_path *path,
diff --git a/upload-pack.c b/upload-pack.c
index a49d872..5524ac4 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -78,20 +78,20 @@ static void show_commit(struct commit *commit)
 	commit->buffer = NULL;
 }
 
-static void show_object(struct object_array_entry *p)
+static void show_object(struct object *obj, const char *name)
 {
 	/* An object with name "foo\n0000000..." can be used to
 	 * confuse downstream git-pack-objects very badly.
 	 */
-	const char *ep = strchr(p->name, '\n');
+	const char *ep = strchr(name, '\n');
 	if (ep) {
-		fprintf(pack_pipe, "%s %.*s\n", sha1_to_hex(p->item->sha1),
-		       (int) (ep - p->name),
-		       p->name);
+		fprintf(pack_pipe, "%s %.*s\n", sha1_to_hex(obj->sha1),
+		       (int) (ep - name),
+		       name);
 	}
 	else
 		fprintf(pack_pipe, "%s %s\n",
-				sha1_to_hex(p->item->sha1), p->name);
+				sha1_to_hex(obj->sha1), name);
 }
 
 static void show_edge(struct commit *commit)
