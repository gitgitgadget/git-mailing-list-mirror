From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] Porcelain scripts: Rewrite cryptic "needs update"
 error message
Date: Thu, 30 Sep 2010 14:08:25 -0700
Message-ID: <7vzkuzgcs6.fsf@alter.siamese.dyndns.org>
References: <1285877017-8060-1-git-send-email-artagnon@gmail.com>
 <1285877017-8060-3-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 30 23:08:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1QMy-00049O-7m
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 23:08:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756825Ab0I3VIm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Sep 2010 17:08:42 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46784 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756778Ab0I3VIl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Sep 2010 17:08:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E2DDADAD6D;
	Thu, 30 Sep 2010 17:08:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mQcfcml/c+zE8BuALDfKeH4G02w=; b=UGXzPV
	WWSqS3iEC3lRrw/ZPaNXJdLhvSz9ux5EITB4HsqKZJrEYO73cR7OEEPup5yYACT7
	y6s3n0Hu61wl0LM47bdZUPnDv0GdJ0l3bQheM28e2zxz8rFR02VbdX/X4ln4QxWH
	+MRaIDkk6qa2EEu5jjk0v6bhFPZqhv/GEq19k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QvWN704+U8C9bfT6gGzgp/ZMDDPJUSGy
	46c/JeQ0mrvGA031t/SHs/IV2YiCH/uY2ZLImss+TuSNzae5hkFP3ei5vbWf76zr
	7vF9QoOB0JAuKxMrsVp2vtArjoO9zh2Okfvs7yAMiEL7rTjrBuhgA3D0n2dgOVu5
	SRF+S8CpWR0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8EBCFDAD69;
	Thu, 30 Sep 2010 17:08:33 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 497E4DAD65; Thu, 30 Sep
 2010 17:08:27 -0400 (EDT)
In-Reply-To: <1285877017-8060-3-git-send-email-artagnon@gmail.com> (Ramkumar
 Ramachandra's message of "Fri\,  1 Oct 2010 01\:33\:37 +0530")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E2434F88-CCD6-11DF-8A46-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157712>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> diff --git a/git-pull.sh b/git-pull.sh
> index 8eb74d4..a15b545 100755
> --- a/git-pull.sh
> +++ b/git-pull.sh
> @@ -201,10 +201,7 @@ test true = "$rebase" && {
>  			die "updating an unborn branch with changes added to the index"
>  		fi
>  	else
> -		git update-index --ignore-submodules --refresh &&
> -		git diff-files --ignore-submodules --quiet &&
> -		git diff-index --ignore-submodules --cached --quiet HEAD -- ||
> -		die "refusing to pull with rebase: your working tree is not up-to-date"
> +		require_clean_work_tree "pull with rebase"

Ok, this wants both the working tree and the index clean, and it will exit
with non-zero.  The original message mentioned "working tree" but by
calling require_clean_work_tree the user won't see that word anymore.

> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index a27952d..9546975 100755
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -153,14 +153,6 @@ run_pre_rebase_hook () {
>  	fi
>  }
>  
> -require_clean_work_tree () {
> -	# test if working tree is dirty
> -	git rev-parse --verify HEAD > /dev/null &&
> -	git update-index --ignore-submodules --refresh &&
> -	git diff-files --quiet --ignore-submodules &&
> -	git diff-index --cached --quiet HEAD --ignore-submodules -- ||
> -	die "Working tree is dirty"
> -}

We used to test and exit early if HEAD cannot be read (e.g. empty
history), but now require_clean_work_tree() will probably spit a cryptic
error from diff-index it makes.  Don't you need to have an equivalent
check for HEAD somewhere before you make the first call to r-c-w-t?

> @@ -557,12 +549,9 @@ do_next () {
>  			exit "$status"
>  		fi
>  		# Run in subshell because require_clean_work_tree can die.
> -		if ! (require_clean_work_tree)
> +		if ! (require_clean_work_tree "rebase")
>  		then
> -			warn "Commit or stash your changes, and then run"
> -			warn
> -			warn "	git rebase --continue"
> -			warn
> +			warn "Then run git rebase --continue."

We will see something like:

	cannot rebase: you have unstaged changes.
	M Makefile
	cannot rebase: you index contains uncommitted changes.
	M Makefile
        M hello.c
        M goodbye.c
        ... 147 other paths that make the above scroll away ...
        Please commit or stash them.
        Then run git rebase --continue.

Is this what we really want?  Also the messages seem somewhat
case-challenged.



>  			exit 1
>  		fi
>  		;;
> @@ -740,7 +729,7 @@ do
>  			die "Cannot read HEAD"
>  		git update-index --ignore-submodules --refresh &&
>  			git diff-files --quiet --ignore-submodules ||
> -			die "Working tree is dirty"
> +			die "Working tree is dirty. Please commit or stash your changes to proceed."

I wonder if it is a good advice to choose between committing and stashing.

This codepath is for --continue, and by definition when rebase started
there wasn't any local modification (otherwise it wouldn't have started
and we wouldn't have come this far), so the change must have come from the
end user who wanted to amend (or resolve conflicts), thought that s/he
included all the changes s/he did in the working tree in the amended
commit and told us to continue.  We however found some leftover local
modifications.

"Please commit or stash" is probably the worst advice we can give in this
particular situation.  It is likely to be something s/he forgot to add;
the existing advice that says "Please commit them first and then ..." you
can see a few lines down this part is probably better.

In other codepaths, aborting rebase and cleaning the work area first
before attempting a rebase might be a better choice than either committing
or stashing.  Often, I find that is the least confusing choise, at least.

> diff --git a/git-rebase.sh b/git-rebase.sh
> index 3335cee..c3ca8d5 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -416,19 +416,7 @@ else
>  	fi
>  fi
>  
> -# The tree must be really really clean.
> -if ! git update-index --ignore-submodules --refresh > /dev/null; then
> -	echo >&2 "cannot rebase: you have unstaged changes"
> -	git diff-files --name-status -r --ignore-submodules -- >&2
> -	exit 1
> -fi
> -diff=$(git diff-index --cached --name-status -r --ignore-submodules HEAD --)
> -case "$diff" in
> -?*)	echo >&2 "cannot rebase: your index contains uncommitted changes"
> -	echo >&2 "$diff"
> -	exit 1
> -	;;
> -esac
> +require_clean_work_tree "rebase"

This side is uncontroversial, except that it has the same "is commit/stash
the best advice?" issue.
