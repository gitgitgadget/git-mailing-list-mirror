From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Some git performance measurements..
Date: Thu, 29 Nov 2007 18:21:06 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0711291812530.8458@woody.linux-foundation.org>
References: <alpine.LFD.0.9999.0711281747450.8458@woody.linux-foundation.org> <alpine.LFD.0.9999.0711281852160.8458@woody.linux-foundation.org> <alpine.LFD.0.99999.0711282244190.9605@xanadu.home> <alpine.LFD.0.9999.0711282022470.8458@woody.linux-foundation.org>
 <alpine.LFD.0.99999.0711291208060.9605@xanadu.home> <finmvm$da8$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>, Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Nov 30 03:22:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxvWA-0003hH-DK
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 03:22:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933563AbXK3CVz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 21:21:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933265AbXK3CVz
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 21:21:55 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:59147 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932834AbXK3CVy (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Nov 2007 21:21:54 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lAU2L9bN026131
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 29 Nov 2007 18:21:10 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lAU2L6pp019008;
	Thu, 29 Nov 2007 18:21:09 -0800
In-Reply-To: <finmvm$da8$1@ger.gmane.org>
X-Spam-Status: No, hits=-2.127 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_22,J_CHICKENPOX_24
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66604>



On Fri, 30 Nov 2007, Jakub Narebski wrote:
> 
> Isn't there a better way to do this sorting? What is needed here is
> (stable) _bucket_ sort / _pigeonhole_ sort (or counting sort), which
> is O(n); quicksort is perhaps simpler to use, but I'm not sure if
> faster in this situation.

Actually, I doubt you need to do any sorting at all: what would be easiest 
would be to simply change "traverse_commit_list()" to use different lists 
for different object types, and just output them in type order (semi-sane 
order choice: commits first, then tags, then trees, and finally blobs).

Ta-daa! All done! Magic! No sorting required, because all the objects got 
output in the right order without any extra sort phase!

Something like the appended (untested! lots of! exclamation marks! 
Really!)

		Linus

---
 list-objects.c |   36 ++++++++++++++++++++++--------------
 1 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/list-objects.c b/list-objects.c
index 4ef58e7..a046f37 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -49,7 +49,6 @@ static void process_blob(struct rev_info *revs,
  */
 static void process_gitlink(struct rev_info *revs,
 			    const unsigned char *sha1,
-			    struct object_array *p,
 			    struct name_path *path,
 			    const char *name)
 {
@@ -58,7 +57,8 @@ static void process_gitlink(struct rev_info *revs,
 
 static void process_tree(struct rev_info *revs,
 			 struct tree *tree,
-			 struct object_array *p,
+			 struct object_array *trees,
+			 struct object_array *blobs,
 			 struct name_path *path,
 			 const char *name)
 {
@@ -75,7 +75,7 @@ static void process_tree(struct rev_info *revs,
 		die("bad tree object %s", sha1_to_hex(obj->sha1));
 	obj->flags |= SEEN;
 	name = xstrdup(name);
-	add_object(obj, p, path, name);
+	add_object(obj, trees, path, name);
 	me.up = path;
 	me.elem = name;
 	me.elem_len = strlen(name);
@@ -86,14 +86,14 @@ static void process_tree(struct rev_info *revs,
 		if (S_ISDIR(entry.mode))
 			process_tree(revs,
 				     lookup_tree(entry.sha1),
-				     p, &me, entry.path);
+				     trees, blobs, &me, entry.path);
 		else if (S_ISGITLINK(entry.mode))
 			process_gitlink(revs, entry.sha1,
-					p, &me, entry.path);
+					&me, entry.path);
 		else
 			process_blob(revs,
 				     lookup_blob(entry.sha1),
-				     p, &me, entry.path);
+				     blobs, &me, entry.path);
 	}
 	free(tree->buffer);
 	tree->buffer = NULL;
@@ -138,10 +138,12 @@ void traverse_commit_list(struct rev_info *revs,
 {
 	int i;
 	struct commit *commit;
-	struct object_array objects = { 0, 0, NULL };
+	struct object_array tags = { 0, 0, NULL };
+	struct object_array trees = { 0, 0, NULL };
+	struct object_array blobs = { 0, 0, NULL };
 
 	while ((commit = get_revision(revs)) != NULL) {
-		process_tree(revs, commit->tree, &objects, NULL, "");
+		process_tree(revs, commit->tree, &trees, &blobs, NULL, "");
 		show_commit(commit);
 	}
 	for (i = 0; i < revs->pending.nr; i++) {
@@ -152,25 +154,31 @@ void traverse_commit_list(struct rev_info *revs,
 			continue;
 		if (obj->type == OBJ_TAG) {
 			obj->flags |= SEEN;
-			add_object_array(obj, name, &objects);
+			add_object_array(obj, name, &tags);
 			continue;
 		}
 		if (obj->type == OBJ_TREE) {
-			process_tree(revs, (struct tree *)obj, &objects,
+			process_tree(revs, (struct tree *)obj, &trees, &blobs,
 				     NULL, name);
 			continue;
 		}
 		if (obj->type == OBJ_BLOB) {
-			process_blob(revs, (struct blob *)obj, &objects,
+			process_blob(revs, (struct blob *)obj, &blobs,
 				     NULL, name);
 			continue;
 		}
 		die("unknown pending object %s (%s)",
 		    sha1_to_hex(obj->sha1), name);
 	}
-	for (i = 0; i < objects.nr; i++)
-		show_object(&objects.objects[i]);
-	free(objects.objects);
+	for (i = 0; i < tags.nr; i++)
+		show_object(&tags.objects[i]);
+	for (i = 0; i < trees.nr; i++)
+		show_object(&trees.objects[i]);
+	for (i = 0; i < blobs.nr; i++)
+		show_object(&blobs.objects[i]);
+	free(tags.objects);
+	free(trees.objects);
+	free(blobs.objects);
 	if (revs->pending.nr) {
 		free(revs->pending.objects);
 		revs->pending.nr = 0;
