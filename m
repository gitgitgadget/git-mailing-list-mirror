Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62ABC1FBB0
	for <e@80x24.org>; Thu,  1 Dec 2016 19:59:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934128AbcLAT7G (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 14:59:06 -0500
Received: from cloud.peff.net ([104.130.231.41]:50104 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757037AbcLAT7F (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 14:59:05 -0500
Received: (qmail 12953 invoked by uid 109); 1 Dec 2016 19:59:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Dec 2016 19:59:05 +0000
Received: (qmail 3012 invoked by uid 111); 1 Dec 2016 19:59:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Dec 2016 14:59:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Dec 2016 14:59:02 -0500
Date:   Thu, 1 Dec 2016 14:59:02 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        sbeller@google.com, bburky@bburky.com, jrnieder@gmail.com
Subject: Re: [PATCH v6 4/4] transport: check if protocol can be used on a
 redirect
Message-ID: <20161201195902.td4zfolqpc3uwfgq@sigill.intra.peff.net>
References: <1478555462-132573-1-git-send-email-bmwill@google.com>
 <1480621447-52399-1-git-send-email-bmwill@google.com>
 <1480621447-52399-5-git-send-email-bmwill@google.com>
 <20161201195031.fd4uwmvkyhk4so7i@sigill.intra.peff.net>
 <xmqqbmwva0im.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbmwva0im.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 01, 2016 at 11:54:09AM -0800, Junio C Hamano wrote:

> > I'm not sure if we should call this "redirect" here. That's how it's
> > used by the curl code, but I think from the perspective of the transport
> > whitelist, it is really "are you overriding the from_user environment".
> >
> > Calling it "from_user" may be confusing though, as the default value
> > would become "1", even though it means only "as far as I know this is
> > from the user, but maybe the environment says otherwise". So bizarrely,
> > I think calling it "not_from_user" is the clearest value.
> 
> Bikeshedding: perhaps call it "unsafe" (in the sense that it is "not
> known to be safe")?

That is definitely what we are going for, but it is vague about how it
is unsafe. :)

I think I may have converted Brandon in the other thread to my way of
thinking of it as a tristate[1]. That lets us call it "from_user", and
just do:

  case PROTOCOL_ALLOW_FROM_USER:
	if (from_user < 0)
		from_user = git_env_bool("GIT_PROTOCOL_FROM_USER", 1);
	return from_user;

which is pretty clear. Nobody would ever pass "1" as from_user to the
function, but it does the sensible thing if they do.

-Peff

[1] The original I posted calling it "redirect" was totally bogus
    because the logic between the two names is inverted.
