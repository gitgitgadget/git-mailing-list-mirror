Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A159205C9
	for <e@80x24.org>; Mon,  9 Jan 2017 03:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755868AbdAIDFQ (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Jan 2017 22:05:16 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65181 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751936AbdAIDFP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jan 2017 22:05:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1F0555F656;
        Sun,  8 Jan 2017 22:05:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=A/JOXO2dVJQv
        O9/snaU3s/x4QNo=; b=pr0icqHProBY6f7E9vQMByjwj9NPCWef7sbruxgmn2wo
        LytglQZGvQ/VaDzpAQBzanOV8F/FUeSwvvr/OFjJQAgJIyNB2diJjZtB/9AoFp6/
        7ftFUedrRCwcwPDiLPUtmIvT1RP5q83zmIGJi+IQrH0LoYehmY/0QUdMkPIoTr8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=xPoYSB
        eS3bLrHV/pb47H8a+F4jgUKzSrbHXmPChsQl6FMbJ0+yRuMoLS+Q9GHmtnmsv0Qf
        Vy3A5Y4K8yZLDtUpVix1wBp2f6VIFzigZe/kSA8T6++HFWB5S1FPa+Sq0GGKpAUs
        l9gkoI/7KNZAZIeM0TpJPWaB4WyQG//UlZoA0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 172855F655;
        Sun,  8 Jan 2017 22:05:14 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8239E5F654;
        Sun,  8 Jan 2017 22:05:13 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] log --graph: customize the graph lines with config log.graphColors
References: <xmqqzijjd34j.fsf@gitster.mtv.corp.google.com>
        <20170108101333.26221-1-pclouds@gmail.com>
Date:   Sun, 08 Jan 2017 19:05:12 -0800
In-Reply-To: <20170108101333.26221-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Sun, 8 Jan 2017 17:13:33 +0700")
Message-ID: <xmqq37gtyluf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 707267C0-D618-11E6-B245-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> diff --git a/graph.c b/graph.c
> index dd17201..048f5cb 100644
> --- a/graph.c
> +++ b/graph.c
> @@ -62,6 +62,49 @@ enum graph_state {
>  static const char **column_colors;
>  static unsigned short column_colors_max;
> =20
> +static void set_column_colors(void)

When I said "'by config' sounds funny", I meant "'from config' may
be more natural".  Perhaps name this read_graph_colors_config(), as
that (i.e. reading "log.graphColors") is what it does.

> +{
> +	static char **colors;
> +	static int colors_max, colors_alloc;
> +	char *string =3D NULL;
> +	const char *end, *start;
> +	int i;
> +
> +	for (i =3D 0; i < colors_max; i++)
> +		free(colors[i]);
> +	if (colors)
> +		free(colors[colors_max]);
> +	colors_max =3D 0;

The correctness of the first loop relies on the fact that colors is
non-null when colors_max is not zero, and then the freeing of the
colors relies on something else.  It is not wrong per-se, but it
will reduce the "Huh?" factor if you wrote it like so:

	if (colors) {
        	/*=20
                 * Reinitialize, but keep the colors[] array.
		 * Note that the last entry is allocated for
		 * reset but colors_max does not count it, hence
		 * "i <=3D colors_max", not "i < colors_max".
		 */
		int i;
		for (i =3D 0; i <=3D colors_max; i++)
			free(colors[i]);
		colors_max =3D 0;
	}

