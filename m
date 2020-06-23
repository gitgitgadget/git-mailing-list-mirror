Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE427C433E0
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 16:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2BF82076E
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 16:16:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732975AbgFWQQX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 12:16:23 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:54878 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729562AbgFWQQV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 12:16:21 -0400
Received: from host-92-20-155-32.as13285.net ([92.20.155.32] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1jnlas-000Abd-4f; Tue, 23 Jun 2020 17:16:18 +0100
Subject: Re: Request for adding a simple mechanism to exclude files from Git
 merge operation
To:     Sergey Organov <sorganov@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Tiran Meltser <Tiran.Meltser@mavenir.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Amir Yosef <Amir.Yosef@mavenir.com>
References: <DM6PR11MB27958B80E3994CEEF13971ECE5990@DM6PR11MB2795.namprd11.prod.outlook.com>
 <20200622194122.GN6531@camp.crustytoothpaste.net>
 <871rm6x86y.fsf@osv.gnss.ru>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <51924543-3e26-8340-2105-1d08adcea196@iee.email>
Date:   Tue, 23 Jun 2020 17:16:17 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <871rm6x86y.fsf@osv.gnss.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/06/2020 13:44, Sergey Organov wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>
>> On 2020-06-20 at 18:21:40, Tiran Meltser wrote:
>>> Hi,
>>> This topic is quite common in various use cases (e.g. production
>>> configuration vs. staging one) and there are quite a few talks about
>>> it in the web.
>>> Nevertheless, there is no specific solution to this problem, only
>>> partial workarounds (including the famous merge driver “ours”).
>> In general, this is a hard problem.  When you perform a merge, you're
>> asking to incorporate changes from both heads against a common merge
>> base.  What does it mean when you want to merge two branches together
>> but not make any changes?  Which version do you want, ours or theirs?
> I believe we basically need support to apply different merge strategies
> to different files.
>
> I had similar problem a few times when I merged a long-standing branch
> and, after I saw the result of merge, I was basically satisfied, except
> I needed to revert a few sub-directories of the project (that gave huge
> number of conflicts), to their original state, either of my current
> branch, or of the branch being merged, depending on particular case. You
> see, I knew exactly what I needed, yet I was not able to achieve my goal
> without resorting to nasty kludges.
>
>> Normally merges are symmetric, so if you want non-symmetric behavior,
>> you have to define what it's supposed to be.
> Yes, I'm ready to define what it's supposed to be. The problem is that
> "git merge" won't let me, due to lack of support to apply different
> merge strategies to different files.
>
> As I see it, first step of improvements could be to support
>
>   git merge -- <files>
>
> where selected strategy applies only to <files>, and the rest of files
> are kept intact (effectively applying "ours" strategy to them),
So, essentially, for larger merges, this would be something like the
recent `--pathspec-from-file=<file>` series
https://public-inbox.org/git/7324e091ba7f48e286e6c35c7b7c40490e5c85d1.1576778515.git.gitgitgadget@gmail.com/
by Alexandr Miloslavskiy for the commands that did allow files to be
passed in via `--` lists.

It would still require merge to be extended to include just a
'partial-merge' or a 'file-merge' to clearly distinguish what is happening!

This still a symmetric merge, but with _author supplied_ pathspec
limiting, which is implicitly "ours" for the paths that are not merged.
(I don't believe that the pathspec file can have negative pathspecs, so..)

>  along
> with
>
>   git merge --exclude=<files>
>
> , to be able to exclude specific files (apply "ours" only to them)
> rather than include.

One difficulty of .precious lists, whether embedded or local, is the
false impression that they provide any form of security to the user, so
it needs a name that make that clear.
>
> [ As a side-note, please notice that after such changes, the "ours"
> strategy could be deprecated (not that I think it should), as either:
>
>    git merge <branch> --
>
> or
>
>    git merge --exclude=. <branch>
>
> would do the trick. ]
>
> The next step would then be to support
>
>   git merge --force -- <files>
>
> that would force to re-merge <files> with given strategy no matter what
> their current status in the index is.
Isn't this already the same as the restore/checkout?

>
> Even though such support would be enough for my specific use-case, it
> doesn't provide suitable way to configure the default behavior. As a
> more generic solution, a new syntax for "git merge" to specify what
> merge strategy to apply to what files could be designed, and then
> ability to put that syntax into a file for "git merge" to pick would
> solve the problem of quasi-static configuration problem. Alternatively,
> even more generic .gitignore way of doing things apparently could be
> re-used to some degree by adding support for .gitmerge files.
>
> -- Sergey
Philip
