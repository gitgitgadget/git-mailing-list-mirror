Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FF5C1FF40
	for <e@80x24.org>; Wed, 14 Dec 2016 22:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933349AbcLNWxg (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Dec 2016 17:53:36 -0500
Received: from cloud.peff.net ([104.130.231.41]:56756 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933121AbcLNWxg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2016 17:53:36 -0500
Received: (qmail 29475 invoked by uid 109); 14 Dec 2016 22:53:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Dec 2016 22:53:02 +0000
Received: (qmail 30047 invoked by uid 111); 14 Dec 2016 22:53:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Dec 2016 17:53:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Dec 2016 17:52:59 -0500
Date:   Wed, 14 Dec 2016 17:52:59 -0500
From:   Jeff King <peff@peff.net>
To:     Blake Burkhart <bburky@bburky.com>
Cc:     git <git@vger.kernel.org>, jrnieder@gmail.com,
        Brandon Williams <bmwill@google.com>, gitster@pobox.com,
        sbeller@google.com
Subject: Re: [PATCH v9 5/5] transport: add from_user parameter to
 is_transport_allowed
Message-ID: <20161214225259.gk4er3v5izxn7kd4@sigill.intra.peff.net>
References: <1480636862-40489-1-git-send-email-bmwill@google.com>
 <1481679637-133137-1-git-send-email-bmwill@google.com>
 <1481679637-133137-6-git-send-email-bmwill@google.com>
 <20161214164050.uxk434kzhw6au4c2@sigill.intra.peff.net>
 <20161214201323.GC20063@google.com>
 <20161214203349.6ym3v2ny2gonovx2@sigill.intra.peff.net>
 <CAP3OtXiOPbAkr5Mn+5tEmZZAZzJXQ4CvtpHCg=wt+k-bi6K2vA@mail.gmail.com>
 <CAP3OtXhH++szRws20MaHt-ftLBMUJuYiTmfL50mOFP4FA4Mn6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP3OtXhH++szRws20MaHt-ftLBMUJuYiTmfL50mOFP4FA4Mn6Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 14, 2016 at 04:29:52PM -0600, Blake Burkhart wrote:

> You may want to set CURLOPT_DEFAULT_PROTOCOL if we don't already. Apparently
> the default value of NULL causes it to make a guess based on the host if no
> protocol is present. But you are discussing a situation where "http://" is
> present, so that doesn't apply.

Cute. I agree it doesn't matter here, where we're sure there's a
protocol specifier at the beginning. It might matter if you instruct git
to use a specific remote-helper, like:

  $ echo 127.0.0.1 ftp.example.com >>/etc/hosts
  $ git clone http::ftp.example.com

which will try to connect via ftp. Of course that's no different than:

  $ git clone http::ftp://example.com

which you can already do.  git-clone sees "http::" and hands it off to
git-remote-http, which then processes the rest of the arguments as it
sees fit (in this case, handing it off to curl).

Prior to these more recent patches I suspect you could do:

  $ git clone http::file://whatever

but now we set CURLOPT_PROTOCOL to restrict it to just http/ftp (so you
can be confusing by asking for http and ending up in curl to do ftp, but
in any such case you could also have just asked for ftp in the first
place).

> Also, I thought we left out ftp because it was deprecated, but I don't
> remember exactly.

I couldn't find anything interesting in the archives (neither the public
list nor git-security). Given how unlikely it is to be used, it does
seem like a good idea to keep it in the "maybe" category, if only
because it decreases the attack surface (and for those following along,
we're just talking about not-from-user uses here, so people sticking a
funny ftp URL in .gitmodules, or redirecting http to ftp, etc).

-Peff
