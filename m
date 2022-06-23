Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9407C43334
	for <git@archiver.kernel.org>; Thu, 23 Jun 2022 15:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbiFWP6M (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jun 2022 11:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbiFWP6L (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jun 2022 11:58:11 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E909FD3
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 08:58:03 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 23A971B6E01;
        Thu, 23 Jun 2022 11:58:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vDpeRRoSpuI2fxPI4ELFDOQZcRxIc6R8E9W80f
        4PkFo=; b=Hq2swKUgRigrc8yhBwodNQHOvY70WjVID2mgDm/6DV64zsMHXfESoA
        eOOTvGFs77vqNFnzZ/yTMgyeSmMwyBxOiYtGg3Bi40yRkIntDp0NUsSL/E8MNIUq
        2hEgmzwPC2W5lU55mDlUculOPM3jJpEOwgJBBZPZZgJxIZokEo/qs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1BAC11B6E00;
        Thu, 23 Jun 2022 11:58:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 66E021B6DFC;
        Thu, 23 Jun 2022 11:57:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v3] ls-files: introduce "--format" option
References: <pull.1262.v2.git.1655629990185.gitgitgadget@gmail.com>
        <pull.1262.v3.git.1655777140231.gitgitgadget@gmail.com>
        <080f65b3-91f5-7b68-4235-4bfb956c8321@gmail.com>
Date:   Thu, 23 Jun 2022 08:57:58 -0700
In-Reply-To: <080f65b3-91f5-7b68-4235-4bfb956c8321@gmail.com> (Phillip Wood's
        message of "Thu, 23 Jun 2022 15:06:33 +0100")
Message-ID: <xmqqv8sr1iex.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 411FC478-F30D-11EC-AF3E-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> Thanks for re-rolling, having taken a look a closer look at the tests
> I'm concerned about the output format for some of the specifiers, see
> below.

Thanks for raising these issues.  I agree with you on many of them.
In addition to what you covered ....

>> +path::
>> +	The pathname of the file which is in the index.
> I think that for all these it might be clearer to say "recorded in the
> index" rather than "of the file which is in the index"

I think we would call this "name".  The name of the existing option
that controls how they are shown is "--full-name", not "--full-path",
for example.

>> +ctime::
>> +	The create time of file which is in the index.
>
> This is printed with a prefix 'ctime:' (the same applies to the format
> specifiers below) I think we should omit that and just print the data
> so the user can choose the format they want.
>
>> +mtime::
>> +	The modified time of file which is in the index.

These are only the low-bits of the full timestamp, not ctime/mtime
themselves.

But stepping back a bit, why do we need to include them in the
output?  What workflow and use case are we trying to help?  Dump
output from "stat <path>" equivalent from ls-files and compare with
"stat ." output to see which ones are stale?  Or is there any value
to see the value of, say, ctime as an individual data item?

>> +dev::
>> +	The ID of device containing file which is in the index.
>> +ino::
>> +	The inode number of file which is in the index.
>> +uid::
>> +	The user id of file owner which is in the index.
>> +gid::
>> +	The group id of file owner which is in the index.

Again, why do we need to include these in the output?

Wouldn't it be sufficient, as well as a lot more useful, to show a
single bit "the cached stat info matches what is in the working tree
(yes/no)"?

>> +size::
>> +	The size of the file which is in the index.

This needs to explain what kind of size this is.  Is it the size of
the blob object?  Is it the size of the file in the working tree
(i.e. not cleaned)?  Is it _always_ the size, or can it become a
number that is very different from size in certain circumstances?

IOW, I do not think giving this to unsuspecting users and call it
"size of the file" hurts them more than it helps them, especially
because it is not always the size of the file.

I'd suggest getting rid of everything from ctime down to size and if
we really care about the freshness of the cached stat info, replace
them with a single bit "up-to-date".

>> +flags::
>> +	The flags of the file in the index which include
>> +	in-memory only flags and some extended on-disk flags.
>
> If %(flags) is going to be useful then I think we need to think about
> how they are printed and document that. At the moment they are printed 
> as a hexadecimal number which is fine for debugging but probably not
> going to be useful for something like --format. I think printing 
> documented symbolic names with some kind of separator (a comma maybe)
> between them is probably more useful

I am guessing that most of the above are only useful for curious
geeks and those who are debugging their new tweak to the code that
touches the index, i.e. a debugging feature.  But these folks can
run "git" under a debugger, and they probably have to do so when
they are seeing an unexpected value in the flags member of a cache
entry anyway.  So I am not sure whom this field is intended to help.

>> [...]
>> +test_expect_success 'git ls-files --format eol' '
>> +	printf "i/lf    w/lf    attr/                 \t\n" >expect &&
>> +	printf "i/lf    w/lf    attr/                 \t\n" >>expect &&
>> +	git ls-files --format="%(eol)" --eol >actual &&
>
> I'm not sure why this is passing --eol as well as --format='%(eol)' -
> shouldn't that combination of flags be an error?

Good eyes.

Thanks.
