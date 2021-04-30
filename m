Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5768CC433B4
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 15:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A9F76144D
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 15:18:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhD3PTk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Apr 2021 11:19:40 -0400
Received: from siwi.pair.com ([209.68.5.199]:21380 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230116AbhD3PTk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Apr 2021 11:19:40 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id C209A3F40B7;
        Fri, 30 Apr 2021 11:18:51 -0400 (EDT)
Received: from HCIPROD2.AZHCI.com (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 962A43F4098;
        Fri, 30 Apr 2021 11:18:51 -0400 (EDT)
Subject: Re: [PATCH 09/23] fsmonitor--daemon: implement daemon command options
To:     Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
 <2b291d805d59b54203d939e048bb568782d5e17b.1617291666.git.gitgitgadget@gmail.com>
 <91a0fc4b-505a-fa2b-c797-5e420e836642@gmail.com>
 <3aa3c802-0ad1-0a65-d646-0cd574cb8036@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <a7e8ef01-b707-5b4a-2652-cc3e08bb85f2@jeffhostetler.com>
Date:   Fri, 30 Apr 2021 11:18:51 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <3aa3c802-0ad1-0a65-d646-0cd574cb8036@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/26/21 12:12 PM, Derrick Stolee wrote:
> On 4/26/2021 11:47 AM, Derrick Stolee wrote:
>> On 4/1/21 11:40 AM, Jeff Hostetler via GitGitGadget wrote:
>>> From: Jeff Hostetler <jeffhost@microsoft.com>
>> ...
>>> +	/* Prepare to (recursively) watch the <worktree-root> directory. */
>>> +	strbuf_init(&state.path_worktree_watch, 0);
>>> +	strbuf_addstr(&state.path_worktree_watch, absolute_path(get_git_work_tree()));
>>> +	state.nr_paths_watching = 1;
>>
>> Yes, let's watch the working directory.
>>
>>> +	/*
>>> +	 * If ".git" is not a directory, then <gitdir> is not inside the
>>> +	 * cone of <worktree-root>, so set up a second watch for it.
>>> +	 */
>>> +	strbuf_init(&state.path_gitdir_watch, 0);
>>> +	strbuf_addbuf(&state.path_gitdir_watch, &state.path_worktree_watch);
>>> +	strbuf_addstr(&state.path_gitdir_watch, "/.git");
>>> +	if (!is_directory(state.path_gitdir_watch.buf)) {
>>> +		strbuf_reset(&state.path_gitdir_watch);
>>> +		strbuf_addstr(&state.path_gitdir_watch, absolute_path(get_git_dir()));
>>> +		state.nr_paths_watching = 2;
>>> +	}
>>
>> But why watch the .git directory, especially for a worktree (or
>> submodule I guess)? What benefit do we get from events within the
>> .git directory? I'm expecting any event within the .git directory
>> should be silently ignored.
> 
> I see in a following patch that we place a cookie file within the
> .git directory. I'm reminded that this is done for a reason: other
> filesystem watchers can get into a loop if we place the cookie
> file outside of the .git directory. The classic example is VS Code
> running 'git status' in a loop because Watchman writes a cookie
> into the root of the working directory.

Yes.  I'll add a comment explaining the need for the second watch.
