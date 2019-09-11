Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A02391F464
	for <e@80x24.org>; Wed, 11 Sep 2019 14:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbfIKOIe (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Sep 2019 10:08:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:46452 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725981AbfIKOIe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Sep 2019 10:08:34 -0400
Received: (qmail 13977 invoked by uid 109); 11 Sep 2019 14:08:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 11 Sep 2019 14:08:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24622 invoked by uid 111); 11 Sep 2019 14:10:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 11 Sep 2019 10:10:31 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 11 Sep 2019 10:08:33 -0400
From:   Jeff King <peff@peff.net>
To:     Konstantinos Dalamagkidis <konstantinos@dalamagkidis.info>
Cc:     git@vger.kernel.org
Subject: Re: git-send-email does not use conditional configuration
Message-ID: <20190911140833.GA13916@sigill.intra.peff.net>
References: <CANTPZbbLNJPEEeG8BgdDEVYS=gudz4SvqGe==28EQHXDXUxuwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANTPZbbLNJPEEeG8BgdDEVYS=gudz4SvqGe==28EQHXDXUxuwQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 11, 2019 at 08:14:45AM +0200, Konstantinos Dalamagkidis wrote:

> In my git configuration, I have an includeif section for work
> related repositories that configures the user and sendemail
> sections.

What kind of includeIf are you using? Does it work with an
unconditional include? This seems to work for me:

  $ git config --global include.path one
  $ git config --file ~/one sendemail.smtpserver one.example.com
  $ git send-email --dry-run -1 --to nobody | grep ^Server
  Server: one.example.com

  $ git config --global includeIf.gitdir:$PWD/.path two
  $ git config --file ~/two sendemail.smtpserver two.example.com
  $ git send-email --dry-run -1 --to nobody | grep ^Server
  Server: two.example.com

I.e. both unconditional and gitdir includes work for me. If you do
something similar, what output do you get?

> I can verify that the configuration is read correctly by git:
> 
> % git config --get-regex "sendemail.*"
> sendemail.smtpencryption tls
> sendemail.smtpserver smtp.office365.com
> sendemail.smtpserverport 587
> sendemail.smtpuser dalamagkidis@work.com

Thanks for this output. That rules out that "git config" is somehow
misbehaving in a way that normal internal config lookups wouldn't.

The rest of git-config should behave the same, but you could also try:

  git config --get sendemail.smtpserver

which is what send-email will actually run (you can run send-email with
GIT_TRACE=1 to see the full set of commands if you want to try them
manually).

-Peff
