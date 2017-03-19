Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52A2F20323
	for <e@80x24.org>; Sun, 19 Mar 2017 22:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752275AbdCSWPT (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Mar 2017 18:15:19 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51983 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752236AbdCSWPS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Mar 2017 18:15:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EC6E97223B;
        Sun, 19 Mar 2017 18:14:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gv/8lO4xAkHX/iRM2ElufXg/FUg=; b=D/yuj+
        U6o0FmoyJMxYrWi+iPxXoWMZWAcGotNCvqdxrtV9S1BjKEhFjghWF7pE2kIlCxyx
        WLXKYtYvEL8TM+P9XJ/3MX6/fjCazoJmzuOqutXtfypLaFGOjod7JCuffe0OyZ6A
        WYQvvxYjkhi70KezYyDilgXV3oRHOIL+6xlOw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=f3BefU3OWpm/O8k1u6yivV8ebvP8fHoN
        o4g6spmIC0gZWmuxG5TKjmVnH5lMmUYDWbHBSzobM/I+Zh2lFxVbGcu13dmVosGI
        MUnptfYhX3enap0iHCp4AvmSzmOTEpUDKayXwkeYZ0bVFovp2mlXlMOUfJWKblOv
        loVw97cJdMk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E4DA77223A;
        Sun, 19 Mar 2017 18:14:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 522DF72239;
        Sun, 19 Mar 2017 18:14:54 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Dennis Kaarsemaker <dennis@kaarsemaker.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 1/2] diff --no-index: optionally follow symlinks
References: <20170318210038.22638-1-dennis@kaarsemaker.net>
        <20170318210038.22638-2-dennis@kaarsemaker.net>
Date:   Sun, 19 Mar 2017 15:14:53 -0700
In-Reply-To: <20170318210038.22638-2-dennis@kaarsemaker.net> (Dennis
        Kaarsemaker's message of "Sat, 18 Mar 2017 22:00:37 +0100")
Message-ID: <xmqqk27kzzfm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7AB5F94E-0CF1-11E7-A060-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:

> diff --git a/diff.c b/diff.c
> index be11e4ef2b..2afecfb939 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -2815,7 +2815,7 @@ int diff_populate_filespec(struct diff_filespec *s, unsigned int flags)
>  		s->size = xsize_t(st.st_size);
>  		if (!s->size)
>  			goto empty;
> -		if (S_ISLNK(st.st_mode)) {
> +		if (S_ISLNK(s->mode)) {
>  			struct strbuf sb = STRBUF_INIT;
>  
>  			if (strbuf_readlink(&sb, s->path, s->size))
> @@ -2825,6 +2825,10 @@ int diff_populate_filespec(struct diff_filespec *s, unsigned int flags)
>  			s->should_free = 1;
>  			return 0;
>  		}
> +		if (S_ISLNK(st.st_mode)) {
> +			stat(s->path, &st);
> +			s->size = xsize_t(st.st_size);

Doesn't this affect --no-index mode?  We never need to do a wasteful
stat() after lstat() and we are penalizing the normal codepath with
this change, no?

> @@ -3884,7 +3888,11 @@ int diff_opt_parse(struct diff_options *options,
>  	else if (!strcmp(arg, "--no-follow")) {
>  		DIFF_OPT_CLR(options, FOLLOW_RENAMES);
>  		DIFF_OPT_CLR(options, DEFAULT_FOLLOW_RENAMES);
> -	} else if (!strcmp(arg, "--color"))
> +	} else if (!strcmp(arg, "--dereference"))
> +		DIFF_OPT_SET(options, DEREFERENCE);
> +	else if (!strcmp(arg, "--no-dereference"))
> +		DIFF_OPT_CLR(options, DEREFERENCE);
> +	else if (!strcmp(arg, "--color"))
>  		options->use_color = 1;

Also shouldn't be some code to detect --[no-]dereference options
given when --no-index is not in effect and error out?  As the patch
title says, this change should be a no-op for normal codepath and
only affect the no-index hack.
