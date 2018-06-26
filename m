Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C67661F516
	for <e@80x24.org>; Tue, 26 Jun 2018 18:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752206AbeFZS1m (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 14:27:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:55722 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751155AbeFZS1m (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 14:27:42 -0400
Received: (qmail 29283 invoked by uid 109); 26 Jun 2018 18:27:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 26 Jun 2018 18:27:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32196 invoked by uid 111); 26 Jun 2018 18:28:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 26 Jun 2018 14:28:01 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Jun 2018 14:27:40 -0400
Date:   Tue, 26 Jun 2018 14:27:40 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [BUG] url schemes should be case-insensitive
Message-ID: <20180626182739.GA28358@sigill.intra.peff.net>
References: <20180624085622.GA28575@sigill.intra.peff.net>
 <xmqqvaa6ohiw.fsf@gitster-ct.c.googlers.com>
 <20180626122143.GA14052@sigill.intra.peff.net>
 <xmqq1sctmq3d.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1sctmq3d.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 26, 2018 at 10:09:58AM -0700, Junio C Hamano wrote:

> > It may also interact in a funny way with our allowed-protocol code, if
> > "SSH" gets a pass as "ssh" under the default config, but actually runs
> > the otherwise-disallowed git-remote-SSH (though one would _hope_ if you
> > have such a git-remote-SSH that it behaves just like an ssh remote).
> 
> True.  I did not offhand recall how protocol whitelist matches the
> protocol name with config, but transport.c::get_protocol_config()
> seems to say that the <name> part of "protocol.<name>.allow" is case
> sensitive, and we match known-safe (and known-unsafe "ext::")
> protocols with strcmp() not strcasecmp().  We need to figure out the
> implications of allowing SSH:// not to error out but pretending as
> if it were ssh:// on those who have protocol.ssh.allow defined.

That function is actually a little tricky, because we feed it mostly
from string literals (so we end up in the ssh code path, and then feed
it "ssh"). But I think for remote-helpers we feed it literally from the
URL we got fed.

So yeah, we would not want to allow EXT::"rm -rf /" to slip past the
known-unsafe match. Any normalization should happen before then
(probably right in transport_helper_init).

Come to think of it, that's already sort-of an issue now. If you have a
case-insensitive filesystem, then EXT:: is going to pass this check, but
still run git-remote-ext. We're saved there somewhat by the fact that
the default is to reject unknown helpers in submodules (otherwise, we'd
have that horrible submodule bug all over again).

That goes beyond just cases, too. On HFS+ I wonder if I could ask for
"\u{0200}ext::" and run git-remote-ext.

> > I think it doesn't help much if the user does not know what a remote
> > helper is, or why Git is looking for one.
> 
> True.  
> 
> 	$ git clone SSH://example.com/repo.git
> 	fatal: unable to handle URL that begins with SSH://
> 
> would be clear enough, perhaps?  At least this line of change is a
> small first step that would improve the situation without potential
> to break anybody who has been abusing the case sensitivity loophole.

Yeah, certainly the advice is orthogonal to any behavior changes. The
original report complained of:

  $ git clone SSH://...
  fatal: 'remote-SSH' is not a git command. See 'git --help'.

but since 6b02de3b9d in 2010 we say:

  fatal: Unable to find remote helper for 'SSH'

So I actually wonder if there is something else going on. I find it hard
to believe the OP is using something older than Git v1.7.0. They did
appear to be on Windows, though. Is it possible our ENOENT detection
from start_command() is not accurate on Windows?

-Peff
