From: Junio C Hamano <junkio@cox.net>
Subject: tag referring to a commit but not directly?
Date: Sat, 09 Jul 2005 03:00:44 -0700
Message-ID: <7v7jg0wb77.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 09 12:01:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DrC8p-0002X8-1P
	for gcvg-git@gmane.org; Sat, 09 Jul 2005 12:00:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261536AbVGIKAs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jul 2005 06:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261584AbVGIKAs
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jul 2005 06:00:48 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:38074 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S261536AbVGIKAq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jul 2005 06:00:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050709100045.MLRH550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 9 Jul 2005 06:00:45 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I was playing with a tag that refers to another tag which refers
to a commit, and found out that some things did not work as I
expected.

Is it a PEBCAK on my part to expect tag-to-tag-to-commit to
behave the same way as a bare commit (or a tag to commit), or is
this just a bug?  I think the following two would fix what I
found, but I am not sure if I am using the "struct object" and
friends the way they are expected to be used.  I am uncertain
about what the expected behaviour should be either for that
matter; I admit that tags are new to me.

---

*** To find whom to ask about the thing I am butchering, I
*** used the following pickaxe:

git-rev-list linus |
git-diff-tree --stdin -v -s \
-S'	if (obj->type == tag_type)
		obj = ((struct tag *)obj)->tagged;'

git-rev-list linus |
git-diff-tree --stdin -v -s \
-S'	/*
	 * Tag object? Look what it points to..
	 */
	if (object->type == tag_type) {'

------------
cd /opt/packrat/playpen/public/in-place/git/git.junio/
jit-diff 0:5
# - master: format-patch: fix skipping of blank-lines (take 2)
# + 5: tag deref until we get non tag
diff --git a/commit.c b/commit.c
--- a/commit.c
+++ b/commit.c
@@ -52,8 +52,9 @@ struct commit *lookup_commit_reference(c
 
 	if (!obj)
 		return NULL;
-	if (obj->type == tag_type)
-		obj = ((struct tag *)obj)->tagged;
+	while (obj->type == tag_type)
+		obj = parse_object(((struct tag *)obj)->tagged->sha1);
+
 	return check_commit(obj, sha1);
 }
 
diff --git a/rev-list.c b/rev-list.c
--- a/rev-list.c
+++ b/rev-list.c
@@ -354,12 +354,12 @@ static struct commit *get_commit_referen
 	/*
 	 * Tag object? Look what it points to..
 	 */
-	if (object->type == tag_type) {
+	while (object->type == tag_type) {
 		struct tag *tag = (struct tag *) object;
 		object->flags |= flags;
 		if (tag_objects && !(object->flags & UNINTERESTING))
 			add_pending_object(object, tag->tag);
-		object = tag->tagged;
+		object = parse_object(tag->tagged->sha1);
 	}
 
 	/*

Compilation finished at Sat Jul  9 02:37:16
