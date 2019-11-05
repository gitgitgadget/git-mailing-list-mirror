Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 887491F454
	for <e@80x24.org>; Tue,  5 Nov 2019 19:36:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390811AbfKETgk (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 14:36:40 -0500
Received: from smtprelay01.ispgateway.de ([80.67.31.24]:8424 "EHLO
        smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390769AbfKETgk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 14:36:40 -0500
Received: from [84.175.180.230] (helo=[192.168.2.6])
        by smtprelay01.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.3)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1iS4cx-0007bX-5v; Tue, 05 Nov 2019 20:36:31 +0100
Subject: Re: [PATCH 3/5] reset: support the --pathspec-from-file option
To:     phillip.wood@dunelm.org.uk,
        Alexandr Miloslavskiy via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <pull.445.git.1572895605.gitgitgadget@gmail.com>
 <8d9f1fbc18346144a0c866a59891b652dcfe9b7f.1572895605.git.gitgitgadget@gmail.com>
 <b93592df-561f-36d4-09ce-e02d570c60da@gmail.com>
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Message-ID: <8548babb-db15-3fc8-f99f-678032e476c3@syntevo.com>
Date:   Tue, 5 Nov 2019 20:36:31 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <b93592df-561f-36d4-09ce-e02d570c60da@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05.11.2019 16:03, Phillip Wood wrote:

>> The new option allows to read either a specified file or `stdin`.
>> Reading from file is a good way to avoid competing for stdin, and
>> also gives some extra flexibility.
> 
> I think this flexibility is a good idea

Thanks for your support :) Previously the opinions were mixed and I was 
a bit afraid that this will invoke a new round of discussions.

>> Decisions taken for simplicity:
>> 1) The new option is declared incompatible with other options that
>>     could use `stdin`.
> 
> I'm confused reset does not use stdin does it?

I understand that '--patch' interacts with user via stdin. Will 
double-check tomorrow.

>> 2) It is not allowed to pass some refspecs in args and others in file.
> 
> s/refspecs/pathspecs/ ?

Thanks! Not quite used to git speak and mix up things sometimes.

>> Also add new '--pathspec-file-null' switch that mirrors '-z' used in
>> various places. Some porcelain commands, such as `git commit`, already
>> use '-z', therefore it needed a new unambiguous name.
> 
> As the 'lines' in the file are nul terminated perhaps it would be better 
> to call this --pathspec-file-nul or --nul-termination. I think the use 
> of --null to mean nul termination for config was a mistake (for grep it 
> matches what GUN grep does but it's still unfortunate).

OK, will change to '--pathspec-file-nul'

>> +'git reset' [-q] [--pathspec-from-file=<file> [--pathspec-file-null]] 
>> [<tree-ish>]
> 
> --pathspec-file would be shorter and still conveys the intent of the 
> option. Is this line missing a leading space?

'--pathspec-from-file' was kind of suggested instead of '--paths-file' 
by Junio here:
https://public-inbox.org/git/xmqqtv9qr82q.fsf@gitster-ct.c.googlers.com/

so Junio added '-from' to previous writing. Hmm. What do you think, 
taking Junio's message into account?

As for whitespaces, sorry, will fix.

>> +'git reset' [-q] [--pathspec-from-file=<file> [--pathspec-file-null]] 
>> [<tree-ish>]::
> 
> Alignment again

Will fix

>> +    These forms reset the index entries for all `<pathspec>` to their
> 
> The new form does not mention <pathspec> so this could be confusing

Shall I replace '<pathspec>' with 'pathspecs' ?

> As we have a separate synopsis line for --pathspec-from-file which does 
> not mention <pathspec> it might be better just to say "read pathspecs 
> from `<file>` instead of the command line".

OK

>> +    if (pathspec_from_file) {
>> +        if (patch_mode)
>> +            die(_("--pathspec-from-file is incompatible with --patch"));
> 
> This is sensible as -p is interactive so we wouldn't expect command line 
> length to be an issue

Yes, I also thought so. I doubt that user is willing to interactively 
decide on hundreds of files.

>> +    } else if (pathspec_file_null)
>> +        die(_("--pathspec-file-null requires --pathspec-from-file"));
> 
> Style nit: the coding guidelines state that if any branch of an if 
> statement requires braces then all the branches should be braced. This 
> is widely ignored though.

Took this code from a guy who ignored it :) But sure, will change.

> These days we tend to set up the expected files within the relevant test 
> case using <<-\EOF to allow indentation and disallow substitution 
> (unless it's needed of course)

I'll try to change this.

>> +test_expect_success 'quotes' '
>> +    restore_checkpoint &&
>> +
>> +    git rm fileA.t &&
>> +    printf "\"file\\101.t\"" | git reset --pathspec-from-file=- &&
>> +
>> +    verify_state expect.a
> 
> If I've understood correctly this doesn't test if a path is correctly 
> unquoted, only that it is accepted.

In my understanding, 'verify_state expect.a' should test that it's 
correctly understood. Am I wrong?

>> +test_expect_success '--pathspec-from-file is not compatible with 
>> --soft --hard' '
> 
> s/--soft --hard/--soft or --hard/

Good idea.

>> +test_expect_success 'only touches what was listed' '
> 
> s/^/--pathspec-from-file / ?

I thought that whole test package is about '--pathspec-from-file' so I'd 
rather not repeat that in every test name. Shall I change that?
