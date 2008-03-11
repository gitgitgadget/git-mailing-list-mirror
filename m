From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Fast forward strategies allow, never, and only
Date: Mon, 10 Mar 2008 23:19:02 -0700
Message-ID: <7vk5k9eqax.fsf@gitster.siamese.dyndns.org>
References: <402c10cd0803101959q619efa86pbd501e5e2cc018c2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Sverre Hvammen Johansen" <hvammen@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 11 07:20:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYxqA-0006yk-QV
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 07:19:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756977AbYCKGTV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 02:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750992AbYCKGTU
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 02:19:20 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41017 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756841AbYCKGTK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 02:19:10 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 483E92667;
	Tue, 11 Mar 2008 02:19:08 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id E73C32665; Tue, 11 Mar 2008 02:19:04 -0400 (EDT)
In-Reply-To: <402c10cd0803101959q619efa86pbd501e5e2cc018c2@mail.gmail.com>
 (Sverre Hvammen Johansen's message of "Mon, 10 Mar 2008 18:59:17 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76799>

"Sverre Hvammen Johansen" <hvammen@gmail.com> writes:

>>From 795bd1b3e70f011b675061ecae322527a9f0695c Mon Sep 17 00:00:00 2001
> From: Sverre Hvammen Johansen <sj@gmail.com>
> Date: Sun, 9 Mar 2008 21:43:56 -0800
> Subject: [PATCH] Fast forward strategies allow, never, and only.

Please do not do this.  The first line is not part of anything but is only
a mail message boundary in mbox format.  Reproducing From: is fine
especially if the patch author is different from the person who is sending
the patch, but I do not think it is necessary in this case.  Date and
Subject should also go, as taking them from the e-mail header is just as
good.

> New fast forward strategies, only, is introduced.  This new fast
> forward strategy prevents real merges.

"What it does".

> FF strategy "only" fails if the specified heads and HEAD can not
> be reduced down to only one real parent.  The only allowed
> outcome is a fast forward unless HEAD is up to date with
> the specified heads.

"What it does" continues.

> This patch also uses the real heads found instead of those
> specified for real merges.  This means that merge startegies
> that only take two heads can now accept more than two heads
> if they can be reduced down to only two real heads.  However,
> fast-forward of head in combination with a real merge is
> handled as before.

"What it does" continues further.

What's lacking is "why this is a good idea".

> Signed-off-by: Sverre Hvammen Johansen <sj@black.local>

Please check "[user] email" section in your .git/config file.

> @@ -0,0 +1,16 @@
> +FAST FORWARD STRATEGIES
> +-----------------------

In the context of "merge", the word "strategy" is already taken to mean
something quite different, and I am afraid that reusing the word may cause
confusion.  Probably this should be called fast forward options.

> +allow::
> +	Do not generate a merge commit if the merge resolved
> +	as a fast-forward, only update the branch pointer.
> +	This is the default behavior of git-merge.

Makes one wonder if git-pull uses different default from the default for
the git-merge command.

> +never::
> +	Generate a merge commit even if the merge resolved
> +	as a fast-forward.
> +
> +only::
> +	Only allow a fast-forward.  The merge will fail
> +	unless HEAD is up to date or the merge resolved as
> +        a fast-forward.

Funny indentation on the last line...

> @@ -29,12 +29,13 @@
>
>  --no-ff::
>  	Generate a merge commit even if the merge resolved as a
> -	fast-forward.
> +	fast-forward.  --on-ff is an alias for --ff=never.

Really?

> @@ -153,8 +153,8 @@ parse_config () {
>  		--summary)
>  			show_diffstat=t ;;
>  		--squash)
> -			test "$allow_fast_forward" = t ||
> -				die "You cannot combine --squash with --no-ff."
> +			test "$fast_forward" = allow ||
> +				die "You cannot combine --squash with --ff=never."

Why does the user get this message after saying --ff=only?

>  			squash=t no_commit=t ;;
>  		--no-squash)
>  			squash= no_commit= ;;
> @@ -163,11 +163,28 @@ parse_config () {
>  		--no-commit)
>  			no_commit=t ;;
>  		--ff)
> -			allow_fast_forward=t ;;
> +			case "$2" in
> +			allow|never|only)
> +				fast_forward=$2 squash= no_commit= ; shift ;;
> +			-*)
> +				fast_forward=allow squash= no_commit= ;;
> +			*)
> +				die "available fast-forward strategies are: allow, newer, and only" ;;

Shouldn't "squash= no_commit=" be shared across case arms?

How does this code parse "git merge --ff my_other_branch"?

Shouldn't you issue the same error message for these two inputs?

	"git merge --ff=never --squash" 
	"git merge --squash --ff=never"

> +		--ff=*)
> +			fast_forward=$(echo $1 |cut -d = -f 2) squash= no_commit=

I do not know the reason why, and theoretically there shouldn't be any
correlation, but somehow I see "cut" used more often in shell scripts that
are sloppily done.

At least you would need to quote "$1" above (and ideally protect yourself
against nonsense input like "--ff=-n"), but in this case, I think it is
simpler to say:

	fast_forward=${1#--ff=}

> @@ -279,24 +296,125 @@ do
>  done
>  set x $remoteheads ; shift
>
> +echo "$head" >"$GIT_DIR/ORIG_HEAD"
> +
> +find_one_real_parent () {

There are too many leftover debugging output in this function.

> +	while test $# -gt 0
> +	do
> +		if test $real_parent = $1
> +		then
> +			# Found a parent that is equal to the real
> +			# parent candidate
> +			echo "Duplicate $(git rev-parse --short $1)"
> +			echo "Ignoring $1"
> +		else
> +			common_b=$(git merge-base --all $real_parent $1)
> +		
> +			if test "$common_b" = $1
> +			then
> +				# Found a parent that is not
> +				# independent of the real parent
> +				# candidate
> +				echo "Possible ff $(git rev-parse --short $1)..$(git rev-parse
> --short $real_parent)."

Linewrapped by MUA.

> +find_real_parents () {
> +    find_one_real_parent $head "$@"
> +    ff_head=$real_parent
> +    real_parents=
> +
> +    while test -n "$other_parents"
> +    do
> +	find_one_real_parent $other_parents
> +	real_parents="$real_parents $real_parent"
> +    done
> +}

What does this complex double loop compute differently from what "git
show-branch --independent" gives you?  Aside from that you will run slower
but you can take more than 25 branches?

More generally, I doubt it is really useful to let the user throw millions
of potentially duplicate refs and have the merge silently record a
filtered out results.  Yes, you made the process of culling duplicates too
chatty in the above part of the patch, and fmt-merge-msg will hopefully
still show what the user gave on the command line, but the heads used by
the real merge process now is very different from it.  The merge comment
is totally disconnected from the reality.  Why is this an improvement?

If the goal is to allow Octopus that is more complex than the simplest
kind, don't.  Octopus was deliberately written to allow the most simple
kind and nothing else for a reason: bisectability.

The user should know what he is merging; throwing many heads that he does
not even know how they relate to each other, and call the resulting mess a
merge feels like a sure way to encourage a bad workflow.  Perhaps I am
missing something obvious that you are trying to automate, but I do not
see it, as there were no justification in the proposed commit log message
nor in the documentation.

> +if test $fast_forward = never -o

-o?

> +then
> +	real_parents="$@"
> +	ff_head=$head
> +else
> +	find_real_parents "$@"
> +fi

This part is simply unacceptable.  At least please do not needlessly call
find_real_parents in the most common case of giving only one remote head.

> diff --git a/t/t7601-merge-ff-strategies.sh b/t/t7601-merge-ff-strategies.sh
> new file mode 100755
> index 0000000..6c0a91a
> --- /dev/null
> +++ b/t/t7601-merge-ff-strategies.sh
> @@ -0,0 +1,549 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2007 Lars Hjemli
> +#

Really?

> -- 
> 1.5.3.3

Makes reviewers suspect that the patch submitter is not keeping up to
date.
