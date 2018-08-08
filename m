Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5ED581F405
	for <e@80x24.org>; Wed,  8 Aug 2018 22:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731564AbeHIBMB (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 21:12:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:47680 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727530AbeHIBMB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 21:12:01 -0400
Received: (qmail 17518 invoked by uid 109); 8 Aug 2018 22:50:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 08 Aug 2018 22:50:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4068 invoked by uid 111); 8 Aug 2018 22:50:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 08 Aug 2018 18:50:15 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Aug 2018 18:50:12 -0400
Date:   Wed, 8 Aug 2018 18:50:12 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/5] chainlint: match arbitrary here-docs tags rather
 than hard-coded names
Message-ID: <20180808225011.GC3902@sigill.intra.peff.net>
References: <20180711064642.6933-1-sunshine@sunshineco.com>
 <20180807082135.60913-1-sunshine@sunshineco.com>
 <20180807082135.60913-2-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180807082135.60913-2-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 07, 2018 at 04:21:31AM -0400, Eric Sunshine wrote:

> diff --git a/t/chainlint.sed b/t/chainlint.sed
> index 5f0882cb38..bd76c5d181 100644
> --- a/t/chainlint.sed
> +++ b/t/chainlint.sed
> @@ -61,6 +61,22 @@
>  # "else", and "fi" in if-then-else likewise must not end with "&&", thus
>  # receives similar treatment.
>  #
> +# Swallowing here-docs with arbitrary tags requires a bit of finesse. When a
> +# line such as "cat <<EOF >out" is seen, the here-doc tag is moved to the front
> +# of the line enclosed in angle brackets as a sentinel, giving "<EOF>cat >out".
> +# As each subsequent line is read, it is appended to the target line and a
> +# (whitespace-loose) back-reference match /^<(.*)>\n\1$/ is attempted to see if
> +# the content inside "<...>" matches the entirety of the newly-read line. For
> +# instance, if the next line read is "some data", when concatenated with the
> +# target line, it becomes "<EOF>cat >out\nsome data", and a match is attempted
> +# to see if "EOF" matches "some data". Since it doesn't, the next line is
> +# attempted. When a line consisting of only "EOF" (and possible whitespace) is
> +# encountered, it is appended to the target line giving "<EOF>cat >out\nEOF",
> +# in which case the "EOF" inside "<...>" does match the text following the
> +# newline, thus the closing here-doc tag has been found. The closing tag line
> +# and the "<...>" prefix on the target line are then discarded, leaving just
> +# the target line "cat >out".

Gross, but OK, as long as we would not get confused by a line that
actually started with <EOF> at the start.

> +/<<[ 	]*[-\\]*[A-Z0-9_][A-Z0-9_]*/ {
> +	s/^\(.*\)<<[ 	]*[-\\]*\([A-Z0-9_][A-Z0-9_]*\)/<\2>\1<</
> +	s/[ 	]*<<//

Here-docs can use lowercase, too, though I'd personally frown on that
from a style perspective.

It looks like this doesn't catch:

  cat <<'EOF'
  EOF

either. I think we prefer the backslash style, but there are quite a few
<<-'EOF' hits. Is it covered somewhere else?

-Peff
