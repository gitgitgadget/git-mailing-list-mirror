From: Junio C Hamano <junkio@cox.net>
Subject: Re: On blame/pickaxe
Date: Sat, 14 Oct 2006 16:43:53 -0700
Message-ID: <7vfydq79ae.fsf@assigned-by-dhcp.cox.net>
References: <7vr6xddm7h.fsf@assigned-by-dhcp.cox.net>
	<7vwt739org.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 15 01:44:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GYtAe-00049E-Vp
	for gcvg-git@gmane.org; Sun, 15 Oct 2006 01:44:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752250AbWJNXnz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Oct 2006 19:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752249AbWJNXnz
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Oct 2006 19:43:55 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:46295 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1752250AbWJNXny (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Oct 2006 19:43:54 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061014234354.HUOK16798.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>;
          Sat, 14 Oct 2006 19:43:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id aPjx1V0051kojtg0000000
	Sat, 14 Oct 2006 19:43:57 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vwt739org.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 14 Oct 2006 03:26:43 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28895>

Junio C Hamano <junkio@cox.net> writes:

> Junio C Hamano <junkio@cox.net> writes:
>
>> 4. Passing more blame.
>>
>> Instead of taking responsibility for the remainder, there are
>> other ways to find other people to pass blame on.  That's what
>> the "NEEDSWORK" comment in pass_blame() is about.
>
> I've spent a few hours tonight to further work (eh, "have fun")
> on this.  The version at the tip of "pu" implements detection of
> a case like this:
> ...
> You can use the pickaxe on its source itself, like this:
>
> 	git pickaxe -n master..pu builtin-pickaxe.c
>
> If you compare this with output from:
>
> 	git log --pretty=short -p master..pu builtin-pickaxe.c
>
> you will notice the line-movement detection in action.
>
> During the course of development, I had to move quite a few
> static functions around so that they are defined before their
> first call site.  This is partly because I am very bad at
> initial planning (who is?) and this still being in experimental
> stage I did not bother declaring static functions upfront as
> forward declarations.
>
> For example, commit db3f0f2 introduces find_last_in_target()
> function, but it was moved up by commit b5c0e4f (near the tip of
> "pu").  pickaxe blames the implementation of it to db3f0f20, and
> also notices that the bulk of its logic was actually copied from
> the implementation of pass_blame_to_parent() function in commit
> b14dc9ef (the initial commit that introduced builtin-pickaxe.c).
>
> What _ought_ to come next is to detect line movement across
> files, but I'll go to bed for now.

And this implements it.  After testing it some more, I'll have
it near the tip of "pu" sometime tonight.

I have to admit that I am becoming quite fond of the name
"pickaxe", by the way.

I consider that the "following the changed lines and see where
it came from" you described in the ancient message:

    http://thread.gmane.org/gmane.comp.version-control.git/27/focus=217

the holy grail of software archaeology.  Once we have it, I
would feel I am pretty much _done_ with git.  It will have
everything I want it to do.

My "diff -S" (where the "pickaxe" name started) was a crude
first step to achieve that goal.  The way I envisioned it was
that you would feed the lines 50-89 as a single -S parameter to
"git whatchanged" and the tool finds the commit that touched
that area, and the Porcelain would either figure out what the
corresponding lines in the previous commit look like or ask the
user to highlight what to dig deeper interactively, and restart
another "whatchanged" with adjusted value for -S.  Unfortunately
nobody wrote such a Porcelain command.

I think the command with this patch gets us closer to that goal;
although it still does not have a way to detect "oh these five
copies were consolidated into one" (I'd imagine we _could_ do
that in find_copy_in_parent() function if we really wanted to --
but that would be a tad expensive).  In any case, I think this
is going in the right direction.

Before anybody asks, the example Daniel Barkalow gave on date.c
is far trickier and even this version would not catch it.  It
requires digging random, distant, ancestors in order to look for
lines that were lost by an earlier removal.

-- >8 --
git-pickaxe: blame cut-and-paste lines.

This completes the initial round of git-pickaxe.  In addition to
the line movement the previous round implements, this finds new
lines that were created by moving or cutting-and-pasting lines
from different path in the parent.

With this,

	git pickaxe -f -n v1.4.0 -- revision.c

finds that major part of that file actually came from rev-list.c
when Linus split the latter at commit ae563642 and blames them
to earlier commits that touches rev-list.c.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 builtin-pickaxe.c |   71 +++++++++++++++++++++++++++++++++++------------------
 1 files changed, 47 insertions(+), 24 deletions(-)

diff --git a/builtin-pickaxe.c b/builtin-pickaxe.c
index 3f9f679..1124919 100644
--- a/builtin-pickaxe.c
+++ b/builtin-pickaxe.c
@@ -638,39 +638,16 @@ static int find_copy_in_blob(struct scor
 	return 0;
 }
 
-static int find_copy_in_parent(struct scoreboard *sb,
-			       struct origin *target,
-			       struct commit *parent,
-			       struct origin *porigin)
-{
-	int last_in_target;
-
-	last_in_target = find_last_in_target(sb, target);
-	if (last_in_target < 0)
-		return 1; /* nothing remains for this target */
-
-	/* NEEDSWORK: run diff-tree between target->commit with parent
-	 * to find the paths that were modified from parent, and find
-	 * copies in the parent; if we find any we can pass blame to it.
-	 * We have checked path in porigin so do not bother checking it
-	 * again (but porigin might be NULL).
-	 */
-
-	return 0;
-}
-
 static int find_move_in_parent(struct scoreboard *sb,
 			       struct origin *target,
 			       struct origin *parent)
 {
-	int last_in_target;
 	struct blame_entry *ent;
 	mmfile_t file_p;
 	char type[10];
 	char *blob_p;
 
-	last_in_target = find_last_in_target(sb, target);
-	if (last_in_target < 0)
+	if (find_last_in_target(sb, target) < 0)
 		return 1; /* nothing remains for this target */
 
 	blob_p = read_sha1_file(parent->blob_sha1, type,
@@ -690,6 +667,52 @@ static int find_move_in_parent(struct sc
 	return 0;
 }
 
+static int find_copy_in_parent(struct scoreboard *sb,
+			       struct origin *target,
+			       struct commit *parent,
+			       struct origin *porigin)
+{
+	struct diff_options diff_opts;
+	const char *paths[1];
+	int no_more, i;
+
+	if (find_last_in_target(sb, target) < 0)
+		return 1; /* nothing remains for this target */
+
+	diff_setup(&diff_opts);
+	diff_opts.recursive = 1;
+	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
+
+	/* Try "find copies harder" on new path */
+	if (!porigin || strcmp(target->path, porigin->path)) {
+		diff_opts.detect_rename = DIFF_DETECT_COPY;
+		diff_opts.find_copies_harder = 1;
+	}
+	paths[0] = NULL;
+	diff_tree_setup_paths(paths, &diff_opts);
+	if (diff_setup_done(&diff_opts) < 0)
+		die("diff-setup");
+	diff_tree_sha1(parent->tree->object.sha1,
+		       target->commit->tree->object.sha1,
+		       "", &diff_opts);
+	diffcore_std(&diff_opts);
+
+	for (i = no_more = 0; !no_more && i < diff_queued_diff.nr; i++) {
+		struct diff_filepair *p = diff_queued_diff.queue[i];
+		struct origin *new_porigin;
+		if (!DIFF_FILE_VALID(p->one))
+			continue; /* does not exist in parent */
+		if (porigin && !strcmp(p->one->path, porigin->path))
+			continue; /* find_move already checked this path */
+
+		new_porigin = find_origin(sb, parent, p->one->path);
+		no_more = find_move_in_parent(sb, target, new_porigin);
+	}
+	diff_flush(&diff_opts);
+
+	return no_more;
+}
+
 #define MAXPARENT 16
 static void pass_blame(struct scoreboard *sb, struct origin *origin)
 {
-- 
1.4.3.rc2.g195ab
