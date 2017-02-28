Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A431F202C9
	for <e@80x24.org>; Tue, 28 Feb 2017 22:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751864AbdB1Wfz (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 17:35:55 -0500
Received: from cloud.peff.net ([104.130.231.41]:36127 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751533AbdB1Wff (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 17:35:35 -0500
Received: (qmail 27540 invoked by uid 109); 28 Feb 2017 22:12:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Feb 2017 22:12:39 +0000
Received: (qmail 31695 invoked by uid 111); 28 Feb 2017 22:12:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Feb 2017 17:12:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Feb 2017 17:12:37 -0500
Date:   Tue, 28 Feb 2017 17:12:37 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peartben@gmail.com,
        benpeart@microsoft.com
Subject: Re: [PATCH 2/3] revision: exclude trees/blobs given commit
Message-ID: <20170228221236.selqkf5wme3fvued@sigill.intra.peff.net>
References: <cover.1487984670.git.jonathantanmy@google.com>
 <7082d91f30663b2e6d7fb1795c5ea37d3fe3446c.1487984670.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7082d91f30663b2e6d7fb1795c5ea37d3fe3446c.1487984670.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 24, 2017 at 05:18:37PM -0800, Jonathan Tan wrote:

> When the --objects argument is given to rev-list, an argument of the
> form "^$tree" can be given to exclude all blobs and trees reachable from
> that tree, but an argument of the form "^$commit" only excludes that
> commit, not any blob or tree reachable from it. Make "^$commit" behave
> consistent to "^$tree".

Like Junio, I suspect this is going to be quite expensive. This is
similar to the "--objects-edge" and "--objects-edge-aggressive" options,
which we had to pull back on the use of because of their expensiveness.

(And as an aside, wouldn't those options be the right place for what
you're doing?).

I also think that the mechanism here is not 100% accurate. The commit
traversal will stop once it has painted down, so you're effectively
exploring the trees of the merge bases. But older history could mention
an object that has resurfaced again (e.g., due to a cherry-pick).

Getting the 100% accurate answer is _really_ expensive, though with
reachability bitmaps it's not too bad. I just wonder if that's a better
approach to be taking.

-Peff
