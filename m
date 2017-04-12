Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B2391FA14
	for <e@80x24.org>; Wed, 12 Apr 2017 13:02:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754077AbdDLNB4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Apr 2017 09:01:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:60618 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753461AbdDLNBy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2017 09:01:54 -0400
Received: (qmail 18950 invoked by uid 109); 12 Apr 2017 13:01:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 12 Apr 2017 13:01:48 +0000
Received: (qmail 12136 invoked by uid 111); 12 Apr 2017 13:02:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 12 Apr 2017 09:02:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Apr 2017 09:01:45 -0400
Date:   Wed, 12 Apr 2017 09:01:45 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Danny Sauer <danny@dannysauer.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Make git log work for git CWD outside of work tree
Message-ID: <20170412130145.jjnyait5234qsmys@sigill.intra.peff.net>
References: <20170409022128.21337-1-danny@dannysauer.com>
 <alpine.DEB.2.20.1704091238560.4268@virtualbox>
 <413a1456-cac6-56c8-ea45-38f14cf958ae@dannysauer.com>
 <xmqqvaqdqfhe.fsf@gitster.mtv.corp.google.com>
 <CACsJy8CLBY22j3EjR4PW3n+K6PWUzb-HCgxTVeCGpwtApZF-6g@mail.gmail.com>
 <20170410171352.s7r7tzheadxjlulw@sigill.intra.peff.net>
 <CACsJy8B8osxd-0axJ9giaMYKuict2h1zW8TcYYuRFGXfBbdF0A@mail.gmail.com>
 <xmqqy3v6ow54.fsf@gitster.mtv.corp.google.com>
 <CACsJy8DPFzgxqvPzpMbmoM4sMP7oSZ=eO6DJa+dv4sY=QKHjoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8DPFzgxqvPzpMbmoM4sMP7oSZ=eO6DJa+dv4sY=QKHjoA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 12, 2017 at 06:13:49PM +0700, Duy Nguyen wrote:

> > Can't we model this after how setup_git_directory_gently() gives the
> > subcommands a choice?  While the majority of subcommands do not call
> > the _gently() variant and die when we are not in a repository, the
> > rest do use it and continue after learning that they are outside a
> > repository.
> 
> It may work, but we need to be careful because paths as command line
> arguments will not be relative to cwd anymore. If some code assumes
> cwd unchanged, they're in trouble. I guess they're in trouble either
> way because of the "sometimes chdir, sometimes not" current behavior.

Exactly. The code itself must respect "prefix", and if it doesn't, it's
broken. So I don't think a code switch makes any sense here. It's not
the code which needs to care, it's the user who might be relying on the
externally visible behavior.

I can't think of a case where the existing behavior actually makes sense
for the user, though. They've provided a $GIT_WORK_TREE, but somehow
want their out-of-worktree relative paths to still work? What are they
using the paths for? Surely:

  cd /out-of-tree
  echo content >foo
  GIT_DIR=/repo/.git GIT_WORK_TREE=/repo git add foo

shouldn't work?

Likewise reading .mailmap and .gitattributes from /out-of-tree is simply
a bug.

I dunno. Maybe I am missing some subtle case, but it's not clear to me
what the user would be trying to do by having git stay in the original
directory.

-Peff
