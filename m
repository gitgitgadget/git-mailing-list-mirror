Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A66061F403
	for <e@80x24.org>; Sun, 17 Jun 2018 15:05:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933508AbeFQPE6 (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Jun 2018 11:04:58 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:61908 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933432AbeFQPE5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Jun 2018 11:04:57 -0400
Received: from [192.168.2.240] ([92.22.19.223])
        by smtp.talktalk.net with SMTP
        id UZEbf2TVDoI6LUZEbfSxf4; Sun, 17 Jun 2018 16:04:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1529247895;
        bh=YMoBSfY/xCjCw94MbXkBU4FilNUSxceY2ZoyQsLUhiI=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=gGsctVcLZp3/b3tDzYUUaet8q061EjyOdXr+iXJcvWY4v/jihPf6YnjLKyVq+fKQH
         aLV/S+gsWAZUIfMIj4K40hGj0Es5NzoA4eWwYMNpegzgG1P5+S2wZrgnn4aFEdwN4X
         5e+4ShM3sfwX3Y+h9KBNvSOFbD1qQKnWeVKd3vHg=
X-Originating-IP: [92.22.19.223]
X-Spam: 0
X-OAuthority: v=2.3 cv=FOE1Odgs c=1 sm=1 tr=0 a=DH/r9e32v+C519lOzZJhbw==:117
 a=DH/r9e32v+C519lOzZJhbw==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=_mMwHqrrNykCLcPBQuMA:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] sequencer: do not squash 'reword' commits when we hit
 conflicts
To:     Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     ch <cr@onlinehome.de>, johannes.schindelin@gmx.de,
        git@vger.kernel.org, gitster@pobox.com
References: <CAPig+cRKxpNrTNSEgB66LBxcJk1b24ViR=T-fkqo07wxMFywpQ@mail.gmail.com>
 <20180617053703.19856-1-newren@gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <d62d834a-58dd-590a-cf71-028220323bf9@talktalk.net>
Date:   Sun, 17 Jun 2018 16:04:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180617053703.19856-1-newren@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfDS4/2ZWIklhT6i8lZbP0xX2NNmHjnSvjiGLuF4L0oBas6++s97JeLBH1DWSb1006w4GczSeef+CXpg46bpTIQrYCHhohDntqwU0LUwnfxqLyH/N7EW2
 924MAXv40Wqi2aBgfXlzMhsCkCoy8xeemCIXXZiM3yEmXPPdH4Sj3FDkT7/80Cy6/yGXJ8ItnO/Ap32Us6K7d2/EWqwbQ51Iv40L1evm5OrIb3vznsKyip5E
 abktVxhalr44KLIg8N2X0wLySKqqrHRNPlJcZY57CSnq2gRfNDF1k5uiqPTcPv3g4FgvlJYhk68PY+Rh7aQjosjYgvw7cdSr+WYocHu5UZo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On 17/06/18 06:37, Elijah Newren wrote:
> Ever since commit 18633e1a22 ("rebase -i: use the rebase--helper builtin",
> 2017-02-09), when a commit marked as 'reword' in an interactive rebase
> has conflicts and fails to apply, when the rebase is resumed that commit
> will be squashed into its parent with its commit message taken.
> 
> The issue can be understood better by looking at commit 56dc3ab04b
> ("sequencer (rebase -i): implement the 'edit' command", 2017-01-02), which
> introduced error_with_patch() for the edit command.  For the edit command,
> it needs to stop the rebase whether or not the patch applies cleanly.  If
> the patch does apply cleanly, then when it resumes it knows it needs to
> amend all changes into the previous commit.  If it does not apply cleanly,
> then the changes should not be amended.  Thus, it passes !res (success of
> applying the 'edit' commit) to error_with_patch() for the to_amend flag.
> 
> The problematic line of code actually came from commit 04efc8b57c
> ("sequencer (rebase -i): implement the 'reword' command", 2017-01-02).
> Note that to get to this point in the code:
>    * !!res (i.e. patch application failed)
>    * item->command < TODO_SQUASH
>    * item->command != TODO_EDIT
>    * !is_fixup(item->command) [i.e. not squash or fixup]
> So that means this can only be a failed patch application that is either a
> pick, revert, or reword.  For any of those cases we want a new commit, so
> we should not set the to_amend flag.

Unfortunately I'm not sure it's that simple. Looking and do_pick() 
sometimes reword amends HEAD and sometimes it does not. In the "normal" 
case then the commit is picked and committed with '--edit'. However when 
fast-forwarding the code fast forwards to the commit to be reworded and 
then amends it. If the root commit is being reworded it takes the same 
code path. While these cases cannot fail with conflicts, it is possible 
for the user to cancel the commit or for them to fail due to collisions 
with untracked files.

If I remember correctly the shell version always picks the commit and 
then calls 'git commit --amend' afterwards which is less efficient but 
consistent.

I'm afraid I don't have a simple solution for fixing this, as currently 
pick_commits() does not know if the commit was called with AMEND_MSG, I 
guess that means adding some kind of flag for do_pick() to set.

Best Wishes

Phillip

> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
> Differences since v1 (Thanks to Eric Sunshine for the suggestions):
>    * Add test_when_finished "reset_rebase" calls
>    * Remove unnecessary word from description of test
> 
>   sequencer.c              |  2 +-
>   t/t3423-rebase-reword.sh | 48 ++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 49 insertions(+), 1 deletion(-)
>   create mode 100755 t/t3423-rebase-reword.sh
> 
> diff --git a/sequencer.c b/sequencer.c
> index cca968043e..9e6d1ee368 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -3217,7 +3217,7 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
>   			} else if (res && is_rebase_i(opts) && item->commit)
>   				return res | error_with_patch(item->commit,
>   					item->arg, item->arg_len, opts, res,
> -					item->command == TODO_REWORD);
> +					0);
>   		} else if (item->command == TODO_EXEC) {
>   			char *end_of_arg = (char *)(item->arg + item->arg_len);
>   			int saved = *end_of_arg;
> diff --git a/t/t3423-rebase-reword.sh b/t/t3423-rebase-reword.sh
> new file mode 100755
> index 0000000000..6963750794
> --- /dev/null
> +++ b/t/t3423-rebase-reword.sh
> @@ -0,0 +1,48 @@
> +#!/bin/sh
> +
> +test_description='git rebase interactive with rewording'
> +
> +. ./test-lib.sh
> +
> +. "$TEST_DIRECTORY"/lib-rebase.sh
> +
> +test_expect_success 'setup' '
> +	test_commit master file-1 test &&
> +
> +	git checkout -b stuff &&
> +
> +	test_commit feature_a file-2 aaa &&
> +	test_commit feature_b file-2 ddd
> +'
> +
> +test_expect_success 'reword without issues functions as intended' '
> +	test_when_finished "reset_rebase" &&
> +
> +	git checkout stuff^0 &&
> +
> +	set_fake_editor &&
> +	FAKE_LINES="pick 1 reword 2" FAKE_COMMIT_MESSAGE="feature_b_reworded" \
> +		git rebase -i -v master &&
> +
> +	test "$(git log -1 --format=%B)" = "feature_b_reworded" &&
> +	test $(git rev-list --count HEAD) = 3
> +'
> +
> +test_expect_success 'reword after a conflict preserves commit' '
> +	test_when_finished "reset_rebase" &&
> +
> +	git checkout stuff^0 &&
> +
> +	set_fake_editor &&
> +	test_must_fail env FAKE_LINES="reword 2" \
> +		git rebase -i -v master &&
> +
> +	git checkout --theirs file-2 &&
> +	git add file-2 &&
> +	FAKE_COMMIT_MESSAGE="feature_b_reworded" git rebase --continue &&
> +
> +	test "$(git log -1 --format=%B)" = "feature_b_reworded" &&
> +	test $(git rev-list --count HEAD) = 2
> +'
> +
> +test_done
> 

