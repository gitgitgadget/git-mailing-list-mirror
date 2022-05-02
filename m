Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF0CCC433EF
	for <git@archiver.kernel.org>; Mon,  2 May 2022 10:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384454AbiEBKgl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 May 2022 06:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345533AbiEBKgk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 May 2022 06:36:40 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5E7136
        for <git@vger.kernel.org>; Mon,  2 May 2022 03:33:12 -0700 (PDT)
Received: from host-84-13-159-41.opaltelecom.net ([84.13.159.41] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1nlTMc-00075N-6j;
        Mon, 02 May 2022 11:33:10 +0100
Message-ID: <ab047b4b-6037-af78-1af6-ad35ac6d7c90@iee.email>
Date:   Mon, 2 May 2022 11:33:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] builtin/remote.c: teach `-v` to list filters for promisor
 remotes
Content-Language: en-GB
To:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Git <git@vger.kernel.org>
References: <xmqqfslt44di.fsf@gitster.g>
 <20220501193807.94369-1-chakrabortyabhradeep79@gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <20220501193807.94369-1-chakrabortyabhradeep79@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/05/2022 20:38, Abhradeep Chakraborty wrote:
> Junio C Hamano <gitster@pobox.com> wrote:
>
>> You forgot to answer more important half of the question.  It would
>> be easy for you to know what the string inside brackets means
>> because you are so obsessed with the promisor remote to write this
>> patch ;-) But when we need to add even more pieces of information in
>> the future, will it stay so?  Can "[some-random-string]" easily be
>> identified as a list-objects-filter by those who do not care
>> particularly about promisor remotes (e.g. those who wanted to see
>> the URL to tell multiple remote nicknames apart) when the line has
>> even more piece of information in the future?
>>
>> At some point, we'd need to either (1) stop adding too many details
>> to avoid cluttering the output line, or (2) start labeling each
>> piece of information to make it easy for the readers to identify
>> which one is which [*].  We need to ask ourselves why now is not
>> that "some point" already.
>>
>>     Side note: and the strategy to add new pieces of information
>>     need to take the same approach between the two, and that is why
>>     we need "what is the plan to add new pieces of information?"
>>     answered.
> I am sorry if I failed to explain you what I really wanted to mean.
> Yes, I forgot to answer the last question which is "When we
> want to add new kinds of information other than the URL and the
> list-objects-filter, what is our plan to add them?".
>
> So let me answer this now. As `-v` flag gives a kind of overall summary
> of the remotes, users expect that the most important and most basic
> information should be listed in the output of `remote -v`. So, there
> may be some other more important informations in the future that we
> have to add to `remote -v` output. In that case, method (1) would not
> be a great idea I think (unless a new flag has been created). method
> (2) is better.

When I use the `git remote` command, I use the -vv variant to what what
I need, i.e. its more than `-v`, so maybe adding an extra
`--show-partial-filter` option may be necessary (with a more compact
name ;-).

There will also be a similar desire (IIUC) to match the sparse/cone mode
repos to their remotes, i.e. to remind a user that what is held at the
remote isn't the same as held locally.
>
>>> (i.e. which are promisor remotes and which are not) one by one. If the
>>> user try to search for the promisor remotes in the config file, he/she
>>> have to go through the other configuration settings (irrelevant to him/her
>>> at that time) to reach the `[remote]` section. Isn't it?
>> Sorry, but the question does not make much sense to me.  Why is a
>> piece of information you get from "git config" irrelevant if you get
>> it in order to figure out what you want to know, i.e.  what promisor
>> remote do we rely on?
> Let me explain what I really meant here - I am guessing that you have no
> problem with the upper part of that para.
>
> If we forget about my proposed change, there are two possible ways to find
> out the info about promisor remotes - 
> 	(1) Use `git config --get remote.<remote-name>.partialCloneFilter`
>
> 	   This command gives an output only if <remote-name> is a promisor
> 	   remote. So in case the user forget which one is a promisor
> 	   remote, he/she has to try this command with each and every
> 	   <remote-name> to find out which is/are the promisor remote(s).

I hear your pain here. I had the same issue with the branch description.
(https://stackoverflow.com/questions/15058844/print-branch-description).
It's the same 'extract from config' problem.
 
```You can display the branch description using a git config command.

To show all branch descriptions, I have the alias

brshow = config --get-regexp 'branch.*.description'

, and for the current HEAD I have

brshow1 = !git config --get "branch.$(git rev-parse --abbrev-ref
HEAD).description". ```

so it is possible to generalise the config query, if hard to discover.
<https://stackoverflow.com/a/15062356/717355>
>
> 	(2) Open the git config file (either manually or by running `git
> 	    config --edit`
>
> 	    In this case, the user has to go through all the settings until
> 	    the [remote "<remote-name>"] section is found. E.g. let's say
> 	    below is the config file - 
>
> 	    [core]
>         	repositoryformatversion = 0
>         	filemode = true
>         	bare = false
>         	logallrefupdates = true
>         	ignorecase = true
>         	precomposeunicode = true
> 	    [remote "upstream"]
>         	url = https://github.com/git/git.git
>         	fetch = +refs/heads/*:refs/remotes/upstream/*
> 	    [branch "master"]
>         	remote = upstream
>         	merge = refs/heads/master
> 	    [remote "origin"]
>         	url = https://github.com/Abhra303/git.git
>         	fetch = +refs/heads/*:refs/remotes/origin/*
> 		partialCloneFilter = blob:none
>
> 	    To find out whether "origin" is promisor or not, he has to go
> 	    to the [remote "origin"] section. Here all the configuations
> 	    under `[core]`, `[remote "upstream"]` and `[branch "master"]
> 	    are irrelevant to him/her at that time (because he/she is not
> 	    interested to know about those configuration settings at that
> 	    time).
>
> The proposed change is simpler compared to the above as it lists down all
> the remotes along with their list-objects-filter. Another point is that
> it's important for an user to know which one is a promisor remote and what
> filter type they use. If we go with the current implementation the output
> would be let's say - 
> origin <remote-url> (fetch)
> origin <remote-url> (push)
> upstream <remote-url> (fetch)
> upstream <remote-url> (push)
>
> By seeing the above output anyone may assume that all the remotes are
> normal remotes. If the user now try to run `git pull origin` and suddenly
> he/she discover that some blobs are not downloaded. He/she run the above
> mentioned (1) command and find that this is a promisor remote!
>
> Here `remote -v` didn't warn the user about the origin remote being an
> promisor remote. Instead it makes him/her assume that all are normal
> remotes. Providing only these three info (i.e. <remote-name>, <remote-url>
> and <direction>) is not sufficient - it only shows the half of the picture.
>
>
>> The question is "what can readers achieve by having this extra
>> information in 'remote -v' output".  Do you have to duck the
>> question because you cannot answer in a simple sentence, and instead
>> readers must read reams of documentation pages?  I doubt it would be
>> that obscure.
> Sorry, I misunderstood that section of your first comment. I think
> I hopefully answered this question in the above portion of this comment.
> Providing only the three information about remotes is not sufficient
> as it do not distinguish between promisor remotes and normal remotes.
> In that sense, it will add simplicity and the user would be much more
> clear about the remotes(i.e. which is promisor remote and which is not).
>
>> I wanted to like the patch, the changed text is simple enough, but
>> quite honestly, the lack of clarity in the answers to the most basic
>> "why do we want this? what is this good for? how does this help the
>> users?" questions, I am not yet succeeding to do so.
> My bad! Hope I am now able to answer all the questions you asked. Let
> me know if you still struggle to get my point.
>
> Thanks :)

