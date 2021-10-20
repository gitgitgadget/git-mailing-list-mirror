Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C18C433EF
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 13:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9B8260EB2
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 13:58:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbhJTOAW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 10:00:22 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54480 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbhJTOAV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Oct 2021 10:00:21 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 05863FFBCF;
        Wed, 20 Oct 2021 09:58:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=U+RXZSXXcvIdx+kd7Y5K2ZPZuuGVP3O+sK6vo1GX0jM=; b=FlwK
        icENA647rFRG48StQmVjic+sJtshzyZkMd8pP1+Qej9l+weVMRPdeU51MJCsNHo4
        3uWZvMRTMLWUMb/H6aZdBFDyKfrgL8ShI53hhlJ+GOG9kLpPfb46Kb9bC3Tq1qf4
        rhYY9/BDKOAm4KwguBumCedRB/7hPNyvqnQov7M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F060EFFBCE;
        Wed, 20 Oct 2021 09:58:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4CDD5FFBCD;
        Wed, 20 Oct 2021 09:58:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] for-each-ref: delay parsing of --sort=<atom> options
References: <xmqqv91uw5dl.fsf@gitster.g>
        <YW9EP5UNX0f+eOke@coredump.intra.peff.net>
Date:   Wed, 20 Oct 2021 06:58:04 -0700
Message-ID: <xmqq4k9bssr7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C014C444-31AD-11EC-A58A-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> As side effects, this change also cleans up a few issues:
>> 
>>  - 95be717c (parse_opt_ref_sorting: always use with NONEG flag,
>>    2019-03-20) muses that "git for-each-ref --no-sort" should simply
>>    clear the sort keys accumulated so far; it now does.
>
> Neat. Is it worth adding a test here?

It probably is.  The feature lets you defeat the configured personal
default, if I understand the code right, which is probably a good
thing.

I think that the command line option is cumulative on top of
configured values, with or without this change, and I think that
qualifies as a bug to be fixed.  E.g. with a command line option

    $ git -c branch.sort=-committerdate branch --sort=subject

any configured sort keys should be cleared and the branches ought to
be sorted solely on their subject string, but I think the code with
or without the patch still uses the "-committerdate" as a secondary
key to tiebreak sorting by "subject".

Until that bug is fixed, using --no-sort as the first command line
option before the true --sort=<key> option(s) you want to use would
be a workaround.

However, it is tricky to arrange, as the command already takes
multiple --sort keys, and the laster ones are taken as more
significant sort order, so it is tricky to come up with two keys A
and B such that --sort=A --no-sort --sort=B will produce one order,
while --sort=A --sort=B will produce another different order.

>> +	if (sorting_options.nr) {
>> +		struct ref_sorting *sorting;
>> +		UNLEAK(sorting);
>> +
>> +		sorting = ref_sorting_options(&sorting_options);
>>  		ref_array_sort(sorting, &ref_array);
>> +	}
>
> I wondered at first about pulling this UNLEAK() down, but it's because
> you move the "sorting" variable itself into the smaller scope. So this
> makes sense (and calling UNLEAK() before the pointer is set is perfectly
> fine, since it takes the address of the auto variable). It is a shame
> you can't just ref_sorting_free() afterwards, but we don't have that
> function yet. And adding it is way out of scope here. :)
>
> I do find it interesting that this case checks sorting_options.nr
> itself, rather than relying on ref_sorting_options() to give us the
> default. But that's because the existing code avoids sorting at all in
> that case, so this is staying faithful to the original.

One thing that is somewhat scary was that with all the other
changes, but without the changes to builtin/ls-remote.c file, the
resulting tree still _compiles_ without any warning and only
segfaults at runtime.  Since this does not use the "if nothing is
specified, use the default", I didn't even find it as a candidate
for conversion before seeing the tests to fail.  This is an oddball
case.

>   - I'd probably have kept the word "parse" somewhere in the name, since
>     it really is turning the user-provided text into our internal form

Perhaps.

>   - clearing the list at the end feels a little funny to me, just
>     because this is conceptually a read-only operation (parse the user's
>     text into our internal format). Your comment tells me what you're
>     trying to protect against, but I find it unlikely anybody would
>     mis-use the string_list afterwards (it doesn't do anything itself
>     unless you parse it into the ref_sorting struct).
>
>     All of the current callers are happy with this (and it even saves
>     them clearing it themselves), but it just feels like an unusual
>     interface.

Yes.  The story the comment gives is an officially sounding lame
excuse; the true motivation was that I was too lazy to repeat
writing resource deallocation for each caller and made the callee to
do the freeing ;-)

>> @@ -97,9 +94,8 @@ struct ref_format {
>>  #define OPT_NO_MERGED(f, h) _OPT_MERGED_NO_MERGED("no-merged", f, h)
>>  
>>  #define OPT_REF_SORT(var) \
>> -	OPT_CALLBACK_F(0, "sort", (var), \
>> -		       N_("key"), N_("field name to sort on"), \
>> -		       PARSE_OPT_NONEG, parse_opt_ref_sorting)
>> +	OPT_STRING_LIST(0, "sort", (var), \
>> +			N_("key"), N_("field name to sort on"))
>
> Oh, this part makes using a string_list more appealing. ;)

Yes.
