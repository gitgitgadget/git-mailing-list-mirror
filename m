X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-add --interactive (wip)
Date: Tue, 12 Dec 2006 13:51:49 -0800
Message-ID: <7vwt4wpytm.fsf@assigned-by-dhcp.cox.net>
References: <360959.72234.qm@web31809.mail.mud.yahoo.com>
	<7vd56s8t9w.fsf@assigned-by-dhcp.cox.net>
	<7vslfm23co.fsf_-_@assigned-by-dhcp.cox.net>
	<200612111147.44964.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 12 Dec 2006 21:52:01 +0000 (UTC)
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200612111147.44964.Josef.Weidendorfer@gmx.de> (Josef
	Weidendorfer's message of "Mon, 11 Dec 2006 11:47:44 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34149>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuFXW-00077O-KI for gcvg-git@gmane.org; Tue, 12 Dec
 2006 22:51:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932451AbWLLVvv (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 16:51:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932456AbWLLVvv
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 16:51:51 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:43288 "EHLO
 fed1rmmtao11.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932451AbWLLVvu (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec 2006
 16:51:50 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao11.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061212215150.KTPY25875.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>; Tue, 12
 Dec 2006 16:51:50 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id xxs11V00M1kojtg0000000; Tue, 12 Dec 2006
 16:52:01 -0500
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Sender: git-owner@vger.kernel.org

Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:

> I just tried to work with this thing to separate my recent
> "branch.*.localmerge" changes to the simple version I posted
> afterwards.
>
> I noted that I need to manually change a few dependent hunks,
> so this "one hunk at a time" and not being able to edit changes
> in a hunk does not fit my workflow.

I've updated my "git add --interactive" in 'pu' and it now knows
how to split a hunk into smaller pieces and recounting the diff
offsets before applying (Johannes pointed out that his partial
commit script, entirely written in bash using shell arrays, has
a similar feature.  I guess I should have stolen his code
instead of lifting the logic from my own abandoned porcelain).

Hunk splitting allows you to start with this hunk:

        @@ -9,9 +9,10 @@
         #include "builtin.h"
         #include "dir.h"
         #include "cache-tree.h"
        +#include "exec_cmd.h"

         static const char builtin_add_usage[] =
        -"git-add [-n] [-v] <filepattern>...";
        +"git-add [-n] [-v] <filepattern>... | git-add --interactive";

         static void prune_directory(struct dir_struct *dir, const char **...
         {

and lets you split it into two, and you can pick each individually:

        @@ -9,5 +9,6 @@
         #include "builtin.h"
         #include "dir.h"
         #include "cache-tree.h"
        +#include "exec_cmd.h"

         static const char builtin_add_usage[] =
        @@ -12,6 +13,6 @@

         static const char builtin_add_usage[] =
        -"git-add [-n] [-v] <filepattern>...";
        +"git-add [-n] [-v] <filepattern>... | git-add --interactive";

         static void prune_directory(struct dir_struct *dir, const char **...
         {

The post-context of the first hunk and pre-context of the
second hunk are duplicated to give you better context when
reviewing each of them alone.  If you choose to apply both, they
are merged back again before applied.

Anyway, after I finished doing this, I started thinking...

One of the most beautifully done patch series in git.git history
is this series by Sergey Vlasov:

	http://thread.gmane.org/gmane.comp.version-control.git/9057

The resulting commits are from e8d2a6d4 to 4041483e (inclusive).

What's interesting about this series is that its patches touch
the same area of the code over and over again, refining a bit by
bit as the series progresses.

Sergey might have done it exactly the way the final patches
presented the evolution, but I somehow doubt it [*1*].  I often
have the state that corresponds to [PATCH n/n] in my working
tree after hacking around without making a single commit, and
often would start wanting to commit the state as a clean
multi-step series at that point.  I think this is the same for
everybody.

What I often end up doing is to make a snapshot of that
"proposed final" state, reset to the original, and work toward
the proposed final state:

	# snapshot
	$ git commit -a -m 'commit goal'
        $ git tag -f CG
        $ git reset --hard HEAD^

	# repeat for (i = 1; i <= n; i++)
        $ git diff HEAD CG >P.diff
        $ edit
        # use P.diff as a reference, and edit the working tree
        # files to produce [i/n] state.  I might remove pieces
        # that belong to [j/n] for j > i from  P.diff and run
	# "git apply --index", or hand edit the files directly
	# in the working tree.
	$ make test
        $ git commit -a -m "[PATCH i/n] title..."
        # end repeat

	# when finished the above cycle, this diff should only
	# show the improvements I made during the decomposition.
        $ git diff CG HEAD

For a very simple case where the patch munging in the "repeat"
part of the above workflow only deletes hunks (or sub-hunks),
the patch subcommand of "git add --interactive" with hunk
splitting would work nicely, but in general it would not be
enough.  It certainly is far from usable to produce something
like what Sergey gave us.

To make it easier, one possibility might be to add a subcommand
to "git add --interactive" that lets you edit what is currently
staged in the index by opening a temporary copy in your favorite
editor, and stage the result of your edit in the index.  But I
feel quite uneasy to introduce ways to update the index with
something _wildly_ different from what you ever had in your
working tree as a whole.

I think it is wrong to commit partially, purely from the index,
when you are building a series that has complex changes that
come during the series but go away at the end.  The user should
be able to verify all the steps in the middle in such a complex
series, but it is not easy if you have it only in the index.

You could do

	$ git checkout-index --prefix=testarea/ -f -q -u -a

and run your tests there, but that takes a discipline, and is
cumbersome to do.

So in short, I think per-hunk update-index is a cute hack and
may be useful in a narrow simple cases, but it would not be so
useful in the real life.


> Just as a sidenote: after deciding to not apply hunks, you
> lose them in this WIP, as you will find nothing in "unstaged" mode
> afterwards :-(

I do not understand this part.  You can 'revert' to match the
index to HEAD and run 'patch' to pick what you want again.


[Footnote]

*1* Maybe Sergey indeed did things the way the series was
presented, in which case that would only strengthen my respect
to his ability even more.  The quoted patch series made him one
of three people on the git list whose patches I trust 100%; in
fact, I trust their patches so much that I read them not to find
bugs but to admire and enjoy.
