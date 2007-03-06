From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/4] revision traversal: retire BOUNDARY_SHOW
Date: Mon, 05 Mar 2007 16:41:38 -0800
Message-ID: <7vzm6rurst.fsf@assigned-by-dhcp.cox.net>
References: <8aa486160703050202y5ee159d2i42a2859a00b41679@mail.gmail.com>
	<7vlkicynwm.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0703051951340.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0703051130090.3998@woody.linux-foundation.org>
	<Pine.LNX.4.64.0703051145210.3998@woody.linux-foundation.org>
	<Pine.LNX.4.63.0703060016020.13683@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vk5xvw6mg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Santi =?utf-8?Q?B?= =?utf-8?Q?=C3=A9jar?= <sbejar@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 06 01:41:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HONkO-0004rN-6b
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 01:41:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933579AbXCFAll (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 19:41:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933660AbXCFAll
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 19:41:41 -0500
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:38944 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933579AbXCFAlk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 19:41:40 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070306004139.XNHO24587.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Mon, 5 Mar 2007 19:41:39 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id XChf1W00J1kojtg0000000; Mon, 05 Mar 2007 19:41:39 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41516>

This removes the flag internally used by revision traversal to
decide which commits are indeed boundaries and renames it to
CHILD_SHOWN.  builtin-bundle uses the symbol for its
verification, but I think the logic it uses it is wrong.  The
flag is still useful but it is local to the git-bundle, so it is
renamed to PREREQ_MARK.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 * The earlier one that competed with Johannes's and Linus's is
   the [1/4] of this series.

 builtin-bundle.c |    6 ++++--
 revision.c       |    9 ++++++++-
 revision.h       |    3 +--
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/builtin-bundle.c b/builtin-bundle.c
index d41a413..0265845 100644
--- a/builtin-bundle.c
+++ b/builtin-bundle.c
@@ -160,6 +160,8 @@ static int fork_with_pipe(const char **argv, int *in, int *out)
 	return pid;
 }
 
+#define PREREQ_MARK (1u<<16)
+
 static int verify_bundle(struct bundle_header *header)
 {
 	/*
@@ -179,7 +181,7 @@ static int verify_bundle(struct bundle_header *header)
 		struct ref_list_entry *e = p->list + i;
 		struct object *o = parse_object(e->sha1);
 		if (o) {
-			o->flags |= BOUNDARY_SHOW;
+			o->flags |= PREREQ_MARK;
 			add_pending_object(&revs, o, e->name);
 			continue;
 		}
@@ -202,7 +204,7 @@ static int verify_bundle(struct bundle_header *header)
 
 	i = req_nr;
 	while (i && (commit = get_revision(&revs)))
-		if (commit->object.flags & BOUNDARY_SHOW)
+		if (commit->object.flags & PREREQ_MARK)
 			i--;
 
 	for (i = 0; i < req_nr; i++)
diff --git a/revision.c b/revision.c
index 5d137ea..2d27ccf 100644
--- a/revision.c
+++ b/revision.c
@@ -1285,17 +1285,21 @@ struct commit *get_revision(struct rev_info *revs)
 			commit_list_insert(c, &l);
 		revs->commits = l;
 		revs->reverse = 0;
+		c = NULL;
 	}
 
 	/*
 	 * Now pick up what they want to give us
 	 */
-	c = get_revision_1(revs);
+	if (!(c = get_revision_1(revs)))
+		return NULL;
 	while (0 < revs->skip_count) {
 		revs->skip_count--;
 		c = get_revision_1(revs);
 		if (!c)
 			break;
+		/* Although we grabbed it, it is not shown. */
+		c->object.flags &= ~SHOWN;
 	}
 
 	/*
@@ -1305,6 +1309,9 @@ struct commit *get_revision(struct rev_info *revs)
 	case -1:
 		break;
 	case 0:
+		/* Although we grabbed it, it is not shown. */
+		if (c)
+			c->object.flags &= ~SHOWN;
 		c = NULL;
 		break;
 	default:
diff --git a/revision.h b/revision.h
index 6579a44..1885f8d 100644
--- a/revision.h
+++ b/revision.h
@@ -7,10 +7,9 @@
 #define SHOWN		(1u<<3)
 #define TMP_MARK	(1u<<4) /* for isolated cases; clean after use */
 #define BOUNDARY	(1u<<5)
-#define BOUNDARY_SHOW	(1u<<6)
+#define CHILD_SHOWN	(1u<<6)
 #define ADDED		(1u<<7)	/* Parents already parsed and added? */
 #define SYMMETRIC_LEFT	(1u<<8)
-#define CHILD_SHOWN	(1u<<9)
 
 struct rev_info;
 struct log_info;
-- 
1.5.0.3.862.g71037
