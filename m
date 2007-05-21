From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Teach 'git-apply --whitespace=strip' to remove empty lines at the end of file
Date: Sun, 20 May 2007 23:57:06 -0700
Message-ID: <7vmyzyhdfh.fsf@assigned-by-dhcp.cox.net>
References: <e5bfff550705200251j3dd9b377je7ae5bafac988060@mail.gmail.com>
	<7vabvzq0bb.fsf@assigned-by-dhcp.cox.net>
	<e5bfff550705200334pef694cn1a7842c23e2672f5@mail.gmail.com>
	<7vabvzoij8.fsf@assigned-by-dhcp.cox.net>
	<e5bfff550705200545kcf1f7f9n4f3f6d7d25955e1@mail.gmail.com>
	<7v1whbmjel.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 21 08:57:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hq1q7-0002kb-LX
	for gcvg-git@gmane.org; Mon, 21 May 2007 08:57:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754357AbXEUG5K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 May 2007 02:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753191AbXEUG5K
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 02:57:10 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:50509 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754357AbXEUG5I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 02:57:08 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070521065707.NJPL15717.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Mon, 21 May 2007 02:57:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 1ix61X00D1kojtg0000000; Mon, 21 May 2007 02:57:07 -0400
In-Reply-To: <7v1whbmjel.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 20 May 2007 11:36:50 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47977>

Junio C Hamano <junkio@cox.net> writes:

> "Marco Costalba" <mcostalba@gmail.com> writes:
>
>> Ok. This is take 3. It works correctly on standard patches and also on
>> u0 example that you gave above.
>>
>> This patch is on top of git 1.5.2
>>
>> Please check it.
>
> I think the checks and actions are at the right places (I
> haven't looked very closely nor tried to run it yet).

After fixing it up a bit to actually perform the removal only
under --whitespace=strip option, I merged it to 'next' and
pushed the result out.  Then I found a slight breakage, when I
tried to reproduce your 6 "whitespace fix" series using that
famous procedure:

    $ git checkout master
    $ rm -f .git/index
    $ git checkout HEAD -- t/ Documentation/
    $ git clean -x -d
    $ git diff -R --binary HEAD >P.diff
    $ git apply --index --whitespace=strip P.diff

We somehow end up removing one LF too many, like this:

    diff --git a/contrib/emacs/.gitignore b/contrib/emacs/.gitignore
    index c531d98..016d3b1 100644
    --- a/contrib/emacs/.gitignore
    +++ b/contrib/emacs/.gitignore
    @@ -1 +1 @@
    -*.elc
    +*.elc
    \ No newline at end of file

Here is a fix on top of what's in 'next'.  I think this is a lot
closer to what I outlined originally.  Passes the testsuite but
that does not tell us much, as they did not catch the breakage
in your version.

Care to add a few tests for this new feature?  Hint, hint...

-- >8 --
[PATCH] git-apply: Fix removal of new trailing blank lines.

The earlier code removed one newline too many from the hunk that
adds new lines at the end of the file.  Also the way the code
counted the added blank lines was somewhat roundabout; I think
the way updated code does it is more direct and easier to
follow:

 * We keep track of the number of blank lines added;

 * While processing each line, we notice if it adds a blank
   line, and increment the counter, or reset it to zero
   otherwise;

 * When actually we apply the data, we remove the empty lines we
   counted earlier if we are applying it at the end of the
   file.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 builtin-apply.c |   48 +++++++++++++++---------------------------------
 1 files changed, 15 insertions(+), 33 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index ac7c824..e717898 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1671,7 +1671,7 @@ static int apply_one_fragment(struct buffer_desc *desc, struct fragment *frag, i
 	char *new = xmalloc(size);
 	const char *oldlines, *newlines;
 	int oldsize = 0, newsize = 0;
-	int trailing_added_lines = 0;
+	int new_blank_lines_at_end = 0;
 	unsigned long leading, trailing;
 	int pos, lines;
 
@@ -1679,6 +1679,7 @@ static int apply_one_fragment(struct buffer_desc *desc, struct fragment *frag, i
 		char first;
 		int len = linelen(patch, size);
 		int plen;
+		int added_blank_line = 0;
 
 		if (!len)
 			break;
@@ -1700,16 +1701,6 @@ static int apply_one_fragment(struct buffer_desc *desc, struct fragment *frag, i
 			else if (first == '+')
 				first = '-';
 		}
-		/*
-		 * Count lines added at the end of the file.
-		 * This is not enough to get things right in case of
-		 * patches generated with --unified=0, but it's a
-		 * useful upper bound.
-		*/
-		if (first == '+')
-			trailing_added_lines++;
-		else
-			trailing_added_lines = 0;
 
 		switch (first) {
 		case '\n':
@@ -1728,9 +1719,14 @@ static int apply_one_fragment(struct buffer_desc *desc, struct fragment *frag, i
 				break;
 		/* Fall-through for ' ' */
 		case '+':
-			if (first != '+' || !no_add)
-				newsize += apply_line(new + newsize, patch,
-						      plen);
+			if (first != '+' || !no_add) {
+				int added = apply_line(new + newsize, patch,
+						       plen);
+				newsize += added;
+				if (first == '+' &&
+				    added == 1 && new[newsize-1] == '\n')
+					added_blank_line = 1;
+			}
 			break;
 		case '@': case '\\':
 			/* Ignore it, we already handled it */
@@ -1740,6 +1736,10 @@ static int apply_one_fragment(struct buffer_desc *desc, struct fragment *frag, i
 				error("invalid start of line: '%c'", first);
 			return -1;
 		}
+		if (added_blank_line)
+			new_blank_lines_at_end++;
+		else
+			new_blank_lines_at_end = 0;
 		patch += len;
 		size -= len;
 	}
@@ -1750,24 +1750,6 @@ static int apply_one_fragment(struct buffer_desc *desc, struct fragment *frag, i
 		newsize--;
 	}
 
-	if (new_whitespace == strip_whitespace) {
-		/* Any added empty lines is already cleaned-up here
-		 * becuase of 'strip_whitespace' flag, so just count '\n'
-		*/
-		int empty = 0;
-		while (   empty < trailing_added_lines
-		       && newsize - empty > 0
-		       && new[newsize - empty - 1] == '\n')
-			empty++;
-
-		if (empty < trailing_added_lines)
-			empty--;
-
-		/* these are the empty lines added at
-		 * the end of the file, modulo u0 patches.
-		 */
-		trailing_added_lines = empty;
-	}
 	oldlines = old;
 	newlines = new;
 	leading = frag->leading;
@@ -1805,7 +1787,7 @@ static int apply_one_fragment(struct buffer_desc *desc, struct fragment *frag, i
 
 			if (new_whitespace == strip_whitespace &&
 			    (desc->size - oldsize - offset == 0)) /* end of file? */
-				newsize -= trailing_added_lines;
+				newsize -= new_blank_lines_at_end;
 
 			diff = newsize - oldsize;
 			size = desc->size + diff;
-- 
1.5.2.24.g93d4
