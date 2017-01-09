Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D65D41FEB3
	for <e@80x24.org>; Mon,  9 Jan 2017 17:29:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1035172AbdAIR3m (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 12:29:42 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58704 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932489AbdAIR3l (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 12:29:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7CE595E397;
        Mon,  9 Jan 2017 12:29:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=tVWWhIliXKmp
        MfGTuDSTQdjHiTE=; b=UU6a6KI84KkBf6PMqgvviGwlh/wuzJSOQqkBhqk9rPgn
        4lYCGgN7CpwouUK2V+zCalOET/EsFRykRWl4vM5diJ0HK5mLQBbTdKJRdn7KQ03B
        DiA3HFsIfhjT9B1LjeaPWuK5cs3EwHmd3W8xpgqrXPTJQ5MkXUSaRncOSleUXuI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=pCZKGl
        UuVGRIwHeu8pWbysYnXmgVD1ppI00E7MLAEqNwctm6RKXd4TP/3DrjajyPK7Jim5
        52Te74+ZpiUs/VsQQfNrUfxCzxAfsmJT9N4FkjcWak2mb/22CGHC9Krqgjpb2kEn
        V5p84gSHOcYXBbiQEDHptrCUML4tAVPpi6SPY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 731875E396;
        Mon,  9 Jan 2017 12:29:40 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 963785E390;
        Mon,  9 Jan 2017 12:29:39 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v4] log --graph: customize the graph lines with config log.graphColors
References: <20170108101333.26221-1-pclouds@gmail.com>
        <20170109103258.25341-1-pclouds@gmail.com>
Date:   Mon, 09 Jan 2017 09:29:38 -0800
In-Reply-To: <20170109103258.25341-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Mon, 9 Jan 2017 17:32:58 +0700")
Message-ID: <xmqqh958uoot.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 330ADD4E-D691-11E6-BB32-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> +	end =3D string + strlen(string);
> +	while (start < end) {
> +		const char *comma =3D strchrnul(start, ',');
> +		char color[COLOR_MAXLEN];
> +
> +		while (start < comma && isspace(*start))
> +			start++;
> +		if (start =3D=3D comma) {
> +			start =3D comma + 1;
> +			continue;
> +		}
> +
> +		if (!color_parse_mem(start, comma - start, color))

So you skip the leading blanks but let color_parse_mem() trim the
trailing blanks?  It would work once the control reaches the loop,
but wouldn't that miss

	git -c log.graphColors=3D' reset , blue, red' log --graph=20

as "reset" is not understood by parse_color() and is understood by
color_parse_mem() only when the length is given correctly?

I am undecided, but leaning towards declaring that it is a bug in
color_parse_mem() not in this caller.

> +			argv_array_push(&colors, color);
> +		else
> +			warning(_("ignore invalid color '%.*s' in log.graphColors"),
> +				(int)(comma - start), start);
> +		start =3D comma + 1;
> +	}
> +	free(string);
> +	argv_array_push(&colors, GIT_COLOR_RESET);
> +	/* graph_set_column_colors takes a max-index, not a count */
> +	graph_set_column_colors(colors.argv, colors.argc - 1);
> +}
> +
>  void graph_set_column_colors(const char **colors, unsigned short color=
s_max)
>  {
>  	column_colors =3D colors;
> @@ -208,8 +248,7 @@ struct git_graph *graph_init(struct rev_info *opt)
>  	struct git_graph *graph =3D xmalloc(sizeof(struct git_graph));
> =20
>  	if (!column_colors)
> -		graph_set_column_colors(column_colors_ansi,
> -					column_colors_ansi_max);
> +		read_graph_colors_config();

Now that the helper is renamed to be about "reading the
configuration to figure out the graph colors", the division of labor
between the caller and the callee we see here is suboptimal for
readability, I would think.  =20

We would want to see the caller to either be

	if (!column_colors) {
		if (read_graph_colors_config())
			; /* ok */
		else                       =20
			graph_set_column_colors(ansi, ansi_max);
	}

or better yet, something like:

	if (!column_colors) {
		const char **colors =3D column_colors_ansi;
		int colors_max =3D column_colors_ansi_max;

		read_graph_colors_config(&colors, &colors_max);
		graph_set_collumn_colors(colors, colors_max);
	}

The last one would make it clear that by default we use ansi but
override that default by calling that function whose purpose is to
read the values that override the default from the configuration.

I haven't thought things thru regarding memory leakages etc., so
there may be valid reasons why the last one is infeasible.

