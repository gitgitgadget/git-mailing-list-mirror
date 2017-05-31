Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B223A2027C
	for <e@80x24.org>; Wed, 31 May 2017 04:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750954AbdEaEny (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 00:43:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:60375 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750911AbdEaEnx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 00:43:53 -0400
Received: (qmail 14387 invoked by uid 109); 31 May 2017 04:43:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 31 May 2017 04:43:50 +0000
Received: (qmail 1642 invoked by uid 111); 31 May 2017 04:44:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 31 May 2017 00:44:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 31 May 2017 00:43:49 -0400
Date:   Wed, 31 May 2017 00:43:49 -0400
From:   Jeff King <peff@peff.net>
To:     Philip Oakley <philipoakley@iee.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?RsOpbGl4?= Saparelli <felix@passcod.name>,
        git@vger.kernel.org
Subject: Re: [Non-Bug] cloning a repository with a default MASTER branch
 tries to check out the master branch
Message-ID: <20170531044349.bcb6jlte5gmo6p6v@sigill.intra.peff.net>
References: <xmqqa864mea3.fsf@gitster.mtv.corp.google.com>
 <76BD8B6A1511438B8CCB79C616F3BC5B@PhilipOakley>
 <20170524141947.2gguzcvyu6lch373@sigill.intra.peff.net>
 <xmqqshjtg1kh.fsf@gitster.mtv.corp.google.com>
 <xmqqa861fx34.fsf@gitster.mtv.corp.google.com>
 <20170525155924.hk5jskennph6tta3@sigill.intra.peff.net>
 <20170525191115.tqd6zlj5mxqls4wp@sigill.intra.peff.net>
 <CEF93B59EA3F49608B41892952454B1D@PhilipOakley>
 <xmqqh905c0tm.fsf@gitster.mtv.corp.google.com>
 <48CB2547397B471C99F54CFB3F113C3F@PhilipOakley>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <48CB2547397B471C99F54CFB3F113C3F@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 28, 2017 at 12:21:50PM +0100, Philip Oakley wrote:

> > Are you aware of the symref capability that is already advertised in
> > the initial upload-pack response?  Right now, we do so only when
> > HEAD actually points at something, and the earlier suggestion by
> > Peff is to do so unconditionally, even when HEAD is dangling.
> 
> The suggestion is the otherway around. I would argue (as a viewpoint) that
> what we advertise are object IDs and their associated refs, sorted by ref
> name. (I'm thinking of the git/Documentation/technical/pack-protocol.txt
> here). My suggestion was that when we get to the sorted ref that HEAD points
> to (including the unborn oid) that we annotate that ref.

It's hard to do that in a backwards-compatible way. The reason the
symref capability works like it does (and supports only HEAD) is that
the bits after the NUL are treated as a capability string, and older
clients will actually _replace_ any earlier capability string they saw
with the new one. So:

  1234abcd refs/heads/a\0symref=refs/heads/target1
  5678abcd refs/heads/b\0symref=refs/heads/target2

doesn't work as you'd like.

But even if it did, I don't think that solves the dangling symref
problem by itself. As you note, we'd need to advertise a null sha1 line
and annotate that. I didn't test, but I'd suspect that's another
compatibility problem; clients will probably choke on the null sha1.

> I didn't quite follow Peff's suggestion as to where the list change
> went and if that was a protocol change.

The current protocol just advertises symref=source:target in the
capability line, where "source" does not have to be the ref that is
currently being advertised at all. So you are free to do:

  1234abcd refs/heads/unrelated\0...symref=HEAD:refs/heads/target

But the server does not bother to do so when the HEAD symref doesn't
point to anything. We could fix that without changing the protocol
syntax. It's possible that some picky client would complain that we
mentioned the HEAD symref even though it was not advertised, but
certainly older git.git clients are fine with it. They'd still need a
client-side update in order to do something useful with it, but at least
its presence would not make older clients behave any worse.

-Peff
