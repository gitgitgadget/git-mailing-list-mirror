Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A82231F597
	for <e@80x24.org>; Tue, 31 Jul 2018 19:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732321AbeGaVLV (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 17:11:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:37692 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729623AbeGaVLU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 17:11:20 -0400
Received: (qmail 2518 invoked by uid 109); 31 Jul 2018 19:29:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 31 Jul 2018 19:29:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4890 invoked by uid 111); 31 Jul 2018 19:29:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 31 Jul 2018 15:29:35 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 31 Jul 2018 15:29:31 -0400
Date:   Tue, 31 Jul 2018 15:29:31 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        pawelparuzel95@gmail.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH/RFC] clone: report duplicate entries on case-insensitive
 filesystems
Message-ID: <20180731192931.GD3372@sigill.intra.peff.net>
References: <20180729092759.GA14484@sigill.intra.peff.net>
 <20180730152756.15012-1-pclouds@gmail.com>
 <CABPp-BG+nB+ifRbCdMpXnnxQ+rzhM8W-=sfQf8TYmXvuPy5WXg@mail.gmail.com>
 <xmqqo9enb4n9.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo9enb4n9.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 31, 2018 at 12:12:58PM -0700, Junio C Hamano wrote:

> Elijah Newren <newren@gmail.com> writes:
> 
> > Is it worth attempting to also warn about paths that only differ in
> > UTF-normalization on relevant MacOS systems?
> 
> I hate to bring up a totally different approach this late in the
> party, but I wonder if it makes more sense to take advantage of
> "clone" being a command that starts from an empty working tree.
> 
> builtin/clone.c::checkout() drives a single-tree unpack_trees(),
> using oneway_merge() as its callback and at the end, eventually
> unpack_trees.c:check_updates() will call into checkout_entry()
> to perform the usual "unlink and then create" dance.
> 
> I wonder if it makes sense to introduce a new option to tell the
> machinery to report when the final checkout_entry() notices that it
> needed to remove the working tree file to make room (perhaps that
> bit would go in "struct unpack_trees_options").  In the initial
> checkout codepath for a freshly cloned repository, that would only
> happen when your tree has two (or more) paths that gets smashed
> by case insensitive or UTF-normalizing filesystem, and the code we
> would maintain do not have to care how exactly the filesystem
> collapses two (or more) paths if we go that way.  We only need to
> report "we tried to check out X but it seems your filesystem equates
> something else that is also in the project to X".

Heh. See my similar suggestion in:

  https://public-inbox.org/git/20180728095659.GA21450@sigill.intra.peff.net/

and the response from Duy.

-Peff
