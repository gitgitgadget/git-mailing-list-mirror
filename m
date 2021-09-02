Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A24FC433EF
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 22:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59E7061041
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 22:28:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347634AbhIBW3o (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 18:29:44 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56874 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239498AbhIBW3n (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 18:29:43 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6EB2915340B;
        Thu,  2 Sep 2021 18:28:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oJVXIQSUExEN69FZdWItNE+K5D/LRes8H4bXP4
        iMCu4=; b=f7X35s9vslkzxToQZiFmDTWxk1a3U9qwItqI5vFm7d1AdPUtaFdVpP
        or1I4lnGKVxV04U97whd6s8ubUJ8r1vJwDW9U4GBrjbgOYmwAQJ2d0Bj9cVNosOI
        T+xNm+Yjsm/iQNu286GN3TrCDPTaM5pK+59l8UaVzBTUY5kMhZdwk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 56AB715340A;
        Thu,  2 Sep 2021 18:28:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8E8A2153408;
        Thu,  2 Sep 2021 18:28:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Miriam Rubio <mirucam@gmail.com>
Cc:     git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>
Subject: Re: [PATCH v6 4/6] bisect--helper: reimplement
 `bisect_visualize()`shell function in C
References: <20210902090421.93113-1-mirucam@gmail.com>
        <20210902090421.93113-5-mirucam@gmail.com>
Date:   Thu, 02 Sep 2021 15:28:39 -0700
In-Reply-To: <20210902090421.93113-5-mirucam@gmail.com> (Miriam Rubio's
        message of "Thu, 2 Sep 2021 11:04:19 +0200")
Message-ID: <xmqqfsumipd4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 204B51A2-0C3D-11EC-855E-FA11AF6C5138-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Miriam Rubio <mirucam@gmail.com> writes:

> From: Pranit Bauva <pranit.bauva@gmail.com>

Need a SP before "shell" on the title line.

> Reimplement the `bisect_visualize()` shell function
> in C and also add `--bisect-visualize` subcommand to
> `git bisect--helper` to call it from git-bisect.sh.

Nice.

> +static int bisect_visualize(struct bisect_terms *terms, const char **argv, int argc)
> +{
> +	struct strvec args = STRVEC_INIT;
> +	int flags = RUN_COMMAND_NO_STDIN, res = 0;
> +	struct strbuf sb = STRBUF_INIT;
> +
> +	if (bisect_next_check(terms, NULL) != 0)
> +		return BISECT_FAILED;
> +
> +	if (!argc) {
> +		if ((getenv("DISPLAY") || getenv("SESSIONNAME") || getenv("MSYSTEM") ||
> +		     getenv("SECURITYSESSIONID")) && exists_in_PATH("gitk"))
> +			strvec_push(&args, "gitk");
> +		else {
> +			strvec_push(&args, "log");
> +			flags |= RUN_GIT_CMD;
> +		}

Let's have {} on the if() side, even though it only has one
statement and does not require one, because the else side needs one.

> +	} else {
> +		if (argv[0][0] == '-') {
> +			strvec_push(&args, "log");
> +			flags |= RUN_GIT_CMD;

OK, any -option makes it "git log -option ..." invocation.

> +		} else if (strcmp(argv[0], "tig") && !starts_with(argv[0], "git"))
> +			flags |= RUN_GIT_CMD;

OK, when the first token is "tig", or it begins with "git", the
scripted version just leaves the command line intact.  Everything
else is taken as a subcommand to git.  And this conditional is a
faithful translation of that logic.

> +		strvec_pushv(&args, argv);
> +	}
> +
> +	strvec_pushl(&args, "--bisect", "--", NULL);
> +
> +	strbuf_read_file(&sb, git_path_bisect_names(), 0);
> +	sq_dequote_to_strvec(sb.buf, &args);
> +	strbuf_release(&sb);
> +
> +	res = run_command_v_opt(args.v, flags);
> +	strvec_clear(&args);
> +	return res;

OK.

The code is quite easy to follow, thanks to many helpers that have
been invented for this exact purpose, like sq_dequote_to_strvec().

> diff --git a/git-bisect.sh b/git-bisect.sh
> index 6a7afaea8d..95f7f3fb8c 100755
> --- a/git-bisect.sh
> +++ b/git-bisect.sh
> @@ -39,29 +39,6 @@ _x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
>  TERM_BAD=bad
>  TERM_GOOD=good
>  
> -bisect_visualize() {
> ...
> -}
> -
>  bisect_run () {
>  	git bisect--helper --bisect-next-check $TERM_GOOD $TERM_BAD fail || exit
>  
> @@ -152,7 +129,7 @@ case "$#" in
>  		# Not sure we want "next" at the UI level anymore.
>  		git bisect--helper --bisect-next "$@" || exit ;;
>  	visualize|view)
> -		bisect_visualize "$@" ;;
> +		git bisect--helper --bisect-visualize "$@" || exit;;

Nice.

Thanks.
