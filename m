From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH/RFC 2/2] Make path-limiting be incremental when possible.
Date: Sat, 01 Apr 2006 19:11:17 -0800
Message-ID: <7vacb4oene.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0603301648530.27203@g5.osdl.org>
	<Pine.LNX.4.64.0603301652531.27203@g5.osdl.org>
	<7vr74jxhp3.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0603302225160.27203@g5.osdl.org>
	<7vr74jw0zj.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604011628500.3684@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 02 05:11:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FPszy-0006w8-Fv
	for gcvg-git@gmane.org; Sun, 02 Apr 2006 05:11:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751657AbWDBDLY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Apr 2006 22:11:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751655AbWDBDLY
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Apr 2006 22:11:24 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:4803 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751213AbWDBDLX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Apr 2006 22:11:23 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060402031118.MSQF20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 1 Apr 2006 22:11:18 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604011628500.3684@g5.osdl.org> (Linus Torvalds's
	message of "Sat, 1 Apr 2006 16:35:06 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18255>

Linus Torvalds <torvalds@osdl.org> writes:

> What ends up not working very well at all is the combination of 
> "--topo-order" and the output filter in get_revision. It will return NULL 
> when we see the first commit out of date-order, even if we have other 
> commits coming.
>
> So we really should do the "past the date order" thing in get_revision() 
> only if we have _not_ done it already in limit_list().

Right now --max-age causes "limited" so there should not be a
difference, if I am not mistaken.  But I've been meaning to
change that, so the patch makes sense.  Similarly,...

-- >8 --
[PATCH] revision: --topo-order and --unpacked

Now, using --unpacked without limit_list() does not make much
sense, but this is parallel to the earlier --max-age fix.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 revision.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

22c31bf183bff576c7807f9d67abfc11ee8e1fa4
diff --git a/revision.c b/revision.c
index 558ed01..07cc86f 100644
--- a/revision.c
+++ b/revision.c
@@ -787,7 +787,10 @@ struct commit *get_revision(struct rev_i
 		 * that we'd otherwise have done in limit_list().
 		 */
 		if (!revs->limited) {
-			if (revs->max_age != -1 && (commit->date < revs->max_age))
+			if ((revs->unpacked &&
+			     has_sha1_pack(commit->object.sha1)) ||
+			    (revs->max_age != -1 &&
+			     (commit->date < revs->max_age)))
 				continue;
 			add_parents_to_list(revs, commit, &revs->commits);
 		}
-- 
1.3.0.rc1.gf385
