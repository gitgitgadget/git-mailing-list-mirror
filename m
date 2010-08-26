From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] filter-branch: retire --remap-to-ancestor
Date: Thu, 26 Aug 2010 10:19:43 -0700
Message-ID: <7vtymhl2a8.fsf@alter.siamese.dyndns.org>
References: <20100826092233.GA32617@acharya.in.gluster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Csaba Henk <csaba@gluster.com>
X-From: git-owner@vger.kernel.org Thu Aug 26 19:19:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oog7J-0006rb-PQ
	for gcvg-git-2@lo.gmane.org; Thu, 26 Aug 2010 19:19:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751985Ab0HZRTx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Aug 2010 13:19:53 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35937 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751301Ab0HZRTv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Aug 2010 13:19:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 28CBAD08C5;
	Thu, 26 Aug 2010 13:19:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=j3+oCrYohNylIUGtdaNyKOUbx2Y=; b=FxkwFc
	xNByoB6ZWSKq+Qb0iaX0Proi4tqRnbS9iZtC3TA+nE2bPSEagrNeRk7VNJpgWgmR
	oXEunI7oVwTjNfofAldtc6e2VrKqH+1XSb8s4QHPwT5hqBTTIBUUvFc1sTDPUm0H
	XNejbxnsMTfN+ilQ16TodyXUgfehv5von/x+Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=v12X0/YjEDm+Rrmrpc7NK+dDG6KSFvHc
	htmT9cLm2Rz4LyPHLxrWb9chIuLrhfiaoh9dStjifxdgu/IdaBqlGq4btXjJeoq1
	4lol8Gx5XYoKnwQFtcCMS221oryJoX9gVW5Cd33Egmw4a5Bidp+hRDxXYANnzB/5
	FFQRYZWW3sU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0429FD08C4;
	Thu, 26 Aug 2010 13:19:47 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 29084D08BA; Thu, 26 Aug
 2010 13:19:45 -0400 (EDT)
In-Reply-To: <20100826092233.GA32617@acharya.in.gluster.com> (Csaba Henk's
 message of "Thu\, 26 Aug 2010 14\:52\:33 +0530")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 20BB2158-B136-11DF-B809-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154547>

Csaba Henk <csaba@gluster.com> writes:

> We can be clever and know by ourselves when we need the behavior
> implied by "--remap-to-ancestor". No need to encumber users by having
> them exposed to it as a tunable.
> ---

Sign-off?

> diff --git a/git-filter-branch.sh b/git-filter-branch.sh
> index 88fb0f0..fd5caaa 100755
> --- a/git-filter-branch.sh
> +++ b/git-filter-branch.sh
> @@ -138,11 +138,6 @@ do
>  		force=t
>  		continue
>  		;;
> -	--remap-to-ancestor)
> -		shift
> -		remap_to_ancestor=t
> -		continue
> -		;;

This is not friendly to people who already wrote their own scripts and/or
trained their fingers to use this option.  It would be better to just
accept the option silently and do nothing.  Even better, do not touch this
part at all, so that people can ask for this option when there is no
pathspec (as far as I can see, there is no harm in doing so).

> @@ -265,7 +260,14 @@ mkdir ../map || die "Could not create map/ directory"
>  
>  # we need "--" only if there are no path arguments in $@
>  nonrevs=$(git rev-parse --no-revs "$@") || exit
> -test -z "$nonrevs" && dashdash=-- || dashdash=
> +if test -z "$nonrevs"
> +then
> +	dashdash=--
> +else
> +	dashdash=
> +	remap_to_ancestor=t
> +fi

The above is fine.

If you were paranoid, you could make this default assignment conditional,
i.e.

	: ${remap_to_ancestor:=t}

which would then allow people to say --no-remap-to-ancestor when using
pathspecs (for whatever reason), if you add:

	--no-remap-to-ancestor)
		shift
                remap_to_ancestor=f
		continue
                ;;

in the command line parser loop.  You would need to change the remapping
logic to trigger when $remap_to_ancestor is set to 't' if you did so.

But I don't think the paranoia is necessary here.

> diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
> index 2c55801..486c453 100755
> --- a/t/t7003-filter-branch.sh
> +++ b/t/t7003-filter-branch.sh
> @@ -289,7 +289,7 @@ test_expect_success 'Prune empty commits' '
>  	test_cmp expect actual
>  '
>  
> -test_expect_success '--remap-to-ancestor with filename filters' '
> +test_expect_success 'filename filters work even if the given files are not changed in branch head' '
>  	git checkout master &&
>  	git reset --hard A &&
>  	test_commit add-foo foo 1 &&
> @@ -299,7 +299,7 @@ test_expect_success '--remap-to-ancestor with filename filters' '
>  	orig_invariant=$(git rev-parse invariant) &&
>  	git branch moved-bar &&
>  	test_commit change-foo foo 2 &&
> -	git filter-branch -f --remap-to-ancestor \
> +	git filter-branch -f \
>  		moved-foo moved-bar A..master \
>  		-- -- foo &&
>  	test $(git rev-parse moved-foo) = $(git rev-parse moved-bar) &&

This is good, but I think it is better if the same is tested with and
without the option (iow, add a test without --remap that expects the same
result, keeping the existing one with --remap intact).

Thanks.
