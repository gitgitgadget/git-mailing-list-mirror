Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B75FC433EF
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 20:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F28F610A0
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 20:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243779AbhJ0UIq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 16:08:46 -0400
Received: from siwi.pair.com ([209.68.5.199]:52719 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243776AbhJ0UIp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 16:08:45 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 711553F4821;
        Wed, 27 Oct 2021 16:06:19 -0400 (EDT)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 3E1F43F40FB;
        Wed, 27 Oct 2021 16:06:19 -0400 (EDT)
Subject: Re: [PATCH v4 29/29] t7527: test status with untracked-cache and
 fsmonitor--daemon
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1041.v3.git.1634157107.gitgitgadget@gmail.com>
 <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
 <507020bbef08a02afc53815754cc999c390eb7c7.1634826309.git.gitgitgadget@gmail.com>
 <CAPig+cT1j6NsZaSM+_JgGksmH4XGsnh7Pe=dbELoBU+FisHGag@mail.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <d9c3ef61-768c-3560-2858-3438c355a742@jeffhostetler.com>
Date:   Wed, 27 Oct 2021 16:06:18 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cT1j6NsZaSM+_JgGksmH4XGsnh7Pe=dbELoBU+FisHGag@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/22/21 1:23 AM, Eric Sunshine wrote:
> On Thu, Oct 21, 2021 at 10:26 AM Jeff Hostetler via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> Create 2x2 test matrix with the untracked-cache and fsmonitor--daemon
>> features and a series of edits and verify that status output is
>> identical.
>>
>> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
>> ---
>> diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
>> @@ -508,4 +510,98 @@ test_expect_success 'cleanup worktrees' '
>> +test_lazy_prereq UNTRACKED_CACHE '
>> +       { git update-index --test-untracked-cache; ret=$?; } &&
>> +       test $ret -ne 1
>> +'
> 
> I may be missing something obvious, but can't this be expressed more simply as:
> 
>      test_lazy_prereq UNTRACKED_CACHE '
>          git update-index --test-untracked-cache
>          test $? -ne 1
>      '
> 
> How significant is it to test specifically against 1? If not, then
> even simpler would be:
> 
>      test_lazy_prereq UNTRACKED_CACHE '
>          git update-index --test-untracked-cache
>      '
> 
> which is also more robust since it won't be fooled by die() or crashes.
> 

IIRC I stole that from t7063.  It didn't occur to me to try to
simplify it.


>> +test_expect_success 'Matrix: setup for untracked-cache,fsmonitor matrix' '
>> +       test_might_fail git config --unset core.useBuiltinFSMonitor &&
> 
> More idiomatic:
> 
>      test_unconfig core.useBuiltinFSMonitor &&
> 

Good to know, thanks!
I'll take a look at this and the rest of your comments below.

thanks
Jeff


>> +       git update-index --no-fsmonitor &&
>> +       test_might_fail git fsmonitor--daemon stop
>> +'
>> +
>> +matrix_clean_up_repo () {
>> +       git reset --hard HEAD
>> +       git clean -fd
>> +}
> 
> Since calls to this function are part of the &&-chain in tests, it
> probably would be a good idea to maintain the &&-chain within the body
> of the function, as well.
> 
>> +matrix_try () {
>> +       test_expect_success "Matrix[uc:$uc][fsm:$fsm] $fn" '
>> +               matrix_clean_up_repo &&
>> +               $fn &&
>> +               if test $uc = false -a $fsm = false
> 
> We avoid -a and -o with `test` and instead chain them with &&:
> 
>      if test $uc = false && test $fsm = false
> 
> Documentation/CodingGuidelines mentions this. Also see [1] & [2].
> 
> [1]: https://lore.kernel.org/git/xmqqa6qkb5fi.fsf@gitster.g/
> [2]: https://lore.kernel.org/git/CAPig+cQFFsLeE921WpzTxVnBMnNRiKs4N=hUQ2UQi1VznNEQwg@mail.gmail.com/
> 
>> +               then
>> +                       git status --porcelain=v1 >.git/expect.$fn
>> +               else
>> +                       git status --porcelain=v1 >.git/actual.$fn
>> +                       test_cmp .git/expect.$fn .git/actual.$fn
>> +               fi
>> +       '
> 
> Broken &&-chain in the `else` arm.
> 
>> +       return $?
>> +}
> 
> No callers care about the return value of this function, so the
> `return $?` can be dropped.
> 
>> +uc_values="false"
>> +test_have_prereq UNTRACKED_CACHE && uc_values="false true"
>> +for uc_val in $uc_values
>> +do
>> +       if test $uc_val = false
>> +       then
>> +               test_expect_success "Matrix[uc:$uc_val] disable untracked cache" '
>> +                       git config core.untrackedcache false &&
>> +                       git update-index --no-untracked-cache
>> +               '
>> +       else
>> +               test_expect_success "Matrix[uc:$uc_val] enable untracked cache" '
>> +                       git config core.untrackedcache true &&
>> +                       git update-index --untracked-cache
>> +               '
>> +       fi
>> +
>> +       fsm_values="false true"
>> +       for fsm_val in $fsm_values
>> +       do
>> +               if test $fsm_val = false
>> +               then
>> +                       test_expect_success "Matrix[uc:$uc_val][fsm:$fsm_val] disable fsmonitor" '
>> +                               test_might_fail git config --unset core.useBuiltinFSMonitor &&
> 
> Ditto: test_unconfig()
> 
>> +                               git update-index --no-fsmonitor &&
>> +                               test_might_fail git fsmonitor--daemon stop 2>/dev/null
>> +                       '
> 
> stderr is redirected within tests anyhow, so we normally don't
> suppress it manually like this (especially since it may come in handy
> when debugging a failing test).
> 
>> +               else
>> +                       test_expect_success "Matrix[uc:$uc_val][fsm:$fsm_val] enable fsmonitor" '
>> +                               git config core.useBuiltinFSMonitor true &&
>> +                               git fsmonitor--daemon start &&
>> +                               git update-index --fsmonitor
>> +                       '
>> +               fi
>> +
>> +               matrix_try $uc_val $fsm_val edit_files
>> +               matrix_try $uc_val $fsm_val delete_files
>> +               matrix_try $uc_val $fsm_val create_files
>> +               matrix_try $uc_val $fsm_val rename_files
>> +               matrix_try $uc_val $fsm_val file_to_directory
>> +               matrix_try $uc_val $fsm_val directory_to_file
>> +
>> +               if test $fsm_val = true
>> +               then
>> +                       test_expect_success "Matrix[uc:$uc_val][fsm:$fsm_val] disable fsmonitor at end" '
>> +                               test_might_fail git config --unset core.useBuiltinFSMonitor &&
> 
> Ditto: test_unconfig()
> 
>> +                               git update-index --no-fsmonitor &&
>> +                               test_might_fail git fsmonitor--daemon stop 2>/dev/null
> 
> Ditto: stderr
> 
>> +                       '
>> +               fi
>> +       done
>> +done
