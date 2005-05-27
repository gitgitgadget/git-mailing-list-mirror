From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 02/12] Introduce diff_free_filepair() funcion.
Date: Fri, 27 May 2005 15:50:30 -0700
Message-ID: <7v7jhk5lmx.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505261731050.17207@ppc970.osdl.org>
	<7vsm091887.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505270848220.17402@ppc970.osdl.org>
	<7vk6lk5lxt.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 28 00:49:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbndO-0001n3-Cu
	for gcvg-git@gmane.org; Sat, 28 May 2005 00:48:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262639AbVE0Wu5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 May 2005 18:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262641AbVE0Wu5
	(ORCPT <rfc822;git-outgoing>); Fri, 27 May 2005 18:50:57 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:37329 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S262639AbVE0Wuc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2005 18:50:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050527225031.NIEW16890.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 27 May 2005 18:50:31 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vk6lk5lxt.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Fri, 27 May 2005 15:43:58 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This introduces a new function to free a common data structure,
and plugs some leaks.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

diff.c              |   15 +++++++++------
diffcore-pathspec.c |    2 +-
diffcore-pickaxe.c  |    2 +-
diffcore-rename.c   |    7 ++-----
diffcore.h          |    2 ++
5 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/diff.c b/diff.c
--- a/diff.c
+++ b/diff.c
@@ -521,6 +521,13 @@ struct diff_filepair *diff_queue(struct 
 	return dp;
 }
 
+void diff_free_filepair(struct diff_filepair *p)
+{
+	diff_free_filespec_data(p->one);
+	diff_free_filespec_data(p->two);
+	free(p);
+}
+
 static void diff_flush_raw(struct diff_filepair *p,
 			   int line_termination,
 			   int inter_name_termination)
@@ -817,12 +824,8 @@ void diff_flush(int diff_output_style, i
 			break;
 		}
 	}
-	for (i = 0; i < q->nr; i++) {
-		struct diff_filepair *p = q->queue[i];
-		diff_free_filespec_data(p->one);
-		diff_free_filespec_data(p->two);
-		free(p);
-	}
+	for (i = 0; i < q->nr; i++)
+		diff_free_filepair(q->queue[i]);
 	free(q->queue);
 	q->queue = NULL;
 	q->nr = q->alloc = 0;
diff --git a/diffcore-pathspec.c b/diffcore-pathspec.c
--- a/diffcore-pathspec.c
+++ b/diffcore-pathspec.c
@@ -59,7 +59,7 @@ void diffcore_pathspec(const char **path
 		    matches_pathspec(p->two->path, spec, speccnt))
 			diff_q(&outq, p);
 		else
-			free(p);
+			diff_free_filepair(p);
 	}
 	free(q->queue);
 	*q = outq;
diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -49,7 +49,7 @@ void diffcore_pickaxe(const char *needle
 			 contains(p->two, needle, len))
 			diff_q(&outq, p);
 		if (onum == outq.nr)
-			free(p);
+			diff_free_filepair(p);
 	}
 	free(q->queue);
 	*q = outq;
diff --git a/diffcore-rename.c b/diffcore-rename.c
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -361,11 +361,8 @@ void diffcore_rename(int detect_rename, 
 			else
 				pair_to_free = p;
 		}
-		if (pair_to_free) {
-			diff_free_filespec_data(pair_to_free->one);
-			diff_free_filespec_data(pair_to_free->two);
-			free(pair_to_free);
-		}
+		if (pair_to_free)
+			diff_free_filepair(pair_to_free);
 	}
 	diff_debug_queue("done copying original", &outq);
 
diff --git a/diffcore.h b/diffcore.h
--- a/diffcore.h
+++ b/diffcore.h
@@ -54,6 +54,8 @@ struct diff_filepair {
 	(S_ISREG(mode) ? (S_IFREG | ce_permissions(mode)) : \
 	S_ISLNK(mode) ? S_IFLNK : S_IFDIR)
 
+extern void diff_free_filepair(struct diff_filepair *);
+
 extern int diff_unmodified_pair(struct diff_filepair *);
 
 struct diff_queue_struct {
------------------------------------------------

