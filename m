Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 373A8211B3
	for <e@80x24.org>; Tue,  4 Dec 2018 07:06:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726001AbeLDHGE (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Dec 2018 02:06:04 -0500
Received: from cloud.peff.net ([104.130.231.41]:58264 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725983AbeLDHGE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Dec 2018 02:06:04 -0500
Received: (qmail 28911 invoked by uid 109); 4 Dec 2018 07:06:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 04 Dec 2018 07:06:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17785 invoked by uid 111); 4 Dec 2018 07:05:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 04 Dec 2018 02:05:31 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Dec 2018 02:06:02 -0500
Date:   Tue, 4 Dec 2018 02:06:02 -0500
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git <git@vger.kernel.org>, git-users@googlegroups.com,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: How de-duplicate similar repositories with alternates
Message-ID: <20181204070602.GB11010@sigill.intra.peff.net>
References: <87zhtsx73l.fsf@evledraar.gmail.com>
 <CAGZ79ka1sjU+rHctRP4SVMP0GQsK2iZghkU46=f96ugqvX5Neg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGZ79ka1sjU+rHctRP4SVMP0GQsK2iZghkU46=f96ugqvX5Neg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 29, 2018 at 10:55:49AM -0800, Stefan Beller wrote:

> On Thu, Nov 29, 2018 at 7:00 AM Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
> >
> > A co-worker asked me today how space could be saved when you have
> > multiple checkouts of the same repository (at different revs) on the
> > same machine. I said since these won't block-level de-duplicate well[1]
> > one way to do this is with alternates.
> 
> Another way is to use git-worktree, which would solve the gc issues
> mentioned below?
> 
> I view alternates as a historic artefact as the deduping
> of objects client side can be done using worktrees, and on the
> serverside - I think - most of the git hosters use namespaces
> and put a fork network into the same repository and use pack islands.

Nope, we definitely use alternates. The ref namespace support in Git is
not nearly complete enough to run a modern hosting site; it only kicks
in for upload-pack and receive-pack. Other commands (e.g., rev-list to
traverse for a history-view page) have no support at all. So we share
object storage, but not ref storage.

In theory the caller could namespace requests (e.g., the user asks for
"foo", the web site feeds "refs/forks/$id/refs/heads/foo" to git). But
any bugs are a lot more likely to lead to security problems (oops, you
accidentally wrote into somebody else's fork!). And ref storage has
traditionally been a sore point for scaling, so giving each fork its own
repo and refs helps break that up.

By contrast, object storage is pretty easy to share. It scales
reasonably well, and the security model is much simpler due to the
immutable nature of object names.

-Peff
