Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FF58201A0
	for <e@80x24.org>; Fri, 30 Jun 2017 18:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752450AbdF3S2Y (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 14:28:24 -0400
Received: from siwi.pair.com ([209.68.5.199]:60380 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751887AbdF3S2X (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 14:28:23 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id CA9F78455E;
        Fri, 30 Jun 2017 14:28:21 -0400 (EDT)
Received: from [10.160.98.126] (unknown [167.220.148.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id D127F84541;
        Fri, 30 Jun 2017 14:28:20 -0400 (EDT)
Subject: Re: RFC: Missing blob hook might be invoked infinitely recursively
To:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
References: <20170629114830.39dc2161@twelve2.svl.corp.google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <3a68d8a2-8f4a-427b-f24a-fa215a1443fd@jeffhostetler.com>
Date:   Fri, 30 Jun 2017 14:28:14 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170629114830.39dc2161@twelve2.svl.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 6/29/2017 2:48 PM, Jonathan Tan wrote:
> As some of you may know, I'm currently working on support for partial
> clones/fetches in Git (where blobs above a user-specified size threshold
> are not downloaded - only their names and sizes are downloaded). To do
> this, the client repository needs to be able to download blobs at will
> whenever it needs a missing one (for example, upon checkout).
> 
> So I have done this by adding support for a hook in Git [1], and
> updating the object-reading code in Git to, by default, automatically
> invoke this hook whenever necessary. (This means that existing
> subsystems will all work by default, in theory at least.) My current
> design is for the hook to have maximum flexibility - when invoked with a
> list of SHA-1s, it must merely ensure that those objects are in the
> local repo, whether packed or loose.
> 
> I am also working on a command (fetch-blob) to be bundled with Git to be
> used as a default hook, and here is where the problem lies.
> 
> Suppose you have missing blob AB12 and CD34 that you now need, so
> fetch-blob is invoked. It sends the literals AB12 and CD34 to a new
> server endpoint and obtains a packfile, which it then pipes through "git
> index-pack". The issue is that "git index-pack" wants to try to access
> AB12 and CD34 in the local repo in order to do a SHA-1 collision check,
> and therefore fetch-blob is invoked once again, creating infinite
> recursion.
> 
> This is straightforwardly fixed by making "git index-pack" understand
> about missing blobs, but this might be a symptom of this approach being
> error-prone (custom hooks that invoke any Git command must be extra
> careful).

I'm not sure if this what you meant, but could you pass to index-pack
the set of missing blobs that you passed to fetch-blob?  That is, let
index-pack do it's normal lookups, but just not on the list passed in.

> 
> So I have thought of a few solutions, each with its pros and cons:
> 
> 1. Require the hook to instead output a packfile to stdout. This means
> that that hook no longer needs to access the local repo, and thus has
> less dependence on Git commands. But this reduces the flexibility in
> that its output must be packed, not loose. (This is fine for the use
> cases I'm thinking of, but probably not so for others.)
> 
> 2. Add support for an environment variable to Git that suppresses access
> to the missing blob manifest, in effect, suppressing invocation of the
> hook. This allows anyone (the person configuring Git or the hook writer)
> to suppress this access, although they might need in-depth knowledge to
> know whether the hook is meant to be run with such access suppressed or
> required.
> 
> 3. Like the above, except for a command-line argument to Git.
> 
> What do you think? Any solutions that I am missing?
> 
> [1] Work in progress, but you can see an earlier version here: https://public-inbox.org/git/b917a463f0ad4ce0ab115203b3f24894961a2e75.1497558851.git.jonathantanmy@google.com/
> 
