Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05FB91F428
	for <e@80x24.org>; Sat, 30 Dec 2017 14:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750888AbdL3Ovr (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Dec 2017 09:51:47 -0500
Received: from cloud.peff.net ([104.130.231.41]:49608 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750828AbdL3Ovq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Dec 2017 09:51:46 -0500
Received: (qmail 29021 invoked by uid 109); 30 Dec 2017 14:51:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 30 Dec 2017 14:51:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4101 invoked by uid 111); 30 Dec 2017 14:52:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Sat, 30 Dec 2017 09:52:15 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 30 Dec 2017 09:51:44 -0500
Date:   Sat, 30 Dec 2017 09:51:44 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Ernesto Alfonso <erjoalgo@gmail.com>, git@vger.kernel.org
Subject: Re: possible completion bug with --set-upstream-to=
Message-ID: <20171230145143.GB29252@sigill.intra.peff.net>
References: <87bmih83iu.fsf@gmail.com>
 <20171230082806.6303-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20171230082806.6303-1-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 30, 2017 at 09:28:06AM +0100, SZEDER Gábor wrote:

> I couldn't reproduce the wrong behavior you saw using v2.1.4 in a
> regular setup.
>  
> However, I could reproduce it after I removed the '=' character from
> the set of characters in $COMP_WORDBREAKS, but then all completions
> after an '--option=' are affected, e.g. 'pulseaudio --daemonize=t<TAB>
> becomes 'pulseaudio true', too.

I can reproduce here on my Debian unstable system.

> Could you tell us the content of your $COMP_WORDBREAKS using the
> output of the following command (to make the included space, tab and
> newline visible):
> 
>   printf "$COMP_WORDBREAKS" |tr ' \t\n' STN ; echo
> 
> If it's indeed the case that $COMP_WORDBREAKS is missing the '=', then
> you should add it back and check whether it fixed the issue.  If it
> did fix it, then you should try to figure out how the '=' got removed
> from there.  Perhaps you used a program that ships its own completion
> script whose developers changed $COMP_WORDBREAKS to their liking, not
> knowing about its effect on other completion scripts.

Looks like the system npm completion is the culprit:

  $ grep COMP_WORDBREAKS /etc/bash_completion.d/*
  /etc/bash_completion.d/npm:COMP_WORDBREAKS=${COMP_WORDBREAKS/=/}
  /etc/bash_completion.d/npm:COMP_WORDBREAKS=${COMP_WORDBREAKS/@/}
  /etc/bash_completion.d/npm:export COMP_WORDBREAKS

  $ dpkg -S /etc/bash_completion.d/npm
  npm: /etc/bash_completion.d/npm

Looks like there's already a bug filed:

  https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=711810

Sadly there's even a patch which was taken upstream, but the debian
packaged version of npm is just woefully out of date.

-Peff
