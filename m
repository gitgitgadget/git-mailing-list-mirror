Return-Path: <SRS0=eTRQ=EM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D68C2D0A3
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 23:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C6372087E
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 23:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729071AbgKFXNM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Nov 2020 18:13:12 -0500
Received: from bsmtp2.bon.at ([213.33.87.16]:7702 "EHLO bsmtp2.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728878AbgKFXNI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Nov 2020 18:13:08 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 4CSblj6PSLz5tl9;
        Sat,  7 Nov 2020 00:13:05 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id D5A4420EF;
        Sat,  7 Nov 2020 00:13:04 +0100 (CET)
Subject: Re: git rebase/git rebase --abort cause inconsistent state
To:     Elijah Newren <newren@gmail.com>, Eugen Konkov <kes-kes@yandex.ru>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <1526558917.20201106203213@yandex.ru>
 <CABPp-BGAJiaU5aeC3sGvp3znQw1esrn9c19gyOZQBymYvNFCaw@mail.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <43de6950-a33c-f3da-2a76-72719fef5af3@kdbg.org>
Date:   Sat, 7 Nov 2020 00:13:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BGAJiaU5aeC3sGvp3znQw1esrn9c19gyOZQBymYvNFCaw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 06.11.20 um 21:27 schrieb Elijah Newren:
> On Fri, Nov 6, 2020 at 10:41 AM Eugen Konkov <kes-kes@yandex.ru> wrote:
>> I try to rebase, get conflicts. So I decide to --abort
>>
>> After --abort I expect state before rebasing, but I get conflicts.
>>
>> I  suppose this  is  because `git rebase` switches to not branch and
>> --abort can not return to branch I was on before rebasing
>>
>> Is this a bug?
>>
>>
>>
>>
>> kes@work ~/t/lib/MaitreD $ git rebase dev local/dev
>> Created autostash: 566876c8
>> warning: Cannot merge binary files: share/ChangeAgreement.docx (HEAD vs. f2442d9a... Update Docs.pm)
>> Auto-merging share/ChangeAgreement.docx
>> CONFLICT (content): Merge conflict in share/ChangeAgreement.docx
>> error: could not apply f2442d9a... Update Docs.pm
>> Resolve all conflicts manually, mark them as resolved with
>> "git add/rm <conflicted_files>", then run "git rebase --continue".
>> You can instead skip this commit: run "git rebase --skip".
>> To abort and get back to the state before "git rebase", run "git rebase --abort".
>> Could not apply f2442d9a... Update Docs.pm
>> kes@work ~/t/lib/MaitreD $ git rebase --abort
>> Applying autostash resulted in conflicts.
> ^^^^^^
> 
> Looks like you have rebase.autostash set to true and have some
> uncommitted changes before your rebase started; it looks like it was
> the reapplying of that stash at the time you abort is the thing that
> failed.
> 
> According to the rebase docs for the --abort flag:
> "If <branch> was provided when the rebase operation was started, then
> HEAD will be reset to <branch>"
> which suggests that the abort should switch you back to the original
> branch, where the application of your local changes should be safe.

Unfortunately, that is not always the case, for example, in this one.

>> Your changes are safe in the stash.
>> You can run "git stash pop" or "git stash drop" at any time.
>>
>> Here is a tree before rebasing:
>>> a9597aaa (HEAD -> dev) Use DateTime with correct timezone >>> 822ff801 Add link to Podio into mail
>>> 65575afe Update Docs.pm
>> | < e0003861 (local/dev) Update podio.t - test person contacts
>> | < 28ab8630 Create docdate if agreement is new and update test for that
>> | < 208ead68 Specified checking of person
>> | < f2442d9a Update Docs.pm
>> |/
>> o 6d9c2159 (xtucha/test, xtucha/dev) Leave only one example in month

You start at branch dev. Then you use the two argument form

     git rebase dev local/dev

and when you later

     git rebase --abort

then you are not warped back to dev, but to local/dev:

> history after --abort:
> * e0003861 (HEAD, local/dev) Update podio.t - test person contacts
> * 28ab8630 Create docdate if agreement is new and update test for that
> * 208ead68 Specified checking of person
> * f2442d9a Update Docs.pm
> * 6d9c2159 (xtucha/test, xtucha/dev) Leave only one example in month

and at this point, your stashed changes, which were snapshot when you 
were on branch dev, are obvously in conflict with branch local/dev.

I'm not saying that that the behavior should be like this, I'm just 
explaining what was going on. I hate this behavior, BTW.

-- Hannes
