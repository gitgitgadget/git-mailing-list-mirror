Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 213B8C43334
	for <git@archiver.kernel.org>; Thu,  7 Jul 2022 17:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236524AbiGGRGX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jul 2022 13:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235634AbiGGRGW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jul 2022 13:06:22 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943F9E08E
        for <git@vger.kernel.org>; Thu,  7 Jul 2022 10:06:21 -0700 (PDT)
Received: (qmail 6267 invoked by uid 109); 7 Jul 2022 17:06:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 07 Jul 2022 17:06:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2724 invoked by uid 111); 7 Jul 2022 17:06:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Jul 2022 13:06:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 7 Jul 2022 13:06:18 -0400
From:   Jeff King <peff@peff.net>
To:     Konstantin Khomoutov <kostix@bswap.ru>
Cc:     wuzhouhui <wuzhouhui14@mails.ucas.ac.cn>, git@vger.kernel.org
Subject: Re: How to display "HEAD~*" in "git log"
Message-ID: <YscSigm9b8QJMuRM@coredump.intra.peff.net>
References: <17411d88-b27a-2d20-623d-85c49dc7754e@mails.ucas.ac.cn>
 <20220705092514.hsm7cou5bqvajvgq@carbon>
 <YsWebbaOJbaOZ6i7@coredump.intra.peff.net>
 <20220706162856.mkgfdr2lnjdbxgn4@carbon>
 <YsW9BI61tWGh9OJo@coredump.intra.peff.net>
 <20220706182149.gg75w6uonm4hs5af@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220706182149.gg75w6uonm4hs5af@carbon>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 06, 2022 at 09:21:49PM +0300, Konstantin Khomoutov wrote:

> > Right. The problem is that it gets the set of possible ref tips with
> > for_each_ref(), which will not include HEAD. And then worse, since the
> > argument to "--refs" is a pattern, it matches junk like origin/HEAD.
> 
> Do I assume correctly that `git for-each-ref HEAD` does nothing, successfully,
> for the very same reason?

Yes.

> If so, I wonder if this should be somehow reflected in the docs.
> I mean, I have always maintained an impression that things like HEAD,
> ORIGIN_HEAD, FETCH_HEAD etc are also "refs" - because they, well, reference
> commits or branches.
> 
> The gitglossary manual page of my Git 2.30.2 states that
> 
> | ref
> |   A name that begins with refs/ (e.g. refs/heads/master)
> | <...>
> |   There are a few special-purpose refs that do not begin with refs/.
> |   The most notable example is HEAD.
> 
> which suggests that HEAD is a ref.

Yeah, I think the situation around those top-level names
is...complicated. They act like refs when you name them, but they are
often omitted from iteration of refs. And yet many spots (e.g.,
"rev-list --all") will include them explicitly. Documentation aside, I
would not be surprised if there are still places in the code itself
where there are inconsistencies. I feel like we've had a number of
"oops, include HEAD in this corner case" patches pop up over the years.
Maybe we've gotten them all now?

All of which is to say: you're definitely not wrong, but I'm not sure
what simple documentation change would be helpful. The handling of HEAD
in each specific situation could be mentioned in their respective
documentation spots, but identifying all of those is tough. Possibly the
glossary entry should say something like:

  Note that HEAD is sometimes includes in sets of refs (e.g., in `git
  rev-list --all`) and sometimes not (e.g., in `git for-each-ref`).

but that may be too vague to be helpful to anybody.

-Peff
