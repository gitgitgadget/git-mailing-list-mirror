Return-Path: <SRS0=PlGQ=4G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDED2C34031
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 05:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A42B920722
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 05:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbgBRFkL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Feb 2020 00:40:11 -0500
Received: from cloud.peff.net ([104.130.231.41]:46550 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725909AbgBRFkL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Feb 2020 00:40:11 -0500
Received: (qmail 14501 invoked by uid 109); 18 Feb 2020 05:40:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 18 Feb 2020 05:40:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14632 invoked by uid 111); 18 Feb 2020 05:49:10 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 Feb 2020 00:49:10 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 18 Feb 2020 00:40:09 -0500
From:   Jeff King <peff@peff.net>
To:     Drew DeVault <sir@cmpwn.com>
Cc:     git@vger.kernel.org, Stefan Beller <stefanbeller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] send-pack: downgrade push options error to warning
Message-ID: <20200218054009.GD1641086@coredump.intra.peff.net>
References: <20200217144432.43920-1-sir@cmpwn.com>
 <20200217144432.43920-2-sir@cmpwn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200217144432.43920-2-sir@cmpwn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 17, 2020 at 09:44:32AM -0500, Drew DeVault wrote:

> Because the receiving end has to explicitly enable
> receive.advertisePushOptions, and many servers don't, it doesn't make
> sense to set push options globally when half of your pushes are just
> going to die.

This makes me a little nervous, because we don't know what those push
options were supposed to do. Yet we'll proceed with the push minus the
options, which might perform an action that it's hard for the user to
undo. Imagine something as harmless as an option to suppress
notifications to your teammates about a push, or something as dangerous
as one that changes how the push will do an auto-deploy to a production
service.

That latter is probably unlikely, but it feels like we ought to be
erring on the conservative side here, especially since we've had the old
behavior for so many versions.

I do agree that setting push.pushOptions in your global gitconfig is
probably going to be annoying. Even in the repo .git/config, you might
push to multiple remotes, only some of which support the options.

So perhaps it would make sense to do one or both of:

 - allow remote.*.pushOptions for specific remotes

 - add a push.pushOptionIfAble key which behaves similarly to
   push.pushOption, but is quietly ignored if options aren't supported.
   Then you could put options there that you know are safe to be
   ignored.

I'm not sure exactly what kinds of options you want be setting globally,
so I'm not sure which of those would be more useful.

-Peff
