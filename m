Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6B2B20323
	for <e@80x24.org>; Mon, 20 Mar 2017 03:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752460AbdCTD4r (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Mar 2017 23:56:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:47336 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752053AbdCTD4r (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Mar 2017 23:56:47 -0400
Received: (qmail 23443 invoked by uid 109); 20 Mar 2017 03:55:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Mar 2017 03:55:54 +0000
Received: (qmail 29167 invoked by uid 111); 20 Mar 2017 03:56:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 19 Mar 2017 23:56:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 19 Mar 2017 23:55:49 -0400
Date:   Sun, 19 Mar 2017 23:55:49 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Lars Hjemli <hjemli@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>
Subject: Re: [PATCH 4/8] tag: Implicitly supply --list given another
 list-like option
Message-ID: <20170320035549.smzgu2jkaxrhuxl4@sigill.intra.peff.net>
References: <20170318103256.27141-1-avarab@gmail.com>
 <20170318103256.27141-5-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170318103256.27141-5-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 18, 2017 at 10:32:52AM +0000, Ævar Arnfjörð Bjarmason wrote:

> With this change errors messages such as "--contains option is only
> allowed with -l" don't make sense anymore, since options like
> --contain turn on -l. Instead we error out when list-like options such
> as --contain are used in conjunction with conflicting options such as
> -d or -v.

Yeah, I think this is the right approach.

> This change does not consider "-n" a list-like option, even though
> that might be logical. Permitting it would allow:
> 
>     git tag -n 100
> 
> As a synonym for:
> 
>     git tag -n --list 100
> 
> Which, while not technically ambiguous as the option must already be
> provided as -n<num> rather than -n <num>, would be confusing.

I'm not sure the existing behavior isn't confusing anyway (most optional
arguments are). But I don't mind being conservative and leaving out "-n"
for now; we can always convert it later if somebody feels strongly about
it.

> diff --git a/builtin/tag.c b/builtin/tag.c
> index 0bba3fd070..3483636e59 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -454,8 +454,12 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
>  	}
>  	create_tag_object = (opt.sign || annotate || msg.given || msgfile);
>  
> -	if (argc == 0 && !cmdmode && !create_tag_object)
> -		cmdmode = 'l';
> +	if (!cmdmode && !create_tag_object) {
> +		if (argc == 0)
> +			cmdmode = 'l';
> +		else if (filter.with_commit || filter.points_at.nr || filter.merge_commit)
> +			cmdmode = 'l';
> +	}

Makes sense.

> @@ -483,15 +487,16 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
>  		if (column_active(colopts))
>  			stop_column_filter();
>  		return ret;
> +	} else {
> +		if (filter.lines != -1)
> +			die(_("-n option is only allowed in list mode."));
> +		if (filter.with_commit)
> +			die(_("--contains option is only allowed in list mode."));
> +		if (filter.points_at.nr)
> +			die(_("--points-at option is only allowed in list mode."));
> +		if (filter.merge_commit)
> +			die(_("--merged and --no-merged options are only allowed in list mode."));
>  	}
> -	if (filter.lines != -1)
> -		die(_("-n option is only allowed with -l."));
> -	if (filter.with_commit)
> -		die(_("--contains option is only allowed with -l."));
> -	if (filter.points_at.nr)
> -		die(_("--points-at option is only allowed with -l."));
> -	if (filter.merge_commit)
> -		die(_("--merged and --no-merged option are only allowed with -l"));

I'm not sure why these go into the "else" clause here. The other side of
the conditional (i.e., when we are in list mode) always returns. I don't
_mind_ it, it's just surprising in this patch.

While we are re-wording the messages, we may want to drop the periods at
the end of the first three (or keep it on the fourth one, but I our
usual style is to omit it).

> --- a/t/t7004-tag.sh
> +++ b/t/t7004-tag.sh

The tests looked reasonable to me.

-Peff
