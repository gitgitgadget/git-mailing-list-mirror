Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF6CC433FE
	for <git@archiver.kernel.org>; Sat, 22 Oct 2022 00:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiJVA2o (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 20:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiJVA2m (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 20:28:42 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F5F2A9373
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 17:28:41 -0700 (PDT)
Received: (qmail 15274 invoked by uid 109); 22 Oct 2022 00:28:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 22 Oct 2022 00:28:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19077 invoked by uid 111); 22 Oct 2022 00:28:42 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 21 Oct 2022 20:28:42 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 21 Oct 2022 20:28:40 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, jacob@initialcommit.io, gitster@pobox.com,
        avarab@gmail.com
Subject: Re: [PATCH v3 4/7] shortlog: support arbitrary commit format
 `--group`s
Message-ID: <Y1M5OH/FiWNaKO6p@coredump.intra.peff.net>
References: <cover.1665448437.git.me@ttaylorr.com>
 <cover.1666391136.git.me@ttaylorr.com>
 <f75a952421ee1ab531d9977252d6594346a94583.1666391136.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f75a952421ee1ab531d9977252d6594346a94583.1666391136.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 21, 2022 at 06:25:49PM -0400, Taylor Blau wrote:

> @@ -203,6 +205,32 @@ static void insert_records_from_trailers(struct shortlog *log,
>  	unuse_commit_buffer(commit, commit_buffer);
>  }
>  
> +static int shortlog_needs_dedup(const struct shortlog *log)
> +{
> +	return log->format.nr > 1 || log->trailers.nr;
> +}

So this is obviously much nicer to read. But I think there might be a
weird logic error during the series. Since we haven't yet folded
SHORTLOG_GROUP_AUTHOR, etc, into the "format" code, I think at this
point it still needs:

  HAS_MULTI_BITS(log->groups)

at the beginning of the OR-chain. Otherwise "shortlog --group=author
--format=%an" would fail to dedup, I think.

It's hard to care too much, since the end result of the series is
correct, and you'd end up just removing that part of the line in the
final patch. So I could go either way on re-rolling.

Sorry for not catching this in the last round.

-Peff
