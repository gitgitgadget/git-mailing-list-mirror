Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6A6C432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 05:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A31B960FE8
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 05:19:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbhHaFUO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 01:20:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:34666 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231530AbhHaFUO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 01:20:14 -0400
Received: (qmail 3649 invoked by uid 109); 31 Aug 2021 05:19:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 31 Aug 2021 05:19:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17238 invoked by uid 111); 31 Aug 2021 05:19:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 31 Aug 2021 01:19:20 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 31 Aug 2021 01:19:17 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, dstolee@microsoft.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v4 05/25] midx: clear auxiliary .rev after replacing the
 MIDX
Message-ID: <YS271RmGhwne0iTm@coredump.intra.peff.net>
References: <YSVuUYFh7lmhNlEy@nand.local>
 <xmqqo89jbf49.fsf@gitster.g>
 <YSko4OwwPb7MwEMa@nand.local>
 <xmqq4kb797xc.fsf@gitster.g>
 <YSwhNxqAS8JajA7p@nand.local>
 <xmqqfsur7otx.fsf@gitster.g>
 <YSwpsp/hQsPFnj+I@nand.local>
 <YS1XOMtj94BcI9HM@camp.crustytoothpaste.net>
 <xmqqmtoy1s9s.fsf@gitster.g>
 <YS1croR3etCfMQhR@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YS1croR3etCfMQhR@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 30, 2021 at 06:33:18PM -0400, Taylor Blau wrote:

> On Mon, Aug 30, 2021 at 03:28:47PM -0700, Junio C Hamano wrote:
> > "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> >
> > > Yeah, this is a possible problem.  You can also see it when using git
> > > index-pack outside of a repository with an incorrect --object-format
> > > option.
> > >
> > > I'm not sure how folks want to deal with that; I'm just fine saying,
> > > "Well, don't do that," but other folks may have different opinions.
> >
> > OK, so if we go back to the original breakage of the test script
> > that triggered this discussion, the right solution would be to make
> > sure both test repositories/object stores are prepared with the
> > algorithm specified with GIT_TEST_DEFAULT_HASH?
> 
> Just to make sure do you still see this as a separate issue from running
> the midx builtin outside of a repository?

Adding my two cents: yes, I think it most definitely should be a
separate issue. As you demonstrated, differing config between alternates
and repos that point to them is not specific to the midx code. I agree
with brian's "well, don't do that". But _if_ we want to try to behave
better in such a case, whatever we changes we make would then naturally
apply to the midx code as well.

The two midx-specific things we have to care about are:

  - is it OK for the midx command to refuse to operate when we are not
    in a repository at all? I think yes; we can't even know which hash
    is being used, along with who knows what other lurking
    complications.

  - is it OK to restrict the midx command's --object-dir to only operate
    on a directory which is an alternate of the current repo? I think
    yes again. If it _isn't_ related, we have all the lurking problems
    from the first point, but even worse (because we use config, refs,
    and other information from our current repo with the _totally
    unrelated_ object dir).

So I'm all in favor of locking those down now before things get any more
complicated. If we later want to make the object store more aware of of
differences between alternates and the main store (like say, the object
hash in use), then we could consider loosening using the same mechanism.

-Peff
