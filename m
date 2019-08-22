Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C55431F461
	for <e@80x24.org>; Thu, 22 Aug 2019 04:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfHVEYq (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Aug 2019 00:24:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:51978 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725793AbfHVEYq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Aug 2019 00:24:46 -0400
Received: (qmail 27543 invoked by uid 109); 22 Aug 2019 04:24:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 22 Aug 2019 04:24:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17701 invoked by uid 111); 22 Aug 2019 04:25:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 22 Aug 2019 00:25:58 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 22 Aug 2019 00:24:45 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Bryan Turner <bturner@atlassian.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: Fully peel tags via for-each-ref?
Message-ID: <20190822042445.GB4347@sigill.intra.peff.net>
References: <CAGyf7-GBx3FSCQTipmkNBtnwMANg5A0FXiiPc2az0NiRLRT+xg@mail.gmail.com>
 <xmqq8srowfkv.fsf@gitster-ct.c.googlers.com>
 <20190821230035.GA26107@sigill.intra.peff.net>
 <xmqqmug1rj7y.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmug1rj7y.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 21, 2019 at 08:07:29PM -0700, Junio C Hamano wrote:

> But after we learn that a ref "refs/tags/foo" points at a tag object
> that points at another tag object, what can the script do?  It
> cannot feed the other tag found that way back into --format=%(*<thing>)
> machinery of for-each-ref, as the command and its variants, the "--list"
> mode of "branch" and "tag" commands, only work on the object at the
> tip of refs.  The script must manually peel the tag one layer at a time.
> 
> And that "manually" has to be really manual.  No ^{<type>} suffix
> allows scripts to peel just one layer, so inside a loop, the script
> has to say "cat-file tag <object>" and parse the "object" header
> from the output.
> 
> The only thing that gets affected if we changed %(*<thing>) to fully
> peel tags is a tag that points at another tag, and the traditional
> behaviour to peel only one layer, while it _might_ have been done as
> a good first step to add more support for chain of trust, is not all
> that useful for such a tag, I am not sure if the current behaviour
> is defensible.

Yeah, well said, and I think this is the heart of the matter. There
isn't good tooling for this case, but even if there was, for-each-ref is
definitely not the place for it.

I took a brief look at making a patch, and it's unfortunately
non-trivial because of the way the deref logic in ref-filter is
implemented. So it may not be worth digging too far into for now if
nobody cares much either way.

I still have dreams of writing a more efficient and more reusable
version of ref-filter, and it would probably make sense to use
peel_ref() as part of that rewrite.

-Peff
