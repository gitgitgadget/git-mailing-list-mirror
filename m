Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 815801F954
	for <e@80x24.org>; Wed, 22 Aug 2018 19:07:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbeHVWdZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Aug 2018 18:33:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:52116 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727844AbeHVWdZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Aug 2018 18:33:25 -0400
Received: (qmail 26771 invoked by uid 109); 22 Aug 2018 19:07:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 22 Aug 2018 19:07:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3386 invoked by uid 111); 22 Aug 2018 19:07:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 22 Aug 2018 15:07:26 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Aug 2018 15:07:18 -0400
Date:   Wed, 22 Aug 2018 15:07:18 -0400
From:   Jeff King <peff@peff.net>
To:     Hari Lubovac <hlubovac@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: MINOR: log-format "%C" & "%+" log
Message-ID: <20180822190718.GA19730@sigill.intra.peff.net>
References: <CAFLu24kbCJu74tgfRDR=xPZ3pkbau9R6jmqPbFKR=ZnWOvbCvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFLu24kbCJu74tgfRDR=xPZ3pkbau9R6jmqPbFKR=ZnWOvbCvQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 22, 2018 at 09:46:08AM -0700, Hari Lubovac wrote:

> I don't know where else to report this. It relates to the "log"
> command with "--pretty:format" argument.
> 
> It appears to me that "%C" format argument combined with "%+" or "%-"
> results in no color applied.
> 
> For example, I'd expect the last part of the output line ("%+D") to be
> colored red (it does when the "+" is removed):
> 
> git log --pretty="format:%C(Yellow)%t %C(reset)%ad
> %C(Cyan)%<(6,trunc)%an %C(reset)%s %C(Red)%+D" --date="format:%m/%d"
> 
> This info is taken from https://git-scm.com/docs/pretty-formats: "If
> you add a + (plus sign) after '%' of a placeholder..."

Hmm. I think this is actually due to the way the pager displays colors.

Try this:

  git --no-pager log -1 --format='foo%C(red)%+an'

I see the committer name on its own line in read, as expected. Now try
the same thing with a pager:

  git log -1 --format='foo%C(red)%+an'

I see no color.

The actual output sequence is (<red>, <newline>, <author>). So
presumably what is happening is that the pager does not let color from
the previous line impact to the next line.

Unfortunately I don't know if there's an easy workaround. What you
really want is to apply the "+" magic to a whole section of the string.
You can do that with git-for-each-ref's format, like:

  %(if)%D%(then)%n%C(red)%D%(end)

but the two formats are not (yet) unified. There's interest in doing
that, and an Outreachy intern worked on it over the winter, but there's
still a long way to go.

-Peff
