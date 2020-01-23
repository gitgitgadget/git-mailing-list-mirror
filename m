Return-Path: <SRS0=ZAU+=3M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699E6C33CAA
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 22:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 013E5207FF
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 22:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rotBpvAd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729449AbgAWWu7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jan 2020 17:50:59 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59822 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729259AbgAWWu7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jan 2020 17:50:59 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1BF5BB58A6;
        Thu, 23 Jan 2020 17:50:57 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7sqJQ4pGdmgMNzPCHmTVg0KIc8g=; b=rotBpv
        AdUEcC7irzA+o2DGnY5P5jO4OfjCQMfTdZ+l7R4J0ESJtWSy4GkIKqs4in06s3gM
        9Ecbh9Vwgy1EBpCeJFbcp+70yTh/DDORpUI+MPCU06koWzIiXFLrqgLnPQXuaei4
        pakyh+6UtO07TTsOghrKEN8WercW+EOxCfdss=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PkuoIld2aq0TWz4JXPdt+8U6I5WUDjlg
        n1IjIEwHtFQi1d2+o1xH80MY4ldTKwqkhJ56eR5gThDlqYJfapsfiZCmYCc+fkCd
        ijK/ehlBAHRt3gDfCT6kKGv+oX/K40Lt3L7zluniXi5x9jQ1AActvZlJokwGTk2M
        P/xJiyExyOI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 130EFB58A4;
        Thu, 23 Jan 2020 17:50:57 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3CEBBB58A2;
        Thu, 23 Jan 2020 17:50:54 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eyal Soha <shawarmakarma@gmail.com>
Cc:     peff@peff.net, git@vger.kernel.org
Subject: Re: [PATCH 1/3] color.c: refactor color_output arguments
References: <CANsz78+-Z89d8E=n3cjfnXaGVFXpchdG7EjtdQuFjzo-=2aPeA@mail.gmail.com>
        <20200121165623.151880-1-shawarmakarma@gmail.com>
Date:   Thu, 23 Jan 2020 14:50:52 -0800
In-Reply-To: <20200121165623.151880-1-shawarmakarma@gmail.com> (Eyal Soha's
        message of "Tue, 21 Jan 2020 08:56:21 -0800")
Message-ID: <xmqqsgk53hyr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CFBAF94C-3E32-11EA-AE83-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eyal Soha <shawarmakarma@gmail.com> writes:

> @@ -166,23 +173,26 @@ int color_parse(const char *value, char *dst)
>   * already have the ANSI escape code in it. "out" should have enough
>   * space in it to fit any color.
>   */
> -static char *color_output(char *out, int len, const struct color *c, char type)
> +static char *color_output(char *out, int len, const struct color *c, int background)
>  {
> +	int offset = 0;

Have a blank line here, between the end of decl/defn and the first stmt.

> +	if (background) {
> +		offset = COLOR_BACKGROUND_OFFSET;
> +	}

No {} around a single statement block.

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

Break the line after the format string instead, i.e.

> +		out += xsnprintf(out, len, "%d;5;%d",
> +				 COLOR_FOREGROUND_256 + offset, c->value);

that would make it easier to see which parameter corresponds to
which placeholder and also saves line width at the same time.

>  		break;
>  	case COLOR_RGB:
> -		out += xsnprintf(out, len, "%c8;2;%d;%d;%d", type,
> +		out += xsnprintf(out, len, "%d;2;%d;%d;%d",
> +				 COLOR_FOREGROUND_RGB + offset,
>  				 c->red, c->green, c->blue);

... like you did here.
