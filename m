Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2742C35280
	for <git@archiver.kernel.org>; Thu,  7 May 2020 22:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A748D20870
	for <git@archiver.kernel.org>; Thu,  7 May 2020 22:24:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgEGWYa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 18:24:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:41132 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726437AbgEGWYa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 May 2020 18:24:30 -0400
Received: (qmail 3465 invoked by uid 109); 7 May 2020 22:17:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 May 2020 22:17:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22685 invoked by uid 111); 7 May 2020 22:17:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 May 2020 18:17:53 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 7 May 2020 18:17:48 -0400
From:   Jeff King <peff@peff.net>
To:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [PATCH 0/4] credential: documentation updates for maint
Message-ID: <20200507221748.GA41996@coredump.intra.peff.net>
References: <20200503063423.83152-1-carenas@gmail.com>
 <20200505013908.4596-1-carenas@gmail.com>
 <20200506162712.GB1275237@coredump.intra.peff.net>
 <20200506232848.GB75901@Carlos-MBP>
 <20200507205909.GA38308@coredump.intra.peff.net>
 <20200507212348.GA19917@Carlos-MBP>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200507212348.GA19917@Carlos-MBP>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 07, 2020 at 02:23:48PM -0700, Carlo Marcelo Arenas Belón wrote:

> On Thu, May 07, 2020 at 04:59:09PM -0400, Jeff King wrote:
> > On Wed, May 06, 2020 at 04:28:48PM -0700, Carlo Marcelo Arenas Belón wrote:
> > 
> > > Subject: [RFC PATCH 5/4] credential: document encoding assumptions for values
> > > 
> > > Because of the similarity on the names of the keys with what is defined
> > > in RFC3986 is easy to assume the same rules would apply here.
> > > 
> > > Make sure that the format and encoding is well defined to avoid helper
> > > developers assuming incorrectly.
> > 
> > I'm not sure this really clarifies anything, because it just says "no
> > assumptions can be made". Which I guess is a statement, but I'm not sure
> > what I'd do with it as a helper developer.
> 
> not sure what part of the added lines you are referring to but I am happy
> to provide some examples of what I would expect to clarify below from
> what I'd seen from some helpers that I'd read the code from recently.
> 
> as an example, I would expect the helper developer to start checking for
> the locale and calling iconv in cases where it is not using utf-8, before
> sending it to a storage that requires that (ex: osxkeychain), or utf-16
> (maybe in windows).
> 
> osxkeychain will probably also check for protocol in a case insensitive
> way to make sure it is not ignoring credentials that are not all lowercase
> as it does now.

Those things all seem reasonable. I just meant that reading:

  No assumptions of case insensitivity can be made on their contents and
  if a specific encoding is required (e.g. "UTF-8") then the byte
  contents should be re-encoded before use.

didn't point me in a useful direction there. Reading it again, I'm still
not sure if you're trying to say that helpers should match protocols
case-insensitively or not. And TBH, I don't think it matters that much.
It's a quality-of-implementation issue for helpers, and if nobody is
complaining about their behavior, does it really matter? I'd be more
concerned if doing the wrong thing involved a security vulnerability,
but the worst case with case-insensitivity is probably that they _fail_
to match a credential when they should.

Likewise for weird encodings, unless an attacker can somehow come up
with a hostname byte sequence that a helper mistakes for another
legitimate hostname, _and_ that can be used sensibly by git or curl.

-Peff
