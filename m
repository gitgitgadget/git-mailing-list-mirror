Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 020C2203C1
	for <e@80x24.org>; Tue, 15 Nov 2016 01:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941189AbcKOBD6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Nov 2016 20:03:58 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:36946 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S941172AbcKOBD5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2016 20:03:57 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 862FE203C1;
        Tue, 15 Nov 2016 01:03:56 +0000 (UTC)
Date:   Tue, 15 Nov 2016 01:03:56 +0000
From:   Eric Wong <e@80x24.org>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: RFC: Enable delayed responses to Git clean/smudge filter requests
Message-ID: <20161115010356.GA29602@starla>
References: <D10F7C47-14E8-465B-8B7A-A09A1B28A39F@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <D10F7C47-14E8-465B-8B7A-A09A1B28A39F@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> wrote:
> Hi,
> 
> Git always performs a clean/smudge filter on files in sequential order.
> Sometimes a filter operation can take a noticeable amount of time. 
> This blocks the entire Git process.

I have the same problem in many places which aren't git :>

> I would like to give a filter process the possibility to answer Git with
> "I got your request, I am processing it, ask me for the result later!".
> 
> I see the following way to realize this:
> 
> In unpack-trees.c:check_updates() [1] we loop through the cache 
> entries and "ask me later" could be an acceptable return value of the 
> checkout_entry() call. The loop could run until all entries returned
> success or error.
> 
> The filter machinery is triggered in various other places in Git and
> all places that want to support "ask me later" would need to be patched 
> accordingly.

That all sounds reasonable.

The filter itself would need to be aware of parallelism
if it lives for multiple objects, right?

> Do you think this could be a viable approach?

It'd probably require a bit of work, but yes, I think it's viable.

We already do this with curl_multi requests for parallel
fetching from dumb HTTP servers, but that's driven by curl
internals operating with a select/poll loop.

Perhaps the curl API could be a good example for doing this.

> Do you see a better way?

Nope, I prefer non-blocking state machines to threads for
debuggability and determinism.

Anyways, I'll plan on doing something similar (in Perl) with the
synchronous parts of public-inbox which relies on "cat-file --batch"
at some point... (my rotational disks are sloooooooow :<)
