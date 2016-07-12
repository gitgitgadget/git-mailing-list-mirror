Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 013C91FE4E
	for <e@80x24.org>; Tue, 12 Jul 2016 14:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932421AbcGLOEn (ORCPT <rfc822;e@80x24.org>);
	Tue, 12 Jul 2016 10:04:43 -0400
Received: from cloud.peff.net ([50.56.180.127]:43456 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751335AbcGLOEc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2016 10:04:32 -0400
Received: (qmail 4300 invoked by uid 102); 12 Jul 2016 14:04:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 Jul 2016 10:04:31 -0400
Received: (qmail 2956 invoked by uid 107); 12 Jul 2016 14:04:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 Jul 2016 10:04:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Jul 2016 10:04:28 -0400
Date:	Tue, 12 Jul 2016 10:04:28 -0400
From:	Jeff King <peff@peff.net>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.9.1
Message-ID: <20160712140427.GB613@sigill.intra.peff.net>
References: <xmqqbn247x1f.fsf@gitster.mtv.corp.google.com>
 <87lh17kgdy.fsf@linux-m68k.org>
 <20160711235417.GA26163@sigill.intra.peff.net>
 <xmqqy4577h0o.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1607120927410.6426@virtualbox>
 <20160712073912.GA26431@sigill.intra.peff.net>
 <alpine.DEB.2.20.1607121257450.6426@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1607121257450.6426@virtualbox>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jul 12, 2016 at 01:25:20PM +0200, Johannes Schindelin wrote:

> [PATCH] Work around test failures due to timestamps being unsigned long
> 
> Git's source code refers to timestamps as unsigned longs. On 32-bit
> platforms, as well as on Windows, unsigned long is not large enough to
> capture dates that are "absurdly far in the future".
> 
> While we will fix this issue properly by replacing unsigned long ->
> time_t, on the maint track we want to be a bit more conservative and
> just skip those tests.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

This looks like a reasonable interim fix for both Windows and for the
general maint track. If we reliably produce "2038" for the 999... value
then that's simpler than adding in magic to ask about sizeof(ulong). I
also wondered if we should test forthe _correct_ value, but that would
defeat the point of the test (999... is also far in the future).

One minor comment:

> diff --git a/t/t0006-date.sh b/t/t0006-date.sh
> index 04ce535..d185640 100755
> --- a/t/t0006-date.sh
> +++ b/t/t0006-date.sh
> @@ -48,10 +48,17 @@ check_show default "$TIME" 'Wed Jun 15 16:13:20 2016 +0200'
>  check_show raw "$TIME" '1466000000 +0200'
>  check_show iso-local "$TIME" '2016-06-15 14:13:20 +0000'
>  
> -# arbitrary time absurdly far in the future
> -FUTURE="5758122296 -0400"
> -check_show iso       "$FUTURE" "2152-06-19 18:24:56 -0400"
> -check_show iso-local "$FUTURE" "2152-06-19 22:24:56 +0000"
> +case "$(test-date show:iso 9999999999)" in
> +*2038*)
> +	# on this platform, unsigned long is 32-bit, i.e. not large enough
> +	;;
> +*)
> +	# arbitrary time absurdly far in the future
> +	FUTURE="5758122296 -0400"
> +	check_show iso       "$FUTURE" "2152-06-19 18:24:56 -0400"
> +	check_show iso-local "$FUTURE" "2152-06-19 22:24:56 +0000"
> +	;;
> +esac

It would be nice to wrap this in a prereq, like:

  test_lazy_prereq 64BIT_TIME '
	case "$(test-date show:short 9999999999)" in
	*2038*)
		false
		;;
	*)
		true
		;;
	esac
  '

  ...
  check_show 64BIT_TIME iso       "$FUTURE" "2152-06-19 18:24:56 -0400"
  check_show 64BIT_TIME iso-local "$FUTURE" "2152-06-19 22:24:56 +0000"

The main advantage is that it will number the tests consistently, and
give us a "skipped" message (which can remind us to drop the prereq
later when everything goes 64-bit).

But it also will do the right thing with test-date's output with respect
to "-v" (not that we expect it to produce any output).

You'll need to adjust check_show as I did in my earlier patch.

-Peff
