From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Reallow git-rebase --interactive --continue if commit is unnecessary
Date: Wed, 26 Dec 2007 15:48:56 -0800
Message-ID: <7vr6h9m2zb.fsf@gitster.siamese.dyndns.org>
References: <87r6hias5s.fsf@gollum.intra.norang.ca>
	<20071220071212.GA20534@spearce.org>
	<7vzlw5rg53.fsf@gitster.siamese.dyndns.org>
	<20071220073113.GJ14735@spearce.org>
	<7vy7bppv3s.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Bernt Hansen <bernt@alumni.uwaterloo.ca>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Dec 27 00:49:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J7g0K-0003d6-JJ
	for gcvg-git-2@gmane.org; Thu, 27 Dec 2007 00:49:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751691AbXLZXtJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Dec 2007 18:49:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751676AbXLZXtI
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Dec 2007 18:49:08 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:44585 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751673AbXLZXtH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Dec 2007 18:49:07 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 79B1B5219;
	Wed, 26 Dec 2007 18:49:03 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 93C635214;
	Wed, 26 Dec 2007 18:48:58 -0500 (EST)
In-Reply-To: <7vy7bppv3s.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 20 Dec 2007 01:35:03 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69250>

Junio C Hamano <gitster@pobox.com> writes:

> Will do, but the code looks quite bad (not entirely your fault).
>
> Line by line comment to show my puzzlement.
>
>  		# commit if necessary
>
> Ok, the user has prepared the index for us, and we are going to do some
> tests and conditionally create commit.
>
>  		git rev-parse --verify HEAD > /dev/null &&
>
> Do we have HEAD commit?  Why check this --- we do not want to rebase
> from the beginning of time?  No, that's not it.  If this fails, there is
> something seriously wrong.  This is not about "will we make a commit?"
> check at all.  This is a basic sanity check and if it fails we must
> abort, not just skip.
>
>  		git update-index --refresh &&
>  		git diff-files --quiet &&
>
> Is the work tree clean with respect to the index?  Why check this --- we
> want to skip the commit if work tree is dirty?  Or is this trying to
> enforce the invariant that during the rebase the work tree and index and
> HEAD should all match?  If the latter, failure from this again is a
> reason to abort.
>
>  		! git diff-index --cached --quiet HEAD -- &&
>
> Do we have something to commit?  This needs to be checked so that we can
> skip a commit that results in emptyness, so using this as a check to see
> if we should commit makes sense.
>
>  		. "$DOTEST"/author-script && {
>  			test ! -f "$DOTEST"/amend || git reset --soft HEAD^
>  		} &&
>
> Find GIT_AUTHOR_* variables and if we are amending rewind the HEAD.  The
> failure from this is a grave problem and reason to abort, isn't it?
>
>  		export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_AUTHOR_DATE &&
> 		git commit --no-verify -F "$DOTEST"/message -e
>
> Then we go on to create commit.  As you said, failure from this is a
> grave error.

Any response to this or problems in the clean-up patch?

> ---
>  git-rebase--interactive.sh |   29 +++++++++++++++++++----------
>  1 files changed, 19 insertions(+), 10 deletions(-)
>
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 090c3e5..7aa4278 100755
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -363,17 +363,26 @@ do
>  
>  		test -d "$DOTEST" || die "No interactive rebase running"
>  
> -		# commit if necessary
> -		git rev-parse --verify HEAD > /dev/null &&
> -		git update-index --refresh &&
> -		git diff-files --quiet &&
> -		! git diff-index --cached --quiet HEAD -- &&
> -		. "$DOTEST"/author-script && {
> -			test ! -f "$DOTEST"/amend || git reset --soft HEAD^
> -		} &&
> -		export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_AUTHOR_DATE &&
> -		if ! git commit --no-verify -F "$DOTEST"/message -e
> +		# Sanity check
> +		git rev-parse --verify HEAD >/dev/null ||
> +			die "Cannot read HEAD"
> +		git update-index --refresh && git diff-files --quiet ||
> +			die "Working tree is dirty"
> +
> +		# do we have anything to commit?
> +		if git diff-index --cached --quiet HEAD --
>  		then
> +			: Nothing to commit -- skip this
> +		else
> +			. "$DOTEST"/author-script ||
> +				die "Cannot find the author identity"
> +			if test -f "$DOTEST"/amend
> +			then
> +				git reset --soft HEAD^ ||
> +				die "Cannot rewind the HEAD"
> +			fi
> +			export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_AUTHOR_DATE &&
> +			git commit --no-verify -F "$DOTEST"/message -e ||
>  			die "Could not commit staged changes."
>  		fi
>  
