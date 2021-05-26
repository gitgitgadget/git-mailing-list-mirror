Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26264C2B9F7
	for <git@archiver.kernel.org>; Wed, 26 May 2021 11:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC6AF613BD
	for <git@archiver.kernel.org>; Wed, 26 May 2021 11:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234146AbhEZLIB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 07:08:01 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:15744 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234006AbhEZLIA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 07:08:00 -0400
Received: from host-92-14-216-189.as13285.net ([92.14.216.189] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1llrMp-0009Ry-5v; Wed, 26 May 2021 12:06:28 +0100
Subject: Re: fast forward merge overwriting my code
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        Andre Ulrich <andre.ulrich@smail.fh-koeln.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>
References: <20210522154815.Horde.rqiNSyIc3CGJECACotWLO1T@webmail.th-koeln.de>
 <4c1c3dbc-7a89-02db-3883-b7eea644cd83@kdbg.org>
 <YKrsC9CaG/KDvDBi@camp.crustytoothpaste.net>
 <20210524061355.Horde.I7EpK9A1l-KtI_TwFo97eNd@webmail.th-koeln.de>
 <60adb824bac10_2c7f620844@natae.notmuch>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <da77d0a0-7fdb-e4c8-6510-87ea0294dac4@iee.email>
Date:   Wed, 26 May 2021 12:06:27 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <60adb824bac10_2c7f620844@natae.notmuch>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26/05/2021 03:53, Felipe Contreras wrote:
> Andre Ulrich wrote:
>> So the last point is where we still want to do some fine tuning. Right  
>> now this looks about: my prof fetches my edits and locally checks out  
>> a branch to compare the changes with git diff.
>> But in this diff view you can't edit the files. So you have to  
>> separately open up another window to edit the changes (lets say my  
>> prof only wants to keep some of my changes, but not all).
> So for example after fetching your changes your professor sees this:

Part of Andre's problem was that this diff wasn't stable because the
underlying file format is said to be json so items can move around
without issue (e.g. key value pairs swapping position) and that they
aren't really working on the json file (it may as well be binary..) but
on the jupytper notebook display view, so one step removed from the 'diff'.
>
>   % git diff --cached
>   --- a/README
>   +++ b/README
>   @@ -1,5 +1,7 @@
>    This is an example document. Lot's of things to fill in.
>    
>   -[[ insert formula]]
>   +The fromula is:
>   +
>   +  y[1], mu * (1 - y[0] ** 2) * y[1] - y[0]
>    
>    This will help students jump straight in with simple examples.
>
> The professor can then open the file, fix the typo, do some other
> changes, type `git add --update`, 

  type `git add --update`,
Useful suggestion. Maybe need a corresponding `stash --update --keep-index` command 
(https://git-scm.com/docs/git-stash#Documentation/git-stash.txt-Testingpartialcommits)

> then do `git diff --cached` again to
> see if that's the output she wants:
>
>   --- a/README
>   +++ b/README
>   @@ -1,5 +1,7 @@
>    This is an example document. Lot's of things to fill in.
>    
>   -[[ insert formula]]
>   +The formula is:
>   +
>   +  x[1], mu * (1 - x[0] ** 2) * x[1] - x[0]
>    
>    This will help students jump straight in with simple examples.
>
>
> What you are saying is that it would be better to do `git $cmd` and in
> that command you would be able to view the staged diff, edit the diff,
> and after quitting the editor the diff is applied to the stage.
>
> Essentially leaving everything ready for a commit.
I see it as a two part problem - diff isn't an appropriate tool (the
files are binary-like) but also that it's a review not a resolution of
the issues, which has to pick apart, and comment on, the proposed changes.

I also suspect that it's part of the small commit - large commit
disparity (patches to be as small as possible but no smaller, so most
patches end up too big..)
>
> Sort of like a combination of: `git diff --cached`,
> `vim $problematic_file`, `git add $problematic_file`, `git diff --cached`.
>
> Correct?
I think they have a need for a `git stash` that works when there is an
intervening commit of the staged files (i.e. clean wrt the stash's
staged files).
>
>> So my Question is: is there any possibility, to be able to view (and  
>> even edit, if necessary) the changed notebook in the merging process  
>> (as in my example with the 3way merge)?
>> Or is the only option to separately view the diff and edit the  
>> notebook (two seperate steps instead of one)?
>>
>> The latter would also be acceptable, if it really is the only way. Bu  
>> it would be nice, if viewing and editing could be done in one  
>> convenient step during merging.
> You are describing `git stage edit`, a subcommand I suggested back in
> 2014 and went completely ignored [1].
>
> Your professor just types `git stage edit`, fixes any problems she sees,
> quits the editor, `git commit`.
>
> Done.
>
> I just rebased the patches from 2016 and they seem to work fine. If you
> are interested let me know.
>
> Cheers.
>
> [1] https://lore.kernel.org/git/1398449567-16314-3-git-send-email-felipe.contreras@gmail.com/
>

