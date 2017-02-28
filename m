Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 999C3202C9
	for <e@80x24.org>; Tue, 28 Feb 2017 22:33:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751722AbdB1WdQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 17:33:16 -0500
Received: from cloud.peff.net ([104.130.231.41]:36115 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751492AbdB1WdP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 17:33:15 -0500
Received: (qmail 27148 invoked by uid 109); 28 Feb 2017 22:06:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Feb 2017 22:06:28 +0000
Received: (qmail 31659 invoked by uid 111); 28 Feb 2017 22:06:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Feb 2017 17:06:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Feb 2017 17:06:26 -0500
Date:   Tue, 28 Feb 2017 17:06:26 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peartben@gmail.com,
        benpeart@microsoft.com
Subject: Re: [PATCH 1/3] revision: unify {tree,blob}_objects in rev_info
Message-ID: <20170228220626.at4cihedmvkqiq5c@sigill.intra.peff.net>
References: <cover.1487984670.git.jonathantanmy@google.com>
 <06a84f8c77924b275606384ead8bb2fd7d75f7b6.1487984670.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <06a84f8c77924b275606384ead8bb2fd7d75f7b6.1487984670.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 24, 2017 at 05:18:36PM -0800, Jonathan Tan wrote:

> Whenever tree_objects is set to 1 in revision.h's struct rev_info,
> blob_objects is likewise set, and vice versa. Combine those two fields
> into one.
> 
> Some of the existing code does not handle tree_objects being different
> from blob_objects properly. For example, "handle_commit" in revision.c
> recurses from an UNINTERESTING tree into its subtree if tree_objects ==
> 1, completely ignoring blob_objects; it probably should still recurse if
> tree_objects == 0 and blob_objects == 1 (to mark the blobs), and should
> behave differently depending on blob_objects (controlling the
> instantiation and marking of blob objects). This commit resolves the
> issue by forbidding tree_objects from being different to blob_objects.

Yeah, I agree that is awkward. I'm OK with the rule "if blob_objects is
set, then tree_objects must also be set". It's the other way around I
care more about.

> It could be argued that in the future, Git might need to distinguish
> tree_objects from blob_objects - in particular, a user might want
> rev-list to print the trees but not the blobs. However, this results in
> a minor performance savings at best in that objects no longer need to be
> instantiated (causing memory allocations and hashtable insertions) - no
> disk reads are being done for objects whether blob_objects is set or
> not.

In a full object-graph traversal, we actually spend a big chunk of our
time in hash lookups. My measurements (admittedly from 2013, which I
haven't repeated lately) show something like a 20-25% speedup for this
case.

My only use for it (and the source of those timings) was to compute
archive reachability, which nobody seems to care too much about. But I
suspect we could speed up your case, too, when we are just computing the
reachability of a non-blob. I.e., you should be able to turn on the
smallest subset of "commits only", "commits and trees", and "commits,
trees, and blobs", based on what the other side has asked for.

-Peff
