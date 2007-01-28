From: Junio C Hamano <junkio@cox.net>
Subject: Re: More precise tag following
Date: Sun, 28 Jan 2007 01:27:38 -0800
Message-ID: <7vps8zfqlx.fsf@assigned-by-dhcp.cox.net>
References: <7vy7nqxd08.fsf@assigned-by-dhcp.cox.net>
	<20070127080126.GC9966@spearce.org>
	<Pine.LNX.4.64.0701270837170.25027@woody.linux-foundation.org>
	<Pine.LNX.4.64.0701270945260.25027@woody.linux-foundation.org>
	<7vzm84gmei.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0701271439340.25027@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Jan 28 10:27:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HB6KC-0004yc-0r
	for gcvg-git@gmane.org; Sun, 28 Jan 2007 10:27:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932480AbXA1J1l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 Jan 2007 04:27:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932500AbXA1J1l
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Jan 2007 04:27:41 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:37770 "EHLO
	fed1rmmtao04.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932480AbXA1J1j (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jan 2007 04:27:39 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070128092739.XWFU20530.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>;
          Sun, 28 Jan 2007 04:27:39 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id GZSg1W00j1kojtg0000000; Sun, 28 Jan 2007 04:26:41 -0500
In-Reply-To: <Pine.LNX.4.64.0701271439340.25027@woody.linux-foundation.org>
	(Linus Torvalds's message of "Sat, 27 Jan 2007 14:54:10 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38026>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sat, 27 Jan 2007, Junio C Hamano wrote:
>> 
>> I would think we probably should reuse the --porcelain output,
>> perhaps enhancing it even more.
>
> I looked at using "emit_porcelain()" directly, but that format doesn't 
> seem to actually be usable for incremental blame.

I agree the code itself wouldn't be for the reasons you stated.

> Also, for the incremental blame, it makes no sense to actually print out 
> the actual blame buffer: anybody who uses the incremental blame thing 
> really needs to get the original buffer separately set up anyway.

Yes and no -- it might be interesting to start from a blank
canvas, and insert the lines as they are received at appropriate
places (recorded as ent->lno), although in general I agree the
GUI would have the way and the need to grab the blob contents
without us giving it in the --incremental output.

I think it is sensible to do the attached on top of your patch.

-- >8 --
[PATCH] Update blame --incremental output format.

It makes the output show the origin information in the same
format as the porcelain format.  The first line has commit
object name, the line number of the first line in the group in
the original file, the line number of that file in the final
image, and number of lines in the group.  Then subsequent lines
show the metainformation for the commit when the commit is shown
for the first time, except the filename information is always
shown (we cannot even make it conditional to -C option as blame
always follows the renaming of the file wholesale).

Two things I updated are (1) line numbers start at 1, not 0, to
make it consistent with other formats, (2) filename is C-quoted
if needed.

The latter should be done to fix the original porcelain output;
it was an oversight.

 builtin-blame.c |   67 +++++++++++++++++++++++++++++++++++++------------------
 1 files changed, 45 insertions(+), 22 deletions(-)

diff --git a/builtin-blame.c b/builtin-blame.c
index 7d97ae9..967e30d 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -13,6 +13,7 @@
 #include "diff.h"
 #include "diffcore.h"
 #include "revision.h"
+#include "quote.h"
 #include "xdiff-interface.h"
 
 static char blame_usage[] =
@@ -1071,18 +1072,56 @@ static void pass_blame(struct scoreboard *sb, struct origin *origin, int opt)
 		origin_decref(parent_origin[i]);
 }
 
+struct commit_info
+{
+	char *author;
+	char *author_mail;
+	unsigned long author_time;
+	char *author_tz;
+
+	/* filled only when asked for details */
+	char *committer;
+	char *committer_mail;
+	unsigned long committer_time;
+	char *committer_tz;
+
+	char *summary;
+};
+
+static void get_commit_info(struct commit *commit,
+			    struct commit_info *ret,
+			    int detailed);
+
 static void found_guilty_entry(struct blame_entry *ent)
 {
 	if (ent->guilty)
 		return;
 	ent->guilty = 1;
 	if (incremental) {
-		struct origin *origin = ent->suspect;
-		printf("%d %d %s:%s:%d\n",
-			ent->lno, ent->num_lines,
-			sha1_to_hex(origin->commit->object.sha1),
-			origin->path,
-			ent->s_lno);
+		struct origin *suspect = ent->suspect;
+
+		printf("%s %d %d %d\n",
+		       sha1_to_hex(suspect->commit->object.sha1),
+		       ent->s_lno + 1, ent->lno + 1, ent->num_lines);
+		if (!(suspect->commit->object.flags & METAINFO_SHOWN)) {
+			struct commit_info ci;
+			suspect->commit->object.flags |= METAINFO_SHOWN;
+			get_commit_info(suspect->commit, &ci, 1);
+			printf("author %s\n", ci.author);
+			printf("author-mail %s\n", ci.author_mail);
+			printf("author-time %lu\n", ci.author_time);
+			printf("author-tz %s\n", ci.author_tz);
+			printf("committer %s\n", ci.committer);
+			printf("committer-mail %s\n", ci.committer_mail);
+			printf("committer-time %lu\n", ci.committer_time);
+			printf("committer-tz %s\n", ci.committer_tz);
+			printf("summary %s\n", ci.summary);
+			if (suspect->commit->object.flags & UNINTERESTING)
+				printf("boundary\n");
+		}
+		printf("filename ");
+		write_name_quoted(NULL, 0, suspect->path, 1, stdout);
+		putchar('\n');
 	}
 }
 
@@ -1152,22 +1191,6 @@ static const char *format_time(unsigned long time, const char *tz_str,
 	return time_buf;
 }
 
-struct commit_info
-{
-	char *author;
-	char *author_mail;
-	unsigned long author_time;
-	char *author_tz;
-
-	/* filled only when asked for details */
-	char *committer;
-	char *committer_mail;
-	unsigned long committer_time;
-	char *committer_tz;
-
-	char *summary;
-};
-
 static void get_ac_line(const char *inbuf, const char *what,
 			int bufsz, char *person, char **mail,
 			unsigned long *time, char **tz)
