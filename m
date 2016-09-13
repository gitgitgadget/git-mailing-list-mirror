Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0D2E207DF
	for <e@80x24.org>; Tue, 13 Sep 2016 00:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752190AbcIMA0E (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 20:26:04 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61053 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752152AbcIMA0C (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 20:26:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 905F13E280;
        Mon, 12 Sep 2016 20:26:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=B0ciCQ5NXCtRU5u/cL2zt0/u9Ds=; b=YXwr5T
        BMCBwiUzzaUSE3kfj9Qe519MAT/mnQjr3xKB3Ev/zYbqMBy12yaz3WgFEtgjqFyq
        eaQjOMta5ZwafVx0Al0WOq6f7j6pkWLNkkS7pkKE/9WYhDtJxMalFZUlb9q00NNb
        f/jPhgJk7z1mDbRSNCw9OMjqjrtc4d9SL7pzc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pVJW2en67cWwFtiSrLBjU4QmEgD8J0YN
        A1K0/FQbkQrAQc4eKeIj17UgNw8NciQirL8kesLllPihXO9gH/OaRA0NIA4Vk/MJ
        Li+KQDrtbKhFEod8A881/X0SA+g9I/l7cGzj+jKNuq8XMISYbc5I7uiB+/XtSYfK
        LHoIW/pWV8A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 415F53E27F;
        Mon, 12 Sep 2016 20:26:00 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B1B6E3E27E;
        Mon, 12 Sep 2016 20:25:59 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <stefanbeller@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 07/10] diff.c: convert fn_out_consume to use emit_line_*
References: <1473572530-25764-1-git-send-email-stefanbeller@gmail.com>
        <1473572530-25764-8-git-send-email-stefanbeller@gmail.com>
Date:   Mon, 12 Sep 2016 17:25:56 -0700
In-Reply-To: <1473572530-25764-8-git-send-email-stefanbeller@gmail.com>
        (Stefan Beller's message of "Sat, 10 Sep 2016 22:42:07 -0700")
Message-ID: <xmqqk2egwsq3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A5308186-7948-11E6-98DF-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <stefanbeller@gmail.com> writes:

> diff --git a/diff.c b/diff.c
> index 2aefd0f..7dcef73 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -493,6 +493,19 @@ static void emit_line(struct diff_options *o, const char *set, const char *reset
>  	emit_line_0(o, set, reset, line[0], line+1, len-1);
>  }
>  
> +static void emit_line_fmt(struct diff_options *o,
> +			  const char *set, const char *reset,
> +			  const char *fmt, ...)
> +{
> +	struct strbuf sb = STRBUF_INIT;
> +	va_list ap;
> +	va_start(ap, fmt);
> +	strbuf_vaddf(&sb, fmt, ap);
> +	va_end(ap);
> +
> +	emit_line(o, set, reset, sb.buf, sb.len);
> +}
> +
>  static int new_blank_line_at_eof(struct emit_callback *ecbdata, const char *line, int len)
>  {
>  	if (!((ecbdata->ws_rule & WS_BLANK_AT_EOF) &&
> @@ -1217,7 +1230,6 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
>  	const char *context = diff_get_color(ecbdata->color_diff, DIFF_CONTEXT);
>  	const char *reset = diff_get_color(ecbdata->color_diff, DIFF_RESET);
>  	struct diff_options *o = ecbdata->opt;
> -	const char *line_prefix = diff_line_prefix(o);
>  
>  	o->found_changes = 1;
>  
> @@ -1233,10 +1245,12 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
>  		name_a_tab = strchr(ecbdata->label_path[0], ' ') ? "\t" : "";
>  		name_b_tab = strchr(ecbdata->label_path[1], ' ') ? "\t" : "";
>  
> -		fprintf(o->file, "%s%s--- %s%s%s\n",
> -			line_prefix, meta, ecbdata->label_path[0], reset, name_a_tab);
> -		fprintf(o->file, "%s%s+++ %s%s%s\n",
> -			line_prefix, meta, ecbdata->label_path[1], reset, name_b_tab);
> +		emit_line_fmt(o, meta, reset, "--- %s%s\n",
> +			      ecbdata->label_path[0], name_a_tab);
> +
> +		emit_line_fmt(o, meta, reset, "+++ %s%s\n",
> +			      ecbdata->label_path[1], name_b_tab);

Hmph, the original showed the following for the name-a line:

	diff_line_prefix(o) META "--- " label_path RESET name_a_tab LF

The updated one calls emit_line_fmt() with o, meta, reset, fmt and
args, and then

 * strbuf_vaddf(&buf, "--- %s%s\n", label_path, name_a_tab) creates
   a string "--- " + label_path + LF

 * emit_line() is called on the whole thing with META and RESET

 * which is emit_line_0() that encloses the whole thing between META
   and RESET but knows the trailing LF should come after RESET.

So the coloring seems to be correct, but I am not sure where the
line-prefix went.



