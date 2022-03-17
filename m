Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F7BC433F5
	for <git@archiver.kernel.org>; Thu, 17 Mar 2022 22:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiCQWdi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Mar 2022 18:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiCQWdg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Mar 2022 18:33:36 -0400
X-Greylist: delayed 952 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Mar 2022 15:32:19 PDT
Received: from outmail148108.authsmtp.net (outmail148108.authsmtp.net [62.13.148.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7291890E6
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 15:32:18 -0700 (PDT)
Received: from mail-c237.authsmtp.com (mail-c237.authsmtp.com [62.13.128.237])
        by punt15.authsmtp.com. (8.15.2/8.15.2) with ESMTP id 22HMGOq8046342
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 22:16:24 GMT
        (envelope-from david@cantrell.org.uk)
Received: from [10.13.12.171] (199.80.155.90.in-addr.arpa [90.155.80.199])
        (authenticated bits=0)
        by mail.authsmtp.com (8.15.2/8.15.2) with ESMTPA id 22HMGNvl049978
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 22:16:23 GMT
        (envelope-from david@cantrell.org.uk)
Message-ID: <6fd18785-500b-a83e-a6d7-1e7fe69fe4b6@cantrell.org.uk>
Date:   Thu, 17 Mar 2022 22:16:21 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH v3] tab completion of filenames for 'git restore'
To:     git@vger.kernel.org
References: <pull.1227.v2.git.git.1647305547.gitgitgadget@gmail.com>
 <pull.1227.v3.git.git.1647382437475.gitgitgadget@gmail.com>
 <xmqqsfribuan.fsf@gitster.g>
From:   David Cantrell <david@cantrell.org.uk>
In-Reply-To: <xmqqsfribuan.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Server-Quench: e181187b-a63f-11ec-ba2e-8434971169dc
X-AuthReport-Spam: If SPAM / abuse - report it at: http://www.authsmtp.com/abuse
X-AuthRoute: OCd2ZQ4QB1ZZRRob BgsPBSlcUwghIltL GxBFMAhML1sVfRpe P1wcLVdJNlAYA1ZD VCgKXEspAR9uW2N3 aRpTbw9cZEBMXEtj UFZIR1dMHAV2ABUI GRsWVQZyOQdEAAMH GwA+XnRSVUNyO0V8 REwaQGwOZGZobzIC AUZbIR5VcVYZY00U aAViXHcOZWwAZ3tm TgM4KQo8b31sEA1p aSFFMwknCVoCFHY3 QBUaGTgzHEoDDyI9 ZxInLlMaFUMcKQ08 NkFpFl0ZL1cIBxZC GFtAT0fG
X-Authentic-SMTP: 61633535363534.1024:7600
X-AuthFastPath: 0 (Was 255)
X-AuthSMTP-Origin: 90.155.80.199/587
X-AuthVirus-Status: No virus detected - but ensure you scan with your own anti-virus system.
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16/03/2022 00:44, Junio C Hamano wrote:
> "David Cantrell via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> If no --args are present after 'git restore' it assumes that you want
>> to tab-complete one of the files with unstaged uncommitted changes.
> What do you mean by "--args" in this sentence?  Dashed-options?

Yes.

> I am getting the same set of files whose name begins with 'a' from
> these two:
> 
>   $ git restore a<TAB>
>   $ git restore --staged a<TAB>
> 
> so, with or without --dashed-options, we complete one of the files,
> whether they have any modifications.

If --staged is present I think it falls back to the standard behaviour 
of attempting to complete to any file it can find

> Perhaps you meant to say more like:
> 
>      When completing a non-option argument to 'git restore', the
>      command line completion support offers names of the files
>      present in the working tree as candidates.
> 
> to describe the status quo; to hint what the shortcoming of the
> current behaviour is, we may want to add a bit more, perhaps
> append the following at the end of that first paragraph:
> 
>      But many of these files may not have any changes, and running
>      "restore" on them would be a no-op.  Listing only the files, to
>      which doing "restore" is not a no-op, would reduce the clutter.
>      
> Then we'd continue with the solution, while explaining why the exact
> choice between modified vs committable was made:
> 
>      Offer only the files that are different from the index, to match
>      the default behaviour of "git restore" that checks out the
>      contents last added to the index to the working tree.  We could
>      instead show the files that are different between the index and
>      HEAD, and that is more suittable if "git restore --staged" is
>      being completed, but this should do for now.
> 
> or something.  The last part is written in such a way to explicitly
> signal to future developers that we know we did not do a perfect job
> and we do not mind if they extend the logic to use something other
> than "--modified" when appropriate.  For example, they could build
> on this solution to make it inspect the command line for "--staged"
> and "--source" and drive "diff-index" differently to grab the paths
> that are offered.  We just do not do that at least for now, but we
> have no objection if other people do so in the future.

That makes sense.

> Thanks.  Will queue as-is for now.

Thank you.

-- 
David Cantrell
