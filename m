Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED69C33CAF
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 18:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFC4C2192A
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 18:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jDwVYUqU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394631AbgAPSBy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:01:54 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52659 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393606AbgAPSBx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 13:01:53 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BAB1194637;
        Thu, 16 Jan 2020 13:01:49 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JlTlqO/Uzd//y1FW5TqVZwGQDS4=; b=jDwVYU
        qUGhxDnMLGAr5g+X4iSpsJzRb5hupLqznX/8IrBWMuJsa9vykdg/m2MQwhCXyx6U
        y4Tx33qm/ePQcaf+KuD7sGdYu12ywg1LD+6kgyevyiOj5+ngbXgWkNM/6EOZmqE9
        JIa9MF2CjqfoM1ZGfLpYL+tDo8Hyyo+6xRym0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ofjMRp3s5w855qAoCMkXRlpy1/8VXY28
        cjtmNR+FzEIbit1oAzD7kTm3GiXUrOgpzOupWYXEaPhyG0hHvqR6/1Ez1mny11QU
        Q2wny9T5lFS2AH7i+mAaLJdm57sU9wvBIFxstSIxZ57tnesI4XmQA2TYl3UukU0R
        fDMtfuIISEc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B342794636;
        Thu, 16 Jan 2020 13:01:49 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D046A94635;
        Thu, 16 Jan 2020 13:01:46 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eyal Soha <shawarmakarma@gmail.com>
Cc:     peff@peff.net, git@vger.kernel.org
Subject: Re: [PATCH 1/3] color.c: Refactor color_output to use enums
References: <20200110111516.GA474613@coredump.intra.peff.net>
        <20200110150547.221314-1-shawarmakarma@gmail.com>
Date:   Thu, 16 Jan 2020 10:01:44 -0800
In-Reply-To: <20200110150547.221314-1-shawarmakarma@gmail.com> (Eyal Soha's
        message of "Fri, 10 Jan 2020 10:05:45 -0500")
Message-ID: <xmqq5zhbi8l3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 42FC0B16-388A-11EA-AA1C-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eyal Soha <shawarmakarma@gmail.com> writes:

This space looks a bit underexplained.  I cannot tell, for example,
if the changes to out->value this patch makes (i.e. in COLOR_ANSI
mode, we used to use 0-7, but now it is offset to 30-37) is
intended.

It is especially confusing that parse_color() stuffs 30-37 in
the .value field for COLOR_ANSI mode, and then color_output() takes
a struct color and then uses xsnprintf() on .value PLUS offset.  The
offset used to be "type" that was either "3" or "4", and now it is
either 0 or 10 (= COLOR_BACKGROUND_OFFSET), so it cancels out, but
when this step is viewed alone, it is not clear why the updated code
does not use 0-7 in .value and 30 or 40 in the offset, which is more
in line with how the original code worked.

In any case, "COLOR_BACKGROUND_OFFSET = 10" needs to be commented
much better---something like "In 'struct color', we chose to
represent the color value in the .value field with the ANSI
foreground color number between 30 and 37, and adding this offset
value makes the color to their background counterparts".

Not that I agree with the (untold) reasoning why we chose to use
30-37 instead of 0-7, though.  If this were up to me, I would have
rather defined COLOR_BACKGROUND_ANSI = 40, kept .value to 0-7 and
passed COLOR_{FORE,BACK}GROUPD_ANSI to callers of color_output().

Since I haven't seen 2/3 and 3/3, perhaps there is a good reason why
this step was done this way instead, though, I guess.

> +enum {
> +	COLOR_BACKGROUND_OFFSET = 10,
> +	COLOR_FOREGROUND_ANSI = 30,
> +	COLOR_FOREGROUND_RGB = 38,
> +	COLOR_FOREGROUND_256 = 38,
> +};
> +
>  /* Ignore the RESET at the end when giving the size */
>  const int column_colors_ansi_max = ARRAY_SIZE(column_colors_ansi) - 1;
>  
> @@ -92,7 +99,7 @@ static int parse_color(struct color *out, const char *name, int len)
>  	for (i = 0; i < ARRAY_SIZE(color_names); i++) {
>  		if (match_word(name, len, color_names[i])) {
>  			out->type = COLOR_ANSI;
> -			out->value = i;
> +			out->value = i + COLOR_FOREGROUND_ANSI;
>  			return 0;
>  		}
>  	}
> @@ -112,7 +119,7 @@ static int parse_color(struct color *out, const char *name, int len)
>  		/* Rewrite low numbers as more-portable standard colors. */

This comment, being in the context, obviously is not a new problem
introduced by this patch, but my reading hiccupped on the verb
"rewrite"---what are we rewriting?---and had to read the logic twice
to realize that this comment is about choosing COLOR_ANSI over
COLOR_256 (i.e. we assume ANSI is more prevalent than 256, so any
color expressible in both is better shown using ANSI).  Perhaps

		/* Express low numbers in basic ANSI rather than 256 */

or something may have been easier to understand at least to me.

Thanks.

>  		} else if (val < 8) {
>  			out->type = COLOR_ANSI;
> -			out->value = val;
> +			out->value = val + COLOR_FOREGROUND_ANSI;
>  			return 0;
>  		} else if (val < 256) {
>  			out->type = COLOR_256;
> @@ -166,23 +173,22 @@ int color_parse(const char *value, char *dst)
>   * already have the ANSI escape code in it. "out" should have enough
>   * space in it to fit any color.
>   */
> -static char *color_output(char *out, int len, const struct color *c, char type)
> +static char *color_output(char *out, int len, const struct color *c, int offset)
>  {
>  	switch (c->type) {
>  	case COLOR_UNSPECIFIED:
>  	case COLOR_NORMAL:
>  		break;
>  	case COLOR_ANSI:
> -		if (len < 2)
> -			BUG("color parsing ran out of space");
> -		*out++ = type;
> -		*out++ = '0' + c->value;
> +		out += xsnprintf(out, len, "%d", c->value + offset);
>  		break;
>  	case COLOR_256:
> -		out += xsnprintf(out, len, "%c8;5;%d", type, c->value);
> +		out += xsnprintf(out, len, "%d;5;%d", COLOR_FOREGROUND_256 + offset,
> +				 c->value);
>  		break;
>  	case COLOR_RGB:
> -		out += xsnprintf(out, len, "%c8;2;%d;%d;%d", type,
> +		out += xsnprintf(out, len, "%d;2;%d;%d;%d",
> +				 COLOR_FOREGROUND_RGB + offset,
>  				 c->red, c->green, c->blue);
>  		break;
>  	}
> @@ -280,13 +286,13 @@ int color_parse_mem(const char *value, int value_len, char *dst)
>  			if (sep++)
>  				OUT(';');
>  			/* foreground colors are all in the 3x range */
> -			dst = color_output(dst, end - dst, &fg, '3');
> +			dst = color_output(dst, end - dst, &fg, 0);
>  		}
>  		if (!color_empty(&bg)) {
>  			if (sep++)
>  				OUT(';');
>  			/* background colors are all in the 4x range */
> -			dst = color_output(dst, end - dst, &bg, '4');
> +			dst = color_output(dst, end - dst, &bg, COLOR_BACKGROUND_OFFSET);
>  		}
>  		OUT('m');
>  	}
