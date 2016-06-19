Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 219C720189
	for <e@80x24.org>; Sun, 19 Jun 2016 01:43:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbcFSBnj (ORCPT <rfc822;e@80x24.org>);
	Sat, 18 Jun 2016 21:43:39 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62955 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751149AbcFSBni (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jun 2016 21:43:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D781824AD7;
	Sat, 18 Jun 2016 21:43:36 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rTCZNr15XF/wohqBe0vK3SlADX4=; b=ZU10wp
	d904ymHa9kWFBSxxcMx/B7CCQNAJLFH4vzJaCNKp5549vE+r4pyBXQp03rkc22jL
	qpySoJ23hpe5thHMPUEzlNX7xuLqyVtrw06QBV+jjvLzdK3AQ7FPQgJpXMG51GxW
	eVQidVnfwxxjJhRuC04GlJ9Przf9jbJXH1Gyc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=H1Km4Zl7QxQtM55UBcSNBJ8mfP7BcfGa
	At2xaf0geErrWsY8795XcQUNAGtsCKC8Q3mOdAiryuB5jZvF2VH/LJWCdjXszqrl
	dWdtE5HfZRNIk68Zv6JccAbUA3Bx6NI7TsVvyqOmGtHtgHeIyDIBsH1tKAe4MOmg
	5oSGnzBeysY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CEC7A24AD6;
	Sat, 18 Jun 2016 21:43:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5917224AD4;
	Sat, 18 Jun 2016 21:43:36 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	LE Manh Cuong <cuong.manhle.vn@gmail.com>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH] git-sh-setup.sh: fix missing double quotes variables
References: <20160618193710.32265-1-cuong.manhle.vn@gmail.com>
Date:	Sat, 18 Jun 2016 18:43:34 -0700
In-Reply-To: <20160618193710.32265-1-cuong.manhle.vn@gmail.com> (LE Manh
	Cuong's message of "Sun, 19 Jun 2016 02:37:10 +0700")
Message-ID: <xmqqshwax8ah.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3D3C0504-35BF-11E6-BA21-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

LE Manh Cuong <cuong.manhle.vn@gmail.com> writes:

> Leaving shell variables un-quotes can lead to security vulnerabilities. In:
>
>     : ${x=.}
>
> `$x` is always expanded, cause `glob+split` on its result. There're some
> globs is too expensive to expand, like:
>
>     x='/*/*/*/*/../../../../*/*/*/*/../../../../*/*/*/*' sh -c ':
>     ${x=.}'
>
> Run it and our machine will hang/crash (especially in Linux).
>
> `LESS`, `LV` and `GIT_OBJECT_DIRECTORY` variables in `git-sh-setup` are
> vulnerable with this case.
>
> Fix this vulnerability  by quoting those variables.
>
> Signed-off-by: LE Manh Cuong <cuong.manhle.vn@gmail.com>
> ---

That is "interesting".

Given that LESS, LV and GIT_OBJECT_DIRECTORY are expected to be free
of any "expensive to expand" strings, I am not sure if this actually
matters, though.  And more importantly, these are what the end users
are expected to set to whatever sensible values for them.

You would not be lying if you said that Git lets people who want to
do strange things shoot their feet off; I do not think that hardly
deserves to be called "vulnerability", though.

Having said all that, I do not mind preventing people from shooting
their foot off, and the change in this patch certainly would not
hurt.

Thanks.

>  git-sh-setup.sh | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/git-sh-setup.sh b/git-sh-setup.sh
> index c48139a..85db5f1 100644
> --- a/git-sh-setup.sh
> +++ b/git-sh-setup.sh
> @@ -160,8 +160,8 @@ git_pager() {
>  	else
>  		GIT_PAGER=cat
>  	fi
> -	: ${LESS=-FRX}
> -	: ${LV=-c}
> +	: "${LESS=-FRX}"
> +	: "${LV=-c}"
>  	export LESS LV
>  
>  	eval "$GIT_PAGER" '"$@"'
> @@ -344,7 +344,7 @@ git_dir_init () {
>  		echo >&2 "Unable to determine absolute path of git directory"
>  		exit 1
>  	}
> -	: ${GIT_OBJECT_DIRECTORY="$(git rev-parse --git-path objects)"}
> +	: "${GIT_OBJECT_DIRECTORY="$(git rev-parse --git-path objects)"}"
>  }
>  
>  if test -z "$NONGIT_OK"
