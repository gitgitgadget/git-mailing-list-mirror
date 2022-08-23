Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE4FBC32789
	for <git@archiver.kernel.org>; Tue, 23 Aug 2022 17:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240358AbiHWRQm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Aug 2022 13:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344261AbiHWRPw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2022 13:15:52 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573477FE4F
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 06:51:04 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 6E3053F40F3;
        Tue, 23 Aug 2022 09:51:03 -0400 (EDT)
Received: from jeffhost-mbp.local (unknown [IPv6:2600:1014:b122:41a:c2:57ee:2a32:2b0e])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id DCA373F4090;
        Tue, 23 Aug 2022 09:51:02 -0400 (EDT)
Subject: Re: [PATCH] fsmonitor: option to allow fsmonitor to run against
 network-mounted repos
To:     Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>,
        Eric DeCosta <edecosta@mathworks.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <pull.1326.git.1660855703816.gitgitgadget@gmail.com>
 <xmqqsflqlfjq.fsf@gitster.g> <092oq98r-39q3-4s66-0n0p-r77po7pq8275@tzk.qr>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <055470ae-1483-bbd4-5b23-3762a4c131b8@jeffhostetler.com>
Date:   Tue, 23 Aug 2022 09:51:01 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <092oq98r-39q3-4s66-0n0p-r77po7pq8275@tzk.qr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: mailmunge 3.09 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/22/22 9:22 AM, Johannes Schindelin wrote:
> Hi Junio,
> 
> On Sat, 20 Aug 2022, Junio C Hamano wrote:
> 
>>> As a first step towards enabling fsmonitor to work against
>>> network-mounted repos, a configuration option, 'fsmonitor.allowRemote'
>>> was introduced for Windows. Setting this option to true will override
>>> the default behavior (erroring-out) when a network-mounted repo is
>>> detected by fsmonitor. In order for macOS to have parity with Windows,
>>> the same option is now introduced for macOS.
>>
>> With this merged in, recent CI runs for 'seen'
>>
>> e.g. https://github.com/git/git/actions/runs/2892889122
>>
>> seems to break macOS jobs, letting them hog CPU forever and exceed
>> 6hr or whatever the limit is.
>>
>> As an experiment I pushed out 'seen' but without this commit (not
>> the entire topic is excluded, the Windows one is still included).
>> As there is nothing specific to macOS between 'next' and 'seen',
>> macOS jobs seem to pass, which is not very surprising.
>>
>> https://github.com/git/git/actions/runs/2896207171
>>
>> As the patch collected some review comments, I've already marked it
>> in the "What's cooking" draft as expecting a reroll of that step;
>> until that happens, let's keep it out of 'seen'.
> 
> It makes sense to keep it out of `seen`, and at the same time I would like
> to encourage Eric to investigate what causes those time-outs.
> 
> When toggling timestamps (click on the wheel on the upper right) at
> https://github.com/git/git/runs/7927812510?check_suite_focus=true#step:4:1774,
> it can be seen that at close to 1am, t9903 finished, but then nothing
> happens until twenty past 6am.
> 
> I've downloaded the raw logs (also available via the wheel on the upper
> right) to find out which test timed out:
> 
> 	$ diff -u \
> 	  <(sed -n 's/.*\] \(t[0-9][^ ]*\).*/\1/p' <~/Downloads/17 | sort) \
> 	  <(git ls-tree upstream/seen:t | cut -c 54- | grep '^t[0-9].*-.*sh$')
> 
> 	--- /dev/fd/63  2022-08-22 14:56:05.510269527 +0200
> 	+++ /dev/fd/62  2022-08-22 14:56:05.510269527 +0200
> 	@@ -794,6 +794,7 @@
> 	 t7524-commit-summary.sh
> 	 t7525-status-rename.sh
> 	 t7526-commit-pathspec-file.sh
> 	+t7527-builtin-fsmonitor.sh
> 	 t7528-signed-commit-ssh.sh
> 	 t7600-merge.sh
> 	 t7601-merge-pull-config.sh
> 	@@ -945,6 +946,7 @@
> 	 t9812-git-p4-wildcards.sh
> 	 t9813-git-p4-preserve-users.sh
> 	 t9814-git-p4-rename.sh
> 	+t9815-git-p4-submit-fail.sh
> 	 t9816-git-p4-locked.sh
> 	 t9817-git-p4-exclude.sh
> 	 t9818-git-p4-block.sh
> 	@@ -964,5 +966,8 @@
> 	 t9832-unshelve.sh
> 	 t9833-errors.sh
> 	 t9834-git-p4-file-dir-bug.sh
> 	+t9835-git-p4-metadata-encoding-python2.sh
> 	+t9836-git-p4-metadata-encoding-python3.sh
> 	 t9901-git-web--browse.sh
> 	+t9902-completion.sh
> 	 t9903-bash-prompt.sh
> 
> I have no idea what's up with t98* and t9902, but I would bet that they
> were somehow "swallowed" by `prove` being terminated, and that the
> actual test script that times out is t7527.
> 
> Eric: To investigate, you will want to reproduce the problem on a macOS
> machine. If you have none available, you could create a temporary branch,
> heavily edit the CI definition, and push it to GitHub. And by heavy edits
> I mean something like this:
> 
> - Remove all non-macOS jobs from `.github/workflows/main.yml` (that means
>    removing all but the `regular` job, removing all but at least one
>    `macos` matrix entry, and removing the the `needs: ci-config` and
>    corresponding `if:` line.
> 
> - Edit `t/Makefile` to define `T = t7527-builtin-fsmonitor.sh` instead of
>    running all the tests.
> 
> - Edit `.github/workflows/main.yml` so that the step that causes the
>    time-out has a chance of timing out much sooner (and the subsequent
>    steps then have a chance to upload the relevant logs):
>    https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions#jobsjob_idstepstimeout-minutes

I would also set GIT_TRACE_FSMONITOR and GIT_TRACE2_PERF (on both daemon
and client sides of the tests) and capture the logs and try to figure
out what is happening.

I suspect that this testing should wait until you redo the patch to
remove the tmp file stuff and just move the socket into $HOME as we
talked about earlier.

Jeff

