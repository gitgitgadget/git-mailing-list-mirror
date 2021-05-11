Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C64E0C433B4
	for <git@archiver.kernel.org>; Tue, 11 May 2021 19:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 939B9616ED
	for <git@archiver.kernel.org>; Tue, 11 May 2021 19:24:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbhEKTZg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 15:25:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:51160 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231454AbhEKTZg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 15:25:36 -0400
Received: (qmail 24268 invoked by uid 109); 11 May 2021 19:24:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 11 May 2021 19:24:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27187 invoked by uid 111); 11 May 2021 19:24:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 11 May 2021 15:24:29 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 11 May 2021 15:24:28 -0400
From:   Jeff King <peff@peff.net>
To:     Gregory Anders <greg@gpanders.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3] git-send-email: use ! to indicate relative path to
 command
Message-ID: <YJrZ7Hho6jrVyM7f@coredump.intra.peff.net>
References: <20210511191510.25888-1-greg@gpanders.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210511191510.25888-1-greg@gpanders.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 11, 2021 at 01:15:11PM -0600, Gregory Anders wrote:

> When the smtpServer config option is prefixed with a ! character, the
> value of the option should be interpreted as a command to look up on
> PATH.

This tells us "what", but the commit message is a good place to describe
"why". That helps reviewers now understand what you're trying to
accomplish, and why this is a good way to do it rather than some other
patch.

IMHO the most important "why" here is that there currently is no way to
specify a local smtp server program without using a full path.

I think this is a good direction to fix it, though for anybody just
seeing this patch, I'd call attention to the nearby thread (and the one
it links to):

  https://lore.kernel.org/git/YJrH8uqzapnpNEsb@gpanders.com/

>  git-send-email.perl | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

We'd probably want a test here, as well; see t/t9001-send-email.sh.

We implicitly test the absolute-path behavior in that script because
pass "--smtp-server=$(pwd)/fake.sendmail" in lots of places. But we'd
probably want a new test block that checks that:

  PATH=$(pwd):$PATH \
  git send-email --smtp-server="!fake.sendmail"

does what you expect.

-Peff
