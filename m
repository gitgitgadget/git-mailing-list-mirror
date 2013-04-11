From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pull: fail early if we know we can't merge from upstream
Date: Thu, 11 Apr 2013 10:37:39 -0700
Message-ID: <7v1uahj7do.fsf@alter.siamese.dyndns.org>
References: <1365686801-17206-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Thu Apr 11 19:37:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQLRV-0001AH-Va
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 19:37:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935431Ab3DKRhp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Apr 2013 13:37:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63270 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752303Ab3DKRho convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Apr 2013 13:37:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 085B5143F3;
	Thu, 11 Apr 2013 17:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=rThbU/iylKsU
	k/O3RdcMz3Fzo+E=; b=JvTWZKVR1+bjk6xxdU78zuYn/vmGqUaXp3cPNCYjNXGU
	4xRn8rxu2N+1ip4gk+N8IN6iOU8gPIf2YDAvBoe0vPHWuJIAnz+4Eo/GLtBBN5Wn
	ByCYRAwpFW1WaodFxOikDvzOLXqmhYvntoS3lUyudOeOOktlVEtIAB5KiwxrqHY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=aJbahL
	OBFA7F5ggYKGuzJvsmK+TImAh7eWCkvTDF6bvJ85gdMoyvMVkxnaEGpAPstp37EG
	cdw7PfDB4Ps7SGaYfbsV+nG5lyZxhqNtESFYmmDSdo95MmM2aJwg5i9QuB2YiOXy
	BUIaZMvygCqjeQyAou1a33lFjDNqJayiefFRY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 00476143F2;
	Thu, 11 Apr 2013 17:37:42 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3D703143EE; Thu, 11 Apr
 2013 17:37:41 +0000 (UTC)
In-Reply-To: <1365686801-17206-1-git-send-email-cmn@elego.de> ("Carlos
 =?utf-8?Q?Mart=C3=ADn?= Nieto"'s message of "Thu, 11 Apr 2013 15:26:41
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 82997AD2-A2CE-11E2-A7B2-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220898>

Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:

> I can't quite decide whether the behaviour of 'git pull' with no
> upstream configured but a default remote with no fetch refspecs
> merging the remote's HEAD is a feature, a bug or something in between=
,
> but it's used by t7409 so maybe someone else is using it and we
> shouldn't break it.

Isn't it the simplest "works without any configuration" from the
original days?=20

> There's another check that could be made earlier ('git pull
> someremote' when that's not the branch's upstream remote), but then
> you have to start figuring out what the flags to fetch are.

When the user gave us explicitly the name of the remote, it does not
sound too bad to fetch from there.  "git pull someremote thatbranch"
can be given after seeing a failure and succeed without retransfer,
no?

I am not sure if it is worth the added complexity and potential to
introduce new bugs in general by trying to outsmart the for-merge
logic that kicks in only after we learn what the other side offers
and fetch from it, but anyway, let's see what we got here...

> diff --git a/git-pull.sh b/git-pull.sh
> index 266e682..b62f5d3 100755
> --- a/git-pull.sh
> +++ b/git-pull.sh
> @@ -43,6 +43,8 @@ log_arg=3D verbosity=3D progress=3D recurse_submodu=
les=3D
>  merge_args=3D edit=3D
>  curr_branch=3D$(git symbolic-ref -q HEAD)
>  curr_branch_short=3D"${curr_branch#refs/heads/}"
> +upstream=3D$(git config "branch.$curr_branch_short.merge")
> +remote=3D$(git config "branch.$curr_branch_short.remote")
>  rebase=3D$(git config --bool branch.$curr_branch_short.rebase)

Learning these upfront sounds sensible.

>  if test -z "$rebase"
>  then
> @@ -138,6 +140,47 @@ do
>  	esac
>  	shift
>  done
> +if test true =3D "$rebase"
> +then
> +    op_type=3Drebase
> +    op_prep=3Dagainst
> +else
> +    op_type=3Dmerge
> +    op_prep=3Dwith
> +fi
> +
> +check_args_against_config () {
> +	# If fetch gets user-provided arguments, the user is
> +	# overriding the upstream configuration, so we have to wait
> +	# for fetch to do its work to know if we can merge.
> +	if [ $# -gt 0 ]; then
> +		return
> +	fi

> +	# Figure out what remote we're going to be fetching from
> +	use_remote=3Dorigin
> +	if [ -n "$remote" ]; then
> +		use_remote=3D"$remote"
> +	fi
> +
> +	# If the remote doesn't have a fetch refspec, then we'll merge
> +	# whatever fetch marks for-merge, same as above.

The "above" in this sentence refers to...?

I guess "we have to wait", but it wasn't very clear.

> +	fetch=3D$(git config --get-all "remote.$use_remote.fetch")
> +	if [ -z "$fetch" ]; then
> +		return
> +	fi

Hmm, it is probably correct to punt on this case, but it defeats
large part of the effect of your effort, doesn't it? We fetch what
is covered by remote.$name.fetch _and_ what need to complete the
merge operation (otherwise branch.$name.merge that is not covered by
remote.$there.fetch will not work).  So

    [remote "origin"]
            url =3D $over_there
    [branch "master"]
            remote =3D origin
            merge =3D refs/heads/master

would still fetch refs/heads/master from there and merge it.

> +	# The typical 'git pull' case where it should merge from the
> +	# current branch's upstream. We can already check whether we
> +	# we can do it. If HEAD is detached or there is no upstream
> +	# branch, complain now.

Drop "typical", and rephrase "merge from" to also cover "rebase" (I
often say "integrate with").

To return to your original description:

    A 'git pull' without specifying a remote is asked to take the
    current branch's upstream as the branch to merge from. This
    cannot work without an upstream configuration nor with HEAD
    detached, but we only check for this after fetching.

Wouldn't it be sufficient to add something like this before fetch
happens:

	if test $# !=3D 0 || # args explicitly specified
           test -n "$curr_branch" || # not detached
	   test -n "$upstream" # what to integrate with is known
	then
		return ;# then no problem
	fi
	die "underspecified 'git pull'"

without changing anything else?  For that matter, $upstream is
likely to be empty when detached, so the second test may not even be
necessary.
