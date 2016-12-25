Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6CC21FCC7
	for <e@80x24.org>; Sun, 25 Dec 2016 23:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753170AbcLYXCJ (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Dec 2016 18:02:09 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51587 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751214AbcLYXCI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Dec 2016 18:02:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 139735A90E;
        Sun, 25 Dec 2016 18:02:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Xt5C1BPf7lLN
        BsAIJSMotp/Qqaw=; b=RkDsnZi9DeRYndmSDLdP49cKu2A0mLohaDGDjxMxmOkf
        TgK0Tv0N5HjTjoQ247FtYAnh74qPMKLD+T9d5SMgw5G6/WksQn7ZJieeNLWHYVuI
        dXrCikRwHFfTVrYSZlq+EZUpAw6SleuIAIPETJ5nL7hHJhWm/bfpY+mhM5LzDHY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=i7DwjN
        pJNQzHvo6eNVAz708FsSfmdXMwAUT7jeax7wxLgt0kHTuYkd4W3koG34dElsK+9A
        LgxO1lw/9oRpLHuelor36S+oKAvPaCtNK1GQ1ZMG+ysMrqGkYxI0GmnL7geIzz+L
        mVuyOwh+p9aOpb0ltk0Ab4a5eGLX/ldU7lQfI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EF4D45A90D;
        Sun, 25 Dec 2016 18:02:06 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 688975A90A;
        Sun, 25 Dec 2016 18:02:06 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] log --graph: customize the graph lines with config log.graphColors
References: <20161220123929.15329-1-pclouds@gmail.com>
        <20161224113817.18407-1-pclouds@gmail.com>
Date:   Sun, 25 Dec 2016 15:02:04 -0800
In-Reply-To: <20161224113817.18407-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Sat, 24 Dec 2016 18:38:17 +0700")
Message-ID: <xmqqzijjd34j.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 28127A06-CAF6-11E6-A222-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

>  Sounds like the good first step should be something like this instead
>  of jumping straight to generating a new color palette automatically.

I like this not merely as a good first step but potentially a good
endgame.

> diff --git a/graph.c b/graph.c
> index d4e8519..9c58fd1 100644
> --- a/graph.c
> +++ b/graph.c
> @@ -79,6 +79,39 @@ static void graph_show_line_prefix(const struct diff=
_options *diffopt)
>  static const char **column_colors;
>  static unsigned short column_colors_max;
> =20
> +static void set_column_colors_by_config(void)
> +{
> +	static char **colors;
> +	static int colors_max, colors_alloc;

I doubt you want these to be static (and allow multiple instances of
the same configuration variable to accumulate).  As you defined the
value to be comma-separated colors, users would want the usual "last
one wins" rule to override previous settings, no?

> +	char *string =3D NULL;
> +	const char *end, *start;
> +
> +	if (git_config_get_string("log.graphcolors", &string)) {
> +		graph_set_column_colors(column_colors_ansi,
> +					column_colors_ansi_max);

On the other hand, if you do want cumulative semantics, then you'd
need to free the previous set you held in the statics here, I would
think.

> +		return;
> +	}
> +
> +	start =3D string;
> +	end =3D string + strlen(string);
> +	while (start < end) {
> +		const char *comma =3D strchrnul(start, ',');
> +		char color[COLOR_MAXLEN];
> +
> +		if (!color_parse_mem(start, comma - start, color)) {
> +			ALLOC_GROW(colors, colors_max + 1, colors_alloc);
> +			colors[colors_max++] =3D xstrdup(color);
> +		} else
> +			warning(_("ignore invalid color '%.*s'"),
> +				(int)(comma - start), start);

"ignore invalid color"?  Who is giving the command to ignore to whom?

> +		start =3D comma + 1;
> +	}
> +	free(string);
> +	ALLOC_GROW(colors, colors_max + 1, colors_alloc);
> +	colors[colors_max] =3D xstrdup(GIT_COLOR_RESET);
> +	graph_set_column_colors((const char **)colors, colors_max);
> +}
> +
>  void graph_set_column_colors(const char **colors, unsigned short color=
s_max)
>  {
>  	column_colors =3D colors;
> @@ -239,8 +272,7 @@ struct git_graph *graph_init(struct rev_info *opt)
>  	struct git_graph *graph =3D xmalloc(sizeof(struct git_graph));
> =20
>  	if (!column_colors)
> -		graph_set_column_colors(column_colors_ansi,
> -					column_colors_ansi_max);
> +		set_column_colors_by_config();

"by" in the function name somehow sounds funny, at least to me.
