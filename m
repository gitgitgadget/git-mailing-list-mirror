Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 716C11F462
	for <e@80x24.org>; Fri, 22 Feb 2019 06:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbfBVG0J (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 01:26:09 -0500
Received: from cloud.peff.net ([104.130.231.41]:53872 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725868AbfBVG0J (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 01:26:09 -0500
Received: (qmail 29238 invoked by uid 109); 22 Feb 2019 06:26:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 22 Feb 2019 06:26:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19769 invoked by uid 111); 22 Feb 2019 06:26:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 22 Feb 2019 01:26:22 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Feb 2019 01:26:07 -0500
Date:   Fri, 22 Feb 2019 01:26:07 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <junio@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] format-patch: notice failure to open cover letter for
 writing
Message-ID: <20190222062606.GD10248@sigill.intra.peff.net>
References: <xmqqlg28snv0.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlg28snv0.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 21, 2019 at 03:50:11PM -0800, Junio C Hamano wrote:

> The make_cover_letter() function is supposed to open a new file for
> writing, and let the caller write into it via FILE *rev->diffopt.file
> but because the function does not return anything, the caller does not
> bother checking the return value.
> 
> Make sure it dies, instead of keep going with a NULL output
> filestream and relying on it to cause a crash.

Definitely makes sense.

> diff --git a/builtin/log.c b/builtin/log.c
> index 3e145fe502..43fc9a07df 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -1047,7 +1047,7 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
>  
>  	if (!use_stdout &&
>  	    open_next_file(NULL, rev->numbered_files ? NULL : "cover-letter", rev, quiet))
> -		return;
> +		die(_("Failed to create cover-letter file"));

I wondered if we should be showing errno here, but it looks like
open_next_file() will give us a more specific error (including errno if
applicable).

I'd suggest s/F/f/ in the message to match our usual style, though I see
this code has a lot of capitalized errors already. :)

> +test_expect_success 'failure to write cover-letter aborts gracefully' '
> +	test_when_finished "rmdir 0000-cover-letter.patch" &&
> +	mkdir 0000-cover-letter.patch &&
> +	test_must_fail git format-patch --no-renames --cover-letter -1
> +'

Cute test. :)

-Peff
