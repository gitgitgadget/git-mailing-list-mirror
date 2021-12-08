Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0C8C433F5
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 16:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237278AbhLHQuk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 11:50:40 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53037 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbhLHQuj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 11:50:39 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8F91515D471;
        Wed,  8 Dec 2021 11:47:07 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=B9njVQQrWWZlMACXNtvdCyWqFpYaCLzGo0sY4q
        hQEhY=; b=xW8tSN5o/0+ffMyMVNQLgJsJlJoPRs0EOH8H/bbXo8LyHQK5PKGfVC
        jOuJnl3NXGJ62oW2ojRdNM0/luqjptzxKludTK3vcfR4Z5nXbz/D7Q97KbTNHhiD
        XWrBwNyqHKhHP4+2g441TwknzryVhnOewdTa90WEvQLymc92GUKEk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8912A15D470;
        Wed,  8 Dec 2021 11:47:07 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8344D15D46F;
        Wed,  8 Dec 2021 11:47:03 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 10/10] reftable: make reftable_record a tagged union
References: <pull.1152.git.git.1638899124.gitgitgadget@gmail.com>
        <8deccc3a1dff7e4f7d613fa63d2781fd1f11f841.1638899124.git.gitgitgadget@gmail.com>
        <072ff09c-9174-e769-7ebb-4bb248199337@gmail.com>
Date:   Wed, 08 Dec 2021 08:47:02 -0800
In-Reply-To: <072ff09c-9174-e769-7ebb-4bb248199337@gmail.com> (Derrick
        Stolee's message of "Wed, 8 Dec 2021 09:35:36 -0500")
Message-ID: <xmqqv8zz2ge1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 78936BC4-5846-11EC-A72D-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 12/7/2021 12:45 PM, Han-Wen Nienhuys via GitGitGadget wrote:
>> From: Han-Wen Nienhuys <hanwen@google.com>
>> 
>> This reduces the amount of glue code, because we don't need a void pointer or
>> vtable within the structure.
>> 
>> The only snag is that reftable_index_record contain a strbuf, so it cannot be
>> zero-initialized. To address this, introduce reftable_record_for() to create a
>> fresh instance, given a record type.
>> 
>> Thanks to Peff for the suggestion.
>> 
>> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
>> ---
>>  reftable/block.c       |   4 +-
>>  reftable/block_test.c  |  22 +++---
>>  reftable/generic.c     |  35 ++++----
>>  reftable/iter.c        |   4 +-
>>  reftable/merged.c      |  37 ++++-----
>>  reftable/pq.c          |   3 +-
>>  reftable/pq_test.c     |  31 ++++----
>>  reftable/reader.c      | 105 ++++++++++++------------
>>  reftable/record.c      | 176 ++++++++++++++++-------------------------
>>  reftable/record.h      |  45 +++++------
>>  reftable/record_test.c | 162 +++++++++++++++++++------------------
>>  reftable/writer.c      |  46 ++++++-----
>
> This is a HUGE diff, especially compared to the previous changes
> in this series. I recommend splitting this out into its own series
> and finding a way to break it down into smaller changes.

As the reftable_record structure is used everywhere (and that is why
this step has to touch everywhere), I suspect that a reviewable fix
in small chunks would be achievable only if we redo the topic that
introduces this hierarchy and fix the type at the source, as if the
reftable_record structure was a struct with union in it from the
beginning, I am afraid.

Perhaps reftable_record_for() can be implemented without changing
the shape of the underlying reftable_record structure in an earlier
step, then all the users of reftable_record instances can be
migrated to call it, and then finally the shape of the structure and
the implementation of reftable_record_for() can be updated?  

If that is doable, then the "migrate each users" part can be split
purely by size.  But (1) I do not know if the first step is even
doable, and (2) I am not sure if it is worth going a somewhat
roundabout route to get to the same destination in this case.

So...


