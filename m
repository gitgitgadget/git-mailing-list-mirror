Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A9031F462
	for <e@80x24.org>; Tue, 28 May 2019 06:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfE1GXM (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 02:23:12 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:63636 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbfE1GXM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 02:23:12 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 45CkL55q7sz5tlL;
        Tue, 28 May 2019 08:23:09 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 861881B7D;
        Tue, 28 May 2019 08:23:08 +0200 (CEST)
Subject: Re: git filter-branch re-write history over a range of commits did
 notwork
To:     LU Chuck <Chuck.LU@edenred.com>
Cc:     Philip Oakley <philipoakley@iee.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "chuck.lu@qq.com" <chuck.lu@qq.com>
References: <DB7PR05MB5573AD842E430342E2BD011B8D1D0@DB7PR05MB5573.eurprd05.prod.outlook.com>
 <db2dcf54-8b1c-39b1-579c-425ef158c6a1@kdbg.org>
 <75618ca1-748d-0761-9108-c7deac63cb53@iee.org>
 <DB7PR05MB5573B5B80C8A9CBE867803D88D1E0@DB7PR05MB5573.eurprd05.prod.outlook.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <fa23e865-94ed-308f-6a19-75b6ea89eec3@kdbg.org>
Date:   Tue, 28 May 2019 08:23:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <DB7PR05MB5573B5B80C8A9CBE867803D88D1E0@DB7PR05MB5573.eurprd05.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 28.05.19 um 07:42 schrieb LU Chuck:
>> From: Philip Oakley <philipoakley@iee.org>
>> The three dots is provided in the literal EXAMPLES section of the man page. That is
>> probably an error, as I think it is meant to be an ellipsis to indicate 'insert other
>> options here'.
>>
>> Simply remove the three dots ('symmetric diff notation') .
>>
>> Not sure what the correct change to the man page should be, but clearly it has
>> caused confusion. It also takes a moment to properly realise which commits the
>> two dot notation will refer to in the example which may further compound the
>> confusion about the three dots.
>>
>> Philip
> [LU Chuck] Hi Hannes,
>          I used ... literally when I cited the command. I write the command with ... directly as the document introduce the usage like that.
>          You can check the document https://git-scm.com/docs/git-filter-branch#_examples about the --env-filter section.

Copying and pasting examples literally is dangerous. You should know
what you are doing.

"..." is a revision range that computes the mergebase between HEAD and
HEAD, which is (surprise!) HEAD, and then includes the two end points,
but excludes everything below the mergebase. So, the revision
specification that your command ends up with is

     HEAD HEAD ^HEAD ^67d9d9 f70bf4

Which is empty if f70bf4 is an ancestor of HEAD.

>          Hi Philip,
>          I also tried to execute the command without ..., 
>          git filter-branch --env-filter 'export GIT_COMMITTER_DATE="$GIT_AUTHOR_DATE"' 67d9d9..f70bf4
>          then I will get another error " You must specify a ref to rewrite."

You cannot restrict your filter to a subset of commits like this. After
all, all commits that descend from one of the rewritten commits must
also change, up to and including to the branch refs. Therefore, it is
necessary to mention the branches that you rewrite in this manner.

Perhaps:

   git filter-branch --env-filter '
     if git merge-base --is-ancestor $GIT_COMMIT f70bf4; then
       export GIT_COMMITTER_DATE="$GIT_AUTHOR_DATE"
     fi' -- 67d9d9..master

This assumes that only branch master is affected by the rewriting. Use
--all if you have many affected branches.

-- Hannes
