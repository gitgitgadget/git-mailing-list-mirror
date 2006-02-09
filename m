From: Junio C Hamano <junkio@cox.net>
Subject: Re: Two crazy proposals for changing git's diff commands
Date: Wed, 08 Feb 2006 17:21:12 -0800
Message-ID: <7vfymtl43b.fsf@assigned-by-dhcp.cox.net>
References: <87slqtcr2f.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 09 02:21:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F70Un-0007MW-JH
	for gcvg-git@gmane.org; Thu, 09 Feb 2006 02:21:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422754AbWBIBVP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Feb 2006 20:21:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422755AbWBIBVO
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Feb 2006 20:21:14 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:64661 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1422754AbWBIBVO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Feb 2006 20:21:14 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060209011955.WYDG20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 8 Feb 2006 20:19:55 -0500
To: Carl Worth <cworth@cworth.org>
In-Reply-To: <87slqtcr2f.wl%cworth@cworth.org> (Carl Worth's message of "Wed,
	08 Feb 2006 16:29:44 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15778>

Carl Worth <cworth@cworth.org> writes:

> Can anyone else think of common use cases for these various
> operations that I've missed?

If there is none, then that means we have covered everything.
But a more interesting question to ask is "are there useful
comparisons that the existing diff lowlevel does not give me
with a single command".  And the answer is of course yes.

For example, you cannot preview "git commit --include paths..."
with a single low-level command.  You would need to run
"git-diff-index --cached HEAD" for paths that are _not_
specified, and "git-diff-index HEAD" output for paths that you
will give to "--include" when you make that commit.

> 	Proposal 1: Make diff-index use HEAD if no <tree> is specified

No need.  "git diff --cached" does it, as you discovered.  I am
open to update the lowlevel if there is a need, but this does
not justify it.

> If "git diff" is learned as a commit preview, (during a larval
> index-unaware stage), then this behavior will have to be unlearned
> when the user starts using the index. At that point "git diff" becomes
> a way to examine what will *not* be committed by "git commit" rather
> than what *will* be committed by "git commit -a".

Of course, learning various flags to give "git diff" is part of
understanding the index, so if the user understands index, "git
diff" without arguments will _not_ be the only diff command the
user uses for a preview.  And I suspect that depending on what
development style you would use, the definition of "useful
comparisons" would be different.

You are assuming that the user graduated from "larval unaware"
in this part of the discussion, no?

> And I think this goes toward my which-diff confusion. Consider the
> three diff operations that allow for investigating un-committed trees:
>
> 	<tree>  -> index	diff-index --cached <tree>
> 	index   -> files	diff-files
> 	<tree>  -> files	diff-index <tree>
>
> Here, "diff-index" is the only one of the three commands that does not
> operate on the index. One can notice a similar thing in the ASCII
> diagram from the core tutorial where diff-index is the only one of
> these three operations that completely bypasses the index (!).

By the way, diff-index without --cached *does* use index.
Unindexed paths are not shown.  All this means that there is
still inconsistent understanding on your part.

> 	Proposal #2: Provide the following 4 diff commands:

Forget about renaming the core-level commands.  This is
UNNEGOTIABLE, at least with something like the reasoning
presented in your message.  You need to have something stronger
than that.

I'm VERY open to give friendlier interface to 'git-diff'
wrapper, though.  And I appreciate that part of your discussion
very much.  The end users, once the improvement proposal like
yours is done right, should NOT need to use the lowlevel diff
command directly AT ALL, so renaming low-level serves no useful
purpose other than confusing Porcelain people and me.

> The goal here is that using diff, diff-index, and diff-files without
> any tree argument and without any options (such as --cached) should
> cover the most common cases. So there's less typing in general.

No, the goal should be for normal workflows there should be *no*
need to use lowlevel commands by end users day-to-day.  Myself,
I have not typed lowlevel commands from the command line for
quite a long time, except when I am debugging, and except when I
wanted to see "diff-tree --cc" output for a single commit, only
because there was no suitable wrapper.  The last reason is now
gone thanks to "git-show" Linus added.  So as far as *MY*
workflow is concerned, that goal has already been achieved.

I am not saying there is something wrong with your workflow --
the tool may still not give an easier way to get a diff you
would want in your workflow.  I've given one example already
about the --include commit preview.  So let's concentrate on
this question:

	What are the useful workflows, in which during various
	phases of that workflow, existing "git diff" wrapper
	does not give us a useful comparison?

Then we can fill what is lacking.  During the course of this
exercise, it _might_ turn out that the low-level may need to be
updated to make generation of such an output easier and/or more
efficient, but first we need know what we want to add to the end
result.  Mucking with the machinery to generate output must come
after that.

While I suspect what people would want most would be commit
previews, I purposely said "useful comparison" instead of
"commit preview" in the above.  Reviewing a conflicted merge
with "git diff" falls into "useful comparison but not commit
preview" category.

Commit preview alone is rather easy.  No matter how your worklow
is (one extreme being no update-index until you are ready to
commit, and say "git commit -a" to commit everything --- the
other extreme being frequent update-index between commit, even
multiple update-index on the same paths, and do "git commit
--include paths..."), there are only four ways to make commits:

	$ git commit
        => git diff --cached

	$ git commit -a
        => git diff HEAD

        $ git commit --only paths...
	=> git diff HEAD paths...

	$ git commit --include paths...
	... there is no support in "git diff"; it cannot be done
        ... with a single low-level.

So we could even implement that with

	$ git commit --preview [other flags] [paths...]

and three quarters of necessary things are already there.
There are obvious two other alternatives:

	$ git commit-preview [commit flags and paths...]
	$ git diff --preview [commit flags and paths...]
