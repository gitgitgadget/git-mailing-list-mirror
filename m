Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CBF21FF76
	for <e@80x24.org>; Tue, 20 Dec 2016 17:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758463AbcLTR0I (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Dec 2016 12:26:08 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59659 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1758412AbcLTR0G (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2016 12:26:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7655357B82;
        Tue, 20 Dec 2016 12:26:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=/CV7k1XSPEYY
        yZKnQ5sT+x2w+rk=; b=g8LW6ibPPpdzBqbv8+YCYMmrAMhUhHhOnwjKFqG8y+bs
        sTHUAeMRe4e9zdT3w9FA2TqIcsyS7nEubwVBXi4eiGjnw9zW9hZtgMdHzUwiHbid
        lcbggy8m94NVh0cbr74GrKysJwoyn0bopENVR7Rk2osxFiYLHGVKpVh8A1aK+xw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=PtEiLe
        ha5ej1QRYkbb7RrrYQlwhbSRCYLiOXSJ9iP0nS00m+r6QoT7ytot72eF1uHDDfBo
        xx+emHDOyq0PCHEOw8vxs4ZDzIgQFo3UB3QP5A25d890HuyolRz6sW2Oyv9/LMUN
        2DJkGRnyyoczIR8anhYCATVVwNckKcFfWToZM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 63BB957B81;
        Tue, 20 Dec 2016 12:26:05 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C208757B80;
        Tue, 20 Dec 2016 12:26:04 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] log: support 256 colors with --graph=256colors
References: <20161220123929.15329-1-pclouds@gmail.com>
Date:   Tue, 20 Dec 2016 09:26:03 -0800
In-Reply-To: <20161220123929.15329-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Tue, 20 Dec 2016 19:39:29 +0700")
Message-ID: <xmqqh95yldg4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 62BC6930-C6D9-11E6-A87D-E98412518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> diff --git a/graph.c b/graph.c
> index d4e8519..75375a1 100644
> --- a/graph.c
> +++ b/graph.c
> @@ -78,6 +78,7 @@ static void graph_show_line_prefix(const struct diff_=
options *diffopt)
> =20
>  static const char **column_colors;
>  static unsigned short column_colors_max;
> +static int column_colors_step;
> =20
>  void graph_set_column_colors(const char **colors, unsigned short color=
s_max)
>  {
> @@ -234,10 +235,24 @@ void graph_setup_line_prefix(struct diff_options =
*diffopt)
>  }
> =20
> =20
> -struct git_graph *graph_init(struct rev_info *opt)
> +struct git_graph *graph_init_with_options(struct rev_info *opt, const =
char *arg)
>  {
>  	struct git_graph *graph =3D xmalloc(sizeof(struct git_graph));
> =20
> +	if (arg && !strcmp(arg, "256colors")) {
> +		int i, start =3D 17, stop =3D 232;
> +		column_colors_max =3D stop - start;
> +		column_colors =3D
> +			xmalloc((column_colors_max + 1) * sizeof(*column_colors));
> +		for (i =3D start; i < stop; i++) {
> +			struct strbuf sb =3D STRBUF_INIT;
> +			strbuf_addf(&sb, "\033[38;5;%dm", i);
> +			column_colors[i - start] =3D strbuf_detach(&sb, NULL);
> +		}
> +		column_colors[column_colors_max] =3D xstrdup(GIT_COLOR_RESET);
> +		/* ignore the closet 16 colors on either side for the next line */
> +		column_colors_step =3D 16;
> +	}

So you pre-fill a table of colors with 232-17=3D215 slots.  Is the
idea that it is a co-prime with column_colors_step which is set to
16 so that going over the table with wraparound will cover all its
elements?

> @@ -382,6 +397,20 @@ static unsigned short graph_get_current_column_col=
or(const struct git_graph *gra
>   */
>  static void graph_increment_column_color(struct git_graph *graph)
>  {
> +	if (column_colors_step) {
> +		static int random_initialized;
> +		int v;
> +
> +		if (!random_initialized) {
> +			srand((unsigned int)getpid());
> +			random_initialized =3D 1;
> +		}
> +		v =3D rand() % (column_colors_max - column_colors_step * 2);
> +		graph->default_column_color +=3D column_colors_step + v;
> +		graph->default_column_color %=3D column_colors_max;
> +		return;
> +	}
> +
>  	graph->default_column_color =3D (graph->default_column_color + 1) %
>  		column_colors_max;
>  }

This is too ugly to live as-is for two reasons.

 - Do you really need rand()?  Doesn't this frustrate somebody who
   runs the same "git log" in two terminals in order to view an
   overly tall graph, expecting both commands that were started with
   the same set of arguments to paint the same line in the same
   color? =20

 - Even if you needed rand(), you should be able to factor out
   computation of V so that the function does not need an early
   return that hints totally different processing for two codepaths.

        static void graph_increment_column_color(struct git_graph *g)
        {
                int next;

                if (! 256-color in use) {
                        next =3D 1;
                } else {
                        do whatever to compute your v;
                        next =3D v + column_colors_step;
                }
                g->default_column_color =3D
                (g->default_column_color + v) / column_colors_max;
        }

   Or something like that, perhaps?
