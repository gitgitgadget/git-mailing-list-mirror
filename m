Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C72E2202AF
	for <e@80x24.org>; Fri, 17 Nov 2017 15:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965437AbdKQPmz (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Nov 2017 10:42:55 -0500
Received: from siwi.pair.com ([209.68.5.199]:24538 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751253AbdKQPmx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Nov 2017 10:42:53 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 3AE9784512;
        Fri, 17 Nov 2017 10:42:53 -0500 (EST)
Received: from [10.160.98.77] (unknown [167.220.148.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id E8591844F1;
        Fri, 17 Nov 2017 10:42:52 -0500 (EST)
Subject: Re: [PATCH v4 4/6] list-objects: filter objects in
 traverse_commit_list
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20171116180743.61353-1-git@jeffhostetler.com>
 <20171116180743.61353-5-git@jeffhostetler.com>
 <20171116122133.4cc718414579c1a5a682174b@google.com>
 <bdf75d90-570d-8cf0-886a-2c5c9cdba1c1@jeffhostetler.com>
 <20171116215725.k44e3alk2lq6bbwu@sigill.intra.peff.net>
 <xmqqh8tttzwq.fsf@gitster.mtv.corp.google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <6f433987-f91b-d5b5-242e-3a241b7442c7@jeffhostetler.com>
Date:   Fri, 17 Nov 2017 10:42:52 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqh8tttzwq.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/16/2017 9:14 PM, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
>> Those encodings don't necessarily need to be the same, because they're
>> about transport. Inside each process we'd have the raw bytes, and encode
>> them as appropriate to whatever sub-program we're going to pass to (or
>> not at all if we skip the shell for sub-processes, which is usually a
>> good idea).
> 
> Yes, I share the same feeling.  It does not help that the series
> defines its own notion of arg_needs_armor() and uses it to set a
> field called requires_armor that is not yet used, the definition of
> "armor"ing being each byte getting encoded as two hexadecimal digits
> without any sign (which makes me wonder what a receiver of
> "deadbeef" would do---did it receive an armored string or a plain
> one???).  I do not understand why these strings are not passed as
> opaque sequences of bytes and instead converted at this low a layer.

I'm probably being too paranoid.  My fear is that a client could pass
an expression to clone/fetch/fetch-pack that would be sent to the
server and evaluated by the interface between upload-pack and pack-objects.
I'm not worried about the pack-protocol transport.  I'm mainly concerned
in how upload-pack passes that *client-expression* to pack-objects and are
there ways for that to go south on the server with a carefully crafted
expression.

Even if we assume that upload-pack on the server directly invokes
pack-objects (rather than a shell), there still might be issues.
For platforms like Linux which have a native execve() and can pass
args in an argv (and which the sub-process also receives in an argv
in their main()), my paranoia is probably overkill.

But on Windows, where the native interface takes a command-line string
rather than an argv, I was concerned.  Yes, there is code in compat/mingw.c
to quote args when building a command line from an argv (and I'm *not*
saying there are bugs in that), but again maybe I am being paranoid.

I'll take another look and the existing quoting mechanisms and re-eval.

Thanks,
Jeff


