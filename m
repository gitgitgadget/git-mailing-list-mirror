Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C96DE1F453
	for <e@80x24.org>; Fri, 19 Oct 2018 23:59:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbeJTIIE (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 04:08:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:47284 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726349AbeJTIIE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 04:08:04 -0400
Received: (qmail 11478 invoked by uid 109); 19 Oct 2018 23:59:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 19 Oct 2018 23:59:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17825 invoked by uid 111); 19 Oct 2018 23:58:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 19 Oct 2018 19:58:59 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Oct 2018 19:59:46 -0400
Date:   Fri, 19 Oct 2018 19:59:46 -0400
From:   Jeff King <peff@peff.net>
To:     steadmon@google.com
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] archive: init archivers before determining format
Message-ID: <20181019235945.GB7326@sigill.intra.peff.net>
References: <cover.1539990488.git.steadmon@google.com>
 <b1f8e288dde9a9dd46386524189da66c7ad2c333.1539990488.git.steadmon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b1f8e288dde9a9dd46386524189da66c7ad2c333.1539990488.git.steadmon@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 19, 2018 at 04:19:28PM -0700, steadmon@google.com wrote:

> diff --git a/builtin/archive.c b/builtin/archive.c
> index e74f675390..dd3283a247 100644
> --- a/builtin/archive.c
> +++ b/builtin/archive.c
> @@ -45,7 +45,10 @@ static int run_remote_archiver(int argc, const char **argv,
>  	 * it.
>  	 */
>  	if (name_hint) {
> -		const char *format = archive_format_from_filename(name_hint);
> +		const char *format;
> +		init_tar_archiver();
> +		init_zip_archiver();
> +		format = archive_format_from_filename(name_hint);
>  		if (format)
>  			packet_write_fmt(fd[1], "argument --format=%s\n", format);

Hrm. This code was added back in 56baa61d01 (archive: move file
extension format-guessing lower, 2011-06-21), and your example
invocation worked back then!

Unfortunately it was broken by the very next patch in the series,
08716b3c11 (archive: refactor file extension format-guessing,
2011-06-21). I guess that's what I get for not adding regression tests.

It's probably worth mentioning those points in the commit message.

Does this work with configured archiver extensions, too? I think so,
because we load them via init_tar_archiver().

Can we avoid repeating the list of archivers here? This needs to stay in
sync with the list in write_archive(). I know there are only two, but
can we factor out an init_archivers() call or something?

We also should probably just call it unconditionally when we start the
archiver command (I don't think there are any other bugs like this
lurking, but it doesn't cost very much to initialize these; it makes
sense to just do it early).

Other than those minor points (and the lack of test), your fix looks
good to me.

-Peff
