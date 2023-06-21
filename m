Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F60EB64D8
	for <git@archiver.kernel.org>; Wed, 21 Jun 2023 20:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjFUU1A (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jun 2023 16:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjFUU0q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2023 16:26:46 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C41A1
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 13:26:44 -0700 (PDT)
Received: (qmail 30047 invoked by uid 109); 21 Jun 2023 20:26:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 21 Jun 2023 20:26:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18556 invoked by uid 111); 21 Jun 2023 20:26:45 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 21 Jun 2023 16:26:45 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 21 Jun 2023 16:26:42 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org
Subject: Re: bug in en/header-split-cache-h-part-3, was Re: What's cooking in
 git.git (Jun 2023, #05; Tue, 20)
Message-ID: <20230621202642.GA1423@coredump.intra.peff.net>
References: <xmqqedm5k7dx.fsf@gitster.g>
 <20230621085526.GA920315@coredump.intra.peff.net>
 <xmqqttv0hhjv.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqttv0hhjv.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 21, 2023 at 10:05:40AM -0700, Junio C Hamano wrote:

> > So I think we'd at least want to fix the Makefile before graduating this
> > topic any further. But IMHO it would also be worth adjusting the topic's
> > start point so that we don't have a big chunk of commits which fail to
> > build in the final history.
> 
> Hmph, meaning (1) revert the merge of the topic to 'next', (2)
> rebase the topic on top of the current 'master', instead of 4bd872e0,
> which was a merge of the prerequisite series into then-current
> master, (3) apply the Makefile (plus setup.c) fix, and then (4)
> merge the result back to 'next'?

Yeah. I guess the real build problem is actually in the merge of split-2
(it conflicted with a simultaneous topic, hence the fix coming in the
merge). So another option to address that here would be to amend the
4bd872e0ed (Merge branch 'en/header-split-cache-h-part-2' into
en/header-split-cache-h-part-3, 2023-05-08) to include that fixup.

As for the others, I'd consider:

  1. (optional) Drop the #ifndef at the very start of the series, before
     we touch anything, with the rationale that it is not doing anything
     and masks errors. I don't _think_ this can ever backfire, because
     we unconditionally set DEFAULT_GIT_TEMPLATE_DIR (unlike some other
     things like DEFAULT_PAGER, where the Makefile might leave it
     unset). But we can also leave this out, or do it as a separate
     topic, if we want to minimize changes / risk of screwing something
     up.

  2. Squash the Makefile fix into the "adopt shared init-db" patch
     (currently 0d652b238).

And that would leave the result fully bisectable. But if we prefer to
keep the history closer to reality, I can prepare the Makefile thing as
a patch on top.

-Peff
