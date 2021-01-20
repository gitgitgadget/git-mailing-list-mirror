Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 898C3C433E6
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 14:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BFA82245C
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 14:38:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390341AbhATOhc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 09:37:32 -0500
Received: from cloud.peff.net ([104.130.231.41]:32782 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390735AbhATOgf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 09:36:35 -0500
Received: (qmail 25582 invoked by uid 109); 20 Jan 2021 14:35:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 20 Jan 2021 14:35:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21778 invoked by uid 111); 20 Jan 2021 14:35:46 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 20 Jan 2021 09:35:46 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 20 Jan 2021 09:35:45 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Harley Paterson <harley.paterson@hotmail.co.nz>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: False negative authentication with multiple accounts on a
 SSH-GIT server
Message-ID: <YAg/wV05JYbzOdck@coredump.intra.peff.net>
References: <DB8P189MB10460B9A3CA31ADF5C05A39FF9A30@DB8P189MB1046.EURP189.PROD.OUTLOOK.COM>
 <YAdnJabiJlu9Qlli@camp.crustytoothpaste.net>
 <87im7r93u7.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87im7r93u7.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 20, 2021 at 01:42:56PM +0100, Ævar Arnfjörð Bjarmason wrote:

> > Unfortunately, this leaks whether a repository exists.  If Company XYZ
> > has a repository for each of its clients, it then becomes easy to see if
> > Company XYZ is doing work for a particular client by trying to see if a
> > repository exists.
> 
> I wonder how many hosting providers are confident that the code involved
> in this isn't vulnerable to a timing attack.

I would say "not very certain" in the case of GitHub. I don't recall any
analysis of the timing ever having happened.

> Why would a site like GitHub treat ssh differently than https here? I
> think it just comes down to openssh's support for use-case being a bit
> of a pain to configure.

GitHub doesn't use openssh at all; ssh sessions are terminated at a
custom load-balancing/proxy layer daemon.

I agree that servers in general probably could accept this notion of "no
valid user" for ssh sessions. I just think it's something that nobody
has asked for. I.e., if you are not planning to be an authenticated
user, then why use ssh in the first place? Certainly you could ask "why
not", but AFAIK this is the first time it has come up.

There is one protocol issue I'm not sure of, though. My understanding of
ssh auth is that the client offers keys in sequence, and the server says
"yes" or "no" on each. We'd want to continue saying "no" on keys that we
don't know about, so the client may keep trying other keys to which we
might say "yes". But after having seen all of the keys, what then?

We would want the server to say "OK, even though we don't like any of
your keys, let's start a session anyway". Is that possible within the
protocol? I think having the server say "OK, now try password auth" is
not a good idea. If the client asks for a dummy password, that is likely
to be either confusing, or disrupt sessions without a human present.

But I don't know the ssh protocol very well, so perhaps my understanding
of what is possible totally wrong. https has this much easier because
unauthenticated requests are totally normal, and the server sees the
auth along with the whole request at the same time.

-Peff
