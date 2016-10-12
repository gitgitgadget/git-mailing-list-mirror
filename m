Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCD682098A
	for <e@80x24.org>; Wed, 12 Oct 2016 01:53:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754769AbcJLBxv (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 21:53:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:56250 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932739AbcJLBxq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 21:53:46 -0400
Received: (qmail 25672 invoked by uid 109); 12 Oct 2016 01:52:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 12 Oct 2016 01:52:26 +0000
Received: (qmail 16066 invoked by uid 111); 12 Oct 2016 01:52:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Oct 2016 21:52:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Oct 2016 21:52:25 -0400
Date:   Tue, 11 Oct 2016 21:52:25 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Ram Rachum <ram@rachum.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Make `git fetch --all` parallel?
Message-ID: <20161012015224.g2eb24jexepeewob@sigill.intra.peff.net>
References: <CANXboVZvfPkTQ10PWop+LgPFpc2bD3-u-e5ix0itGawiwCxOuQ@mail.gmail.com>
 <CAGZ79kZmrYZqi4+bSkRykn+Upt7bEyZ0N8VhiQ-h8DhSMym-FA@mail.gmail.com>
 <xmqqa8ea7bsh.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kZNvTvk4uZa8xhxZABKtzS9A5HoumJ37AacuZnHaZ4+Xw@mail.gmail.com>
 <20161011225942.tvqbbzxglvu7lldi@sigill.intra.peff.net>
 <CAGZ79kaKOiy-HJboaujXXc66P6CLupteDw4JyPOGetREfz_q_Q@mail.gmail.com>
 <20161012013428.swxmrbyxv2wo37xf@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20161012013428.swxmrbyxv2wo37xf@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 11, 2016 at 09:34:28PM -0400, Jeff King wrote:

> > Ok, time to present data... Let's assume a degenerate case first:
> > "up-to-date with all remotes" because that is easy to reproduce.
> > 
> > I have 14 remotes currently:
> > 
> > $ time git fetch --all
> > real 0m18.016s
> > user 0m2.027s
> > sys 0m1.235s
> > 
> > $ time git config --get-regexp remote.*.url |awk '{print $2}' |xargs
> > -P 14 -I % git fetch %
> > real 0m5.168s
> > user 0m2.312s
> > sys 0m1.167s
> 
> So first, thank you (and Ævar) for providing real numbers. It's clear
> that I was talking nonsense.
> 
> Second, I wonder where all that time is going. Clearly there's an
> end-to-end latency issue, but I'm not sure where it is. Is it startup
> time for git-fetch? Is it in getting and processing the ref
> advertisement from the other side? What I'm wondering is if there are
> opportunities to speed up the serial case (but nobody really cared
> before because it doesn't matter unless you're doing 14 of them back to
> back).

Hmm. I think it really might be just network latency. Here's my fetch
time:

  $ git config remote.origin.url
  git://github.com/gitster/git.git

  $ time git fetch origin
  real    0m0.183s
  user    0m0.072s
  sys     0m0.008s

14 of those in a row shouldn't take more than about 2.5 seconds, which
is still twice as fast as your parallel case. So what's going on?

One is that I live about a hundred miles from GitHub's data center, and
my ping time there is ~13ms. The other side of the country, let alone
Europe, is going to be noticeably slower just for the TCP handshake.

The second is that git:// is really cheap and simple. git-over-ssh is
over twice as slow:

  $ time git fetch git@github.com:gitster/git
  ...
  real    0m0.432s
  user    0m0.100s
  sys     0m0.032s

HTTP fares better than I would have thought, but is also slower:

  $ time git fetch https://github.com/gitster/git
  ...
  real    0m0.258s
  user    0m0.080s
  sys     0m0.032s

-Peff
