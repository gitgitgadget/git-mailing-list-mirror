Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E8FC4338F
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 18:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 665CF61004
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 18:13:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233222AbhHISNk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Aug 2021 14:13:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:42668 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230243AbhHISNh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Aug 2021 14:13:37 -0400
Received: (qmail 2071 invoked by uid 109); 9 Aug 2021 18:13:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 09 Aug 2021 18:13:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1672 invoked by uid 111); 9 Aug 2021 18:13:16 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Aug 2021 14:13:16 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 9 Aug 2021 14:13:15 -0400
From:   Jeff King <peff@peff.net>
To:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, liu.denton@gmail.com
Subject: Re: [PATCH] builtin/merge: avoid -Wformat-extra-args from ancient
 Xcode
Message-ID: <YRFwO6TTpGYVbdNz@coredump.intra.peff.net>
References: <20210808033834.74470-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210808033834.74470-1-carenas@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 07, 2021 at 08:38:34PM -0700, Carlo Marcelo Arenas Belón wrote:

> d540b70c85 (merge: cleanup messages like commit, 2019-04-17) adds
> a way to change part of the helper text using a single call to
> strbuf_add_commented_addf but with two formats with varying number
> of parameters.
> 
> this trigger a warning in old versions of Xcode (ex 8.0), so use
> instead two independent calls with a matching number of parameters

In general, if only an old version of a compiler complains, I'd prefer
to either silence it (by loosening the -W options in config.mak.dev for
systems without clang4), or just ignore it.

That said, in this case...

> -		strbuf_commented_addf(&msg, _(cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS ?
> -			scissors_editor_comment :
> -			no_scissors_editor_comment), comment_line_char);
> +		if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS)
> +			strbuf_commented_addf(&msg, _(scissors_editor_comment));
> +		else
> +			strbuf_commented_addf(&msg,
> +				_(no_scissors_editor_comment), comment_line_char);

I think the result is actually easier to follow, as we can see that in
the CLEANUP_SCISSORS code we do not care about comment_line_char.

Thanks for the cleanup.

-Peff
