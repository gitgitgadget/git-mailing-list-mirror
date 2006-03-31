From: Junio C Hamano <junkio@cox.net>
Subject: Re: Possible --boundary bug
Date: Thu, 30 Mar 2006 23:58:00 -0800
Message-ID: <7v64lvvyev.fsf@assigned-by-dhcp.cox.net>
References: <e5bfff550603301034r58b38500ie5897ed06fce6e9a@mail.gmail.com>
	<e5bfff550603301255j52c68963v4b8eebea697eeecf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Fri Mar 31 09:58:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FPEWG-0001y9-D7
	for gcvg-git@gmane.org; Fri, 31 Mar 2006 09:58:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbWCaH6E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Mar 2006 02:58:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbWCaH6E
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Mar 2006 02:58:04 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:58062 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751258AbWCaH6C (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Mar 2006 02:58:02 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060331075801.WXNV17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 31 Mar 2006 02:58:01 -0500
To: "Marco Costalba" <mcostalba@gmail.com>
In-Reply-To: <e5bfff550603301255j52c68963v4b8eebea697eeecf@mail.gmail.com>
	(Marco Costalba's message of "Thu, 30 Mar 2006 22:55:44 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18222>

"Marco Costalba" <mcostalba@gmail.com> writes:

> Sorry, the good description is below, please ignore the wrong previous one.

I think this patch should fix it.

-- >8 --
rev-list --boundary: fix re-injecting boundary commits.

Marco reported that

	$ git rev-list --boundary --topo-order --parents 5aa44d5..ab57c8d

misses these two boundary commits.

        c649657501bada28794a30102d9c13cc28ca0e5e
        eb38cc689e84a8fd01c1856e889fe8d3b4f1bfb4

Indeed, we can see that gitk shows these two commits at the
bottom, because the --boundary code failed to output them.

The code did not check to avoid pushing the same uninteresting
commit twice to the result list.  I am not sure why this fixes
the reported problem, but this seems to fix it.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
diff --git a/revision.c b/revision.c
index abc8745..c2a95aa 100644
--- a/revision.c
+++ b/revision.c
@@ -420,24 +420,33 @@ static void limit_list(struct rev_info *
 		p = &commit_list_insert(commit, p)->next;
 	}
 	if (revs->boundary) {
-		list = newlist;
-		while (list) {
+		/* mark the ones that are on the result list first */
+		for (list = newlist; list; list = list->next) {
 			struct commit *commit = list->item;
+			commit->object.flags |= TMP_MARK;
+		}
+		for (list = newlist; list; list = list->next) {
+			struct commit *commit = list->item;
 			struct object *obj = &commit->object;
-			struct commit_list *parent = commit->parents;
-			if (obj->flags & (UNINTERESTING|BOUNDARY)) {
-				list = list->next;
-				continue;
-			}
-			while (parent) {
+			struct commit_list *parent;
+			if (obj->flags & UNINTERESTING)
+				continue;
+			for (parent = commit->parents;
+			     parent;
+			     parent = parent->next) {
 				struct commit *pcommit = parent->item;
-				parent = parent->next;
 				if (!(pcommit->object.flags & UNINTERESTING))
 					continue;
 				pcommit->object.flags |= BOUNDARY;
+				if (pcommit->object.flags & TMP_MARK)
+					continue;
+				pcommit->object.flags |= TMP_MARK;
 				p = &commit_list_insert(pcommit, p)->next;
 			}
-			list = list->next;
+		}
+		for (list = newlist; list; list = list->next) {
+			struct commit *commit = list->item;
+			commit->object.flags &= ~TMP_MARK;
 		}
 	}
 	revs->commits = newlist;
