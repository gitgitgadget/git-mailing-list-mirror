Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F415120899
	for <e@80x24.org>; Mon, 14 Aug 2017 12:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753151AbdHNMat (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 08:30:49 -0400
Received: from zmcc-5-mx.zmailcloud.com ([52.201.171.122]:42440 "EHLO
        zmcc-5-mx.zmailcloud.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753131AbdHNMar (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 08:30:47 -0400
Received: from zmcc-5-mta-1.zmailcloud.com (127.37.197.104.bc.googleusercontent.com [104.197.37.127])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by zmcc-5-mx.zmailcloud.com (Postfix) with ESMTPS id 3AC3440543;
        Mon, 14 Aug 2017 07:33:24 -0500 (CDT)
Received: from zmcc-5-mta-1.zmailcloud.com (localhost [127.0.0.1])
        by zmcc-5-mta-1.zmailcloud.com (Postfix) with ESMTPS id 27FE9C0D1A;
        Mon, 14 Aug 2017 07:30:46 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
        by zmcc-5-mta-1.zmailcloud.com (Postfix) with ESMTP id 1839CC0D17;
        Mon, 14 Aug 2017 07:30:46 -0500 (CDT)
X-Virus-Scanned: amavisd-new at zmcc-5-mta-1.zmailcloud.com
Received: from zmcc-5-mta-1.zmailcloud.com ([127.0.0.1])
        by localhost (zmcc-5-mta-1.zmailcloud.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id RD6eUdW_sOWe; Mon, 14 Aug 2017 07:30:46 -0500 (CDT)
Received: from [192.168.1.204] (cust230-124.nwewn.com [78.155.230.124])
        by zmcc-5-mta-1.zmailcloud.com (Postfix) with ESMTPSA id 0961CC0CEC;
        Mon, 14 Aug 2017 07:30:43 -0500 (CDT)
Subject: Re: reftable [v5]: new ref storage format
From:   Howard Chu <hyc@symas.com>
To:     spearce@spearce.org
Cc:     David.Turner@twosigma.com, avarab@gmail.com, ben.alex@acegi.com.au,
        dborowitz@google.com, git@vger.kernel.org, gitster@pobox.com,
        mhagger@alum.mit.edu, peff@peff.net, sbeller@google.com,
        stoffe@gmail.com
References: <CAJo=hJsEaKH40WnhxqvkASpiXnV8ipc+b1zrZ9VEjqRjpJ17Qg@mail.gmail.com>
 <ee8f70bd-6f9e-3fb6-67be-ba26b6d5bf16@symas.com>
Message-ID: <576a2361-1a3d-4bb2-1d31-f095f9e3c708@symas.com>
Date:   Mon, 14 Aug 2017 13:30:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:56.0) Gecko/20100101
 Firefox/56.0 SeaMonkey/2.53a1
MIME-Version: 1.0
In-Reply-To: <ee8f70bd-6f9e-3fb6-67be-ba26b6d5bf16@symas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Howard Chu wrote:
> The primary issue with using LMDB over NFS is with performance. All reads are 
> performed thru accesses of mapped memory, and in general, NFS implementations 
> don't cache mmap'd pages. I believe this is a consequence of the fact that 
> they also can't guarantee cache coherence, so the only way for an NFS client 
> to see a write from another NFS client is by always refetching pages whenever 
> they're accessed.

> LMDB's read lock management also wouldn't perform well over NFS; it also uses an mmap'd file. On a local filesystem LMDB read locks are zero cost since they just atomically update a word in the mmap. Over NFS, each update to the mmap would also require an msync() to propagate the change back to the server. This would seriously limit the speed with which read transactions may be opened and closed. (Ordinarily opening and closing a read txn can be done with zero system calls.) 

All that aside, we could simply add an EXCLUSIVE open-flag to LMDB, and 
prevent multiple processes from using the DB concurrently. In that case, 
maintaining coherence with other NFS clients is a non-issue. It strikes me 
that git doesn't require concurrent multi-process access anyway, and any 
particular process would only use the DB for a short time before closing it 
and going away.

-- 
   -- Howard Chu
   CTO, Symas Corp.           http://www.symas.com
   Director, Highland Sun     http://highlandsun.com/hyc/
   Chief Architect, OpenLDAP  http://www.openldap.org/project/
