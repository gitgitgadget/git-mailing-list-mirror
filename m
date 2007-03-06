From: Junio C Hamano <junkio@cox.net>
Subject: SHOWN means shown
Date: Mon, 05 Mar 2007 18:23:57 -0800
Message-ID: <7vzm6rt8hu.fsf_-_@assigned-by-dhcp.cox.net>
References: <8aa486160703050202y5ee159d2i42a2859a00b41679@mail.gmail.com>
	<7vlkicynwm.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0703051951340.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0703051130090.3998@woody.linux-foundation.org>
	<Pine.LNX.4.64.0703051145210.3998@woody.linux-foundation.org>
	<Pine.LNX.4.63.0703060016020.13683@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vk5xvw6mg.fsf@assigned-by-dhcp.cox.net>
	<7vzm6rurst.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0703060253140.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v4pozuncr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Santi =?utf-8?Q?B?= =?utf-8?Q?=C3=A9jar?= <sbejar@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 06 03:24:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOPMA-0007KU-Mr
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 03:24:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965767AbXCFCYD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 21:24:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965773AbXCFCYB
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 21:24:01 -0500
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:62194 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965767AbXCFCX7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 21:23:59 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070306022357.CTZL26279.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Mon, 5 Mar 2007 21:23:57 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id XEPy1W00B1kojtg0000000; Mon, 05 Mar 2007 21:23:58 -0500
In-Reply-To: <7v4pozuncr.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 05 Mar 2007 18:17:40 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41530>

This moves the code to set SHOWN on the commit from get_revision_1() 
back to get_revision(), so that the bit means what it originally
meant: this commit has been given back to the caller.

Also it fixes the --reverse breakage Dscho pointed out.

---

  Junio C Hamano <junkio@cox.net> writes:

  >> Is this really relevant in practice?
  >
  > Absolutely.  But I have further updates on this series.

  ... otherwise, "git-bundle create -3 A B" when B is A~3 would
  mistakenly say "Ah, B is SHOWN so include it".

 revision.c |   26 ++++++++++++++++++--------
 1 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/revision.c b/revision.c
index 2d27ccf..35a1711 100644
--- a/revision.c
+++ b/revision.c
@@ -1227,7 +1227,6 @@ static struct commit *get_revision_1(struct rev_info *revs)
 			if (revs->parents)
 				rewrite_parents(revs, commit);
 		}
-		commit->object.flags |= SHOWN;
 		return commit;
 	} while (revs->commits);
 	return NULL;
@@ -1280,11 +1279,22 @@ struct commit *get_revision(struct rev_info *revs)
 	}
 
 	if (revs->reverse) {
+		int limit = -1;
+
+		if (0 <= revs->max_count) {
+			limit = revs->max_count;
+			if (0 < revs->skip_count)
+				limit += revs->skip_count;
+		}
 		l = NULL;
-		while ((c = get_revision_1(revs)))
+		while ((c = get_revision_1(revs))) {
 			commit_list_insert(c, &l);
+			if ((0 < limit) && !--limit)
+				break;
+		}
 		revs->commits = l;
 		revs->reverse = 0;
+		revs->max_count = -1;
 		c = NULL;
 	}
 
@@ -1298,8 +1308,6 @@ struct commit *get_revision(struct rev_info *revs)
 		c = get_revision_1(revs);
 		if (!c)
 			break;
-		/* Although we grabbed it, it is not shown. */
-		c->object.flags &= ~SHOWN;
 	}
 
 	/*
@@ -1310,16 +1318,18 @@ struct commit *get_revision(struct rev_info *revs)
 		break;
 	case 0:
 		/* Although we grabbed it, it is not shown. */
-		if (c)
-			c->object.flags &= ~SHOWN;
 		c = NULL;
 		break;
 	default:
 		revs->max_count--;
 	}
 
-	if (!revs->boundary)
+	if (c)
+		c->object.flags |= SHOWN;
+
+	if (!revs->boundary) {
 		return c;
+	}
 
 	if (!c) {
 		/*
@@ -1341,7 +1351,7 @@ struct commit *get_revision(struct rev_info *revs)
 	for (l = c->parents; l; l = l->next) {
 		struct object *p;
 		p = &(l->item->object);
-		if (p->flags & CHILD_SHOWN)
+		if (p->flags & (CHILD_SHOWN | SHOWN))
 			continue;
 		p->flags |= CHILD_SHOWN;
 		gc_boundary(&revs->boundary_commits);
