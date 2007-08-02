From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-diff on touched files: bug or feature?
Date: Thu, 02 Aug 2007 12:56:19 -0700
Message-ID: <7vy7gtvhgc.fsf@assigned-by-dhcp.cox.net>
References: <vpqwswf8c1i.fsf@bauges.imag.fr>
	<7v4pjj5fp6.fsf@assigned-by-dhcp.cox.net>
	<vpqhcni47ek.fsf@bauges.imag.fr>
	<7vd4y6xnw4.fsf@assigned-by-dhcp.cox.net>
	<7v1wemxnkk.fsf@assigned-by-dhcp.cox.net>
	<vpqzm1a2l72.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Aug 02 21:56:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGgmd-0007Mo-TW
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 21:56:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758272AbXHBT4W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 15:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757350AbXHBT4W
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 15:56:22 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:41036 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757231AbXHBT4V (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 15:56:21 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070802195619.EGGV26965.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Thu, 2 Aug 2007 15:56:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id X7wK1X00d1kojtg0000000; Thu, 02 Aug 2007 15:56:20 -0400
In-Reply-To: <vpqzm1a2l72.fsf@bauges.imag.fr> (Matthieu Moy's message of "Thu,
	02 Aug 2007 14:08:17 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54590>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Quite honestly, a script that indiscriminately touches everybody
>> but only modifies a few is simply broken.  Think about "make".
>> "git diff" reporting many cache-dirty files is simply reminding
>> you the brokenness of such a script.
>
> I wouldn't call this "broken", but clearly suboptimal, yes. But for an
> occasionnal one-liner (perl -pi -e ... or so), I lose less time
> recompiling extra-files than I would writting a cleaner script. "make"
> has no way to detect the absence of modification, while git has.

The first part of your sentence makes sense.  You are trading
"make" time with the reduction in effort to write a throw-away
script.  That makes sense --- and you pay with a more expensive
make, but that is a valid tradeoff you choose to make.  You can
just choose to make the same tradeoff by running an extra
refresh.

You could do something like the trivial patch attached below to
squelch diff-files "cache-dirty" output, if you wanted to.

After trying to work with this modified git for some time,
however, it has become very clear that doing this and nothing
else is a stupid thing to do (I'll suggest potential
improvements at the end).  For one thing, it obviously loses the
"quick git-diff to see what I touched" benefit.  And that issue
is real, as I first touched diff-lib.c to come up with this
until I realized that doing it in here is much cleaner and
simpler --- this patch is discarding that information, and makes
writing a changelog for this patch, if it were to be included,
more expensive for the user -- that is me.

Another thing is that it loses the coal-mine canary value the
"cache-dirty" output has.  After running a loosely written bulk
regexp script, like this:

	perl -p -i -e 's/foo/bar/' *.c

the cached stat data are destroyed for all paths, and it makes
all the subsequent git worktree operations needlessly more
expensive; existing output makes me realize this situation.

It is not a stupid thing to run such a script [*1*]; in this
case, I am choosing the convenience of using such a suboptimal
(as you said) script.  But after running such a script, I DO
WANT git to tell me that I made the index suboptimal, so that I
can and should refresh it to gain the lost performance back.

Personally, I almost never run "git status".  The command is
there primarily because other systems had a command called
"status", and migrant wondered why we didn't.  We do not need
it, and we do not have to use it.

 * For getting the status so-far, I use "git diff" (and "git
   diff ." when in a subdirectory).  It is "how have I changed
   things?", and that is when it is very useful to know "ah, I
   originally went in that direction but decided against it and
   did it differently" by the cache-dirtiness output.  The
   coal-mine canary value is also felt here;

 * For a quick final status, "git diff --stat" is much simpler
   to read than "git status", and that is what I use.  It is
   "what have I changed overall?".  As this actually counts the
   real changes, you would not see those null changes that come
   from the cache dirtiness you are complaining about;

 * When I am ready to commit, "git status" output comes in the
   commit log editor.  At that point, I already have been
   reminded by the previous "git diff" (which is usually run
   often unless the patch is very small like this), and I do not
   need cache-dirtiness output anymore after making my commit.

You do not have to say, to the above paragraph, that it is
different from your workflow.  I am showing what the opmimum
workflow would be, and it is up to you not to listen to me.

Even if we were willing to lose the "quick git-diff to see what
I touched" benefit and want to go the route of the attached
patch suggests (which I personally do not think we are), there
should be a way to either (1) tell the user that many paths are
found to be cache-dirty and it is a good idea to refresh the
stat information, after squelching diff-files output this way,
or (2) update the stat information automatically when diff-files
finds too many paths are cache-dirty (perhaps without even
telling the user).  The latter requires you to declare that
git-diff is not a read-only operation anymore, though, so you
would need some thought before going in that direction.


[Footnote]

*1* Some people might argue that "perl -i" should have a mode to
leave the original if the script does not modify the contents.
Maybe they are right, but that is an orthogonal issue.

---

 diff.c |   40 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/diff.c b/diff.c
index a5fc56b..ea1239d 100644
--- a/diff.c
+++ b/diff.c
@@ -3143,6 +3143,45 @@ static void diffcore_apply_filter(const char *filter)
 	*q = outq;
 }
 
+static void diffcore_remove_empty(void)
+{
+	int i;
+	struct diff_queue_struct *q = &diff_queued_diff;
+	struct diff_queue_struct outq;
+	outq.queue = NULL;
+	outq.nr = outq.alloc = 0;
+
+	for (i = 0; i < q->nr; i++) {
+		struct diff_filepair *p = q->queue[i];
+
+		/*
+		 * 1. Keep the ones that cannot be diff-files
+		 *    "false" match that are only queued due to
+		 *    cache dirtyness.
+		 *
+		 * 2. Modified, same size and mode, and the object
+		 *    name of one side is unknown.  If they do not
+		 *    have identical contents, keep them.
+		 *    They are different.
+		 */
+		if ((p->status != DIFF_STATUS_MODIFIED) || /* (1) */
+		    (p->one->sha1_valid && p->two->sha1_valid) ||
+		    (p->one->mode != p->two->mode) ||
+
+		    diff_populate_filespec(p->one, 1) || /* (2) */
+		    diff_populate_filespec(p->two, 1) ||
+		    (p->one->size != p->two->size) ||
+		    diff_populate_filespec(p->one, 0) ||
+		    diff_populate_filespec(p->two, 0) ||
+		    memcmp(p->one->data, p->two->data, p->one->size))
+			diff_q(&outq, p);
+		else
+			diff_free_filepair(p);
+	}
+	free(q->queue);
+	*q = outq;
+}
+
 void diffcore_std(struct diff_options *options)
 {
 	if (options->quiet)
@@ -3160,6 +3199,7 @@ void diffcore_std(struct diff_options *options)
 		diffcore_order(options->orderfile);
 	diff_resolve_rename_copy();
 	diffcore_apply_filter(options->filter);
+	diffcore_remove_empty();
 
 	options->has_changes = !!diff_queued_diff.nr;
 }
