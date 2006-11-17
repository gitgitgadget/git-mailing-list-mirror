X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [DRAFT] Branching and merging with git
Date: Thu, 16 Nov 2006 17:09:21 -0800
Message-ID: <7vac2q281q.fsf@assigned-by-dhcp.cox.net>
References: <20061116221701.4499.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 17 Nov 2006 01:09:39 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061116221701.4499.qmail@science.horizon.com>
	(linux@horizon.com's message of "16 Nov 2006 17:17:01 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31652>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GksEQ-0005av-GC for gcvg-git@gmane.org; Fri, 17 Nov
 2006 02:09:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424851AbWKQBJX (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006
 20:09:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424852AbWKQBJX
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 20:09:23 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:24050 "EHLO
 fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP id S1424851AbWKQBJX
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006 20:09:23 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao04.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061117010922.NYFX7494.fed1rmmtao04.cox.net@fed1rmimpo02.cox.net>; Thu, 16
 Nov 2006 20:09:22 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id nd9U1V00n1kojtg0000000; Thu, 16 Nov 2006
 20:09:29 -0500
To: linux@horizon.com
Sender: git-owner@vger.kernel.org

linux@horizon.com writes:

> One outstanding problem with git's man pages is that often the most detail
> is in the command page that was written first, not the user-friendly
> one that you should use.

This is a very important point to remember not for users but for
us in git community.  Thanks for writing it down.

> * Git's representation of history
>...
> And then there are commits which have multiple parents.  Two is most
> common, but git allows many more.  (There's a limit of sixteen in the
> source code, and the most anyone's ever used in real life is 12, and
> that was generally regarded as overdoing it.  Google on "doedecapus"
> for discussion of it.)

Dodecapus would find a few, no hits on doedecapus ;-).

> * Deleting branches
>
> "git branch -d <head>" is safe.  It deletes the given <head>, but first
> it checks that the commit is reachable some other way.  That is, you
> merged the branch in somewhere, or you never did any edits on that branch.

It is not "somewhere" but "in the current branch", so in a sense
it is a bit stricter than that.  While on 'master' "branch -d
topic" would not remove the topic branch head if it is not fully
merged to my 'master' so that is a reasonable safety measure,
but when I am on 'next' it will happily remove it.  It is
recoverable because it is reachable from 'next', though.

> * Remote tags
>
> TODO: Figure out how remote tags work, under what circumstances
> they are fetched, and what git does if there are conflicts.

One bug in my previous response is that I said we do this only
when the command was invoked with shorthand remote name.  Not
so.  We do this only when we use tracking branches.

The reason is because 'git pull $url $branch' (typical Linus's
use) and 'git pull' (defaulting to 'origin' and using the
tracking branch mapping stored in .git/remotes/origin prepared
by git-clone) are sign of very different workflows.  The former
tends to be a one-shot event while the latter is most often
synchronizing with either an upstream or a common distribution
point (i.e. shared central repostiory).  When you are fetching
from somebody in a one-shot manner, most likely as a part of
'pull', you do not want to get the tag the other person has made
to mark his private work in progress.  But in the latter case,
the other end is where everybody who works in the same area
fetches from, and sharing the tags found there among the
developers by default is desirable, and more importantly there
is no risk of accidentally getting private tags, since the other
end is a public distribution point and by definition should not
have private tags that would clutter your refs/tags hierarchy.

> * Exchanging work with other repositories, part II: git-push
>...
> You have to merge the changes locally, and re-try the push when you've
> got a new head that includes the most recently pushed work as an ancestor.
>
> This is exactly like "cvs commit" not working if your recent checkout
> wasn't the (current) tip of the branch, but git can upload more than
> one commit.
>
> The simplest way to resolve the conflict is to merge the remote head with
> your local head.  This is easiest if you have different local branches
> for fetching the remote repository and for pushing to it.
>
> That is, you have one head that just tracks the master repository's
> main branch, and another that you add your work to, and push from.
> This makes merging simpler when there are conflicts.

Here you _might_ want to mention an alternative workflow that
uses rebase, which seems to be the way Wine folks run their
project.  Talking about all the different possibilities tends to
cloud things and may not add value to the document, so I am just
mentioning it as a possibility but I do not know if talking
about rebase is useful in the context of this document.

> * Merging (finally!)
>
> I went through everything else first because the most common merge case
> is local changes with remote changes.  Not that you can't merge two
> branches of your own, but you don't need to do that nearly as often.
>
> The primitive that does the merging is called (guess what?) git-merge.
> And you can use that if you want.  If you want to create a so-called
> octopus merge, with more than two parents, you have to.

This is not true; "git pull . topicA topicB topicC" works as
expected.  But we probably would not want to even talk about
Octopus in a document like this.  It is a curosity, and
sometimes tends to make histories even less cluttered, but
otherwise it does not add much value.

> However, it's usually easier to use the git-pull wrapper.  This merges
> the changes from some other branch into the current HEAD and generates
> a commit message automatically.
>
> git-merge lets you specify the commit message (rather than generating it
> automatically) and use a non-HEAD destination branch, but those options
> are usually more annoying than useful.

I haven't tried for a long time, but I do not think non-HEAD
destination even works at all.  It might be better not to even
mention git-merge at this point of the document.

> * How merging operates
>...
> If all three of a given file in O, A, B are different, then the three
> versions are pulled into the index file, called "stage 1", "stage 2",
> and "stage 3", and a merge strategy driver is called to resolve the mess.
> Git then uses the classic line-based three-way merge, looking for isolated
> changes and applying the same rules as for files when two of the source
> files are the same in some range.

You might also want to mention that recursive first 3-way merges
the renames.  If O->A renames a path while O->B keeps it, the
resulting stages are written under the new name.

> * When merging goes wrong
>...
> and the result of "git diff" is
>
> diff --cc hello.c
> index 4b7f550,948a5f8..0000000
> --- a/hello.c
> +++ b/hello.c
> @@@ -3,5 -3,6 +3,10 @@@
>   int
>   main(void)
>   {
> ++<<<<<<< HEAD/hello.c
>  +      printf("Goodbye, cruel world!");
> ++=======
> +       printf("Hello, world!\n");
> +       return 0;
> ++>>>>>>> edadc53fc7a8aef2a672a4fa9d09aa16f4e14706/hello.c
>   }
>
> Notice how this is not a standard diff!  It has two columns of diff
> symbols, and shows the difference from each of the ancestors to the
> current hello.c contents.  I can also use "git diff -1" to compare
> against the common ancestor, or "-2" or "-3" to compare against each of
> the merged copies individually.

Another tool to help the user decide how the mess should be
sorted out is "git log --merge -- $path".  It gives the logs of
commits that touched the path while the two branches were forked.

> * Cherry picking
>...
> You van get the list of commits on a branch with git-log or git-rev-list,

s/van/can/

> * Rebasing
>...
> Git-rebase can also help you divide up work.  Suppose you've mixed up
> development of two features in the current HEAD, a branch called "dev".

Ancestry graph before and after this procedure would help the
reader a lot here.

>...
> This will find all patches that are in dev and not in dev1,
> apply them on top of master, and call the result dev2.

> * Experimenting with merging
>...
> $ git status
> Hey, look, lots of interesting stuff.  Particularly, see
> # Changed but not updated:
> #   (use git-update-index to mark for commit)
> #
> #       unmerged: Makefile
> #       modified: Makefile
> #       unmerged: builtin.h
> #       modified: builtin.h
> #       unmerged: git.c
> #       modified: git.c
>
> The "unmerged" (a.k.a. "staged") files are ones that need manual resolution.
>
> (I notice that update-index.c isn't listed, despite being mentioned
> as a conflict in the message.  Can someone explain that?)

They were conflicts during the virtual ancestor computation by
recursive (the merge between 'a' and 'b' commits in your earlier
example).  When a virtual ancestor is created, it can textually
have conflicted merge, but that is recorded along with conflict
markers without manual resolving for obvious reasons.  If two
branches that use the virtual ancestor modifies the conflicted
region the same way (because they needed to resolve that
conflict in their branch), the final 3-way merge that uses the
virtual ancestor as the merge-base will replace that conflicted
region with their changes.  This "even conflict markers can be
eliminated by a merge resolution" behaviour is what inspired
git-rerere, by the way.

If you are using this particular commit as an example, you might
also want to tell your readers about:

	git show -M 3f69d405

(-M is there to make the output more readable, because this
merge involved a few renames).
