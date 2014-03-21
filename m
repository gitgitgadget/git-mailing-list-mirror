From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/12] t: stop using GIT_CONFIG to cross repo boundaries
Date: Fri, 21 Mar 2014 14:26:02 -0700
Message-ID: <xmqqtxars0ph.fsf@gitster.dls.corp.google.com>
References: <20140320231159.GA7774@sigill.intra.peff.net>
	<20140320231524.GD8479@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Tran <unsignedzero@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 21 22:26:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WR6xF-0001yH-Qk
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 22:26:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbaCUV0O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 17:26:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57343 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750849AbaCUV0M (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 17:26:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8CA1E76F43;
	Fri, 21 Mar 2014 17:26:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+dhpbE8bjwRt4T36K0Wu550EMnQ=; b=fp72hO
	0+kaHvwZF4qIoSC60MZSojteA8Eld43QjybeH5DQVgZCtSDkGCkqVnV6uw6Wvj/T
	TUCRXiUJq6sFIeHB5+ViYoomBzPv6ANCsWuITuDt9rXCq7S4fcmOym1jDYbiZJbU
	Sy6kJrK1DXDhisNsHmPK26Tem9mZxM70uYhgA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bepmIhHvaNVIwc3Grx4yUXuRohwYquHJ
	u4+6E7KMtCt/0/PE6ePqehjhYKysQHELEx2itx9NO0rTz4i7TqOvTevDk5engXHn
	2icGwnCFd5Rf2QLKXtNabAJcKCkpfy2bVAVPnALJV1yJwF2cggbJA8cwSIzYrTP9
	9VxSVKOQv+4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7074B76F39;
	Fri, 21 Mar 2014 17:26:11 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D83D176F12;
	Fri, 21 Mar 2014 17:26:07 -0400 (EDT)
In-Reply-To: <20140320231524.GD8479@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 20 Mar 2014 19:15:24 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6A7E8BD8-B13F-11E3-A8C8-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244751>

Jeff King <peff@peff.net> writes:

> Some tests want to check or set config in another
> repository. E.g., t1000 creates repositories and makes sure
> that their core.bare and core.worktree settings are what we
> expect. We can do this with:
>
>   GIT_CONFIG=$repo/.git/config git config ...
>
> but it better shows the intent to just enter the repository
> and let "git config" do the normal lookups:
>
>   (cd $repo && git config ...)
>
> In theory, this would cause us to use an extra subshell, but
> in all such cases, we are actually already in a subshell.

Sure; alternatively we could use "git -C $there", but this rewrite
is fine by me.

Thanks.

> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/t0001-init.sh        | 4 ++--
>  t/t5701-clone-local.sh | 6 +++---
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/t/t0001-init.sh b/t/t0001-init.sh
> index ddc8160..9b05fdf 100755
> --- a/t/t0001-init.sh
> +++ b/t/t0001-init.sh
> @@ -12,8 +12,8 @@ check_config () {
>  		echo "expected a directory $1, a file $1/config and $1/refs"
>  		return 1
>  	fi
> -	bare=$(GIT_CONFIG="$1/config" git config --bool core.bare)
> -	worktree=$(GIT_CONFIG="$1/config" git config core.worktree) ||
> +	bare=$(cd "$1" && git config --bool core.bare)
> +	worktree=$(cd "$1" && git config core.worktree) ||
>  	worktree=unset
>  
>  	test "$bare" = "$2" && test "$worktree" = "$3" || {
> diff --git a/t/t5701-clone-local.sh b/t/t5701-clone-local.sh
> index c490368..3c087e9 100755
> --- a/t/t5701-clone-local.sh
> +++ b/t/t5701-clone-local.sh
> @@ -12,8 +12,8 @@ test_expect_success 'preparing origin repository' '
>  	: >file && git add . && git commit -m1 &&
>  	git clone --bare . a.git &&
>  	git clone --bare . x &&
> -	test "$(GIT_CONFIG=a.git/config git config --bool core.bare)" = true &&
> -	test "$(GIT_CONFIG=x/config git config --bool core.bare)" = true &&
> +	test "$(cd a.git && git config --bool core.bare)" = true &&
> +	test "$(cd x && git config --bool core.bare)" = true &&
>  	git bundle create b1.bundle --all &&
>  	git bundle create b2.bundle master &&
>  	mkdir dir &&
> @@ -24,7 +24,7 @@ test_expect_success 'preparing origin repository' '
>  test_expect_success 'local clone without .git suffix' '
>  	git clone -l -s a b &&
>  	(cd b &&
> -	test "$(GIT_CONFIG=.git/config git config --bool core.bare)" = false &&
> +	test "$(git config --bool core.bare)" = false &&
>  	git fetch)
>  '
