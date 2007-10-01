From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Adding rebase merge strategy
Date: Mon, 01 Oct 2007 14:01:32 -0700
Message-ID: <7vr6ker1lf.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0709281751390.28395@racer.site>
	<11912513203420-git-send-email-tom@u2i.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes.Schindelin@gmx.de, git@vger.kernel.org
To: Tom Clarke <tom@u2i.com>
X-From: git-owner@vger.kernel.org Mon Oct 01 23:02:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcSPE-0007rw-0b
	for gcvg-git-2@gmane.org; Mon, 01 Oct 2007 23:02:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753681AbXJAVBt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2007 17:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753620AbXJAVBt
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Oct 2007 17:01:49 -0400
Received: from rune.pobox.com ([208.210.124.79]:58133 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752743AbXJAVBt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2007 17:01:49 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id E4CFA13FBB1;
	Mon,  1 Oct 2007 17:02:04 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id C2E7E13FBEA;
	Mon,  1 Oct 2007 17:02:00 -0400 (EDT)
In-Reply-To: <11912513203420-git-send-email-tom@u2i.com> (Tom Clarke's message
	of "Mon, 1 Oct 2007 17:08:40 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59633>

Tom Clarke <tom@u2i.com> writes:

> diff --git a/Documentation/merge-strategies.txt b/Documentation/merge-strategies.txt
> index 7df0266..dff1909 100644
> --- a/Documentation/merge-strategies.txt
> +++ b/Documentation/merge-strategies.txt
> @@ -33,3 +33,9 @@ ours::
>  	merge is always the current branch head.  It is meant to
>  	be used to supersede old development history of side
>  	branches.
> +
> +rebase::
> +	This rebases the current branch based on a single head.
> +	Commits are rewritten as with git-rebase. This doesn't
> +	produce a merge. The procedure for dealing with conflicts 
> +	is the same as with git-rebase.

This would give a handier shortcut iff the rebase goes well, but
the workflow after stopping would be entirely different from the
normal "merge".  I am a bit worried about it giving confusion to
the end users.

> diff --git a/git-merge-rebase.sh b/git-merge-rebase.sh
> new file mode 100755
> index 0000000..b75be3f
> --- /dev/null
> +++ b/git-merge-rebase.sh
> @@ -0,0 +1,17 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2007 Tom Clarke
> +#
> +# Resolve two trees with rebase
> +
> +# The first parameters up to -- are merge bases ignore them
> +while test $1 != "--"; do shift; done
> +shift
> +
> +# ignore the first head, it's not needed in a rebase merge
> +shift
> +
> +# Give up if we are given two or more remotes -- not handling octopus.
> +test $# = 1 || exit 2
> +
> +git rebase $1 || exit 2

This code makes rebase strategy to signal the caller that rebase
it punted by exit status 2 when it spots conflicting changes.

At that point, what is the state of the branch tip, the index
and the work tree?

When a merge strategy exits with 1 ("I cannot handle this fully
but here is a partial attempt"), it is expected to leave
something that can be resolved in the working tree to be
committed (iow, do some edit, update-index and the a single
"commit" will conclude the whole "git merge" business).

When the strategy exits with 2 ("I cannot deal with this at
all"), git-merge will rewind the branch, index and the work tree
by calling restorestate to the pristine state (in order to clear
whatever mess the strategy may have created), say "Merge with
strategy rebase failed.", and exits with 2.

And at that point, what can the user do?

The user then can initiate the rebase process again from the
command line (perhaps even with "-i"):

	$ git rebase FETCH_HEAD

and deal manually with the incremental conflict resolution.
This needs to be documented a bit more clearly, I think, than
your change in the Documentation/merge-strategies.txt.

But more importantly, the above recovery is possible only if you
abort that failed rebase you did in your strategy module, isn't
it?

Although I haven't tried, I suspect that you need to change the
final "git rebase $1 || exit 2" in your script with something
like:

	git rebase "$1" || {
        	git rebase --abort
                exit 2
	}

Have you tested conflicting cases to see how well it works and
what the user experience would look like?

> diff --git a/git-merge.sh b/git-merge.sh
> index 6c513dc..b58bee2 100755
> --- a/git-merge.sh
> +++ b/git-merge.sh
> ...
> @@ -81,11 +82,18 @@ finish () {
>  			echo "No merge message -- not updating HEAD"
>  			;;
>  		*)
> -			git update-ref -m "$rlogm" HEAD "$1" "$head" || exit 1
> +			case " $wt_strategy " in
> +			*" $no_update_ref "*)
> +				;;
> +			*)
> +				git update-ref -m "$rlogm" HEAD "$1" "$head" || exit 1
> +				;;
> +			esac

Is this because a successful rebase strategy already updated the
ref?  I would not object from the end user experience point of
view to allow "git merge -s rebase" command, but I suspect the
changes to the merge frontend could to be restructured a bit to
handle this easier to read.

>  			;;
>  		esac
>  		;;
>  	esac
> +
>  	case "$1" in
>  	'')
>  		;;

Probably this is a good readability improvement.

> @@ -418,6 +426,16 @@ do
>  	;;
>      esac
>  
> +    # Check to see if there's a message in a merge type that won't produce a commit 
> +    if test $have_message = "t"
> +    then

That quoting is backwards, isn't it?

Literal "t" is not empty and you know you do not need to quote;
you instead need to quote $have_message, because that could be
empty and will not even be given as a separate token to "test"
command without quoting when empty.

> +	case " $strategy " in
> +	    *" $no_update_ref "*)

You have an unnecessary extra indentation here.

> +	    echo >&2 "warning: Message is not used for $strategy merge strategy"
> +	    ;;
> +	esac

I had to spend 3 minutes thinking about this; if you had a
comment like "A strategy that updates the ref by itself (iow,
bypassing git-merge) does not give git-merge to record the merge
commit using the given message."  here, I did not have to.
