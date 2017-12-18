Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B50B1F406
	for <e@80x24.org>; Mon, 18 Dec 2017 06:40:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751110AbdLRGkp (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Dec 2017 01:40:45 -0500
Received: from cloud.peff.net ([104.130.231.41]:41936 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750773AbdLRGkp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Dec 2017 01:40:45 -0500
Received: (qmail 16666 invoked by uid 109); 18 Dec 2017 06:40:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 18 Dec 2017 06:40:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24143 invoked by uid 111); 18 Dec 2017 06:41:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Mon, 18 Dec 2017 01:41:09 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Dec 2017 01:40:42 -0500
Date:   Mon, 18 Dec 2017 01:40:42 -0500
From:   Jeff King <peff@peff.net>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Yaroslav Halchenko <yoh@onerussian.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>, kyle@kyleam.com
Subject: Re: Q: rational for $XDG_CONFIG_HOME/git/config to be "non global"
 or just a bug?
Message-ID: <20171218064042.GA25733@sigill.intra.peff.net>
References: <20171211211102.rrxqd6yscnd33efd@hopa.kiewit.dartmouth.edu>
 <20171211225615.GC214273@aiede.mtv.corp.google.com>
 <xmqqtvww3gea.fsf@gitster.mtv.corp.google.com>
 <20171216220120.GB6217@genre.crustytoothpaste.net>
 <CA+P7+xpFyD0zuOz7XSCc6cV1T1zu6j-gZD=EMQs-t2WPxi1EMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+P7+xpFyD0zuOz7XSCc6cV1T1zu6j-gZD=EMQs-t2WPxi1EMA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 17, 2017 at 08:03:41PM -0800, Jacob Keller wrote:

> I do find it a bit weird that --global writes to one of either file,
> and doesn't read from both. I'd rather have --global "only" be
> .gitconfig, and instead add a new option for handling XDG file, and
> then have it such that it reads them in system -> xdg ->
> home/.gitconfig -> local, which allows for local .gitconfig to
> override XDG config, but logically treat them just like we do any
> other files.

I find it weird, too, but I'm not sure that's the right direction. It
means that users have to start caring about using "--xdg" instead of
"--global" if that's what they want to write to. The original idea was
that the transition to xdg should be fairly seamless, and that --global
would be an abstraction over both.

To complete that abstraction it seems like reading via "--global" should
read from both (in the same precedence order that normal config lookup
uses). If you only use one, there wouldn't be any change in behavior.
And if you use both, then the behavior makes sense as a subset of the
normal config lookup. I.e., it could even be explained as:

  If you give no "source", normal config lookup is similar to checking
  "--system", then "--global", then "--local".

The only person who might be affected is somebody who carries both files
_and_ really wanted "--global" to read from one specific file (though I
have no idea from which without looking at the source, and from reading
this thread it seems I am not the only one who would be confused). So
I'd be OK calling that an unintended and unsupported behavior, and the
right thing all along should have been to use "--file=" if you really
want to avoid "--global" automagic.

-Peff
