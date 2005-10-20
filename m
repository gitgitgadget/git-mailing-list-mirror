From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Do not send "want" lines for complete objects
Date: Wed, 19 Oct 2005 18:16:11 -0700
Message-ID: <7vwtk9vvhg.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0510200004290.7689@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vzmp5xfwu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 20 03:16:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESP2W-0005Dh-5O
	for gcvg-git@gmane.org; Thu, 20 Oct 2005 03:16:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751681AbVJTBQN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Oct 2005 21:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751684AbVJTBQN
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Oct 2005 21:16:13 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:46221 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751678AbVJTBQN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2005 21:16:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051020011613.BRCX9260.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 19 Oct 2005 21:16:13 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <7vzmp5xfwu.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 19 Oct 2005 16:09:37 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10332>

Junio C Hamano <junkio@cox.net> writes:

> Let's draw a single strand of pearl case to illustrate.  You
> have a commit chain A->B->C->D, and the other end says she has
> C.  At this point, telling her that you have C is enough, and by
> not telling her about A and B, you would save her from depreting
> MAX_HAVE slots.  Of course, if the other end has D as another
> head, then the above logic would give "^D^" to rev-list as well,
> telling it not to tell her about C, but that is what we want --
> because she already knows you have C too when you tell her that
> you have D.  I think I like this optimization.

This was subtly wrong.  ^D^ would barf if D is a tag that points
at a non commit (refs/tags/v2.6.11-tree).  Also it would do a
suboptimal thing for a merge commit, since it will not cull the
second and later parents.

Maybe something like this on top of your patch?  This is turning
out to be quite ugly.

---

diff --git a/fetch-pack.c b/fetch-pack.c
index 9dfd072..5cc3766 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -28,20 +28,29 @@ static int find_common(int fd[2], unsign
 	fetching = 0;
 	for ( ; refs ; refs = refs->next) {
 		unsigned char *remote = refs->old_sha1;
-
+		struct object *o;
+		struct commit *commit;
 		/*
-		   If that object is complete (i.e. it is a descendant of a
-		   local ref), we don't want it, nor its descendants.
-		*/
-		if (has_sha1_file(remote)
-				&& parse_object(remote)->flags & COMPLETE) {
-			if (rev_command_len + 44 < sizeof(rev_command)) {
+		 * If that object is complete (i.e. it is an ancestor of a
+		 * local ref), we tell them we have it but do not have to
+		 * tell them about its ancestors, which they already know
+		 * about.
+		 */
+		if (has_sha1_file(remote) &&
+		    ((o = parse_object(remote)) != NULL) &&
+		    (o->flags & COMPLETE) &&
+		    ((commit = (struct commit *) deref_tag(o)) != NULL) &&
+		    (commit->object.type = commit_type)) {
+			struct commit_list *p = commit->parents;
+			while (p && rev_command_len + 44 < sizeof(rev_command)) {
 				snprintf(rev_command + rev_command_len, 44,
-					" ^%s^", sha1_to_hex(remote));
+					 " ^%s",
+					 sha1_to_hex(p->item->object.sha1));
 				rev_command_len += 43;
+				p = p->next;
 			}
-
-			continue;
+			if (!p)
+				continue;
 		}
 
 		packet_write(fd[1], "want %s\n", sha1_to_hex(remote));
