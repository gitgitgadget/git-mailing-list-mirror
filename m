Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 590DF1F4C1
	for <e@80x24.org>; Fri, 11 Oct 2019 20:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbfJKU6d (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 16:58:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:46206 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726281AbfJKU6d (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 16:58:33 -0400
Received: (qmail 16856 invoked by uid 109); 11 Oct 2019 20:58:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 11 Oct 2019 20:58:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4814 invoked by uid 111); 11 Oct 2019 21:01:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 11 Oct 2019 17:01:28 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 11 Oct 2019 16:58:32 -0400
From:   Jeff King <peff@peff.net>
To:     Brent Casavant <brent.casavant@hpe.com>
Cc:     git@vger.kernel.org
Subject: Re: bug: "rev-parse --short" with "--not --remote"
Message-ID: <20191011205831.GA30244@sigill.intra.peff.net>
References: <83e4f54f-190b-115f-b31b-7177c681128b@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <83e4f54f-190b-115f-b31b-7177c681128b@hpe.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 11, 2019 at 03:10:33PM -0500, Brent Casavant wrote:

> I noticed what appears to be a bug in rev-parse with an admittedly
> somewhat unusual combination of arguments.
> 
> Compare the output of the following:
> 
> % git rev-parse HEAD --not --remotes=origin
> 3de09080eb219149a8596dc21915d5a496cba171
> ^4fb157bf360413fe3fad38d03b02ce7232d12961
> ^757cfa6938c3d510d1597096d9f0b6878b884270
> 
> To this:
> 
> % git rev-parse --short HEAD --not --remotes=origin
> ^4fb157b
> ^757cfa6
> ^3de0908
> 
> In the first case rev-parse emits the commit-id of HEAD, followed by
> negated commit-ids of all remote branches in origin.  I believe this
> is the correct and intended behavior.
> 
> In the second case rev-parse emits the negated short commit-ids of all
> remote branches in origin, followed by the negated short commit-id of
> HEAD.  This is inconsistent with the results of the (presumably
> correct) prior example.
> 
> I would expect both commands to emit the same output, modulo the
> number of characters emitted for the commit-id.

That's what I'd have naively expected, too, but that's not what
"--short" is documented to do:

  $ git help rev-parse | grep -A2 -e --short
         --short[=length]
	     Same as --verify but shortens the object name to a unique
	     prefix with at least length characters. The minimum length
	     is 4, the default is the effective value of the core.abbrev
	     configuration variable (see git-config(1)).

and --verify itself is a bit magical:

  $ git help rev-parse | grep -m1 -A2 -e --verify
         --verify
	     Verify that exactly one parameter is provided, and that it
	     can be turned into a raw 20-byte SHA-1 that can be used to
	     access the object database. If so, emit it to the standard
	     output; otherwise, error out.

You can see the same weirdness with --verify (e.g., `git rev-parse
--verify HEAD --not --remotes=origin`). And I think it is kind of buggy,
in that I'd expect it to complain about seeing more than one parameter.

I'm not sure exactly what you're trying to do. If you actually want a
traversal, you probably should be using rev-list (with --abbrev-commit
if you want to abbreviate). If you just want to resolve some names
without traversing, you might be better off using for-each-ref or
similar.

-Peff
