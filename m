Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE22820970
	for <e@80x24.org>; Fri, 14 Apr 2017 19:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752152AbdDNTdC (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Apr 2017 15:33:02 -0400
Received: from siwi.pair.com ([209.68.5.199]:45376 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751854AbdDNTdA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2017 15:33:00 -0400
Received: from [10.160.98.126] (unknown [167.220.148.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id BCB64845CF;
        Fri, 14 Apr 2017 15:32:59 -0400 (EDT)
Subject: Re: [PATCH v3] unpack-trees: avoid duplicate ODB lookups during
 checkout
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
References: <20170413155852.4281-1-git@jeffhostetler.com>
 <20170413155852.4281-2-git@jeffhostetler.com>
 <xmqqtw5roqcc.fsf@gitster.mtv.corp.google.com>
 <20170414005924.sfu4csdxaoafipsv@sigill.intra.peff.net>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <3746703d-54e0-a855-8511-94a573a182a8@jeffhostetler.com>
Date:   Fri, 14 Apr 2017 15:32:58 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170414005924.sfu4csdxaoafipsv@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/13/2017 8:59 PM, Jeff King wrote:
> On Thu, Apr 13, 2017 at 04:11:31PM -0700, Junio C Hamano wrote:
>
>> git@jeffhostetler.com writes:
>>
>>> +	/*
>>> +	 * Fetch the tree from the ODB for each peer directory in the
>>> +	 * n commits.
>>> +	 *
>>> +	 * For 2- and 3-way traversals, we try to avoid hitting the
>>> +	 * ODB twice for the same OID.  This should yield a nice speed
>>> +	 * up in checkouts and merges when the commits are similar.
>>> +	 *
>>> +	 * We don't bother doing the full O(n^2) search for larger n,
>>> +	 * because wider traversals don't happen that often and we
>>> +	 * avoid the search setup.
>>> +	 *
>>> +	 * When 2 peer OIDs are the same, we just copy the tree
>>> +	 * descriptor data.  This implicitly borrows the buffer
>>> +	 * data from the earlier cell.
>>
>> This "borrowing" made me worried, but it turns out that this is
>> perfectly OK.
>>
>> fill_tree_descriptor() uses read_sha1_file() to give a tree_desc its
>> own copy of the tree object data, so the code that calls into the
>> tree traversal API is responsible for freeing the buffer returned
>> from fill_tree_descriptor().  The updated code avoids double freeing
>> by setting buf[i] to NULL for borrowing [i].
>
> Yeah, I think that logic is fine. We could also keep a separate counter
> for the size of buf, like:
>
>   buf[nr_buf++] = fill_tree_descriptor(t+i, sha1);
>
> and then just count from zero to nr_buf in the freeing loop. I don't
> think it matters much either way (the free(NULL) calls are presumably
> cheap).

Agreed. I don't think this matters one way or the other, but
I'll go ahead and do this while it is fresh.
Thanks,
Jeff

