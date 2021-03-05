Return-Path: <SRS0=rdad=ID=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A9CBC433E0
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 17:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCB3765020
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 17:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbhCERdj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Mar 2021 12:33:39 -0500
Received: from siwi.pair.com ([209.68.5.199]:51261 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229488AbhCERdM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Mar 2021 12:33:12 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 483AF3F40E6;
        Fri,  5 Mar 2021 12:33:12 -0500 (EST)
Received: from MININT-RVM6V2G.redmond.corp.microsoft.com (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id F19043F40D9;
        Fri,  5 Mar 2021 12:33:11 -0500 (EST)
Subject: Re: [PATCH v4 09/12] unix-socket: disallow chdir() when creating unix
 domain sockets
To:     Chris Torek <chris.torek@gmail.com>, Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.766.v3.git.1613174954.gitgitgadget@gmail.com>
 <pull.766.v4.git.1613598529.gitgitgadget@gmail.com>
 <1bfa36409d0706d5e22703f80bf95dfa1a313a83.1613598529.git.gitgitgadget@gmail.com>
 <xmqqblbzj1cs.fsf@gitster.c.googlers.com>
 <YED1DmLWd+ciySNa@coredump.intra.peff.net>
 <xmqqa6riejyp.fsf@gitster.c.googlers.com>
 <xmqqtupqbij4.fsf@gitster.c.googlers.com>
 <YEHzmIOYgRtI1Ak1@coredump.intra.peff.net>
 <YEH5AUxgFxWTxb6u@coredump.intra.peff.net>
 <CAPx1GvfXO9Xd+9Fqp-M13WUUNWVtemWm__O4N5WUk7=s4up1Gg@mail.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <449a73be-52e3-8363-b771-959f8114e3a0@jeffhostetler.com>
Date:   Fri, 5 Mar 2021 12:33:11 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAPx1GvfXO9Xd+9Fqp-M13WUUNWVtemWm__O4N5WUk7=s4up1Gg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/5/21 6:59 AM, Chris Torek wrote:
>> On Fri, Mar 05, 2021 at 04:02:16AM -0500, Jeff King wrote:
>>
>>> I don't know offhand if this [bind in a child] trick actually works. ...
> 
> On Fri, Mar 5, 2021 at 1:29 AM Jeff King <peff@peff.net> wrote:
>> I was curious, but this does indeed work:
> [working example snipped]
> 
> Yes, it definitely works.  The bind() call, on a Unix domain socket,
> creates a file system entity linked to the underlying socket instance.
> The file descriptors, in whatever processes have them, provide
> read/write/send/recv/etc linkage to the underlying socket instance
> (and also a refcount or other GC protection: with the ability to
> send sockets over sockets, simple refcounts stop working and we
> need real GC in the kernel...).
> 
> Of course, once all the file descriptor references are gone, the
> socket (eventually, depending on GC) evaporates.  The file system
> entity does not count for keeping the underlying socket alive.  At
> this point the file system entity is "dead".  Unfortunately there's no
> way to test and clean out the dead entity atomically.  The whole
> thing is kind of a mess.
> 
> Chris
> 

The original problem was that chdir() is not safe in a multi-threaded
process because one thread calling chdir() will affect any concurrent
file operations (open(), mkdir(), etc.) that use relative paths.

I think Adding a fork() at this layer would just create new types of 
problems.  For example, if another thread was concurrently writing to
a socket while we were setting up this new socket, we would suddenly
have 1 thread in each process now writing to that socket and the
receiver would get a mixture of output from both processes.  Right?

Jeff


