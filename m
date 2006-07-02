From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: Re: A note on merging conflicts..
Date: Sun, 2 Jul 2006 13:31:33 +0200
Message-ID: <20060702113133.GA11529@lsrfire.ath.cx>
References: <Pine.LNX.4.64.0606301927260.12404@g5.osdl.org> <7vy7vedntn.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0606302046230.12404@g5.osdl.org> <20060701150926.GA25800@lsrfire.ath.cx> <20060701180125.GA27550@fieldses.org> <Pine.LNX.4.64.0607011115500.12404@g5.osdl.org> <Pine.LNX.4.64.0607011754370.9789@iabervon.org> <Pine.LNX.4.64.0607011552170.12404@g5.osdl.org> <Pine.LNX.4.64.0607011905030.9789@iabervon.org> <Pine.LNX.4.64.0607011937190.9789@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 02 13:31:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fx0As-00027x-9o
	for gcvg-git@gmane.org; Sun, 02 Jul 2006 13:31:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964867AbWGBLbf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Jul 2006 07:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964870AbWGBLbf
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Jul 2006 07:31:35 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:35300
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S964867AbWGBLbe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jul 2006 07:31:34 -0400
Received: by neapel230.server4you.de (Postfix, from userid 1000)
	id 8A6CA1A01F; Sun,  2 Jul 2006 13:31:33 +0200 (CEST)
To: Daniel Barkalow <barkalow@iabervon.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607011937190.9789@iabervon.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23103>

On Sat, Jul 01, 2006 at 07:45:33PM -0400, Daniel Barkalow wrote:
> That is: (this only has the logic portion, and it's against master, so it 
> isn't actually a really working patch or anything; also, it doesn't handle 
> "--not a...b" correctly, whatever that should mean)

[concept patch snipped]

You mean something like the patch below?  It seems to work, but in my
unscientific tests it's significant slower than the version based on
get_merge_bases() (0.17s vs 0.05s for
"git-rev-list 89719209...262a6ef7 66ae0c77...ced9456a").  Did I do
something wrong?

You had no mark_parents_left_right() in your patch.  I added it because
otherwise it wouldn't remove any common commits.  Was this supposed to
work some other way?

We still need an automatic test case, and a better benchmark.

diff --git a/revision.c b/revision.c
index ebee05a..8c494ee 100644
--- a/revision.c
+++ b/revision.c
@@ -339,6 +339,20 @@ static void try_to_simplify_commit(struc
 		commit->object.flags |= TREECHANGE;
 }
 
+static void mark_parents_left_right(struct commit *commit)
+{
+	unsigned int flags = commit->object.flags & (RIGHT_HALF | LEFT_HALF);
+	struct commit_list *parents = commit->parents;
+
+	while (parents) {
+		struct commit *p = parents->item;
+		p->object.flags |= flags;
+		if (p->parents)
+			mark_parents_left_right(p);
+		parents = parents->next;
+	}
+}
+
 static void add_parents_to_list(struct rev_info *revs, struct commit *commit, struct commit_list **list)
 {
 	struct commit_list *parent = commit->parents;
@@ -347,6 +361,13 @@ static void add_parents_to_list(struct r
 		return;
 	commit->object.flags |= ADDED;
 
+	if (commit->object.flags & (RIGHT_HALF | LEFT_HALF)) {
+		if (commit->object.flags & RIGHT_HALF &&
+		    commit->object.flags & LEFT_HALF)
+			commit->object.flags |= UNINTERESTING;
+		mark_parents_left_right(commit);
+	}
+
 	/*
 	 * If the commit is uninteresting, don't try to
 	 * prune parents - we want the maximal uninteresting
@@ -772,7 +793,10 @@ int setup_revisions(int argc, const char
 			unsigned char from_sha1[20];
 			const char *next = dotdot + 2;
 			const char *this = arg;
+			int symmetric = *next == '.';
+
 			*dotdot = 0;
+			next += symmetric;
 			if (!*next)
 				next = "HEAD";
 			if (dotdot == arg)
@@ -782,8 +806,13 @@ int setup_revisions(int argc, const char
 				struct object *exclude;
 				struct object *include;
 
-				exclude = get_reference(revs, this, from_sha1, flags ^ UNINTERESTING);
-				include = get_reference(revs, next, sha1, flags);
+				if (symmetric) {
+					exclude = get_reference(revs, this, from_sha1, flags | LEFT_HALF);
+					include = get_reference(revs, next, sha1, flags | RIGHT_HALF);
+				} else {
+					exclude = get_reference(revs, this, from_sha1, flags ^ UNINTERESTING);
+					include = get_reference(revs, next, sha1, flags);
+				}
 				if (!exclude || !include)
 					die("Invalid revision range %s..%s", arg, next);
 
diff --git a/revision.h b/revision.h
index c010a08..0090232 100644
--- a/revision.h
+++ b/revision.h
@@ -9,6 +9,8 @@ #define TMP_MARK	(1u<<4) /* for isolated
 #define BOUNDARY	(1u<<5)
 #define BOUNDARY_SHOW	(1u<<6)
 #define ADDED		(1u<<7)	/* Parents already parsed and added? */
+#define RIGHT_HALF	(1u<<8)
+#define LEFT_HALF	(1u<<9)
 
 struct rev_info;
 struct log_info;
