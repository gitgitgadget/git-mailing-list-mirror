Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17138C4332F
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 22:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbiLLWSc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 17:18:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233032AbiLLWSa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 17:18:30 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B7FAE58
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 14:18:26 -0800 (PST)
Received: (qmail 7165 invoked by uid 109); 12 Dec 2022 22:18:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 12 Dec 2022 22:18:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30393 invoked by uid 111); 12 Dec 2022 22:17:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 12 Dec 2022 17:17:11 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 12 Dec 2022 17:17:09 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        avarab@gmail.com
Subject: Re: [PATCH v4 3/4] object-file: emit corruption errors when detected
Message-ID: <Y5eoZV0nXVKbIPuP@coredump.intra.peff.net>
References: <Y5ebC1qwJi5VwnCh@coredump.intra.peff.net>
 <20221212212947.1559820-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221212212947.1559820-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 12, 2022 at 01:29:47PM -0800, Jonathan Tan wrote:

> > If we return a non-negative value, then we opened something, so by
> > definition, don't we have a path of the thing we opened?
> > 
> > I think the case Junio mentioned was if we for some reason didn't look
> > at _any_ path. In which case we'd be returning an error.
> 
> Ah, my reading comprehension is failing me, sorry. We do want "path"
> to point to something sensible (well, whenever we can) when an error
> occurs, though, since we want to include that path in our error message
> when DIE_IF_CORRUPT is used. So guaranteeing "path" when a non-negative
> value is returned (and hence, no error occurred) is not so useful.

But we only DIE_IF_CORRUPT when there is actual corruption, which means
we've opened an object file, and "path" is valid.

The only time "path" would be invalid is if open_loose_object() itself
returns an error, which is the message under discussion:

	fd = open_loose_object(r, oid, &path);
	if (fd < 0) {
		if (errno != ENOENT)
			error_errno(_("unable to open loose object %s"), path);
		return -1;
	}

If that stops expecting "path" to be valid (and just mentions the oid),
then the rest of loose_object_info() should be fine.

-Peff
