From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-filter-branch could be confused by similar names
Date: Thu, 03 Jan 2008 13:27:27 -0800
Message-ID: <7v7iiqppkw.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0712301700580.14355@wbgn129.biozentrum.uni-wuerzburg.de>
	<1199040667-31850-1-git-send-email-dpotapov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 03 22:28:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAXbl-0002Xk-Qi
	for gcvg-git-2@gmane.org; Thu, 03 Jan 2008 22:28:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752024AbYACV1n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jan 2008 16:27:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752036AbYACV1n
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jan 2008 16:27:43 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:50112 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751540AbYACV1m (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jan 2008 16:27:42 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 40A3E190D;
	Thu,  3 Jan 2008 16:27:38 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 80F8C190B;
	Thu,  3 Jan 2008 16:27:34 -0500 (EST)
In-Reply-To: <1199040667-31850-1-git-send-email-dpotapov@gmail.com> (Dmitry
	Potapov's message of "Sun, 30 Dec 2007 21:51:07 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69536>

Dmitry Potapov <dpotapov@gmail.com> writes:

> 'git-filter-branch branch' could fail producing the error:
> "Which ref do you want to rewrite?" if existed another branch
> or tag, which name was 'branch-something' or 'something/branch'.
>
> Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
> ---
>
> I have corrected my previous patch to allow "heads" or "tags"
> in the name of a branch or tag, i.e. to write it like this:
>    git filter-branch heads/master
>
>  git-filter-branch.sh     |    2 +-
>  t/t7003-filter-branch.sh |   10 ++++++++++
>  2 files changed, 11 insertions(+), 1 deletions(-)
>
> diff --git a/git-filter-branch.sh b/git-filter-branch.sh
> index dbab1a9..5de8b12 100755
> --- a/git-filter-branch.sh
> +++ b/git-filter-branch.sh
> @@ -219,7 +219,7 @@ do
>  	;;
>  	*)
>  		ref="$(git for-each-ref --format='%(refname)' |
> -			grep /"$ref")"
> +			grep '^refs/\([^/]\+/\)\?'"$ref"'$')"
>  	esac

Do we assume everybody's grep groks ERE these days?  I had an
impression that we try to stick to a subset of BRE (namely, no
\{m,n\}, [::], [==], nor [..]).

Also as a general rule when dealing with refname, we use
fileglob not regex.

What's the goal here?  Is it to make sure given refname is
unambiguous by being a unique suffix of tags or heads, as in

	test $(git show-ref "$ref" | wc -l) = 1

or is there anything more going on?

Ah, it also wants the full name of the ref.  How about...

	ref=$(git show-ref "$ref" | sed -e 's/^.* //')

and have the "git check-ref-format" that comes later to issue an
error message?        

A better error message would be obtained with perhaps doing

	LF='
        '
        
at the beginning and then doing:

	candidate=$(git show-ref "$ref" | sed -e 's/^.* //')
	case "$candidate" in
        '')
        	die "should not happen -- $ref did not match?"
                ;;
        ?*"$LF"?*)
		die "$ref is ambiguous, which one of: $canidate?"
		;;
	esac
        ref=$candidate
