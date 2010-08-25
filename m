From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 6/7] list-objects.c: Avoid recomputing interesting-ness for subtrees when possible
Date: Tue, 24 Aug 2010 20:53:14 -0600
Message-ID: <1282704795-29661-7-git-send-email-newren@gmail.com>
References: <1282704795-29661-1-git-send-email-newren@gmail.com>
Cc: gitster@pobox.com, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 25 04:52:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oo66N-0008G6-83
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 04:52:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756497Ab0HYCwG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Aug 2010 22:52:06 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:48421 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756484Ab0HYCwB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 22:52:01 -0400
Received: by vws3 with SMTP id 3so180981vws.19
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 19:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Ihp/zMA9BvO9IA8139E6XdPZq/Pqto7RgYn0LeLaFsE=;
        b=OyKDHO6wKjtCLjFFXNRQvaRqdmAe0eY3IePTP7Ae0FDZrXERwf7wIq8PJ+6fyNDeJM
         G8WHqqvKmyTJ2ZfXgVUUykYnFkY7PgN74Hg5amxaeLeUiRIL7oM80RDxmDO5lU3BjsHe
         Eg98rjpUJhudi60OfA6GzLFgYjBfso/4wAEYI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=gV17prB557Hm+vWq3xP1Q+8YNwce5xHvWeEbiXdkeTJzi80iItv/2BjMQWXd9HOlPZ
         6MbHV+o7tKbJPre+LZkdteYCptZQlj4quTuo82eczStoJfyMAHaUCw0JVZxxPzptVf6w
         pDNPGuuhy5VHvP1Y5vRcvEpFecze5yYrII9Os=
Received: by 10.220.62.72 with SMTP id w8mr4733657vch.32.1282704718117;
        Tue, 24 Aug 2010 19:51:58 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id v11sm577473vbb.3.2010.08.24.19.51.56
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 24 Aug 2010 19:51:57 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.39.gf7e23
In-Reply-To: <1282704795-29661-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154398>

Weather balloon patch.  Doesn't seem to help much in benchmarks; in fact
I think it sometimes hurts a bit.  Is it worthwhile just in case someone
comes up with a ginormous tree that is really deep with few entries per
tree?  I'm leaning against it, but am sending the patch to at least show
others that it has been considered.

---
No signed-off-by, since I'm not sold on this patch and am somewhat leaning
against it.  It would need a better commit message anyway.  :-)

 list-objects.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/list-objects.c b/list-objects.c
index daa50bf..66e4ccc 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -61,13 +61,13 @@ static void process_tree(struct rev_info *revs,
 			 struct tree *tree,
 			 show_object_fn show,
 			 struct name_path *path,
-			 const char *name)
+			 const char *name,
+			 int all_interesting)
 {
 	struct object *obj = &tree->object;
 	struct tree_desc desc;
 	struct name_entry entry;
 	struct name_path me;
-	int all_interesting = (revs->diffopt.nr_paths == 0);
 
 	if (!revs->tree_objects)
 		return;
@@ -106,7 +106,8 @@ static void process_tree(struct rev_info *revs,
 		if (S_ISDIR(entry.mode))
 			process_tree(revs,
 				     lookup_tree(entry.sha1),
-				     show, &me, entry.path);
+				     show, &me, entry.path,
+				     all_interesting);
 		else if (S_ISGITLINK(entry.mode))
 			process_gitlink(revs, entry.sha1,
 					show, &me, entry.path);
@@ -182,7 +183,7 @@ void traverse_commit_list(struct rev_info *revs,
 		}
 		if (obj->type == OBJ_TREE) {
 			process_tree(revs, (struct tree *)obj, show_object,
-				     NULL, name);
+				     NULL, name, revs->diffopt.nr_paths == 0);
 			continue;
 		}
 		if (obj->type == OBJ_BLOB) {
-- 
1.7.2.2.39.gf7e23
