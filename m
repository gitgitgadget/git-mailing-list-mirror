From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] Correct priority of lightweight tags in git-describe.
Date: Sun, 14 Jan 2007 11:31:18 -0800
Message-ID: <7vodp1flrt.fsf@assigned-by-dhcp.cox.net>
References: <2a044746b474f7c1840116762e79481b4669900e.1168767397.git.spearce@spearce.org>
	<20070114093744.GB15007@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 15 19:30:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@m.gmane.org
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6VWX-0000sn-UP
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 18:21:33 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1H6V7z-0003eK-DU
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 17:56:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751635AbXANTbU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 Jan 2007 14:31:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751643AbXANTbU
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Jan 2007 14:31:20 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:64394 "EHLO
	fed1rmmtao03.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751635AbXANTbT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jan 2007 14:31:19 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070114193119.THT29122.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>;
          Sun, 14 Jan 2007 14:31:19 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id B7Xb1W00e1kojtg0000000; Sun, 14 Jan 2007 14:31:36 -0500
To: "Shawn O. Pearce" <spearce@spearce.org>
In-Reply-To: <20070114093744.GB15007@spearce.org> (Shawn O. Pearce's message
	of "Sun, 14 Jan 2007 04:37:44 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36826>

How about this on top?

 * We seem to do "a_" more often than "_a" for parameter names
   we type-cast.

 * int would be enough for 'depth', not long.  Also, "return
   (a->depth - b->depth)" is kosher only when it is signed,
   although it works in practice on sane platforms.

 * I did not find mergesort(); if we want stable, explicitly do
   so.  In practice, qsort() seems stable (as you know qsort()
   does not have to be implemented as quicksort).

--

diff --git a/builtin-describe.c b/builtin-describe.c
index 45fea10..e38c899 100644
--- a/builtin-describe.c
+++ b/builtin-describe.c
@@ -121,18 +121,21 @@ static int compare_names(const void *_a, const void *_b)
 
 struct possible_tag {
 	struct commit_name *name;
-	unsigned long depth;
+	int depth;
+	int found_order;
 	unsigned flag_within;
 };
 
-static int compare_pt(const void *_a, const void *_b)
+static int compare_pt(const void *a_, const void *b_)
 {
-	struct possible_tag *a = (struct possible_tag *)_a;
-	struct possible_tag *b = (struct possible_tag *)_b;
+	struct possible_tag *a = (struct possible_tag *)a_;
+	struct possible_tag *b = (struct possible_tag *)b_;
 	if (a->name->prio != b->name->prio)
 		return b->name->prio - a->name->prio;
 	if (a->depth != b->depth)
 		return a->depth - b->depth;
+	if (a->found_order != b->found_order)
+		return a->found_order - b->found_order;
 	return 0;
 }
 
@@ -146,6 +149,7 @@ static void describe(const char *arg, int last_one)
 	struct possible_tag all_matches[MAX_TAGS];
 	unsigned int match_cnt = 0, annotated_cnt = 0, cur_match;
 	unsigned long seen_commits = 0;
+	int found = 0;
 
 	if (get_sha1(arg, sha1))
 		die("Not a valid object name %s", arg);
@@ -185,6 +189,7 @@ static void describe(const char *arg, int last_one)
 				t->name = n;
 				t->depth = seen_commits - 1;
 				t->flag_within = 1u << match_cnt;
+				t->found_order = found++;
 				c->object.flags |= t->flag_within;
 				if (n->prio == 2)
 					annotated_cnt++;
@@ -219,11 +224,11 @@ static void describe(const char *arg, int last_one)
 	if (!match_cnt)
 		die("cannot describe '%s'", sha1_to_hex(cmit->object.sha1));
 
-	mergesort(all_matches, match_cnt, sizeof(all_matches[0]), compare_pt);
+	qsort(all_matches, match_cnt, sizeof(all_matches[0]), compare_pt);
 	if (debug) {
 		for (cur_match = 0; cur_match < match_cnt; cur_match++) {
 			struct possible_tag *t = &all_matches[cur_match];
-			fprintf(stderr, " %-11s %8lu %s\n",
+			fprintf(stderr, " %-11s %8d %s\n",
 				prio_names[t->name->prio],
 				t->depth, t->name->path);
 		}
