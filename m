Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEAE1C6FD18
	for <git@archiver.kernel.org>; Tue, 25 Apr 2023 06:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233285AbjDYGVL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Apr 2023 02:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232430AbjDYGVK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2023 02:21:10 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386ACAD2A
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 23:21:08 -0700 (PDT)
Received: (qmail 21990 invoked by uid 109); 25 Apr 2023 06:21:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 25 Apr 2023 06:21:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1360 invoked by uid 111); 25 Apr 2023 06:21:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 25 Apr 2023 02:21:07 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 25 Apr 2023 02:21:07 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhostetler@github.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v3 2/6] string-list: introduce `string_list_setlen()`
Message-ID: <20230425062107.GA4061254@coredump.intra.peff.net>
References: <cover.1681428696.git.me@ttaylorr.com>
 <cover.1682374789.git.me@ttaylorr.com>
 <ae8d0ce1f25f26da09f2e3f5bc68f85cc162ce64.1682374789.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ae8d0ce1f25f26da09f2e3f5bc68f85cc162ce64.1682374789.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 24, 2023 at 06:20:14PM -0400, Taylor Blau wrote:

> However, setting `list->nr` manually is not safe in all instances. There
> are a couple of cases worth worrying about:
> 
>   - If the `string_list` is initialized with `strdup_strings`,
>     truncating the list can lead to overwriting strings which are
>     allocated elsewhere. If there aren't any other pointers to those
>     strings other than the ones inside of the `items` array, they will
>     become unreachable and leak.
> 
>     (We could ourselves free the truncated items between
>     string_list->items[nr] and `list->nr`, but no present or future
>     callers would benefit from this additional complexity).

I wondered how bad it would be to just free those truncated entries when
strdup_strings is set. But that led me to another interesting point: the
util fields. The regular string_list_clear() will optionally free the
util entries, too. We'd potentially need to deal with those, too.

We don't do anything with them here. So code like:

  struct string_list foo = STRING_LIST_INIT_NODUP;

  string_list_append(&foo, "bar")->util = xstrdup("something else");
  string_list_setlen(&foo, 0);

would leak that util field. To be clear, to me this definitely falls
under "if it hurts, don't do it", and I think code like above is pretty
unlikely. But since the point of our function is to prevent mistakes, I
thought it was worth mentioning.

I think we _could_ do something like:

  for (i = nr; i < list->nr; i++) {
	if (list->items[i].util)
		BUG("truncated string list item has non-NULL util field");
  }

though that is technically tighter than we need to be (it could be an
unowned util field, after all; we don't know what it means here). So I'm
inclined to leave your patch as-is.

This would all be easier if the string_list had a field for "we own the
util fields, too" just like it has strdup_strings. Or even a free-ing
function. But instead we have ad-hoc solutions like "free_util" and
string_list_clear_func(). But that's really outside the scope of your
series. </rant> :)

-Peff
