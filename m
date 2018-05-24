Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7E131F42D
	for <e@80x24.org>; Thu, 24 May 2018 19:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034413AbeEXTCR (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 15:02:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:51732 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1032740AbeEXTCR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 15:02:17 -0400
Received: (qmail 9717 invoked by uid 109); 24 May 2018 19:02:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 24 May 2018 19:02:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28274 invoked by uid 111); 24 May 2018 19:02:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 24 May 2018 15:02:25 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 May 2018 15:02:14 -0400
Date:   Thu, 24 May 2018 15:02:14 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Kevin Daudt <me@ikke.info>, Git Mailing List <git@vger.kernel.org>
Subject: Re: BUG: No way to set fsck.<msg-id> when cloning
Message-ID: <20180524190214.GA21354@sigill.intra.peff.net>
References: <87vabd6pp2.fsf@evledraar.gmail.com>
 <20180524155807.GA11253@alpha>
 <87tvqx6l4r.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87tvqx6l4r.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 24, 2018 at 07:04:04PM +0200, Ævar Arnfjörð Bjarmason wrote:

> That doesn't work, because that's for the server-side, but I need the
> fetch.fsck.* that doesn't exist. This works (I'll send a better patch
> with tests / docs etc. soon):

Yeah, I think this is the right direction.

> +static int fetch_pack_config_cb(const char *var, const char *value, void *cb)
> +{
> +	if (strcmp(var, "fetch.fsck.skiplist") == 0) {
> +		const char *path;
> +
> +		if (git_config_pathname(&path, var, value))
> +			return 1;
> +		strbuf_addf(&fsck_msg_types, "%cskiplist=%s",
> +			fsck_msg_types.len ? ',' : '=', path);
> +		free((char *)path);
> +		return 0;
> +	}
> +
> +	if (skip_prefix(var, "fetch.fsck.", &var)) {
> +		if (is_valid_msg_type(var, value))
> +			strbuf_addf(&fsck_msg_types, "%c%s=%s",
> +				fsck_msg_types.len ? ',' : '=', var, value);
> +		else
> +			warning("Skipping unknown msg id '%s'", var);
> +		return 0;
> +	}

This matches what's in receive-pack, though the way we stuff all of the
options into a flat string is kind of nasty. I also wonder if we'd
eventually run up against command-line limits if somebody had a
complicated fsck config.

I wonder if we should simply be telling index-pack "please read fsck
config from the prefix 'fetch.fsck'" instead.

I dunno, maybe I am just creating work. Certainly I don't think it
should be a blocker for adding fetch.fsck support. But if you want to
think about it while you are here or write a patch, I wouldn't complain. :)

-Peff
