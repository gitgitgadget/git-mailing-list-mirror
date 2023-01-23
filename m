Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E17DC38142
	for <git@archiver.kernel.org>; Mon, 23 Jan 2023 16:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbjAWQ5C (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Jan 2023 11:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbjAWQ5A (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2023 11:57:00 -0500
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2D04219
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 08:56:58 -0800 (PST)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 7C186CA1264;
        Mon, 23 Jan 2023 11:56:57 -0500 (EST)
Received: from [192.168.4.22] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 39A39CC83BB;
        Mon, 23 Jan 2023 11:56:57 -0500 (EST)
Message-ID: <f7449e73-7f50-67ea-2be4-2037f98a69f3@jeffhostetler.com>
Date:   Mon, 23 Jan 2023 11:56:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [CI]: Is t7527 known to be flakey?
Content-Language: en-US
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Jeff Hostetler <jeffhostetler@github.com>, edecosta@mathworks.com,
        git@vger.kernel.org
References: <xmqqtu0lzzn2.fsf@gitster.g> <20230121102355.GA2155@szeder.dev>
From:   Jeff Hostetler <git@jeffhostetler.com>
In-Reply-To: <20230121102355.GA2155@szeder.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.10 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 1/21/23 5:23 AM, SZEDER Gábor wrote:
> On Thu, Jan 19, 2023 at 06:52:01PM -0800, Junio C Hamano wrote:
>> The said test failed its linux-musl job in its first attempt, but
>> re-running the failed job passed.
>>
>>      https://github.com/git/git/actions/runs/3963948890/jobs/6792356234
>>      (seen@e096683 attempt #1 linux-musl)
>>
>>      https://github.com/git/git/actions/runs/3963948890/jobs/6792850313
>>      (seen@e096683 attempt #2 linux-musl)
> 
> t7527 is quite slow, even with the right selection of test cases, but
> this little tweak makes it much faster:
> 
>    diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
>    index 0e497ba98d..4210ef644c 100755
>    --- a/t/t7527-builtin-fsmonitor.sh
>    +++ b/t/t7527-builtin-fsmonitor.sh
>    @@ -676,7 +676,10 @@ test_expect_success 'cleanup worktrees' '
>     # cause incorrect results when the untracked-cache is enabled.
>     
>     test_lazy_prereq UNTRACKED_CACHE '
>    -	git update-index --test-untracked-cache
>    +	# This check takes a very long time, but I know it works on
>    +	# my system, so let's fake it.
>    +	#git update-index --test-untracked-cache
>    +	true
>     '
>     
>     test_expect_success 'Matrix: setup for untracked-cache,fsmonitor matrix' '
> 
> This with the right selection of test cases makes --stress
> practicable, and the test tends to fail after a handful of
> repetitions:
> 
>    ./t7527-builtin-fsmonitor.sh --stress -r 8,23-58
> 
> I saw different failures in multiple test cases, e.g.:
> 
> Unexpected output in case 55:
> 
>    expecting success of 7527.55 'Matrix[uc:true][fsm:true] move_directory_contents_deeper':
>    		matrix_clean_up_repo &&
>    		$fn &&
>    		if test $uc = false && test $fsm = false
>    		then
>    			git status --porcelain=v1 >.git/expect.$fn
>    		else
>    			git status --porcelain=v1 >.git/actual.$fn &&
>    			test_cmp .git/expect.$fn .git/actual.$fn
>    		fi
>    	
>    + matrix_clean_up_repo
>    + git reset --hard HEAD
>    HEAD is now at 1d1edcb initial
>    + git clean -fd
>    + move_directory_contents_deeper
>    + mkdir T1/_new_
>    + mv T1/F1 T1/F2 T1/T2 T1/_new_
>    + test true = false
>    + git status --porcelain=v1
>    error: read error: Connection reset by peer
>    error: could not read IPC response
>    + test_cmp .git/expect.move_directory_contents_deeper .git/actual.move_directory_contents_deeper
>    + test 2 -ne 2
>    + eval diff -u "$@"
>    + diff -u .git/expect.move_directory_contents_deeper .git/actual.move_directory_contents_deeper
>    --- .git/expect.move_directory_contents_deeper	2023-01-21 09:47:12.677410349 +0000
>    +++ .git/actual.move_directory_contents_deeper	2023-01-21 09:47:14.045448573 +0000
>    @@ -7,3 +7,4 @@
>      D T1/T2/T3/T4/F1
>      D T1/T2/T3/T4/F2
>     ?? T1/_new_/
>    +?? dir1
>    error: last command exited with $?=1
>    not ok 55 - Matrix[uc:true][fsm:true] move_directory_contents_deeper
> 
> SIGPIPE in 'git status' cases 42, 43 and 55:
> 
>    expecting success of 7527.42 'Matrix[uc:false][fsm:true] move_directory_contents_deeper':
>                    matrix_clean_up_repo &&
>                    $fn &&
>                    if test $uc = false && test $fsm = false
>                    then
>                            git status --porcelain=v1 >.git/expect.$fn
>                    else
>                            git status --porcelain=v1 >.git/actual.$fn &&
>                            test_cmp .git/expect.$fn .git/actual.$fn
>                    fi
>    
>    + matrix_clean_up_repo
>    + git reset --hard HEAD
>    HEAD is now at 1d1edcb initial
>    + git clean -fd
>    + move_directory_contents_deeper
>    + mkdir T1/_new_
>    + mv T1/F1 T1/F2 T1/T2 T1/_new_
>    + test false = false
>    + test true = false
>    + git status --porcelain=v1
>    error: last command exited with $?=141
>    not ok 42 - Matrix[uc:false][fsm:true] move_directory_contents_deeper
> 
>    expecting success of 7527.43 'Matrix[uc:false][fsm:true] move_directory_up':
>    		matrix_clean_up_repo &&
>    		$fn &&
>    		if test $uc = false && test $fsm = false
>    		then
>    			git status --porcelain=v1 >.git/expect.$fn
>    		else
>    			git status --porcelain=v1 >.git/actual.$fn &&
>    			test_cmp .git/expect.$fn .git/actual.$fn
>    		fi
>    	
>    + matrix_clean_up_repo
>    + git reset --hard HEAD
>    HEAD is now at 1d1edcb initial
>    + git clean -fd
>    Removing T1/_new_/
>    + move_directory_up
>    + mv T1/T2/T3 T1
>    + test false = false
>    + test true = false
>    + git status --porcelain=v1
>    error: last command exited with $?=141
>    not ok 43 - Matrix[uc:false][fsm:true] move_directory_up
> 
>    expecting success of 7527.55 'Matrix[uc:true][fsm:true] move_directory_contents_deeper':
>                    matrix_clean_up_repo &&
>                    $fn &&
>                    if test $uc = false && test $fsm = false
>                    then
>                            git status --porcelain=v1 >.git/expect.$fn
>                    else
>                            git status --porcelain=v1 >.git/actual.$fn &&
>                            test_cmp .git/expect.$fn .git/actual.$fn
>                    fi
>    
>    + matrix_clean_up_repo
>    + git reset --hard HEAD
>    HEAD is now at 1d1edcb initial
>    + git clean -fd
>    + move_directory_contents_deeper
>    + mkdir T1/_new_
>    + mv T1/F1 T1/F2 T1/T2 T1/_new_
>    + test true = false
>    + git status --porcelain=v1
>    error: last command exited with $?=141
> 
> I find it interesting that the output of 'git status' is redirected to
> a file in all these cases, and yet it gets a SIGPIPE.

The `git status` command talks to the running `git fsmonitor--daemon`
on a Unix domain socket (or a Named Pipe on Windows), so a SIGPIPE is
possible.

Was this on Linux or MacOS ?

Jeff




> 
> 
> I also saw the test hang a couple of times, e.g.:
> 
>    $ ./t7527-builtin-fsmonitor.sh --stress -r 8,23-58
>    OK    6.1
>    OK    7.1
>    OK    1.1
>    OK    2.1
>    OK    3.1
>    OK    5.1
>    OK    4.1
>    OK    0.1
>    OK    6.2
>    OK    1.2
>    OK    2.2
>    OK    7.2
>    OK    5.2
>    OK    0.2
>    OK    4.2
>    OK    6.3
>    OK    7.3
>    OK    2.3
>    OK    0.3
>    OK    4.3
>    OK    6.4
>    OK    7.4
>    OK    2.4
>    OK    0.4
>    OK    4.4
>    OK    6.5
>    OK    7.5
>    OK    2.5
>    OK    0.5
>    OK    4.5
>    OK    6.6
>    OK    7.6
>    OK    2.6
>    OK    0.6
>    OK    4.6
>    OK    6.7
>    OK    7.7
>    OK    2.7
>    OK    0.7
>    OK    4.7
>    OK    6.8
>    OK    7.8
>    OK    2.8
>    OK    0.8
>    OK    4.8
>    OK    6.9
>    OK    7.9
>    OK    2.9
>    OK    0.9
>    OK    4.9
>    OK    6.10
>    OK    7.10
>    OK    2.10
>    OK    0.10
>    OK    4.10
>    OK    6.11
>    OK    7.11
>    OK    2.11
>    OK    0.11
>    OK    4.11
>    OK    6.12
>    OK    7.12
>    OK    2.12
>    OK    0.12
>    OK    4.12
>    OK    6.13
>    OK    7.13
>    OK    2.13
>    OK    0.13
>    OK    6.14
>    OK    4.13
>    OK    7.14
>    OK    2.14
>    OK    0.14
>    OK    6.15
>    OK    4.14
>    OK    2.15
>    OK    7.15
>    OK    0.15
>    FAIL  7.16
>    OK    6.16
>    OK    2.16
>    OK    4.15
>    OK    0.16
> 
> At this point the test script should print the log of the failed job,
> but it hangs instead, as there are a number of stuck fsmonitor--daemon
> and status processes (notice how the stress test starts with 8 jobs,
> but the last repetition only has 4):
> 
>    $ ps aux |grep git
>    szeder   1857100  0.0  0.1  72272  4452 pts/2    Sl+  21:40   0:00 /home/szeder/src/git/git fsmonitor--daemon run --detach --ipc-threads=8
>    szeder   1857779  0.0  0.1   6560  4152 pts/2    S+   21:40   0:00 /home/szeder/src/git/git status --porcelain=v1
>    szeder   1860020  0.0  0.1  88664  4312 pts/2    Sl+  21:40   0:00 /home/szeder/src/git/git fsmonitor--daemon run --detach --ipc-threads=8
>    szeder   1860668  0.0  0.1   6560  4040 pts/2    S+   21:40   0:00 /home/szeder/src/git/git status --porcelain=v1
>    szeder   1860749  0.0  0.1  96860  4528 pts/2    Sl+  21:40   0:00 /home/szeder/src/git/git fsmonitor--daemon run --detach --ipc-threads=8
>    szeder   1861281  0.0  0.1   6560  4272 pts/2    S+   21:40   0:00 /home/szeder/src/git/git status --porcelain=v1
> 
