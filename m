Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0491CC54EBD
	for <git@archiver.kernel.org>; Sat,  7 Jan 2023 13:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbjAGNdu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Jan 2023 08:33:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbjAGNdR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jan 2023 08:33:17 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BEB25F489
        for <git@vger.kernel.org>; Sat,  7 Jan 2023 05:33:15 -0800 (PST)
Received: (qmail 23431 invoked by uid 109); 7 Jan 2023 13:33:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 07 Jan 2023 13:33:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23667 invoked by uid 111); 7 Jan 2023 13:33:15 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 07 Jan 2023 08:33:15 -0500
Authentication-Results: peff.net; auth=none
Date:   Sat, 7 Jan 2023 08:33:14 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] convert trivial uses of strncmp() to skip_prefix()
Message-ID: <Y7l0mq6khtlgxGca@coredump.intra.peff.net>
References: <Y7lyga5g2leSmWQd@coredump.intra.peff.net>
 <Y7lzFG9gyDrOE4Xt@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y7lzFG9gyDrOE4Xt@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 07, 2023 at 08:26:45AM -0500, Jeff King wrote:

> Note in the case in ws.c that to get rid of the magic number "9"
> completely, we also switch out "len" for recomputing the pointer
> difference. These are equivalent because "len" is always "ep - string".

By the way, one thing I noticed about this parse_whitespace_rule()
function is that it's very loose about its matching. It does:

        for (i = 0; i < ARRAY_SIZE(whitespace_rule_names); i++) {
                if (strncmp(whitespace_rule_names[i].rule_name,
                            string, len))
                        continue;
		...we matched...
		break;
	}

So it will prefix-match any of the options, even if there are
ambiguities. E.g.:

  git -c core.whitespace=-t show

will turn off "trailing-space", even though it would also match
"tab-in-indent". It would be easy enough to fix it to require the whole
name, but I wasn't sure if this prefix-matching was supposed to be a
feature (it doesn't seem to be documented anywhere, though).

-Peff
