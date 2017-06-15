Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3147720401
	for <e@80x24.org>; Thu, 15 Jun 2017 13:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752503AbdFONuB (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 09:50:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:40660 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751955AbdFONuA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 09:50:00 -0400
Received: (qmail 29643 invoked by uid 109); 15 Jun 2017 13:50:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Jun 2017 13:50:00 +0000
Received: (qmail 23216 invoked by uid 111); 15 Jun 2017 13:50:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Jun 2017 09:50:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Jun 2017 09:49:58 -0400
Date:   Thu, 15 Jun 2017 09:49:58 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Ulrich Mueller <ulm@gentoo.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3] strbuf: let strbuf_addftime handle %z and %Z itself
Message-ID: <20170615134958.mzmdmhonjsnconu2@sigill.intra.peff.net>
References: <20170602030825.hdpbaisn54d4fi4n@sigill.intra.peff.net>
 <72b001fc-80e7-42b9-bd9d-87621da7978a@web.de>
 <20170602183504.ii7arq2ssxgwgyxr@sigill.intra.peff.net>
 <22833.57584.108133.30274@a1i15.kph.uni-mainz.de>
 <20170602223003.6etkdnnogb2jmoh3@sigill.intra.peff.net>
 <22833.60191.771422.3111@a1i15.kph.uni-mainz.de>
 <20170602225148.drkl7obwhzypgjtr@sigill.intra.peff.net>
 <a8b789e6-d0cd-6d96-1bfb-ccc5bc174013@web.de>
 <d578d104-79c6-6c07-db4d-3e4ccb0c0dd9@web.de>
 <5f398cf6-2bc3-f999-acfa-0ef6d7a43435@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5f398cf6-2bc3-f999-acfa-0ef6d7a43435@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 15, 2017 at 02:29:53PM +0200, René Scharfe wrote:

> There is no portable way to pass timezone information to strftime.  Add
> parameters for timezone offset and name to strbuf_addftime and let it
> handle the timezone-related format specifiers %z and %Z internally.
> 
> Callers can opt out for %Z by passing NULL as timezone name.  %z is
> always handled internally -- this helps on Windows, where strftime would
> expand it to a timezone name (same as %Z), in violation of POSIX.
> Modifiers are not handled, e.g. %Ez is still passed to strftime.
> 
> Use an empty string as timezone name in show_date (the only current
> caller) for now because we only have the timezone offset in non-local
> mode.  POSIX allows %Z to resolve to an empty string in case of missing
> information.
> 
> Helped-by: Ulrich Mueller <ulm@gentoo.org>
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
> Changes from v3:
> - Updated developer documentation in strbuf.h.
> - Added short note to user documentation.

This looks good to me overall.

> diff --git a/t/t0006-date.sh b/t/t0006-date.sh
> index 42d4ea61ef..71082008f0 100755
> --- a/t/t0006-date.sh
> +++ b/t/t0006-date.sh
> @@ -51,6 +51,12 @@ check_show iso-local "$TIME" '2016-06-15 14:13:20 +0000'
>  check_show raw-local "$TIME" '1466000000 +0000'
>  check_show unix-local "$TIME" '1466000000'
>  
> +check_show 'format:%z' "$TIME" '+0200'
> +check_show 'format-local:%z' "$TIME" '+0000'
> +check_show 'format:%Z' "$TIME" ''
> +check_show 'format:%%z' "$TIME" '%z'
> +check_show 'format-local:%%z' "$TIME" '%z'

These check that the zone output is correct, but I don't think we ever
check that the value we feed to strftime is actually in the correct zone
in the first place (i.e., that %H shows the correct time).

I think that should go in a separate test from the %z/%Z handling, as
there are some subtleties.

So here are two patches on top of yours: more tests, and then the
format-local handling of %Z.

  [1/2]: t0006: check --date=format zone offsets
  [2/2]: date: use localtime() for "-local" time formats

 date.c          | 14 ++++++++++++--
 t/t0006-date.sh | 10 ++++++++--
 2 files changed, 20 insertions(+), 4 deletions(-)

-Peff
