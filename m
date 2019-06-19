Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E3C41F462
	for <e@80x24.org>; Wed, 19 Jun 2019 03:51:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730249AbfFSDtc (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 23:49:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:59188 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726047AbfFSDtb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 23:49:31 -0400
Received: (qmail 23825 invoked by uid 109); 19 Jun 2019 03:49:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 19 Jun 2019 03:49:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20555 invoked by uid 111); 19 Jun 2019 03:50:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 18 Jun 2019 23:50:20 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Jun 2019 23:49:29 -0400
Date:   Tue, 18 Jun 2019 23:49:29 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Boxuan Li <liboxuan@connect.hku.hk>, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [RFC PATCH] userdiff: ship built-in driver config file
Message-ID: <20190619034929.GA515@sigill.intra.peff.net>
References: <20190617165450.81916-1-liboxuan@connect.hku.hk>
 <488f215a-cb32-db3f-4a45-0062f0f0a0a9@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <488f215a-cb32-db3f-4a45-0062f0f0a0a9@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 18, 2019 at 10:32:47PM +0200, Johannes Sixt wrote:

> Am 17.06.19 um 18:54 schrieb Boxuan Li:
> > The userdiff.c has been rewritten to avoid hard-coded built-in
> > driver patterns. Now we ship
> > $(sharedir)/git-core/templates/userdiff that can be read using
> > git_config_from_file() interface, using a very narrow callback
> > function that understands only diff.*.xfuncname,
> > diff.*.wordregex, and diff.*.regIcase.
> > 
> > Signed-off-by: Boxuan Li <liboxuan@connect.hku.hk>
> > ---
> > A few notes and questions:
> > 1. In [diff "tex"] section, \x80 and \xff cannot be parsed by git config parser.
> > I have no idea why this is happening. I changed them to \\x80 and \\xff as a workaround, which
> > resulted in t4034 failure (See https://travis-ci.org/li-boxuan/git/jobs/546729906#L4679).
> 
> I guess, the idea is to catch bytes of UTF-8 encoded characters as
> regular words.
> 
> The problem is to write such bytes literally into a git-config file and
> still keep the file editable in a portable. Perhaps it is necessary to
> declare the file as CP1252 encoded via .gitattributes, write that part
> of the regexp as [a-zA-Z0-9€-þ], and hope that your text editor writes
> the file acutally as CP1252. ISO8859-1 does not work because \x80 is not
> occupied.

We don't allow octal or hex escapes in config values, though we do allow
common C ones like "\n". Maybe we should support them.

I didn't check whether we actually want the raw bytes here ourselves,
though, or are happy making sure the backslashed forms make it into the
regex parser (it _seems_ like the latter would be what we want, but that
does mean escaping the backslashes so they make it through the config
parser literally).

> > diff --git a/templates/this--userdiff b/templates/this--userdiff
> > new file mode 100644
> > index 0000000000..85114a7229
> > --- /dev/null
> > +++ b/templates/this--userdiff
> 
> Why place this file in .git? To have per-repository diff drivers, we can
> already specify them via 'git config'. This file should be installed in
> the system.

I think it _could_ actually just be part of the system /etc/gitconfig,
though it is kind of big, and Git has a tendency to parse the config
more than necessary. I wonder if would add a noticeable slowdown.

-Peff
