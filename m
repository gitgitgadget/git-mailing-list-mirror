From: Junio C Hamano <junkio@cox.net>
Subject: Re: blameview and file line number
Date: Tue, 30 Jan 2007 02:39:14 -0800
Message-ID: <7vd54w23zh.fsf@assigned-by-dhcp.cox.net>
References: <cc723f590701292325k1c85d9edgb9e72ae380fcaad7@mail.gmail.com>
	<7vireo52xs.fsf@assigned-by-dhcp.cox.net>
	<cc723f590701300112x6493a0eaw153aad1a18cd289a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>
To: "Aneesh Kumar" <aneesh.kumar@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 30 11:41:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBqOY-0007D4-TO
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 11:39:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933149AbXA3KjT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 05:39:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933151AbXA3KjT
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 05:39:19 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:35007 "EHLO
	fed1rmmtao01.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933149AbXA3KjS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 05:39:18 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070130103915.GMCO9173.fed1rmmtao01.cox.net@fed1rmimpo02.cox.net>;
          Tue, 30 Jan 2007 05:39:15 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id HNfa1W00D1kojtg0000000; Tue, 30 Jan 2007 05:39:35 -0500
In-Reply-To: <cc723f590701300112x6493a0eaw153aad1a18cd289a@mail.gmail.com>
	(Aneesh Kumar's message of "Tue, 30 Jan 2007 14:42:31 +0530")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38151>

"Aneesh Kumar" <aneesh.kumar@gmail.com> writes:

> In that case the heading is wrong. It should be something other than
> Filenum.

You mean "FileLine"?

>  my $fileview = Gtk2::SimpleList->new(
>      'Commit' => 'text',
> +    'OrigLine' => 'text',
>      'CommitInfo' => 'text',
>      'FileLine' => 'text',
>      'Data' => 'text'

I do not have strong feeling to defend what Jeff originally did,
especially as this is only a sample program, whose primary
purpose is to demonstrate how the incremental display can be
used.

Having said that, I think the behaviour of the original makes
quite a lot of sense.  HEAD commit starts out to be tentatively
blamed for everything, and the filename and the line number in
that HEAD commit are shown for everything at the beginning, and
as the processing progresses, the labels for the ones whose
truely guilty party are known are updated to show the guilty
commit, the filename from that guilty commit and the line number
in that guilty commit.  I think the label "FileLine" reflects
what it is showing quite well.

As Linus mentioned, the screen real estate is already wasted by
too much metainfomation.  Although I do not care too much about
the UI issue in it since this is only a sample program, showing
the line number for each line in the final image ($lno) to waste
more space feels doubly wrong.

By the way, telling git-gui to annotate revision.h with the
attached patch was fun to watch.

-- >8 --
[PATCH] Louder git-blame --incremental

This patch takes the ability for --incremental to monitor the
process of "HEAD starts out to be tentatively blamed for
everything, and then blame is passed onto the parents" to the
extreme.  As blame is passed on to parents, incremental output
gives the information for tentatively blamed commits.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 builtin-blame.c |   22 ++++++++++++++++------
 1 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/builtin-blame.c b/builtin-blame.c
index 3033e9b..107524c 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -549,6 +549,8 @@ static void free_patch(struct patch *p)
 	free(p);
 }
 
+static void found_guilty_entry(struct blame_entry *ent, int final);
+
 /*
  * Link in a new blame entry to the scorebord.  Entries that cover the
  * same line range have been removed from the scoreboard previously.
@@ -682,13 +684,16 @@ static void split_blame(struct scoreboard *sb,
 		new_entry = xmalloc(sizeof(*new_entry));
 		memcpy(new_entry, &(split[1]), sizeof(struct blame_entry));
 		add_blame_entry(sb, new_entry);
+		found_guilty_entry(new_entry, 0);
 	}
-	else if (!split[0].suspect && !split[2].suspect)
+	else if (!split[0].suspect && !split[2].suspect) {
 		/*
 		 * The parent covers the entire area; reuse storage for
 		 * e and replace it with the parent.
 		 */
 		dup_entry(e, &split[1]);
+		found_guilty_entry(e, 0);
+	}
 	else if (split[0].suspect) {
 		/* me and then parent */
 		dup_entry(e, &split[0]);
@@ -696,10 +701,12 @@ static void split_blame(struct scoreboard *sb,
 		new_entry = xmalloc(sizeof(*new_entry));
 		memcpy(new_entry, &(split[1]), sizeof(struct blame_entry));
 		add_blame_entry(sb, new_entry);
+		found_guilty_entry(new_entry, 0);
 	}
 	else {
 		/* parent and then me */
 		dup_entry(e, &split[1]);
+		found_guilty_entry(e, 0);
 
 		new_entry = xmalloc(sizeof(*new_entry));
 		memcpy(new_entry, &(split[2]), sizeof(struct blame_entry));
@@ -1359,11 +1366,13 @@ static void write_filename_info(const char *path)
  * The blame_entry is found to be guilty for the range.  Mark it
  * as such, and show it in incremental output.
  */
-static void found_guilty_entry(struct blame_entry *ent)
+static void found_guilty_entry(struct blame_entry *ent, int final)
 {
-	if (ent->guilty)
-		return;
-	ent->guilty = 1;
+	if (final) {
+		if (ent->guilty)
+			return;
+		ent->guilty = 1;
+	}
 	if (incremental) {
 		struct origin *suspect = ent->suspect;
 
@@ -1385,6 +1394,7 @@ static void found_guilty_entry(struct blame_entry *ent)
 			printf("summary %s\n", ci.summary);
 			if (suspect->commit->object.flags & UNINTERESTING)
 				printf("boundary\n");
+			printf("tentative %s\n", final ? "yes" : "no");
 		}
 		write_filename_info(suspect->path);
 	}
@@ -1432,7 +1442,7 @@ static void assign_blame(struct scoreboard *sb, struct rev_info *revs, int opt)
 		/* Take responsibility for the remaining entries */
 		for (ent = sb->ent; ent; ent = ent->next)
 			if (!cmp_suspect(ent->suspect, suspect))
-				found_guilty_entry(ent);
+				found_guilty_entry(ent, 1);
 		origin_decref(suspect);
 
 		if (DEBUG) /* sanity */
