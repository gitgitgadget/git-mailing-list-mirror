Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9961E2022D
	for <e@80x24.org>; Fri, 24 Feb 2017 01:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751380AbdBXBI0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 20:08:26 -0500
Received: from cloud.peff.net ([104.130.231.41]:33119 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751290AbdBXBI0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 20:08:26 -0500
Received: (qmail 2170 invoked by uid 109); 24 Feb 2017 01:08:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Feb 2017 01:08:25 +0000
Received: (qmail 8729 invoked by uid 111); 24 Feb 2017 01:08:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Feb 2017 20:08:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Feb 2017 20:08:23 -0500
Date:   Thu, 23 Feb 2017 20:08:23 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     bs.x.ttp@recursor.net, git@vger.kernel.org
Subject: Re: [PATCH 4/4] ident: do not ignore empty config name/email
Message-ID: <20170224010823.my4wmdyezjuqajfx@sigill.intra.peff.net>
References: <20170223081157.hwfn3msfux5udmng@sigill.intra.peff.net>
 <20170223081708.ge34zjkmpsolocqx@sigill.intra.peff.net>
 <xmqqfuj47hfk.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfuj47hfk.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 23, 2017 at 12:58:39PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > This one is perhaps questionable. Maybe somebody is relying on setting a
> > per-repo user.name to override a ~/.gitconfig value and enforce
> > auto-detection?
> 
> Thanks for splitting this step out.  1/4 and 2/4 are obvious
> improvements, and 3/4 is a very sensible fix.  Compared to those
> three, this one does smell questionable, because I do not quite see
> any other reasonable fallback other than the auto-detection if the
> user gives an empty ident on purpose.

The outcomes are basically:

  1. In strict mode (making a commit, etc), we'll die with "empty name
     not allowed". My thinking was that this is less confusing for the
     user.

  2. In non-strict mode, we'd use a blank name instead of trying your
     username (or dying if you don't have an /etc/passwd entry).

> Erroring out to say "don't do that" is probably not too bad, but
> perhaps we are being run by a script that is doing a best-effort
> conversion from $ANOTHER_SCM using a list of known authors that is
> incomplete, ending up feeding empty ident and allowing us to fall
> back to attribute them to the user who runs the script.  I do not
> see a point in breaking that user and having her or him update the
> script to stuff in a truly bogus "Unknown <unknown>" name.

Keep in mind this _only_ affects Git's config variables. So a script
feeding git via GIT_AUTHOR_NAME, etc, shouldn't change at all with this
code. If your script is doing "git -c user.name=whatever commit", I
think you should reconsider your script. :)

So I dunno. I could really go either way on it. Feel free to drop it, or
even move it into a separate topic to be cooked longer.

-Peff
