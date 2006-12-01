X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] (experimental) per-topic shortlog.
Date: Fri, 01 Dec 2006 02:55:34 -0800
Message-ID: <7vlklranrt.fsf@assigned-by-dhcp.cox.net>
References: <7v8xhxsopp.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0611261652520.30076@woody.osdl.org>
	<Pine.LNX.4.63.0611280040480.30004@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v7ixge8j2.fsf@assigned-by-dhcp.cox.net>
	<20061128131139.GA10874@coredump.intra.peff.net>
	<7v1wnnysrn.fsf@assigned-by-dhcp.cox.net>
	<20061201081117.GA20025@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 1 Dec 2006 10:56:17 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061201081117.GA20025@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 1 Dec 2006 03:11:17 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32889>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gq63P-00008m-By for gcvg-git@gmane.org; Fri, 01 Dec
 2006 11:55:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936308AbWLAKzg (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 05:55:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936309AbWLAKzg
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 05:55:36 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:44543 "EHLO
 fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP id S936308AbWLAKzf
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 05:55:35 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao09.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061201105535.UUDJ18767.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>; Fri, 1
 Dec 2006 05:55:35 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id tNvk1V00C1kojtg0000000; Fri, 01 Dec 2006
 05:55:44 -0500
To: Jeff King <peff@peff.net>
Sender: git-owner@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Nov 28, 2006 at 04:57:00PM -0800, Junio C Hamano wrote:
>
>> > The top 15 for v1.4.3 to v1.4.4 are:
>> >
>> > 1604 6973dcaee76ef7b7bfcabd2f26e76205aae07858 Libify diff-files.
>> 
>> Something is SERIOUSLY wrong.
>> 
>> That commit is not even between v1.4.3 and v1.4.4.
>
> Hmm, you're right. I haven't quite figured out what went wrong with the
> script I posted. However, a somewhat simpler approach is to just use the
> revision limiting in git-blame. The problem with this is that commits
> whose parents aren't in the revision range end up getting blamed for a
> lot of lines they're not responsible for.

The way you used "-S rev" was wrong.  It is a way to temporarily
install grafts and nothing else; but your grafts introduced that
way exactly matched the true parenthood except for the bottom
commit and side branches merged during the timeframe leaked
right through your grafts.  The digger started from your HEAD
(whatever that happened to be) along with the true parenthood
and found an way ancient ancestor.

A "bit more correct" script would have been something like this.

-- >8 --
#!/bin/sh
#
# Usage: sh ./run-me v1.4.3 v1.4.4
#
bottom=${1?bottom} top=${2?top}
bottom=$(git rev-parse --verify "$bottom^0")
range="$bottom..$top"
top=$(git rev-parse --verify "$top^0")

for path in $(git diff --name-only -r --diff-filter=AM "$range")
do
	echo >&2 "* $path"
	git blame -l -C "$range" -- "$path"
done | sed -e 's/ .*//' | sort | uniq -c | sort -n -r |
while read num hash
do
	test "$hash" = "$bottom" && continue
	it=$(git rev-list --pretty=oneline --abbrev --abbrev-commit -1 "$hash")
	printf '%6d %s\n' $num "$it"
done
-- 8< --

But as you correctly observed, even the above script is wrong.
The top one blamed with the above script is this commit:

  8301 808239a Merge branch 'sk/ftp'

But that is an ancestor of v1.4.3!

What's wrong is that the ancestry graph around that commit
roughly looks like this:

         z---o---o---o
        /             \
  808239a--v1.4.3--o---*---o---v1.4.4

The pickaxe passes the blame around to the parents but does not
allow a "boundary" commits to pass the blame to their parents.
As the result, the blame at the commit marked with '*' are split
along both branches, and after the leftmost commit 'z' passes
its blame to its parent, it stops there and ends up blaming
808239a, which is an ancestor of the original "boundary" commit
v1.4.3 given from the command line.  What's wrong with my script
quoted above is that the filter that checks $hash with $bottom;
it needs to check if $hash is an ancestor of $bottom.

With that change, the top commits are:

  1109 9f613dd Add git-for-each-ref: helper for language bindings
  1087 cee7f24 git-pickaxe: blame rewritten.
   218 c31820c Make git-branch a builtin
   209 636171c make index-pack able to complete thin packs.
   200 fe142b3 Rework cvsexportcommit to handle binary files for all cases.

which looks a bit more reasonable (I did not realize
for-each-ref was that big, but in fact it has its own
mini-language).

While what blame outputs is technically correct, it is not very
useful for this kind of application.  As you said, it probably
makes sense to gray-out the lines that are blamed on boundary
commits.

Side note: one might be tempted to say "then blame v1.4.3 for
lines that 808239a is blamed for", but that is a good
workaround.  The original command line could have more than one
bottom commits, and the final blame might go to a common
ancestor of them, and we need to randomly choose between them,
which is worse than telling the truth as we currently do.

And here is an experimental patch to do that.

-- >8 --
[PATCH] git-blame: mark lines blamed on boundary commits.

Lines can be blamed on a commit that is older than the boundary
commit given on the command line when a merge with a branch that
forked before the boundary is involved.  Mark them specially so
that later changes in the interested area can be easily
identified.

In porcelain format, their header line that describe the commit
gets an extended attribute line "boundary".  In human format,
the commit SHA-1 are prefixed with a '-' character.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 builtin-blame.c |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/builtin-blame.c b/builtin-blame.c
index dc3ffea..46a9d0e 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -1090,6 +1090,11 @@ static void assign_blame(struct scoreboard *sb, struct rev_info *revs, int opt)
 		if (!(commit->object.flags & UNINTERESTING) &&
 		    !(revs->max_age != -1 && commit->date  < revs->max_age))
 			pass_blame(sb, suspect, opt);
+		else {
+			commit->object.flags |= UNINTERESTING;
+			if (commit->object.parsed)
+				mark_parents_uninteresting(commit);
+		}
 
 		/* Take responsibility for the remaining entries */
 		for (ent = sb->ent; ent; ent = ent->next)
@@ -1273,6 +1278,8 @@ static void emit_porcelain(struct scoreboard *sb, struct blame_entry *ent)
 		printf("committer-tz %s\n", ci.committer_tz);
 		printf("filename %s\n", suspect->path);
 		printf("summary %s\n", ci.summary);
+		if (suspect->commit->object.flags & UNINTERESTING)
+			printf("boundary\n");
 	}
 	else if (suspect->commit->object.flags & MORE_THAN_ONE_PATH)
 		printf("filename %s\n", suspect->path);
@@ -1308,8 +1315,14 @@ static void emit_other(struct scoreboard *sb, struct blame_entry *ent, int opt)
 	cp = nth_line(sb, ent->lno);
 	for (cnt = 0; cnt < ent->num_lines; cnt++) {
 		char ch;
+		int length = (opt & OUTPUT_LONG_OBJECT_NAME) ? 40 : 8;
+
+		if (suspect->commit->object.flags & UNINTERESTING) {
+			length--;
+			putchar('-');
+		}
 
-		printf("%.*s", (opt & OUTPUT_LONG_OBJECT_NAME) ? 40 : 8, hex);
+		printf("%.*s", length, hex);
 		if (opt & OUTPUT_ANNOTATE_COMPAT)
 			printf("\t(%10s\t%10s\t%d)", ci.author,
 			       format_time(ci.author_time, ci.author_tz,
