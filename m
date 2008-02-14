From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: Re: [RFC Patch] Preventing corrupt objects from entering the repository
Date: Thu, 14 Feb 2008 20:04:55 +0100
Message-ID: <20080214190455.GB26527@auto.tuwien.ac.at>
References: <20080210175812.GB12162@auto.tuwien.ac.at> <7vmyq8cqfn.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0802101929310.2732@xanadu.home> <20080211195623.GA21878@auto.tuwien.ac.at> <alpine.LFD.1.00.0802111513360.2732@xanadu.home> <20080211215806.GA24971@auto.tuwien.ac.at> <alpine.LFD.1.00.0802120937330.2732@xanadu.home> <20080213074209.GG24004@spearce.org> <20080213081128.GA27730@auto.tuwien.ac.at> <alpine.LSU.1.00.0802131200410.30505@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@cam.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 14 20:06:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPjP3-0003Uc-QE
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 20:05:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755375AbYBNTFA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2008 14:05:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757021AbYBNTE7
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 14:04:59 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:57714 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756468AbYBNTE6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 14:04:58 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 332A8680B59E;
	Thu, 14 Feb 2008 20:04:56 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OiSQ9ZWv-Lxt; Thu, 14 Feb 2008 20:04:56 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 0C16F680BEB9; Thu, 14 Feb 2008 20:04:56 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0802131200410.30505@racer.site>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73905>

On Wed, Feb 13, 2008 at 12:01:43PM +0000, Johannes Schindelin wrote:
> On Wed, 13 Feb 2008, Martin Koegler wrote:
> > This would mean, that we must make git-rev-list and git-pack-objects not 
> > segfault on incorrect links between objects.
> 
> We should do that anyway.  It may error out, but segfaulting is no option.
> 
> So if you have a test case, please make it public so we can fix the 
> breakage.

OK, here is the first part of missing checks. 

Its still WIP:
* It should be checked, if reactions to errors are correct.
* Patch should be splitted and turned into submitable pieces

If anybody wants to do this, please go on.

>From 4a6908ff51059a5b2bcc8d8c41fd41de53ee9151 Mon Sep 17 00:00:00 2001
From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Date: Thu, 14 Feb 2008 19:34:39 +0100
Subject: [PATCH] Missing checks (1)

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
 commit.c    |   16 +++++++++++-----
 revision.c  |   12 ++++++++++++
 sha1_file.c |    3 ++-
 sha1_name.c |   11 ++++++++++-
 tag.c       |    5 ++++-
 5 files changed, 39 insertions(+), 8 deletions(-)

diff --git a/commit.c b/commit.c
index 8b8fb04..53f0042 100644
--- a/commit.c
+++ b/commit.c
@@ -311,6 +311,8 @@ int parse_commit(struct commit *item)
 	unsigned long size;
 	int ret;
 
+	if (!item)
+		return -1;
 	if (item->object.parsed)
 		return 0;
 	buffer = read_sha1_file(item->object.sha1, &type, &size);
@@ -385,8 +387,7 @@ struct commit *pop_most_recent_commit(struct commit_list **list,
 
 	while (parents) {
 		struct commit *commit = parents->item;
-		parse_commit(commit);
-		if (!(commit->object.flags & mark)) {
+		if (!parse_commit(commit) && !(commit->object.flags & mark)) {
 			commit->object.flags |= mark;
 			insert_by_date(commit, list);
 		}
@@ -552,8 +553,10 @@ static struct commit_list *merge_bases(struct commit *one, struct commit *two)
 		 */
 		return commit_list_insert(one, &result);
 
-	parse_commit(one);
-	parse_commit(two);
+	if (parse_commit(one))
+		die("invalid commit");
+	if (parse_commit(two))
+		die("invalid commit");
 
 	one->object.flags |= PARENT1;
 	two->object.flags |= PARENT2;
@@ -584,9 +587,12 @@ static struct commit_list *merge_bases(struct commit *one, struct commit *two)
 		while (parents) {
 			struct commit *p = parents->item;
 			parents = parents->next;
+			if (!p)
+				die("invalid commit");
 			if ((p->object.flags & flags) == flags)
 				continue;
-			parse_commit(p);
+			if(parse_commit(p))
+				die("invalid commit");
 			p->object.flags |= flags;
 			insert_by_date(p, &list);
 		}
diff --git a/revision.c b/revision.c
index 6e85aaa..9f8723d 100644
--- a/revision.c
+++ b/revision.c
@@ -46,6 +46,8 @@ void add_object(struct object *obj,
 
 static void mark_blob_uninteresting(struct blob *blob)
 {
+	if (!blob)
+		return;
 	if (blob->object.flags & UNINTERESTING)
 		return;
 	blob->object.flags |= UNINTERESTING;
@@ -57,6 +59,8 @@ void mark_tree_uninteresting(struct tree *tree)
 	struct name_entry entry;
 	struct object *obj = &tree->object;
 
+	if (!obj)
+		return;
 	if (obj->flags & UNINTERESTING)
 		return;
 	obj->flags |= UNINTERESTING;
@@ -94,6 +98,8 @@ void mark_parents_uninteresting(struct commit *commit)
 
 	while (parents) {
 		struct commit *commit = parents->item;
+		if (!commit)
+			continue;
 		if (!(commit->object.flags & UNINTERESTING)) {
 			commit->object.flags |= UNINTERESTING;
 
@@ -173,6 +179,8 @@ static struct commit *handle_commit(struct rev_info *revs, struct object *object
 		struct tag *tag = (struct tag *) object;
 		if (revs->tag_objects && !(flags & UNINTERESTING))
 			add_pending_object(revs, object, tag->tag);
+		if (!tag->tagged)
+			die("bad tag");
 		object = parse_object(tag->tagged->sha1);
 		if (!object)
 			die("bad object %s", sha1_to_hex(tag->tagged->sha1));
@@ -685,12 +693,16 @@ static int add_parents_only(struct rev_info *revs, const char *arg, int flags)
 		it = get_reference(revs, arg, sha1, 0);
 		if (it->type != OBJ_TAG)
 			break;
+		if (!((struct tag*)it)->tagged)
+			return 0;
 		hashcpy(sha1, ((struct tag*)it)->tagged->sha1);
 	}
 	if (it->type != OBJ_COMMIT)
 		return 0;
 	commit = (struct commit *)it;
 	for (parents = commit->parents; parents; parents = parents->next) {
+		if (!parents->item)
+			continue;
 		it = &parents->item->object;
 		it->flags |= flags;
 		add_pending_object(revs, it, arg);
diff --git a/sha1_file.c b/sha1_file.c
index 4179949..c25ce64 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1943,7 +1943,8 @@ void *read_object_with_reference(const unsigned char *sha1,
 		}
 		ref_length = strlen(ref_type);
 
-		if (memcmp(buffer, ref_type, ref_length) ||
+		if (ref_length + 40 >= size ||
+		    memcmp(buffer, ref_type, ref_length) ||
 		    get_sha1_hex((char *) buffer + ref_length, actual_sha1)) {
 			free(buffer);
 			return NULL;
diff --git a/sha1_name.c b/sha1_name.c
index be8489e..bd0bce6 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -396,6 +396,8 @@ static int get_parent(const char *name, int len,
 	p = commit->parents;
 	while (p) {
 		if (!--idx) {
+			if (!p->item)
+				return -1;
 			hashcpy(result, p->item->object.sha1);
 			return 0;
 		}
@@ -417,6 +419,8 @@ static int get_nth_ancestor(const char *name, int len,
 
 		if (!commit || parse_commit(commit) || !commit->parents)
 			return -1;
+		if (!commit->parents->item)
+			return -1;
 		hashcpy(sha1, commit->parents->item->object.sha1);
 	}
 	hashcpy(result, sha1);
@@ -494,6 +498,8 @@ static int peel_onion(const char *name, int len, unsigned char *sha1)
 				return error("%.*s: expected %s type, but the object dereferences to %s type",
 					     len, name, typename(expected_type),
 					     typename(o->type));
+			if (!o)
+				return -1;
 			if (!o->parsed)
 				parse_object(o->sha1);
 		}
@@ -580,6 +586,8 @@ static int handle_one_ref(const char *path,
 		return 0;
 	if (object->type == OBJ_TAG)
 		object = deref_tag(object, path, strlen(path));
+	if (!object)
+		return 0;
 	if (object->type != OBJ_COMMIT)
 		return 0;
 	insert_by_date((struct commit *)object, list);
@@ -617,7 +625,8 @@ static int get_sha1_oneline(const char *prefix, unsigned char *sha1)
 		unsigned long size;
 
 		commit = pop_most_recent_commit(&list, ONELINE_SEEN);
-		parse_object(commit->object.sha1);
+		if(!parse_object(commit->object.sha1))
+			continue;
 		if (temp_commit_buffer)
 			free(temp_commit_buffer);
 		if (commit->buffer)
diff --git a/tag.c b/tag.c
index 38bf913..990134f 100644
--- a/tag.c
+++ b/tag.c
@@ -9,7 +9,10 @@ const char *tag_type = "tag";
 struct object *deref_tag(struct object *o, const char *warn, int warnlen)
 {
 	while (o && o->type == OBJ_TAG)
-		o = parse_object(((struct tag *)o)->tagged->sha1);
+		if (((struct tag *)o)->tagged)
+			o = parse_object(((struct tag *)o)->tagged->sha1);
+		else
+			o = NULL;
 	if (!o && warn) {
 		if (!warnlen)
 			warnlen = strlen(warn);
-- 
1.5.4.1.gb43a
