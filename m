Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9698F1FA14
	for <e@80x24.org>; Tue, 11 Apr 2017 10:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753979AbdDKKHp (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 06:07:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:59717 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752247AbdDKKHD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 06:07:03 -0400
Received: (qmail 21103 invoked by uid 109); 11 Apr 2017 10:06:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Apr 2017 10:06:59 +0000
Received: (qmail 32731 invoked by uid 111); 11 Apr 2017 10:07:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Apr 2017 06:07:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Apr 2017 06:06:57 -0400
Date:   Tue, 11 Apr 2017 06:06:57 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeffrey Walton <noloader@gmail.com>,
        =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 01/12] grep: add ability to disable threading with
 --threads=0 or grep.threads=0
Message-ID: <20170411100656.5bptxdaptc4zznan@sigill.intra.peff.net>
References: <20170408132506.5415-1-avarab@gmail.com>
 <20170408132506.5415-2-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170408132506.5415-2-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 08, 2017 at 01:24:55PM +0000, Ævar Arnfjörð Bjarmason wrote:

> Add the ability to entirely disable threading by having grep.threads=0
> in the config or --threads=0 on the command-line.

In pack-objects and index-pack, --threads=0 means "auto-detect". It
seems like we should try to keep this consistent.

Wouldn't --threads=1 be a better way to disable threading? Pack-objects
is smart enough to just use the non-threaded code path entirely in that
case (rather than wasting time spawning a single worker thread). Grep
should probably do the same.

> +static int thread_callback(const struct option *opt,
> +			   const char *arg, int unset)
> +{
> +	int *threads = (int*)opt->value;
> +	char *end;
> +
> +	if (unset) {
> +		*threads = GREP_NUM_THREADS_DEFAULT;
> +		return 0;
> +	}

This means that "--no-threads" will use 8 threads. Which _kind of_ makes
sense in that it cancels any previous "--threads", but I wonder if it
should be the same as "--threads=1".

This isn't really a change in behavior from the existing code, though
(OPT_INTEGER will set it to 0 in that case, too, and we'd later pick up
the default value).

-Peff
