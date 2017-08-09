Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38B9D208B4
	for <e@80x24.org>; Wed,  9 Aug 2017 11:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752357AbdHILYL (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Aug 2017 07:24:11 -0400
Received: from zmcc-5-mx.zmailcloud.com ([52.201.171.122]:41736 "EHLO
        zmcc-5-mx.zmailcloud.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752214AbdHILYK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2017 07:24:10 -0400
X-Greylist: delayed 315 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 Aug 2017 07:24:10 EDT
Received: from zmcc-5-mta-1.zmailcloud.com (127.37.197.104.bc.googleusercontent.com [104.197.37.127])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by zmcc-5-mx.zmailcloud.com (Postfix) with ESMTPS id 7113F404FB;
        Wed,  9 Aug 2017 06:21:26 -0500 (CDT)
Received: from zmcc-5-mta-1.zmailcloud.com (localhost [127.0.0.1])
        by zmcc-5-mta-1.zmailcloud.com (Postfix) with ESMTPS id B1B41C03FD;
        Wed,  9 Aug 2017 06:18:54 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
        by zmcc-5-mta-1.zmailcloud.com (Postfix) with ESMTP id A10C7C03F0;
        Wed,  9 Aug 2017 06:18:54 -0500 (CDT)
X-Virus-Scanned: amavisd-new at zmcc-5-mta-1.zmailcloud.com
Received: from zmcc-5-mta-1.zmailcloud.com ([127.0.0.1])
        by localhost (zmcc-5-mta-1.zmailcloud.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4xLOJTSb3iqH; Wed,  9 Aug 2017 06:18:54 -0500 (CDT)
Received: from [192.168.1.204] (unknown [83.136.45.95])
        by zmcc-5-mta-1.zmailcloud.com (Postfix) with ESMTPSA id A6C5AC02DF;
        Wed,  9 Aug 2017 06:18:47 -0500 (CDT)
To:     spearce@spearce.org
Cc:     David.Turner@twosigma.com, avarab@gmail.com, ben.alex@acegi.com.au,
        dborowitz@google.com, git@vger.kernel.org, gitster@pobox.com,
        mhagger@alum.mit.edu, peff@peff.net, sbeller@google.com,
        stoffe@gmail.com
References: <CAJo=hJsEaKH40WnhxqvkASpiXnV8ipc+b1zrZ9VEjqRjpJ17Qg@mail.gmail.com>
Subject: Re: reftable [v5]: new ref storage format
From:   Howard Chu <hyc@symas.com>
Message-ID: <ee8f70bd-6f9e-3fb6-67be-ba26b6d5bf16@symas.com>
Date:   Wed, 9 Aug 2017 12:18:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:56.0) Gecko/20100101
 Firefox/56.0 SeaMonkey/2.53a1
MIME-Version: 1.0
In-Reply-To: <CAJo=hJsEaKH40WnhxqvkASpiXnV8ipc+b1zrZ9VEjqRjpJ17Qg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shawn Pearce wrote:
> On Sun, Aug 6, 2017 at 4:37 PM, Ben Alex <ben.alex@acegi.com.au> wrote:
>> > Just on the LmdbJava specific pieces:
>> >
>> > On Mon, Aug 7, 2017 at 8:56 AM, Shawn Pearce <spearce@spearce.org> wrote:

> I don't know if we need a larger key size. $DAY_JOB limits ref names
> to ~200 bytes in a hook. I think GitHub does similar. But I'm worried
> about the general masses who might be using our software and expect
> ref names thus far to be as long as PATH_MAX on their system. Most
> systems run PATH_MAX around 1024.

The key size limit in LMDB can be safely raised to around 2KB or so without 
any issues. There's also work underway in LMDB 1.0 to raise the limit to 2GB, 
but in general it would be silly to use such large keys.

> Mostly at $DAY_JOB its because we can't virtualize the filesystem
> calls the C library is doing.
> 
> In git-core, I'm worried about the caveats related to locking. Git
> tries to work nicely on NFS,

That may be a problem in current LMDB 0.9, but needs further clarification.

> and it seems LMDB wouldn't. Git also runs
> fine on a read-only filesystem, and LMDB gets a little weird about
> that.

Not sure what you're talking about. LMDB works perfectly fine on read-only 
filesystems, it just enforces that it is used in read-only mode.

> Finally, Git doesn't have nearly the risks LMDB has about a
> crashed reader or writer locking out future operations until the locks
> have been resolved. This is especially true with shared user
> repositories, where another user might setup and own the semaphore.

All locks disappear when the last process using the DB environment exits.
If only a single process is using the DB environment, there's no issue. If 
multiple processes are sharing the DB environment concurrently, the write lock 
cleans up automatically when the writer terminates; stale reader locks would 
require a call to mdb_reader_check() to clean them up.

The primary issue with using LMDB over NFS is with performance. All reads are 
performed thru accesses of mapped memory, and in general, NFS implementations 
don't cache mmap'd pages. I believe this is a consequence of the fact that 
they also can't guarantee cache coherence, so the only way for an NFS client 
to see a write from another NFS client is by always refetching pages whenever 
they're accessed.

This is also why LMDB doesn't provide user-level VFS hooks - it's generally 
impractical to emulate mmap from application level. You could always write a 
FUSE driver if that's really what you need to do, but again, the performance 
of such a solution is pretty horrible.

LMDB's read lock management also wouldn't perform well over NFS; it also uses 
an mmap'd file. On a local filesystem LMDB read locks are zero cost since they 
just atomically update a word in the mmap. Over NFS, each update to the mmap 
would also require an msync() to propagate the change back to the server. This 
would seriously limit the speed with which read transactions may be opened and 
closed. (Ordinarily opening and closing a read txn can be done with zero 
system calls.)

-- 
   -- Howard Chu
   CTO, Symas Corp.           http://www.symas.com
   Director, Highland Sun     http://highlandsun.com/hyc/
   Chief Architect, OpenLDAP  http://www.openldap.org/project/
