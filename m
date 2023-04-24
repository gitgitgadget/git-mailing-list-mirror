Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67344C7618E
	for <git@archiver.kernel.org>; Mon, 24 Apr 2023 21:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbjDXV52 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 17:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbjDXV51 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 17:57:27 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5983C2B
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 14:57:24 -0700 (PDT)
Received: (qmail 14499 invoked by uid 109); 24 Apr 2023 21:57:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 24 Apr 2023 21:57:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29211 invoked by uid 111); 24 Apr 2023 21:57:19 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 24 Apr 2023 17:57:19 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 24 Apr 2023 17:57:19 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 1/2] notes: clean up confusing NULL checks in init_notes()
Message-ID: <20230424215719.GA3998354@coredump.intra.peff.net>
References: <20230422135455.GA3942740@coredump.intra.peff.net>
 <20230422135543.GA3942829@coredump.intra.peff.net>
 <xmqqttx5duki.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqttx5duki.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 24, 2023 at 11:05:49AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Coverity complains that we check whether "notes_ref" is NULL, but it was
> > already implied to be non-NULL earlier in the function. And this is
> > true; since b9342b3fd63 (refs: add array of ref namespaces, 2022-08-05),
> > we call xstrdup(notes_ref) unconditionally, which would segfault if it
> > was NULL.
> >
> > But that commit is actually doing the right thing. Even if NULL is
> > passed into the function, we'll use default_notes_ref() as a fallback,
> > which will never return NULL (it tries a few options, but its last
> > resort is a string literal). Ironically, the "!notes_ref" check was
> > added by the same commit that added the fallback: 709f79b0894 (Notes
> > API: init_notes(): Initialize the notes tree from the given notes ref,
> > 2010-02-13). So this check never did anything.
> 
> I am impressed(?) that Coverity can complain at the "_or_null" part
> in xstrdup_or_null().

No, my human brain added that part while I was looking at the function.

Coverity is definitely clever enough to realize that the NULL check in
xstrdup_or_null() is not needed here (it's a static inline, but I think
Coverity can even look between translation units). But complaining about
it would yield lots of false positives. It's redundant in this instance,
but not in other callers of the function.

So it would have to realize: we called xstrdup_or_null(), but there is
another function xstrdup() which is exactly the same but without the
NULL check. And I think that is asking too much of even a very clever
static analyzer. :)

-Peff
