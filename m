Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11AFD1F453
	for <e@80x24.org>; Wed, 30 Jan 2019 23:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbfA3XFM (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 18:05:12 -0500
Received: from siwi.pair.com ([209.68.5.199]:21886 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbfA3XFL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 18:05:11 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id C87163F400C;
        Wed, 30 Jan 2019 17:26:24 -0500 (EST)
Received: from [192.168.1.71] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 9D5233F4012;
        Wed, 30 Jan 2019 17:26:24 -0500 (EST)
Subject: Re: Contributor Summit Topics and Logistics
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20190122075027.GA29441@sigill.intra.peff.net>
 <87va253lun.fsf@evledraar.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <e0173444-c5c4-61d0-5a3d-e37cbfd44bad@jeffhostetler.com>
Date:   Wed, 30 Jan 2019 17:26:23 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:65.0) Gecko/20100101
 Thunderbird/65.0
MIME-Version: 1.0
In-Reply-To: <87va253lun.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 1/30/2019 3:57 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Jan 22 2019, Jeff King wrote:
> 
...
> * "Structured remote logging". We had an RFC spec for turning our trace
>    format into something more structural with a way to send it to a
>    remote server. There were both implementation & privacy concernse,
>    last time at least a couple of users of git reported having in-house
>    patches for this (not ready for upstream). Where are we on this now?

I won't be attending GitMerge this year, but I can talk about
this work here.

My earlier "structured logging" and/or "telemetry" proposals
have been replaced by my Trace2 patch series now in "pu".

The Trace2 feature is designed to report trace and performance
data from within the git process to a local log file, unix
domain socket, or Windows named pipe.  Functions in the Trace2
API generate structured data and can write either structured
(JSON) or non-structured formats to disk.  (It should not be
hard to add a binary structured format too, but that is beyond
the scope of the current patch series.)

The JSON stream is suitable for post-processing by a local
process.  This can be a daemon listening to the stream or a
cron job processing the trace data after the fact.

I consider it to be the job of the post-processor (after
aggregating, filtering or whatever) to decide what to do with
the data.  This lets the the user and/or sysadmin control how
and when data is collected.  The post-processor is free to hook
into something like syslog or ETW or write to a custom DB.

Post-processing tools are not included in the patch series.


Internally within Microsoft, we have a local Windows Service
listening on a named pipe and collecting events from all
git processes for our GVFS users in the Windows OS repo.
It computes a summary record for each git command, for example
combining the argv from the "start" event with the elapsed
time from the "exit" event into a single record.  The service
then sends the aggregate records to a centralized database.

This lets us run various database queries to try to understand
pain points that our OS developers are experiencing (and that
may not show up on my machine) and help us prioritize future perf
and scaling work.

But again, this service is but one possible post-processor
and is for internal-use-only.

The Trace2 feature itself does not have any remote capability.
It just writes data locally.

Jeff


