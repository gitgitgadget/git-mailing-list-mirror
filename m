Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5872F1FBB0
	for <e@80x24.org>; Tue, 22 Nov 2016 21:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932488AbcKVVnJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Nov 2016 16:43:09 -0500
Received: from cloud.peff.net ([104.130.231.41]:46354 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755871AbcKVVnI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2016 16:43:08 -0500
Received: (qmail 20543 invoked by uid 109); 22 Nov 2016 21:43:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 22 Nov 2016 21:43:08 +0000
Received: (qmail 32474 invoked by uid 111); 22 Nov 2016 21:43:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 22 Nov 2016 16:43:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 Nov 2016 16:43:06 -0500
Date:   Tue, 22 Nov 2016 16:43:06 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        Taufiq Hoven <taufiq.hoven@gmail.com>
Subject: Re: [PATCH 2/3] stripspace: respect repository config
Message-ID: <20161122214305.yrn4uqh4dzzafkd2@sigill.intra.peff.net>
References: <cover.1479737858.git.johannes.schindelin@gmx.de>
 <5567548295222401fab10d3f2901c1787afbfd07.1479737858.git.johannes.schindelin@gmx.de>
 <CACsJy8D5oBR+vo2B+Ro2Q4SX0CG3jME4Gfs1_6AohccmpNvD0A@mail.gmail.com>
 <alpine.DEB.2.20.1611221712480.3746@virtualbox>
 <xmqqshqjqw3z.fsf@gitster.mtv.corp.google.com>
 <xmqqzikrpbz2.fsf@gitster.mtv.corp.google.com>
 <20161122195015.rztaixpz7zvdxb4u@sigill.intra.peff.net>
 <xmqqoa17p8k0.fsf@gitster.mtv.corp.google.com>
 <20161122211920.3qdohxdktykqhyga@sigill.intra.peff.net>
 <xmqqeg23p5v3.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqeg23p5v3.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 22, 2016 at 01:22:24PM -0800, Junio C Hamano wrote:

> OK.  The "mailinfo" part turns out a bit more than RUN_SETUP_GENTLY
> as it takes paths from the command line that needs to be adjusted
> for the prefix.

I wondered at first if our lack of parse-options here was holding us
back from using OPT_FILENAME. Though even if that was the case, it is
probably better to do the minimal fix in this instance, rather than
converting the option parsing.

However, the paths which need munged are not even options, they are
arguments. So we wouldn't be able to rely on OPT_FILENAME anyway. I'm
surprised we haven't had to deal with this elsewhere, but I guess most
commands don't take arbitrary filenames (things like `add` take
pathspecs, and then the pathspec machinery takes care of the details).

The only other case I could think of is git-apply, and it does use
prefix_filename() correctly.

> +static char *prefix_copy(const char *prefix, const char *filename)
> +{
> +	if (!prefix || is_absolute_path(filename))
> +		return xstrdup(filename);
> +	return xstrdup(prefix_filename(prefix, strlen(prefix), filename));
> +}

So this is more or less a copy of parse-option's fix_filename(), which
makes sense.

I noticed that git-apply does not check is_absolute_path(), but that's
OK, as prefix_filename() does. So I think it would be correct to drop it
here, but it doesn't matter much either way.

>  int cmd_mailinfo(int argc, const char **argv, const char *prefix)
>  {
>  	const char *def_charset;
>  	struct mailinfo mi;
>  	int status;
> +	char *msgfile, *patchfile;
>  
> -	/* NEEDSWORK: might want to do the optional .git/ directory
> -	 * discovery
> -	 */
>  	setup_mailinfo(&mi);

This part looks straightforward and correct. Dropping the NEEDSWORK is a
nice bonus.

> +test_expect_success 'mailinfo with mailinfo.scissors config' '
> +	test_config mailinfo.scissors true &&
> +	(
> +		mkdir sub &&
> +		cd sub &&
> +		git mailinfo ../msg0014.sc ../patch0014.sc <../0014 >../info0014.sc
> +	) &&
> +	test_cmp "$DATA/msg0014--scissors" msg0014.sc &&
> +	test_cmp "$DATA/patch0014--scissors" patch0014.sc &&
> +	test_cmp "$DATA/info0014--scissors" info0014.sc
> +'

And this test makes sense. Even without "sub", it would show the
regression, but it's a good idea to test the sub-directory case to cover
the path-munging.

In the "archive --remote" test I added, we may want to do the same to
show that "--output" points at the correct path.

-Peff
