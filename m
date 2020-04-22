Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55330C38A30
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 04:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3926A206EC
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 04:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbgDVEGp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 00:06:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:35454 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725810AbgDVEGp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Apr 2020 00:06:45 -0400
Received: (qmail 2687 invoked by uid 109); 22 Apr 2020 04:06:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 22 Apr 2020 04:06:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26271 invoked by uid 111); 22 Apr 2020 04:17:50 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 22 Apr 2020 00:17:50 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 22 Apr 2020 00:06:44 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, Ilya Tretyakov <it@it3xl.ru>,
        "brian m. carlson" <bk2204@github.com>, git@vger.kernel.org
Subject: Re: Credential helpers are no longer invoked in case of having
 sub-folder parts in a repository URL. Since 2.26.1 version
Message-ID: <20200422040644.GC3559880@coredump.intra.peff.net>
References: <CAOrRacVviJP3w98-=QpFKYp630cN3gZQYnvAWZXeKqZRk2UDXg@mail.gmail.com>
 <20200421225837.GB3515235@coredump.intra.peff.net>
 <20200422010943.GD6465@camp.crustytoothpaste.net>
 <20200422012817.GD103469@google.com>
 <20200422022020.GF6465@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200422022020.GF6465@camp.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 22, 2020 at 02:20:20AM +0000, brian m. carlson wrote:

> > Thanks.  Here's another (though I haven't tried bisecting yet):
> > 
> > 	echo url='https://github.com/git/git' |
> > 	GIT_TERMINAL_PROMPT=0 \
> > 	git -c credential.helper= \
> > 		-c credential.github.com.helper='!echo username=foo; echo password=bar;:' \
> > 		credential fill
> 
> gitcredentials(7) says the following:
> 
>   Git considers each credential to have a context defined by a URL.
>   This context is used to look up context-specific configuration, and is
>   passed to any helpers, which may use it as an index into secure
>   storage.
> 
> I'm not sure a hostname qualifies as a URL in this case.  So while my
> patch did break this, I don't believe it's ever been documented to
> actually work and was an artifact of our implementation (along with
> "credential./git/git.helper" and "credential.https://.helper").  I've
> also never seen this syntax used in the wild, but maybe I'm not looking
> in the right places.

I'm pretty sure it was an intended use case, though it is a natural
outcome of the credential_match() strategy of "unspecified things match
anything". I'd suspect that anybody relying on it is doing so
unintentionally, and just forgot to put the protocol field in. Though I
suppose doing so would let you cover http/https in a single block.

At any rate, even in versions _without_ your patch, that became a hard
error in this week's release. In v2.24.3, for example:

  $ echo url=https://anyhost.example.com |
    git -c credential.example.com.username=foo credential fill
  warning: url has no scheme: example.com
  fatal: credential url cannot be parsed: example.com

because we're relying there on credential_from_url() to parse the config
credentials, too. After your patch, we use the http-config machinery,
which simply doesn't match.

> I don't think we can shoehorn it into urlmatch, since that would break
> compatibility with the `http.*` config options, so I think we'd have to
> revert the entire feature if we want to preserve it.  I think I'd prefer
> to leave things as it is since it seems uncommon and there are easy
> alternatives, but if folks prefer, I can send a patch to revert the
> urlmatch feature.

I agree that we should leave it. Aside from the dual http/https thing
(which _hopefully_ is rare these days as https become more of a
standard), I don't think it has a legitimate use case. And I think we
should be pushing users to be a bit more careful with their url config.

-Peff
