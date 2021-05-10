Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A83AC433ED
	for <git@archiver.kernel.org>; Mon, 10 May 2021 16:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D06E610F7
	for <git@archiver.kernel.org>; Mon, 10 May 2021 16:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbhEJQV1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 12:21:27 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:43020 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231144AbhEJQV1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 12:21:27 -0400
Received: from host-92-1-139-132.as13285.net ([92.1.139.132] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1lg8do-0006nw-BK; Mon, 10 May 2021 17:20:20 +0100
Subject: Re: gitignore + commit with excludes = bug
To:     Paul Jackson <mailnew4ster@gmail.com>,
        Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org
References: <e4c3d482-03b4-141c-e47b-cb3e175da3ab@iee.email>
 <789bcc9cd074cb94f706b9d432e29b52bf6a33c3.1620134775.git.matheus.bernardino@usp.br>
 <CAGKR6vLqXpdSr_boKR_V5SMqkACt9BSBa2UA6rW46GvcymjXtg@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <cb6c20cf-6461-3ef6-7a2e-cb98b7b05b1f@iee.email>
Date:   Mon, 10 May 2021 17:20:19 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAGKR6vLqXpdSr_boKR_V5SMqkACt9BSBa2UA6rW46GvcymjXtg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 09/05/2021 07:21, Paul Jackson wrote:
> Thanks, I hope it gets merged at some point.

Are you able to pull it together as a formal patch, with a suitable
commit message, so that it can be reviewed and merged?

Philip

>
> On Tue, May 4, 2021 at 5:07 PM Matheus Tavares
> <matheus.bernardino@usp.br> wrote:
>> Hi, Paul and Philip
>>
>> On Tue, May 4, 2021 at 9:55 AM Philip Oakley <philipoakley@iee.email> wrote:
>>> Hi Paul,
>>>
>>> On 01/05/2021 19:37, Paul Jackson wrote:
>>>> Hello,
>>>>
>>>> I stumbled upon what I believe is a bug in git.
>>>> See the following reproduction steps:
>>>>
>>>> mkdir test
>>>> cd test
>>>> git init
>>>> echo 1 > ignored
>>>> echo 1 > not-ignored
>>>> echo ignored > .gitignore
>>>> git add -A -- ':!ignored' || echo 'ERROR!!!'
>>>>
>>>> In these steps, I ignore the "ignored" file twice - first time in
>>>> .gitignore, and second time in the "git add" command. I didn't expect
>>>> this to be a problem, but I'm getting the following error message:
>>>>
>>>> The following paths are ignored by one of your .gitignore files:
>>>> ignored
>>>>
>>>> It looks as if git thinks I wanted to include, not exclude "ignored"
>>>> in "git add".
>>> I was intrigued by this. The man pages can be hard to decipher, and it
>>> may be an 'as designed' feature, but still not intuitive
>>>
>>> It took a while to find the relevant parts of the man pages.
>>>
>>> The `-A` option of `add` is under
>>> https://git-scm.com/docs/git-add#Documentation/git-add.txt---no-ignore-removal
>>> which has caveats for whether a pathspec is given.
>>>
>>> The `exclude` magic pathspec is under
>>> https://git-scm.com/docs/gitglossary#Documentation/gitglossary.txt-exclude
>>> and again has caveats and a double negative regarding whether the
>>> `exclude` pathspec counts as a path spec.
>>>
>>> I _think_ that it is saying that the `exclude` pathspec is ignored for
>>> the purpose of the `-A` (all) condition for git add.
>> Hmm, I think the issue is not really related to `-A`. In fact, if we
>> reproduce Paul's original example without `-A`, we still get the
>> warning.
>>
>> The problem seems to be at `dir.c:exclude_matches_pathspec()`, which
>> creates the list of ignored files that is later used by `git add` to
>> presented the "The following paths are ignored..." warning.
>>
>> This function ignores the `exclude` magic, so a path 'x' incorrectly
>> matches both ':x' and ':!x'. And thus, we end up warning the user about
>> 'x' being ignored even when the user had ran `git add ':!x'`.
>>
>> I think something like this, might solve the problem:
>>
>> diff --git a/dir.c b/dir.c
>> index 3474e67e8f..165ca6a543 100644
>> --- a/dir.c
>> +++ b/dir.c
>> @@ -2042,6 +2042,25 @@ static int exclude_matches_pathspec(const char *path, int pathlen,
>>                 const struct pathspec_item *item = &pathspec->items[i];
>>                 int len = item->nowildcard_len;
>>
>> +               if (!(item->magic & PATHSPEC_EXCLUDE))
>> +                       continue;
>> +
>> +               if (len == pathlen &&
>> +                   !ps_strncmp(item, item->match, path, pathlen))
>> +                       return 0;
>> +               if (len > pathlen &&
>> +                   item->match[pathlen] == '/' &&
>> +                   !ps_strncmp(item, item->match, path, pathlen))
>> +                       return 0;
>> +       }
>> +
>> +       for (i = 0; i < pathspec->nr; i++) {
>> +               const struct pathspec_item *item = &pathspec->items[i];
>> +               int len = item->nowildcard_len;
>> +
>> +               if (item->magic & PATHSPEC_EXCLUDE)
>> +                       continue;
>> +
>>                 if (len == pathlen &&
>>                     !ps_strncmp(item, item->match, path, pathlen))
>>                         return 1;
>> ---
>>
>> I had to split the original loop into two and handle the `exclude`
>> pathspecs first because we cannot let the original loop return early
>> when one of the `non-exclude` pathspecs matches the path. Otherwise, we
>> would still incorrectly warn the user on executions like
>> `git add ignored ':!ignored'`.
>>
>> (We might also want to extract the matching part to its own function to
>> avoid repeating this code on the two loops.)

