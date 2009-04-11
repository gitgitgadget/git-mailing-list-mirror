From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] process_{tree,blob}: Remove useless xstrdup calls
Date: Fri, 10 Apr 2009 18:15:26 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0904101806340.4583@localhost.localdomain>
References: <20090408112854.GA8624@atjola.homenet> <alpine.LFD.2.00.0904101517520.4583@localhost.localdomain> <alpine.LFD.2.00.0904101714420.4583@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, Jakub Narebski <jnareb@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, david@lang.hm,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Sebrecht <nicolas.s-dev@laposte.net>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Sat Apr 11 03:23:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LsRwN-0004VG-91
	for gcvg-git-2@gmane.org; Sat, 11 Apr 2009 03:23:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754479AbZDKBVz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Apr 2009 21:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754419AbZDKBVy
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Apr 2009 21:21:54 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:43238 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754348AbZDKBVx (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Apr 2009 21:21:53 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n3B1FSca011510
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 10 Apr 2009 18:16:05 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n3B1FQJW029311;
	Fri, 10 Apr 2009 18:15:26 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.00.0904101714420.4583@localhost.localdomain>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-5.445 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116286>



On Fri, 10 Apr 2009, Linus Torvalds wrote:
> 
> Here's a less trivial thing, and slightly more dubious one.

I'm starting to like it more.

In particular, pushing the "path_name()" call _into_ the show() function 
would seem to allow

 - more clarity into who "owns" the name (ie now when we free the name in 
   the show_object callback, it's because we generated it ourselves by 
   calling path_name())

 - not calling path_name() at all, either because we don't care about the 
   name in the first place, or because we are actually happy walking the 
   linked list of "struct name_path *" and the last component.

Now, I didn't do that latter optimization, because it would require some 
more coding, but especially looking at "builtin-pack-objects.c", we really 
don't even want the whole pathname, we really would be better off with the 
list of path components.

Why? We use that name for two things:
 - add_preferred_base_object(), which actually _wants_ to traverse the 
   path, and now does it by looking for '/' characters!
 - for 'name_hash()', which only cares about the last 16 characters of a 
   name, so again, generating the full name seems to be just unnecessary 
   work.

Anyway, so I didn't look any closer at those things, but it did convince 
me that the "show_object()" calling convention was crazy, and we're 
actually better off doing _less_ in list-objects.c, and giving people 
access to the internal data structures so that they can decide whether 
they want to generate a path-name or not.

This patch does that, and then for people who did use the name (even if 
they might do something more clever in the future), it just does the 
straightforward "name = path_name(path, component); .. free(name);" thing.

It obviously goes on top of my previous patch.


		Linus

---
 builtin-pack-objects.c |    9 +++------
 builtin-rev-list.c     |    8 +++++---
 list-objects.c         |   10 +++++-----
 list-objects.h         |    2 +-
 revision.c             |    4 ++--
 revision.h             |    2 +-
 upload-pack.c          |    4 +++-
 7 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index e028a02..d74d8a4 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1907,16 +1907,13 @@ static void show_commit(struct commit *commit)
 	commit->object.flags |= OBJECT_ADDED;
 }
 
-static void show_object(struct object *obj, const char *name)
+static void show_object(struct object *obj, const struct name_path *path, const char *last)
 {
+	char *name = path_name(path, last);
+
 	add_preferred_base_object(name);
 	add_object_entry(obj->sha1, obj->type, name, 0);
 	obj->flags |= OBJECT_ADDED;
-
-	/*
-	 * We will have generated the hash from the name,
-	 * but not saved a pointer to it - we can free it
-	 */
 	free(name);
 }
 
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 0815cf3..aba8a6f 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -168,20 +168,21 @@ static void finish_commit(struct commit *commit)
 	commit->buffer = NULL;
 }
 
-static void finish_object(struct object *obj, const char *name)
+static void finish_object(struct object *obj, const struct name_path *path, const char *name)
 {
 	if (obj->type == OBJ_BLOB && !has_sha1_file(obj->sha1))
 		die("missing blob object '%s'", sha1_to_hex(obj->sha1));
 }
 
-static void show_object(struct object *obj, const char *name)
+static void show_object(struct object *obj, const struct name_path *path, const char *component)
 {
+	char *name = path_name(path, component);
 	/* An object with name "foo\n0000000..." can be used to
 	 * confuse downstream "git pack-objects" very badly.
 	 */
 	const char *ep = strchr(name, '\n');
 
-	finish_object(obj, name);
+	finish_object(obj, path, name);
 	if (ep) {
 		printf("%s %.*s\n", sha1_to_hex(obj->sha1),
 		       (int) (ep - name),
@@ -189,6 +190,7 @@ static void show_object(struct object *obj, const char *name)
 	}
 	else
 		printf("%s %s\n", sha1_to_hex(obj->sha1), name);
+	free(name);
 }
 
 static void show_edge(struct commit *commit)
diff --git a/list-objects.c b/list-objects.c
index 5a4af62..30ded3d 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -23,7 +23,7 @@ static void process_blob(struct rev_info *revs,
 	if (obj->flags & (UNINTERESTING | SEEN))
 		return;
 	obj->flags |= SEEN;
-	show(obj, path_name(path, name));
+	show(obj, path, name);
 }
 
 /*
@@ -77,7 +77,7 @@ static void process_tree(struct rev_info *revs,
 	if (parse_tree(tree) < 0)
 		die("bad tree object %s", sha1_to_hex(obj->sha1));
 	obj->flags |= SEEN;
-	show(obj, path_name(path, name));
+	show(obj, path, name);
 	me.up = path;
 	me.elem = name;
 	me.elem_len = strlen(name);
@@ -140,8 +140,8 @@ static void add_pending_tree(struct rev_info *revs, struct tree *tree)
 }
 
 void traverse_commit_list(struct rev_info *revs,
-			  void (*show_commit)(struct commit *),
-			  void (*show_object)(struct object *, const char *))
+			  show_commit_fn show_commit,
+			  show_object_fn show_object)
 {
 	int i;
 	struct commit *commit;
@@ -158,7 +158,7 @@ void traverse_commit_list(struct rev_info *revs,
 			continue;
 		if (obj->type == OBJ_TAG) {
 			obj->flags |= SEEN;
-			show_object(obj, name);
+			show_object(obj, NULL, name);
 			continue;
 		}
 		if (obj->type == OBJ_TREE) {
diff --git a/list-objects.h b/list-objects.h
index 13b0dd9..0b2de64 100644
--- a/list-objects.h
+++ b/list-objects.h
@@ -2,7 +2,7 @@
 #define LIST_OBJECTS_H
 
 typedef void (*show_commit_fn)(struct commit *);
-typedef void (*show_object_fn)(struct object *, const char *);
+typedef void (*show_object_fn)(struct object *, const struct name_path *, const char *);
 typedef void (*show_edge_fn)(struct commit *);
 
 void traverse_commit_list(struct rev_info *revs, show_commit_fn, show_object_fn);
diff --git a/revision.c b/revision.c
index 44a9ce2..bd0ea34 100644
--- a/revision.c
+++ b/revision.c
@@ -15,9 +15,9 @@
 
 volatile show_early_output_fn_t show_early_output;
 
-char *path_name(struct name_path *path, const char *name)
+char *path_name(const struct name_path *path, const char *name)
 {
-	struct name_path *p;
+	const struct name_path *p;
 	char *n, *m;
 	int nlen = strlen(name);
 	int len = nlen + 1;
diff --git a/revision.h b/revision.h
index c89e8ff..be39e7d 100644
--- a/revision.h
+++ b/revision.h
@@ -146,7 +146,7 @@ struct name_path {
 	const char *elem;
 };
 
-char *path_name(struct name_path *path, const char *name);
+char *path_name(const struct name_path *path, const char *name);
 
 extern void add_object(struct object *obj,
 		       struct object_array *p,
diff --git a/upload-pack.c b/upload-pack.c
index 5524ac4..536efbb 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -78,11 +78,12 @@ static void show_commit(struct commit *commit)
 	commit->buffer = NULL;
 }
 
-static void show_object(struct object *obj, const char *name)
+static void show_object(struct object *obj, const struct name_path *path, const char *component)
 {
 	/* An object with name "foo\n0000000..." can be used to
 	 * confuse downstream git-pack-objects very badly.
 	 */
+	const char *name = path_name(path, component);
 	const char *ep = strchr(name, '\n');
 	if (ep) {
 		fprintf(pack_pipe, "%s %.*s\n", sha1_to_hex(obj->sha1),
@@ -92,6 +93,7 @@ static void show_object(struct object *obj, const char *name)
 	else
 		fprintf(pack_pipe, "%s %s\n",
 				sha1_to_hex(obj->sha1), name);
+	free(name);
 }
 
 static void show_edge(struct commit *commit)
