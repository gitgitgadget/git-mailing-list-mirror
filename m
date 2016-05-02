From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-stash: Don't GPG sign when stashing changes
Date: Mon, 02 May 2016 14:57:38 -0700
Message-ID: <xmqqoa8oqg19.fsf@gitster.mtv.corp.google.com>
References: <00000150dddb0eeb-b77240fb-1b63-4676-ac4b-1220b8d011ca-000000@eu-west-1.amazonses.com>
	<01020154733c27e9-deaa7a20-1de6-416a-a7d4-3229854117eb-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Cameron Currie <me@cameroncurrie.net>,
	Daurnimator <quae@daurnimator.com>
X-From: git-owner@vger.kernel.org Mon May 02 23:57:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axLqe-0003MO-Df
	for gcvg-git-2@plane.gmane.org; Mon, 02 May 2016 23:57:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755192AbcEBV5n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2016 17:57:43 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50944 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754953AbcEBV5m (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2016 17:57:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DC86F18AE2;
	Mon,  2 May 2016 17:57:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/agIU4BvYb6b7mEeYBhgCWrv+jE=; b=BndZvg
	QUEMkebSDnekZLnu/KK65MYSuLu/AXqfF2UubN4LTOjjlQ99rclr2BymQqI689Sz
	HaWJmGMP2U7boDr9PPGgxD3FkqFW7KBpyWHw6b96kqMvCwo2W5JNCk50r6G3nRnI
	5Fi6TdmAGWh1viNAGl131MYkaOfIOhNITvL/0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Z7fBBZS7jkYDi0FXMLsqtdPSkgokmau9
	axjJkaZoLb9YfIKlFJJFlKV5OSeLrnANjGkKNHMDuj+Z/3t1jCUNY+G/Ii/XkwAr
	Frqh/yI2XoZsp71oM5RW7wUOm7AJIhWAdkxR6Mquh7UCYzJCNrfiduG1m4n1HYbr
	FoA8STNQ8gc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D4E0E18AE1;
	Mon,  2 May 2016 17:57:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2ECA518AE0;
	Mon,  2 May 2016 17:57:40 -0400 (EDT)
In-Reply-To: <01020154733c27e9-deaa7a20-1de6-416a-a7d4-3229854117eb-000000@eu-west-1.amazonses.com>
	(Cameron Currie's message of "Mon, 2 May 2016 20:50:02 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E3B66390-10B0-11E6-BADF-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293291>

Cameron Currie <me@cameroncurrie.net> writes:

> This is helpful for folks with commit.gpgsign = true in their .gitconfig.
>
> Signed-off-by: Cameron Currie <me@cameroncurrie.net>
> ---

I do not think this is particularly a good change.

There are a few other in-tree users of "git commit-tree",
e.g. quiltimport and filter-branch, and their users would be hurt
the same way if they set commit.gpgsign in the configuration.

I think it was a mistake that "commit-tree" was made to pay
attention to the configuration variable in the first place.
Allowing scripts that use commit-tree to explicitly pass -S to it is
perfectly fine (and these calling scripts are welcome to honor
commit.gpgsign by reading the configration themselves if their users
want it that way).

I'll send a pair of proposed alternative solutions shortly.

>  git-stash.sh | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/git-stash.sh b/git-stash.sh
> index c7c65e2..fcf01b9 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -85,7 +85,7 @@ create_stash () {
>  	# state of the index
>  	i_tree=$(git write-tree) &&
>  	i_commit=$(printf 'index on %s\n' "$msg" |
> -		git commit-tree $i_tree -p $b_commit) ||
> +		git commit-tree --no-gpg-sign $i_tree -p $b_commit) ||
>  		die "$(gettext "Cannot save the current index state")"
>  
>  	if test -n "$untracked"
> @@ -99,7 +99,7 @@ create_stash () {
>  				rm -f "$TMPindex" &&
>  				git update-index -z --add --remove --stdin &&
>  				u_tree=$(git write-tree) &&
> -				printf 'untracked files on %s\n' "$msg" | git commit-tree $u_tree  &&
> +				printf 'untracked files on %s\n' "$msg" | git commit-tree --no-gpg-sign $u_tree  &&
>  				rm -f "$TMPindex"
>  		) ) || die "Cannot save the untracked files"
>  
> @@ -153,7 +153,7 @@ create_stash () {
>  		stash_msg=$(printf 'On %s: %s' "$branch" "$stash_msg")
>  	fi
>  	w_commit=$(printf '%s\n' "$stash_msg" |
> -	git commit-tree $w_tree -p $b_commit -p $i_commit $untracked_commit_option) ||
> +	git commit-tree --no-gpg-sign $w_tree -p $b_commit -p $i_commit $untracked_commit_option) ||
>  	die "$(gettext "Cannot record working tree state")"
>  }
>  
>
> --
> https://github.com/git/git/pull/186
