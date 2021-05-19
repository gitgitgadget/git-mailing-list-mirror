Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B8FC433ED
	for <git@archiver.kernel.org>; Wed, 19 May 2021 11:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A6DB61004
	for <git@archiver.kernel.org>; Wed, 19 May 2021 11:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349560AbhESLvP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 07:51:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:58982 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235741AbhESLvP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 07:51:15 -0400
Received: (qmail 23041 invoked by uid 109); 19 May 2021 11:49:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 19 May 2021 11:49:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19371 invoked by uid 111); 19 May 2021 11:49:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 19 May 2021 07:49:55 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 19 May 2021 07:49:54 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Ben Humphreys <behumphreys@atlassian.com>,
        Junio C Hamano <gitster@pobox.com>,
        Christopher Schenk <christopher@cschenk.net>,
        git@vger.kernel.org
Subject: Re: Git 2.23.0-rc0 HTTP authentication failure - error message change
Message-ID: <YKT7Ynfc3F4egWwR@coredump.intra.peff.net>
References: <YKMvePOPqjwiXeQ+@C02WD045HTDG>
 <YKNVop80H8xSTCjz@coredump.intra.peff.net>
 <YKRYBLeIlgILfHFj@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YKRYBLeIlgILfHFj@camp.crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 19, 2021 at 12:12:52AM +0000, brian m. carlson wrote:

> > But imagine we didn't get a username/password in the URL. The first
> > request will return REAUTH because of this moved code path (just as it
> > would have before, because http.auth.{username,password} are not set).
> > And then we'll get a credential from the user or from a helper and try
> > again. But this time, if we fail, we'll return HTTP_REAUTH again! We
> > never hit the "if (http_auth.username && http_auth.password)" check at
> > all. And hence we never return HTTP_NOAUTH (which gives us the more
> > useful "authentication failed" message), nor the credential_reject()
> > line (which informs helpers to stop caching a known-bad password).
> 
> I think what we'd want to do in this case is to only call HTTP_REAUTH if
> we actually cleared CURLAUTH_GSSNEGOTIATE.  Maybe something like this:
> [...]

Yeah, that was my instinct, too, but...

> > I suspect we could hack around it by pessimistically guessing that
> > GSSNEGOTIATE was the problem. But I'm worried that making that work
> > would require up to three requests (one to find out we need auth, one to
> > remove the GSSNEGOTIATE bit, and one to retry with a username/password).
> > That seems like punishing people with servers that don't even care about
> > Negotiate for no reason.
> 
> I think my proposal above does that, but I'm not sure.  If Negotiate
> wasn't set, we won't need to make a third request, since we'll have
> known the supported mechanisms as part of the original 401.  If they do
> support both, then three requests will be required if they have to fall
> back to Basic auth, but then they're only paying the price for the
> environment they have.
> 
> If we aren't already reading the supported mechanisms out of the initial
> 401, then we'll need the third request, but that would be silly and we
> should just avoid doing that.

Yeah, I was worried that just clearing the bit results in the extra
round-trip. I think we do clear bits based on what the other side showed
us. That's the:

  http_auth_methods &= results->auth_avail;

in the code being discussed. But it seems like we'd want to do that as
part of setting the "used negotiate" flag in your sample patch. I.e.,:

  if (http_auth_methods & results->auth_avail & CURLAUTH_GSSNEGOTIATE)
          used_negotiate = 1;

But it's entirely possible I don't understand the subtleties around
unsetting GSSNEGOTIATE in the first place (it's not something I've ever
used myself).

> > So perhaps somebody can come up with something clever, but I suspect we
> > may need to just revert this for the v2.32 release, and re-break the
> > case that 1b0d9545bb8 was trying to solve.
> 
> Yeah, I think this is the right solution for the problem until somebody
> with a suitable mixed auth environment shows up and can test.  Your
> patches seemed reasonable and, as always, well explained.

Thanks for taking a look!

-Peff
