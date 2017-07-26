Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38D972047F
	for <e@80x24.org>; Wed, 26 Jul 2017 21:25:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751566AbdGZVZw (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jul 2017 17:25:52 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53018 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751538AbdGZVZv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2017 17:25:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7860A91FF3;
        Wed, 26 Jul 2017 17:25:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/454b4+7UKqfF2fAma7iUYMkCgM=; b=BHG+NT
        XknnrYi6e6e0U9uR+R/UR4OKj2gdHNcd016mZj2/gXzP5N7QxrPIwfamWVcjPKms
        bbnC51TBzTXvmyQLdtOzNzyBhAS2Hoe05AR5Elm8SqBfY9q6MKf342iGUl/3RYHC
        IIdkeBEZ1CAvAEdfv6ZEGJEa+y5Tb6bV2aLlQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=m1mkrv8frPJ9g82fM/I9KJo1e9XGHnwH
        SIKAXBStdnGHHwLZsr/w9hJSY9+7XL9aSrLld62GVAlpg8+p3RJotxq/t+CvHF6B
        D/DGEbpqz0EWZcxsFsp3vieJvjHa2+yP7mlYivHi+d+FT9gyiRHzxcYW6nTaIjOt
        jbLUeWI8KQ8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7076D91FF2;
        Wed, 26 Jul 2017 17:25:50 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CCED991FF1;
        Wed, 26 Jul 2017 17:25:49 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 03/15] add, reset: ensure submodules can be added or reset
References: <20170725213928.125998-1-bmwill@google.com>
        <20170725213928.125998-4-bmwill@google.com>
        <CAGZ79kZByzPbyLUNJ8ViVa2TDk-L+TfnF+wVWRj2d92_MhXPbg@mail.gmail.com>
Date:   Wed, 26 Jul 2017 14:25:48 -0700
In-Reply-To: <CAGZ79kZByzPbyLUNJ8ViVa2TDk-L+TfnF+wVWRj2d92_MhXPbg@mail.gmail.com>
        (Stefan Beller's message of "Tue, 25 Jul 2017 16:33:10 -0700")
Message-ID: <xmqqinieq49v.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FEF1C8A2-7248-11E7-85F6-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Tue, Jul 25, 2017 at 2:39 PM, Brandon Williams <bmwill@google.com> wrote:
>> Commit aee9c7d65 (Submodules: Add the new "ignore" config option for
>> diff and status) ...
>
> introduced in 2010, so quite widely spread.
>
>> ...  introduced the ignore configuration option for
>> submodules so that configured submodules could be omitted from the
>> status and diff commands.  Because this flag is respected in the diff
>> machinery it has the unintended consequence of potentially prohibiting
>> users from adding or resetting a submodule, even when a path to the
>> submodule is explicitly given.
>>
>> Ensure that submodules can be added or set, even if they are configured
>> to be ignored, by setting the `DIFF_OPT_OVERRIDE_SUBMODULE_CONFIG` diff
>> flag.
>>
>> Signed-off-by: Brandon Williams <bmwill@google.com>
>> ---
>>  builtin/add.c   | 1 +
>>  builtin/reset.c | 1 +
>>  2 files changed, 2 insertions(+)
>>
>> diff --git a/builtin/add.c b/builtin/add.c
>> index e888fb8c5..6f271512f 100644
>> --- a/builtin/add.c
>> +++ b/builtin/add.c
>> @@ -116,6 +116,7 @@ int add_files_to_cache(const char *prefix,
>>         rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
>>         rev.diffopt.format_callback = update_callback;
>>         rev.diffopt.format_callback_data = &data;
>> +       rev.diffopt.flags |= DIFF_OPT_OVERRIDE_SUBMODULE_CONFIG;
>
>
> This flag occurs once in the code base, with the comment:
>     /*
>      * Unless the user did explicitly request a submodule
>      * ignore mode by passing a command line option we do
>      * not ignore any changed submodule SHA-1s when
>      * comparing index and parent, no matter what is
>      * configured. Otherwise we won't commit any
>      * submodules which were manually staged, which would
>      * be really confusing.
>      */
>     int diff_flags = DIFF_OPT_OVERRIDE_SUBMODULE_CONFIG;
>
> in prepare_commit, so commit ignores the .gitmodules file.
>
> This allows git-add to add ignored submodules, currently ignored submodules
> would have to be added using the plumbing
>     git update-index --add --cacheinfo 160000,$SHA1,<gitlink>

Let me play devil's advocate (as I have this suspicion that .ignore
thing specific for submodule is probably misdesigned and certainly
its implementation is backwards).  Is the primary use case for this
.ignore thing to be able to do

	git add .

without having to worry about adding the submodule marked as such?  
And if so, wouldn't it surprise these users who do use .ignore if
"git add" suddenly started adding them?

I think the right tool to use these days for excluding some paths
when adding all others is the negative pathspec; perhaps back when
the .ignore thing was added, it didn't exist or not widely known?  

I suspect that it may result in a better system overall if we can
deprecate and remove the submodule-specific .ignore thing.  At
least, I think the DIFF_OPT_OVERRIDE_SUBMODULE_CONFIG is backwards
in that .ignore causes a submodule to be excluded from the diff by
default and forces paths that care about differences to opt into the
"override" thing, which is wrong---the specific UI thing that wants
not to show them should instead opt into ignoring, while keeping the
default not to special case such a flag that can only be set to a
submodule path.

> This makes sense, though a test demonstrating the change in behavior
> would be nice, but git-add doesn't seem to change as it doesn't even load
> the git modules config?
>
>>         rev.max_count = 0; /* do not compare unmerged paths with stage #2 */
>>         run_diff_files(&rev, DIFF_RACY_IS_MODIFIED);
>>         return !!data.add_errors;
>> diff --git a/builtin/reset.c b/builtin/reset.c
>> index 046403ed6..772d078b8 100644
>> --- a/builtin/reset.c
>> +++ b/builtin/reset.c
>> @@ -156,6 +156,7 @@ static int read_from_tree(const struct pathspec *pathspec,
>>         opt.output_format = DIFF_FORMAT_CALLBACK;
>>         opt.format_callback = update_index_from_diff;
>>         opt.format_callback_data = &intent_to_add;
>> +       opt.flags |= DIFF_OPT_OVERRIDE_SUBMODULE_CONFIG;
>
> same here? Also as this is not failing any test, it may be worth adding one
> to document the behavior of the "submodule.<name>.ignore" flag in tests?
>
>>
>>         if (do_diff_cache(tree_oid, &opt))
>>                 return 1;
>> --
>> 2.14.0.rc0.400.g1c36432dff-goog
>>
