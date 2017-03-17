Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A88A20951
	for <e@80x24.org>; Fri, 17 Mar 2017 17:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751182AbdCQRx3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 13:53:29 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57261 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751236AbdCQRx0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 13:53:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0C32D758B4;
        Fri, 17 Mar 2017 13:53:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5yhSZvoPQGjh+n19LPWz/NJtV6c=; b=yBn2OF
        6T4PtVsGpNTPxemhNxx74sXzmu8Y+9o1Hejl7XNdzo/ds0xjTP6e6LJrg1rbGveB
        ReNy00jaFjnGdbbzzRGsZVbpwG8jvGeKOeGtc8dNK8zJnrksOPr7KxCp38UoviUw
        PqChPr3NhXaLsTV1sw8UoTEXDJA9+7mMrPXEQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Hsjd2pFMjnCvAsKtWApj9sP8rqJZ6P36
        2AQgWfEWulpvNGDp6v1z2ppQRek7jJB/npbUs2Zs7WBVVJ8TlhtjvgHhQYJ/vykR
        Qj5NAQEOdL1WdJQdLrYZXToRMFsNAQEeswMCWmsK5zfmcxJKFe46Nr8rEDtp1o/5
        TQHhVNa6i3w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 03638758B3;
        Fri, 17 Mar 2017 13:53:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6F449758B2;
        Fri, 17 Mar 2017 13:53:19 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rahul Bedarkar <rahul.bedarkar@imgtec.com>
Cc:     <git@vger.kernel.org>, Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH] grep: fix build with no thread support
References: <1489729656-17709-1-git-send-email-rahul.bedarkar@imgtec.com>
Date:   Fri, 17 Mar 2017 10:53:18 -0700
In-Reply-To: <1489729656-17709-1-git-send-email-rahul.bedarkar@imgtec.com>
        (Rahul Bedarkar's message of "Fri, 17 Mar 2017 11:17:36 +0530")
Message-ID: <xmqqy3w37ptd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9B01D9F6-0B3A-11E7-9ECA-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rahul Bedarkar <rahul.bedarkar@imgtec.com> writes:

> diff --git a/builtin/grep.c b/builtin/grep.c
> index 2c727ef..4373d79 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -183,11 +183,13 @@ static void *run(void *arg)
>  		if (!w)
>  			break;
>  
> -		opt->output_priv = w;
> -		if (w->source.type == GREP_SOURCE_SUBMODULE)
> +		if (w->source.type == GREP_SOURCE_SUBMODULE) {
> +			opt->output_priv = &w->out;
>  			hit |= grep_submodule_launch(opt, &w->source);
> -		else
> +		} else {
> +			opt->output_priv = w;
>  			hit |= grep_source(opt, &w->source);
> +		}
>  		grep_source_clear_data(&w->source);
>  		work_done(w);
>  	}

This is not a part of the "fix" but merely a code clean-up, right?
Just double-checking.

> @@ -538,7 +540,7 @@ static int grep_submodule_launch(struct grep_opt *opt,
>  	int status, i;
>  	const char *end_of_base;
>  	const char *name;
> -	struct work_item *w = opt->output_priv;
> +	struct strbuf *w = opt->output_priv;
>  
>  	end_of_base = strchr(gs->name, ':');
>  	if (gs->identifier && end_of_base)

OK, so the new code points output_priv at a strbuf; work_item
contains an "out" strbuf, and that was why the original code was
passing one, but this codepath does not need a full work_item to
work with.  Is that what is going on?

> @@ -593,10 +595,10 @@ static int grep_submodule_launch(struct grep_opt *opt,
>  	 * child process.  A '0' indicates a hit, a '1' indicates no hit and
>  	 * anything else is an error.
>  	 */
> -	status = capture_command(&cp, &w->out, 0);
> +	status = capture_command(&cp, w, 0);

And this is consistent with the above change.

>  	if (status && (status != 1)) {
>  		/* flush the buffer */
> -		write_or_die(1, w->out.buf, w->out.len);
> +		write_or_die(1, w->buf, w->len);

So is this.

>  		die("process for submodule '%s' failed with exit code: %d",
>  		    gs->name, status);
>  	}
> @@ -641,19 +643,19 @@ static int grep_submodule(struct grep_opt *opt, const unsigned char *sha1,
>  	} else
>  #endif
>  	{
> -		struct work_item w;
> +		struct grep_source gs;
>  		int hit;
> +		struct strbuf outbuf = STRBUF_INIT;
>  
> -		grep_source_init(&w.source, GREP_SOURCE_SUBMODULE,
> +		grep_source_init(&gs, GREP_SOURCE_SUBMODULE,
>  				 filename, path, sha1);

Likewise for w.source that happened to have grep_source, but passing
a bare grep_source is sufficient for the purpose of this codepath,
without giving it to w.source?  

I didn't look at code that this patch does not touch, but if
anything still looks at w.out and w.source and expect these to
contain the string accumulated in the strbuf and the grep source the
work item is working on, they will get broken by this change, no?

The first hunk that had a pure clean-up shows that w->source being
the correct grep source seems to matter.

> -		strbuf_init(&w.out, 0);
> -		opt->output_priv = &w;
> -		hit = grep_submodule_launch(opt, &w.source);
> +		opt->output_priv = &outbuf;
> +		hit = grep_submodule_launch(opt, &gs);
>  
> -		write_or_die(1, w.out.buf, w.out.len);
> +		write_or_die(1, outbuf.buf, outbuf.len);
>  
> -		grep_source_clear(&w.source);
> -		strbuf_release(&w.out);
> +		grep_source_clear(&gs);
> +		strbuf_release(&outbuf);
>  		return hit;
>  	}
>  }
