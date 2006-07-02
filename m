From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 4/3] Fold get_merge_bases_clean() into get_merge_bases()
Date: Sun, 2 Jul 2006 11:49:38 +0200
Message-ID: <20060702094938.GA10944@lsrfire.ath.cx>
References: <Pine.LNX.4.64.0606301927260.12404@g5.osdl.org> <7vy7vedntn.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0606302046230.12404@g5.osdl.org> <20060701150926.GA25800@lsrfire.ath.cx> <7vfyhldvd2.fsf@assigned-by-dhcp.cox.net> <44A6CD1D.2000600@lsrfire.ath.cx> <Pine.LNX.4.64.0607011301480.12404@g5.osdl.org> <7vveqhccnk.fsf@assigned-by-dhcp.cox.net> <7vpsgpccak.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sun Jul 02 11:49:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwyaF-00050K-8o
	for gcvg-git@gmane.org; Sun, 02 Jul 2006 11:49:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964815AbWGBJtk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Jul 2006 05:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964835AbWGBJtk
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Jul 2006 05:49:40 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:6316
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S964815AbWGBJtk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jul 2006 05:49:40 -0400
Received: by neapel230.server4you.de (Postfix, from userid 1000)
	id DE62A1229C; Sun,  2 Jul 2006 11:49:38 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vpsgpccak.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23098>

Due to popular request ;-), change get_merge_bases() to be able to
clean up after itself if needed by adding a cleanup parameter.

We don't need to save the flags and restore them afterwards anymore;
that was a leftover from before the flags were moved out of the
range used in revision.c.  clear_commit_marks() sets them to zero,
which is enough.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>

diff --git a/commit.c b/commit.c
index 70a4eff..94c1d0e 100644
--- a/commit.c
+++ b/commit.c
@@ -1012,7 +1012,8 @@ static void mark_reachable_commits(struc
 	}
 }
 
-struct commit_list *get_merge_bases(struct commit *rev1, struct commit *rev2)
+struct commit_list *get_merge_bases(struct commit *rev1, struct commit *rev2,
+                                    int cleanup)
 {
 	struct commit_list *list = NULL;
 	struct commit_list *result = NULL;
@@ -1080,20 +1081,10 @@ struct commit_list *get_merge_bases(stru
 		tmp = next;
 	}
 
-	return result;
-}
-
-struct commit_list *get_merge_bases_clean(struct commit *rev1,
-                                          struct commit *rev2)
-{
-	unsigned int flags1 = rev1->object.flags;
-	unsigned int flags2 = rev2->object.flags;
-	struct commit_list *result = get_merge_bases(rev1, rev2);
-
-	clear_commit_marks(rev1, PARENT1 | PARENT2 | UNINTERESTING);
-	clear_commit_marks(rev2, PARENT1 | PARENT2 | UNINTERESTING);
-	rev1->object.flags = flags1;
-	rev2->object.flags = flags2;
+	if (cleanup) {
+		clear_commit_marks(rev1, PARENT1 | PARENT2 | UNINTERESTING);
+		clear_commit_marks(rev2, PARENT1 | PARENT2 | UNINTERESTING);
+	}
 
 	return result;
 }
diff --git a/commit.h b/commit.h
index 3a26e29..779ed82 100644
--- a/commit.h
+++ b/commit.h
@@ -105,7 +105,6 @@ struct commit_graft *read_graft_line(cha
 int register_commit_graft(struct commit_graft *, int);
 int read_graft_file(const char *graft_file);
 
-extern struct commit_list *get_merge_bases(struct commit *rev1, struct commit *rev2);
-extern struct commit_list *get_merge_bases_clean(struct commit *rev1, struct commit *rev2);
+extern struct commit_list *get_merge_bases(struct commit *rev1, struct commit *rev2, int cleanup);
 
 #endif /* COMMIT_H */
diff --git a/merge-base.c b/merge-base.c
index b41f76c..59f723f 100644
--- a/merge-base.c
+++ b/merge-base.c
@@ -6,7 +6,7 @@ static int show_all = 0;
 
 static int merge_base(struct commit *rev1, struct commit *rev2)
 {
-	struct commit_list *result = get_merge_bases(rev1, rev2);
+	struct commit_list *result = get_merge_bases(rev1, rev2, 0);
 
 	if (!result)
 		return 1;
diff --git a/revision.c b/revision.c
index 1da6ce3..7865fa4 100644
--- a/revision.c
+++ b/revision.c
@@ -814,7 +814,7 @@ int setup_revisions(int argc, const char
 				}
 
 				if (symmetric) {
-					exclude = get_merge_bases_clean(a, b);
+					exclude = get_merge_bases(a, b, 1);
 					add_pending_commit_list(revs, exclude,
 					                        flags_exclude);
 					a->object.flags |= flags;
