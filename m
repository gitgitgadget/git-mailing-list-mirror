Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C0AAC433EF
	for <git@archiver.kernel.org>; Sat, 21 May 2022 13:02:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243454AbiEUNC3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 May 2022 09:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbiEUNC1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 May 2022 09:02:27 -0400
Received: from vulcan.kevinlocke.name (vulcan.kevinlocke.name [IPv6:2001:19f0:5:727:1e84:17da:7c52:5ab4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3525F8F8
        for <git@vger.kernel.org>; Sat, 21 May 2022 06:02:25 -0700 (PDT)
Received: from kevinolos.kevinlocke.name (unknown [69.145.56.143])
        (Authenticated sender: kevin@kevinlocke.name)
        by vulcan.kevinlocke.name (Postfix) with ESMTPSA id 5AA022E61724;
        Sat, 21 May 2022 13:02:23 +0000 (UTC)
Received: by kevinolos.kevinlocke.name (Postfix, from userid 1000)
        id B36BC13002CA; Sat, 21 May 2022 07:02:11 -0600 (MDT)
Date:   Sat, 21 May 2022 07:02:11 -0600
From:   Kevin Locke <kevin@kevinlocke.name>
To:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] setup: don't die if realpath(3) fails on getcwd(3)
Message-ID: <Yoji02YhO+sE817q@kevinlocke.name>
Mail-Followup-To: Kevin Locke <kevin@kevinlocke.name>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
References: <80eeba2b2a58af2a5497f398beb5c03447c41f61.1653003552.git.kevin@kevinlocke.name>
 <CABPp-BH+=zd_ZpPMy=S5Q-ygTW85ZXD9-RLOk9Apt_Q1_SgzzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPp-BH+=zd_ZpPMy=S5Q-ygTW85ZXD9-RLOk9Apt_Q1_SgzzA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Elijah and Junio,

I appreciate your reviews.  I agree with all of your suggestions. I'll
send a revised patch that incorporates the suggested changes shortly.

Cheers,
Kevin


On Fri, 2022-05-20 at 17:14 -0700, Elijah Newren wrote:
> On Thu, May 19, 2022 at 4:39 PM Kevin Locke <kevin@kevinlocke.name> wrote:
>>     git init repo
>>     mkdir -p a/b
>>     cd a/b
>>     chmod u-x ..
>>     git -C "${PWD%/a/b}/repo" status
>>
>> If this example seems a bit contrived, consider running with the
>> repository owner as a substitute UID (e.g. with runuser(1) or sudo(8))
>> without ensuring the working directory is accessible by that user.
>>
>> The code added by e6f8861bd4 to preserve the working directory attempts
> 
> When referencing commits in commit messages, this project prefers that the first
> reference in the commit message use the output from `git log --no-walk
> --pretty=reference $HASH` rather than just $HASH.
> So, here, it'd be
> 
>     The code added by e6f8861bd4 (setup: introduce
> startup_info->original_cwd, 2021-12-09) to preserve the ...
> 
>> to normalize the path using strbuf_realpath().  If that fails, as in the
>> case above, it is treated as a fatal error.  To avoid this, we can
>> continue after the error.  At worst, git will fail to detect that the
>> working directory is inside the worktree, resulting in the pre-2.35.0
>> behavior of not preserving the working directory.
>>
>> Fixes: e6f8861bd4 ("setup: introduce startup_info->original_cwd")
> 
> I was slightly surprised to see this tag, but it appears others in
> git.git have used it, so it must just be me that's not familiar with
> it.
> 
>> Signed-off-by: Kevin Locke <kevin@kevinlocke.name>
> 
> Nicely explained commit message.
> 
>> ---
>>  setup.c | 10 ++++++----
>>  1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/setup.c b/setup.c
>> index a7b36f3ffb..fb68caaae0 100644
>> --- a/setup.c
>> +++ b/setup.c
>> @@ -458,11 +458,13 @@ static void setup_original_cwd(void)
>>          *     not startup_info->original_cwd.
>>          */
>>
>> -       /* Normalize the directory */
>> -       strbuf_realpath(&tmp, tmp_original_cwd, 1);
>> -       free((char*)tmp_original_cwd);
>> +       /* Try to normalize the directory.  Fails if ancestor not readable. */
> 
> Is that the only reason it fails?  I'm unsure if the second half of
> the comment helps there.
> 
>> +       if (strbuf_realpath(&tmp, tmp_original_cwd, 0)) {
>> +               free((char*)tmp_original_cwd);
>> +               startup_info->original_cwd = strbuf_detach(&tmp, NULL);
>> +       } else
> 
> git.git coding style: if either of the if/else blocks use braces, use
> braces for both
> 
>> +               startup_info->original_cwd = tmp_original_cwd;
> 
> tmp_original_cwd is not required to be normalized, and there are very
> strong normalization assumptions on startup_info->original_cwd.  While
> a non-normalized value would work to get pre-2.35.0 behavior, it's by
> accident rather than design, and might be confusing for others to
> later reason about.  Also, I think it might be possible for
> tmp_original_cwd to still be NULL, and some of the immediately
> following code I believe will assume it's operating with a non-NULL
> value, so you'd need to skip that stuff.  I think the else block here
> should use "goto no_prevention_needed", as the no_prevention_needed
> block will handle setting startup_info->original_cwd to NULL for you,
> and get you the pre-2.35.0 behavior.
> 
>>         tmp_original_cwd = NULL;
> 
> After changing the above else block to a goto, you may also want to
> copy this to the no_prevention_needed block or else copy it to the
> else portion of the block above (just before the goto you add).
