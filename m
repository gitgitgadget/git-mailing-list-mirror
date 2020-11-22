Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8D6C5519F
	for <git@archiver.kernel.org>; Sun, 22 Nov 2020 20:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7F162076B
	for <git@archiver.kernel.org>; Sun, 22 Nov 2020 20:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbgKVUSM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Nov 2020 15:18:12 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:35239 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727307AbgKVUSL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Nov 2020 15:18:11 -0500
Received: from host-89-243-187-160.as13285.net ([89.243.187.160] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1kgvoF-0008XL-AQ; Sun, 22 Nov 2020 20:18:07 +0000
Subject: Re: [PATCH 00/28] Use main as default branch name
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.762.git.1605221038.gitgitgadget@gmail.com>
 <87r1oraewl.fsf@x220.int.ebiederm.org>
 <xmqqv9e34mq5.fsf@gitster.c.googlers.com>
 <1389dabc-33c9-1e65-a3de-43729a6c2e70@iee.email>
 <xmqqh7pmyuzn.fsf@gitster.c.googlers.com>
 <7df660f2-ad74-7d1f-eb13-a0edadffbfbf@iee.email> <871rgpr497.fsf@osv.gnss.ru>
 <xmqqpn46qppl.fsf@gitster.c.googlers.com> <87y2it8zfm.fsf@osv.gnss.ru>
 <9be54e8e-a702-0eb9-97c9-7a1fac82ed5d@iee.email> <87zh397cfh.fsf@osv.gnss.ru>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <9c285212-3d64-f90c-1b66-9c7172f77ddb@iee.email>
Date:   Sun, 22 Nov 2020 20:18:06 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <87zh397cfh.fsf@osv.gnss.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/11/2020 13:23, Sergey Organov wrote:
>>>> The latter (i.e. you are not on a branch) does not grow any branch.
>>> That's one way of looking at it, resulting in this "detached HEAD"
>>> thingy that is too technical for the git user proper, I think. Moreover,
>>> it immediately raises the question: if it doesn't grow any branch, /what/
>>> does it grow?
>>>
>>> Another way of describing it, that I prefer, is that you /are/ on an
>>> /unnamed/ branch and new commits grow this particular /unnamed/ branch.
>>> No need not only for "detached", but even for "HEAD" to be known to the
>>> user to get the idea, I think.
>> I don't think we can start like this and continue with a commit on top
>> of the orphaned 'unnamed' branch. (Not tried it though..)
> I rather believe we can, no problems, and that's why "detached HEAD" behaves
> exactly as unnamed branch would.
>
> To make it obvious "detached HEAD" is in fact a subset of the usual
> case, imagine that "detached HEAD" is rather first implemented by
> pointing to a branch reference with a hidden name that in turn points to
> the commit, and then this "incognito branch reference" is optimized-out
> as being invisible anyway, so HEAD now points to the commit itself.
>
Thinking about some options...

After a `git init`: We can hack HEAD to "ref: refs/heads/" (i.e. a
symref to an unnamed branch) and `git status` will report "No commits yet".
My PS1 will report the current branch as "()" (i.e. an empty name).

However,
`git branch` reports "Failed to resolve HEAD as a valid ref.", and
`git commit` reports "cannot lock ref 'HEAD': there is a non-empty
directory '.git/refs/heads/' blocking reference 'refs/heads/'".

So, there could be the option to detect that unnamed ref state (no
characters after the final "/") without going "Fatal:".

However there is still the potential difficulty that after the first
commit on that unnamed branch we would have the difficult choice of:

- either keeping that unnamed ref/branch symref, and have nowhere to
hold the new commit name (oid), because HEAD is already acting as the
place holder for the symref,
- or we have to lose the place holder symref and place the new commit
oid into HEAD, leaving us back at the regular "detached head", but for
an as yet unnamed orphan branch.
(tested on Windows[1])

For the second case we would still need to ensure that  protections are
in place to avoid loosing those detached commits if the user
switches/checks out to new branch based on some other oid. (for that to
happen then that checkout oid must be somewhere in the unnamed branch,
but the latest tip commits should need checking to prevent unexpected
loss - the current warning may not be enough...)

At the moment there is a lot of 'lock-in' for the status quo, and the
alternative may not be any better, and have some backward compatibility
issues, though those may be overstated, depending on how repos are being
'shared'.

Philip


[1]
phili@Philip-Win10 MINGW64 /c/git-sdk-64/usr/src/unnamed ()
$ git version
git version 2.29.2.windows.2

