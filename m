Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 517221FC41
	for <e@80x24.org>; Fri, 21 Apr 2017 20:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161451AbdDUUmA (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Apr 2017 16:42:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:37965 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161246AbdDUUl6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2017 16:41:58 -0400
Received: (qmail 20983 invoked by uid 109); 21 Apr 2017 20:41:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 21 Apr 2017 20:41:57 +0000
Received: (qmail 20126 invoked by uid 111); 21 Apr 2017 20:42:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 21 Apr 2017 16:42:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Apr 2017 16:41:54 -0400
Date:   Fri, 21 Apr 2017 16:41:54 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH] t/perf: correctly align non-ASCII descriptions in output
Message-ID: <20170421204154.c5mvmnccxkxdm5aw@sigill.intra.peff.net>
References: <20170421194428.1377-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170421194428.1377-1-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 21, 2017 at 07:44:28PM +0000, Ævar Arnfjörð Bjarmason wrote:

> Change the test descriptions from being treated as binary blobs by
> perl to being treated as UTF-8. This ensures that e.g. a test
> description like "æ" is counted as 1 character, not 2.
> 
> I have WIP performance tests for non-ASCII grep patterns on another
> topic that are affected by this.

Makes sense. As this is purely about test titles in our project,
choosing utf8 as the only encoding is quite sensible.

> diff --git a/t/perf/aggregate.perl b/t/perf/aggregate.perl
> index 924b19dab4..1dbc85b214 100755
> --- a/t/perf/aggregate.perl
> +++ b/t/perf/aggregate.perl
> @@ -88,6 +88,7 @@ for my $t (@tests) {
>  sub read_descr {
>  	my $name = shift;
>  	open my $fh, "<", $name or return "<error reading description>";
> +	binmode $fh, ":utf8" or die "PANIC on binmode: $!";

I thought there was some "use" flag we could set to just make all of our
handles utf8. But all I could come up with was stuff like PERLIO and
"perl -C". Using binmode isn't too bad, though (I think you could
just do it as part of the open, too, but I'm not sure if antique
versions of perl support that).

-Peff
