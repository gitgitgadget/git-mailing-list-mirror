Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FEA5C433EF
	for <git@archiver.kernel.org>; Fri, 11 Mar 2022 07:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344910AbiCKHjC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 02:39:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbiCKHjA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 02:39:00 -0500
Received: from bsmtp.bon.at (bsmtp.bon.at [213.33.87.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1187140A3E
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 23:37:54 -0800 (PST)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 4KFHpQ0qKMz5tlL;
        Fri, 11 Mar 2022 08:37:50 +0100 (CET)
Message-ID: <83d1c3cc-e281-4455-60d4-ead53d578bb8@kdbg.org>
Date:   Fri, 11 Mar 2022 08:37:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] reflog: don't be noisy on empty reflogs
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <571c0796-66d4-e8c7-c5a5-2e7a28132aa9@kdbg.org>
 <de5e2b0e290791d0a4f58a893d8571b5fc8c4f1a.1646952843.git.avarab@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <de5e2b0e290791d0a4f58a893d8571b5fc8c4f1a.1646952843.git.avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.03.22 um 23:56 schrieb Ævar Arnfjörð Bjarmason:
> Fix a regression in my daf1d8285ee (reflog expire: don't use
> lookup_commit_reference_gently(), 2021-12-22), in changing from
> lookup_commit_reference_gently() to lookup_commit() we stopped trying
> to call deref_tag() and parse_object() on the provided OID, but we
> also started returning non-NULL for the null_oid().
> 
> As a result we'd emit an error() via mark_reachable() later in this
> function as we tried to invoke parse_commit() on it.
> 
> Reported-by: Johannes Sixt <j6t@kdbg.org>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
> 
> On Thu, Mar 10 2022, Johannes Sixt wrote:
> 
>> Since daf1d8285eeb ("reflog expire: don't use
>> lookup_commit_reference_gently()", 2021-12-22) we see
>>
>> $ git reflog expire --all
>> error: Could not read 0000000000000000000000000000000000000000
>>
>> that was not there before.
>>
>> The problem seem to be empty reflog files. I assume they can be created
>> when reflogs expire completely. I have a handful of them in repository
>> that was quiet for a long while.
>>
>> To reproduce:
>>
>> git init
>> mkdir -p .git/logs/refs/heads
>> touch .git/logs/refs/heads/foo
>> git reflog expire --all
> 
> Thanks, and sorry about that. I believe this should fix it.
> 
>  builtin/reflog.c  | 2 ++
>  t/t1410-reflog.sh | 9 +++++++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/builtin/reflog.c b/builtin/reflog.c
> index 016466852f1..3fdf926759c 100644
> --- a/builtin/reflog.c
> +++ b/builtin/reflog.c
> @@ -374,6 +374,8 @@ static void reflog_expiry_prepare(const char *refname,
>  		cb->unreachable_expire_kind = UE_HEAD;
>  	} else {
>  		commit = lookup_commit(the_repository, oid);
> +		if (commit && is_null_oid(&commit->object.oid))
> +			commit = NULL;
>  		cb->unreachable_expire_kind = commit ? UE_NORMAL : UE_ALWAYS;
>  	}
>  
> diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
> index 68f69bb5431..ea8e6ac2a02 100755
> --- a/t/t1410-reflog.sh
> +++ b/t/t1410-reflog.sh
> @@ -423,4 +423,13 @@ test_expect_success 'expire with multiple worktrees' '
>  	)
>  '
>  
> +test_expect_success REFFILES 'empty reflog' '
> +	test_when_finished "rm -rf empty" &&
> +	git init empty &&
> +	test_commit -C empty A &&
> +	>empty/.git/logs/refs/heads/foo &&
> +	git -C empty reflog expire --all 2>err &&
> +	test_must_be_empty err
> +'
> +
>  test_done

Thank you for the quick turnaround. This does indeed remove the error
message.

Tested-by: Johannes Sixt <j6t@kdbg.org>

-- Hannes
