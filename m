Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B6581F454
	for <e@80x24.org>; Wed,  6 Nov 2019 15:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732170AbfKFP4p (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 10:56:45 -0500
Received: from smtprelay02.ispgateway.de ([80.67.31.29]:18045 "EHLO
        smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732164AbfKFP4o (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 10:56:44 -0500
Received: from [24.134.116.61] (helo=[192.168.92.208])
        by smtprelay02.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.3)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1iSNfl-0002Uh-0d; Wed, 06 Nov 2019 16:56:41 +0100
Subject: Re: [PATCH 3/5] reset: support the --pathspec-from-file option
To:     Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy via GitGitGadget 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.445.git.1572895605.gitgitgadget@gmail.com>
 <8d9f1fbc18346144a0c866a59891b652dcfe9b7f.1572895605.git.gitgitgadget@gmail.com>
 <xmqqd0e5vcq9.fsf@gitster-ct.c.googlers.com>
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Message-ID: <df4cdf1d-1775-9d25-f32b-1abd57dffc31@syntevo.com>
Date:   Wed, 6 Nov 2019 16:56:39 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <xmqqd0e5vcq9.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I think I have implemented most suggestions in PatchV2. Thanks!

>> 2) Some UI's have started and grown with porcelain commands. Replacing
>>     existing logic with plumbing commands could be cumbersome and prone
>>     to various new problems.
> 
> There is not a lot of sympathy for such argument ;-)

Let's think that this merely reinforces the first point :)

> I do not understand this part.  Wouldn't it natural to expect that
> "-z", when used with "--pathspec-from-file", tell us that the named
> file is NUL delimited collection of records?  What's different about
> "--pathspec-file-null" that it is confusing to all it "-z"?
> 
> I actually do not mind not having "-z" and using only
> "--pathspec-file-null".  A new option with long name that feels
> similar to existing "-z" but does sufficiently different things so
> that it needs a different name, however, feels counter-productive
> for the purpose of using it in the UI that produces commands to be
> learned by end-users.

I didn't want to run into a situation where '-z' suddenly applies to 
multiple things (for example, if later it's decided to allow --patch 
with --pathspec-from-file).

Regarding UI, I think that (insert our UI name here) will not use 
'--pathspec-from-file' unless there are really many files. When it does 
happen, user will probably have an easier time understanding 
'--pathspec-file-nul' then '-z'.

> When I invented the terms "pathspec", "refspec", etc. for this
> project, I meant them to be collective nouns.  A pathspec is a set
> of pathspec elements, each of which is usually given as a separate
> argument on the command line.  So "Read pathspec from file" is good
> (not "Read pathspecs from file").
> 
> And "Pathspec elements" are separated by LF or CR/LF.

I changed that. However, `git grep pathspecs` is quite interesting. My 
own taste says that "pathspecs" is more expected then "pathspec".

> A tangent.  Since we do not allow NUL in a pathspec element, we do
> not even need the "-z" option.  When we read pathspec from a file,
> we can take any of CRLF, LF or NUL as the separator.
> 
> Ah, sorry, that would not help very much.  With "-z" we are allowing
> to express pathspec elements inside which there are embedded LF or
> CR/LF.  Sorry about the noise.

Yes, NUL delimiter allows to avoid escaping.

>   - Quote end-of-here-document (EOF in the above) if you do not rely
>     on parameter interpolation inside the here document; this helps
>     readers by telling them that what is presented is used verbatim.

Tests overwhelmingly prefer escaped form (\EOF) instead, so I used that.

> This feeds "fileA.t<NUL>fileB.t" without <NUL> after "fileB.t" to
> the command.  Intended?

Kind of intended. I changed tests to always use trailing delimiters, and 
also added a new dedicated test without trailing delimiter.
