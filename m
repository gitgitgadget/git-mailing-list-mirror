Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB406C433E0
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 13:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 965DD20CC7
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 13:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbgFPNKl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 09:10:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:33124 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726052AbgFPNKl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 09:10:41 -0400
Received: (qmail 21789 invoked by uid 109); 16 Jun 2020 13:10:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Jun 2020 13:10:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12965 invoked by uid 111); 16 Jun 2020 13:10:40 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Jun 2020 09:10:40 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 16 Jun 2020 09:10:39 -0400
From:   Jeff King <peff@peff.net>
To:     phillip.wood@dunelm.org.uk
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        sandals@crustytoothpaste.net, Matt Rogers <mattr94@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 05/12] fast-export: handle overridden main branch
 names correctly
Message-ID: <20200616131039.GG666057@coredump.intra.peff.net>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
 <pull.656.v2.git.1592225416.gitgitgadget@gmail.com>
 <a3be4f39aa240e614a2e12756e1ea864c35137a2.1592225416.git.gitgitgadget@gmail.com>
 <a0982afb-8c44-aeff-1839-6e0aa897fcf2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a0982afb-8c44-aeff-1839-6e0aa897fcf2@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 15, 2020 at 04:05:52PM +0100, Phillip Wood wrote:

> > @@ -515,14 +515,23 @@ static const char *anonymize_refname(const char *refname)
> >   	};
> >   	static struct hashmap refs;
> >   	static struct strbuf anon = STRBUF_INIT;
> > +	static char *main_branch;
> [...]
> > -	if (!strcmp(refname, "refs/heads/master"))
> > +	if (!main_branch)
> > +		main_branch = git_main_branch_name(MAIN_BRANCH_FULL_NAME);
> > +
> > +	if (!strcmp(refname, main_branch))
> >   		return "refs/heads/ref0";
> 
> This leaks main_branch if it came from git_main_branch_name()

It's a static that's used over and over, so I think it's intentional to
essentially memoize it for the life of the program (at which point we
could free it, but don't bother to do so, letting the process exit take
care of it, and trusting in leak detectors to be aware that it's still
reachable, as we do for lots of other process-lifetime allocations).

-Peff
