From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: A note on merging conflicts..
Date: Sat, 1 Jul 2006 19:45:33 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0607011937190.9789@iabervon.org>
References: <Pine.LNX.4.64.0606301927260.12404@g5.osdl.org>
 <7vy7vedntn.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0606302046230.12404@g5.osdl.org>
 <20060701150926.GA25800@lsrfire.ath.cx> <20060701180125.GA27550@fieldses.org>
 <Pine.LNX.4.64.0607011115500.12404@g5.osdl.org> <Pine.LNX.4.64.0607011754370.9789@iabervon.org>
 <Pine.LNX.4.64.0607011552170.12404@g5.osdl.org> <Pine.LNX.4.64.0607011905030.9789@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	Rene Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 02 01:45:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fwp9Q-0000ze-C7
	for gcvg-git@gmane.org; Sun, 02 Jul 2006 01:45:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932372AbWGAXpR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Jul 2006 19:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932389AbWGAXpR
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Jul 2006 19:45:17 -0400
Received: from iabervon.org ([66.92.72.58]:29714 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S932372AbWGAXpP (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Jul 2006 19:45:15 -0400
Received: (qmail 23057 invoked by uid 1000); 1 Jul 2006 19:45:33 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 1 Jul 2006 19:45:33 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607011905030.9789@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23082>

On Sat, 1 Jul 2006, Daniel Barkalow wrote:

> Actually, I think that it would work to have object flags "LEFT" and 
> "RIGHT", mark b with left, mark c with right, and mark anything with both 
> LEFT and RIGHT as UNINTERESTING as we go through the revisions. The 
> time-ordering problem with symmetric difference isn't absent with regular 
> difference, and, assuming that b..c works in the tricky cases, the same 
> logic should handle symmetric difference.

That is: (this only has the logic portion, and it's against master, so it 
isn't actually a really working patch or anything; also, it doesn't handle 
"--not a...b" correctly, whatever that should mean)

---

diff --git a/revision.c b/revision.c
index 6a6952c..c21d332 100644
--- a/revision.c
+++ b/revision.c
@@ -351,6 +351,9 @@ static void add_parents_to_list(struct r
 		return;
 	commit->object.flags |= ADDED;
 
+	if (commit->object.flags & LEFT && commit->objects.flags & RIGHT)
+		commit->object.flags |= UNINTERESTING;
+
 	/*
 	 * If the commit is uninteresting, don't try to
 	 * prune parents - we want the maximal uninteresting
@@ -781,8 +784,13 @@ int setup_revisions(int argc, const char
 				struct object *exclude;
 				struct object *include;
 
-				exclude = get_reference(revs, this, from_sha1, flags ^ UNINTERESTING);
-				include = get_reference(revs, next, sha1, flags);
+				if (symmetric) {
+					exclude = get_reference(revs, this, from_sha1, flags ^ UNINTERESTING);
+					include = get_reference(revs, next, sha1, flags);
+				} else {
+					exclude = get_reference(revs, this, from_sha1, flags | LEFT_HALF);
+					include = get_reference(revs, next, sha1, flags | RIGHT_HALF);
+				}
 				if (!exclude || !include)
 					die("Invalid revision range %s..%s", arg, next);
 
diff --git a/revision.h b/revision.h
index 7d85b0f..93421e6 100644
--- a/revision.h
+++ b/revision.h
@@ -9,6 +9,8 @@
 #define BOUNDARY	(1u<<5)
 #define BOUNDARY_SHOW	(1u<<6)
 #define ADDED		(1u<<7)	/* Parents already parsed and added? */
+#define LEFT_HALF	(1u<<8) /* Reachable from start of dotdotdot */
+#define RIGHT_HALF	(1u<<9) /* Reachable from end of dotdotdot */
 
 struct rev_info;
 struct log_info;
-- 
1.2.4
