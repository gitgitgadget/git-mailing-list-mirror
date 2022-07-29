Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 481E2C19F2A
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 16:07:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236279AbiG2QHx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 12:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiG2QHv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 12:07:51 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765F088762
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 09:07:49 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D0C1F135515;
        Fri, 29 Jul 2022 12:07:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CKgudPOrrtqACGukRpwVsEV4Bntz+RAI9xJFU+
        eCrlw=; b=Nf0zPpsXhwhP2aWuKGHYE11kyuEzIHfa9zWw+/2SfnNZBqgIzxUBHO
        iUZIFBQevEMgw0X9HC7h3PkDdApj2pgSL1EwTqfKrT4iWWd/+bV+eaUYVSA8aiHA
        48VFyLzdyMbTJxo53YJqjmIHqaZj2dv9X5FsUIxjulKisNHpvQDJ0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C8352135514;
        Fri, 29 Jul 2022 12:07:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 34606135513;
        Fri, 29 Jul 2022 12:07:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Neeraj Singh <neerajsi@microsoft.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/2] t5351: avoid relying on `core.fsyncMethod = batch`
 to be supported
References: <pull.1308.git.1659097724.gitgitgadget@gmail.com>
        <501a89aa0b2de396b0c7b82b2e24046b9c98c382.1659097724.git.gitgitgadget@gmail.com>
Date:   Fri, 29 Jul 2022 09:07:46 -0700
In-Reply-To: <501a89aa0b2de396b0c7b82b2e24046b9c98c382.1659097724.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Fri, 29 Jul 2022
        12:28:43 +0000")
Message-ID: <xmqq1qu3aoml.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 96599894-0F58-11ED-8C05-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> On FreeBSD, this mode is not supported. But since 3a251bac0d1a (trace2:
> only include "fsync" events if we git_fsync(), 2022-07-18) t5351 will
> fail if this mode is unsupported.
>
> Let's address this in the minimal fashion, by detecting that that mode
> is unsupported and expecting a different count of hardware flushes in
> that case.
>
> This fixes the CI/PR builds on FreeBSD again.
>
> Note: A better way would be to test only what is relevant in t5351.6
> "unpack big object in stream (core.fsyncmethod=batch)" again instead of
> blindly comparing the output against some exact text. But that would
> pretty much revert the idea of above-mentioned commit, and that commit
> was _just_ accepted into Git's main branch so one must assume that it
> was intentional.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  bulk-checkin.c                  |  2 ++
>  t/t5351-unpack-large-objects.sh | 10 ++++++++--
>  2 files changed, 10 insertions(+), 2 deletions(-)

I am inclined to take this as-is for now.

But it inherits from 3a251bac0d1a the general "we should be able to
count the value" expectation, which may not be the best approach to
run this test; asking Acks from those originally involved in this
area and possibly ideas to test this in a more robust way.

Thanks.


> diff --git a/bulk-checkin.c b/bulk-checkin.c
> index 98ec8938424..855b68ec23b 100644
> --- a/bulk-checkin.c
> +++ b/bulk-checkin.c
> @@ -340,6 +340,8 @@ void fsync_loose_object_bulk_checkin(int fd, const char *filename)
>  	 */
>  	if (!bulk_fsync_objdir ||
>  	    git_fsync(fd, FSYNC_WRITEOUT_ONLY) < 0) {
> +		if (errno == ENOSYS)
> +			warning(_("core.fsyncMethod = batch is unsupported on this platform"));
>  		fsync_or_die(fd, filename);
>  	}
>  }
> diff --git a/t/t5351-unpack-large-objects.sh b/t/t5351-unpack-large-objects.sh
> index f785cb06173..dd7ebc40072 100755
> --- a/t/t5351-unpack-large-objects.sh
> +++ b/t/t5351-unpack-large-objects.sh
> @@ -70,9 +70,15 @@ test_expect_success 'unpack big object in stream (core.fsyncmethod=batch)' '
>  	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" \
>  	GIT_TEST_FSYNC=true \
>  		git -C dest.git $BATCH_CONFIGURATION unpack-objects <pack-$PACK.pack &&
> -	check_fsync_events trace2.txt <<-\EOF &&
> +	if grep "core.fsyncMethod = batch is unsupported" trace2.txt
> +	then
> +		flush_count=7
> +	else
> +		flush_count=1
> +	fi &&
> +	check_fsync_events trace2.txt <<-EOF &&
>  	"key":"fsync/writeout-only","value":"6"
> -	"key":"fsync/hardware-flush","value":"1"
> +	"key":"fsync/hardware-flush","value":"$flush_count"
>  	EOF
>  
>  	test_dir_is_empty dest.git/objects/pack &&
