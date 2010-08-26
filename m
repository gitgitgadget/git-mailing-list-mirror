From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv2 7/8] list-objects.c: Avoid recomputing interesting-ness for subtrees when possible
Date: Thu, 26 Aug 2010 00:21:50 -0600
Message-ID: <1282803711-10253-8-git-send-email-newren@gmail.com>
References: <1282803711-10253-1-git-send-email-newren@gmail.com>
Cc: gitster@pobox.com, pclouds@gmail.com,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 26 08:21:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoVpX-0002cj-Su
	for gcvg-git-2@lo.gmane.org; Thu, 26 Aug 2010 08:20:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752535Ab0HZGUp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Aug 2010 02:20:45 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:47237 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752456Ab0HZGUi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Aug 2010 02:20:38 -0400
Received: by mail-yw0-f46.google.com with SMTP id 1so200832ywh.19
        for <git@vger.kernel.org>; Wed, 25 Aug 2010 23:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=D4cP0yowbmOhPIG9/5p2AFBHI4lnFoIAc3svwH2Emgk=;
        b=CSadyygm9JqVXrHfROj175w+hmvLiPcT36WzCRIrHAoWGogYgN2q4JedkaMcRiNh18
         rifKzWQEgXlCX3rg7MlIu6gtC2zZY62hD/2z/QNbmXBp5TcUKu6uGpKzllLAkWatDlSv
         nx4g3eUObF+hn2djngnwn5ePZGy67Lb9cFYbE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=wI0q48AaXN9F7CbQDcLZxXjFu8e6I37NAEQzjHMAqIIx5fXViclFhFF7tSJwbHJPaA
         Zi7n/7bFI2+Evyxo3OkbKeX3tcl5HgdAcv1qUWNJLl6h/9uKDCrePa7T5O7Cmkgh9WUB
         Z7W66u+vO9jJyzN6eURhG9iSVFmi809jlGmsQ=
Received: by 10.151.122.15 with SMTP id z15mr9741693ybm.249.1282803638010;
        Wed, 25 Aug 2010 23:20:38 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id t20sm7160156ybm.5.2010.08.25.23.20.35
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 25 Aug 2010 23:20:37 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.45.ga60f
In-Reply-To: <1282803711-10253-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154524>

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
index bb95962..488428b 100644
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
 	char *full_prefix = NULL;
 	int full_prefix_len = 0;
 
@@ -112,7 +112,8 @@ static void process_tree(struct rev_info *revs,
 		if (S_ISDIR(entry.mode))
 			process_tree(revs,
 				     lookup_tree(entry.sha1),
-				     show, &me, entry.path);
+				     show, &me, entry.path,
+				     all_interesting);
 		else if (S_ISGITLINK(entry.mode))
 			process_gitlink(revs, entry.sha1,
 					show, &me, entry.path);
@@ -189,7 +190,7 @@ void traverse_commit_list(struct rev_info *revs,
 		}
 		if (obj->type == OBJ_TREE) {
 			process_tree(revs, (struct tree *)obj, show_object,
-				     NULL, name);
+				     NULL, name, revs->diffopt.nr_paths == 0);
 			continue;
 		}
 		if (obj->type == OBJ_BLOB) {
-- 
1.7.2.2.45.ga60f
