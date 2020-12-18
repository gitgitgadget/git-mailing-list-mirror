Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F83C4361B
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 05:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6FF123A79
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 05:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgLRF52 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 00:57:28 -0500
Received: from cloud.peff.net ([104.130.231.41]:37446 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725298AbgLRF51 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 00:57:27 -0500
Received: (qmail 10227 invoked by uid 109); 18 Dec 2020 05:56:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 18 Dec 2020 05:56:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11551 invoked by uid 111); 18 Dec 2020 05:56:48 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 18 Dec 2020 00:56:48 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 18 Dec 2020 00:56:46 -0500
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/1] Hashed mailmap support
Message-ID: <X9xEnpLeZ4mCjwWF@coredump.intra.peff.net>
References: <20201213010539.544101-1-sandals@crustytoothpaste.net>
 <X9gV3mKwGrHL7PzV@coredump.intra.peff.net>
 <X9wUGaR3IXcpV0nT@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <X9wUGaR3IXcpV0nT@camp.crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 18, 2020 at 02:29:45AM +0000, brian m. carlson wrote:

> > And from that argument, I think the obvious question becomes: is it
> > worth using a real one-way function, as opposed to just obscuring the
> > raw bytes (which Ævar went into in more detail). I don't have a strong
> > opinion either way (the obvious one in favor is that it's less expensive
> > to do so; and something like "git log" will have to either compute a lot
> > of these hashes, or cache the hash computations internally).
> [...]
> So I think I'm firmly in favor of hashing.  If that means my patch needs
> to implement caching, then I'll reroll with that change.  I think by
> switching to a hash table I may be able to actually improve total
> performance overall, at least in some cases.

OK. I agree it raises the bar a little bit. Whether that matters or not
depends on your threat model (e.g., casual spammers versus dedicated
information seekers). I don't have a particularly strong opinion on
what's realistic, but I don't mind erring on the side of caution here.

It might be worth making a short argument along those lines in the
commit message.

As far as caching goes, my main concern is mostly that people who are
not using the feature do not pay a performance penalty. So:

  - if the feature is not used in the repository's mailmap, it should
    have zero cost (i.e., we do not bother hashing lookup entries if
    there are no hashed entries in the map)

  - as soon as there is one hashed entry, we need to hash the key for
    every lookup in the map. I'm not sure what the overhead is like. It
    might be negligible. But I think we should confirm that before
    proceeding.

> And as someone who had to download all 21 GB of the Chromium repository
> for testing purposes recently, I can tell you that absent a very
> compelling use case, nobody's going to want to download that entire
> repository just to extract some personal information, especially since
> the git index-pack operation is essentially guaranteed to take at least
> 7 minutes at maximum speed.  So by hashing, we've guaranteed significant
> inconvenience unless you have the repository, whereas that's not the
> case for base64.  And making abuse even slightly harder can often deter
> a surprising amount of it[0].

They just need the objects that have ident lines in them, so:

  $ time git clone --bare --filter=tree:0 https://github.com/chromium/chromium
  Cloning into bare repository 'chromium.git'...
  remote: Enumerating objects: 202, done.
  remote: Counting objects: 100% (202/202), done.
  remote: Compressing objects: 100% (161/161), done.
  remote: Total 1105453 (delta 49), reused 194 (delta 41), pack-reused 1105251
  Receiving objects: 100% (1105453/1105453), 462.14 MiB | 11.13 MiB/s, done.
  Resolving deltas: 100% (99790/99790), done.
  
  real	0m49.304s
  user	0m21.330s
  sys	0m4.727s

gets you there much quicker. I don't think that negates your point about
raising the bar, but my guess is that the threat model of "casual
spammer" would probably be deterred, but "troll who wants to annoy
specific person" would probably not be.

-Peff
