From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Dereference tag repeatedly until we get a non-tag.
Date: Sun, 10 Jul 2005 23:55:56 -0700
Message-ID: <7v8y0dx24j.fsf@assigned-by-dhcp.cox.net>
References: <7v7jg0wb77.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 11 08:56:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DrsDA-0004BO-SK
	for gcvg-git@gmane.org; Mon, 11 Jul 2005 08:56:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261155AbVGKG4A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jul 2005 02:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261183AbVGKG4A
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jul 2005 02:56:00 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:61156 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S261155AbVGKGz6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2005 02:55:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050711065557.CLKQ7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 11 Jul 2005 02:55:57 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7v7jg0wb77.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Sat, 09 Jul 2005 03:00:44 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

When we allow a tag object in place of a commit object, we only
dereferenced the given tag once, which causes a tag that points
at a tag that points at a commit to be rejected.  Instead,
dereference tag repeatedly until we get a non-tag.

This patch makes change to two functions:

 - commit.c::lookup_commit_reference() is used by merge-base,
   rev-tree and rev-parse to convert user supplied SHA1 to that of
   a commit.
 - rev-list uses its own get_commit_reference() to do the same.

Dereferencing tags this way helps both of these uses.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

*** Whether having a tag pointing at another tag is a separate
*** issue, but I do not see a reason to forbid it.  Maybe it
*** is used to represent a chain of trust.

 commit.c   |    5 +++--
 rev-list.c |    4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

0dc9377363ee73c5e3f3711d6f82e49886ce8c6a
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
@@ -367,12 +367,12 @@ static struct commit *get_commit_referen
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
