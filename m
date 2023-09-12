Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65703EE3F0D
	for <git@archiver.kernel.org>; Tue, 12 Sep 2023 19:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236798AbjILTBY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Sep 2023 15:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237509AbjILTBT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2023 15:01:19 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5318EE6
        for <git@vger.kernel.org>; Tue, 12 Sep 2023 12:01:15 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9B8B119B9A8;
        Tue, 12 Sep 2023 15:01:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=A71aOfN7Ec8BqOv8878QhwjRX7sQD4fOYr1be/
        WvEY4=; b=t3Bqg1gPT+l+LHs0EDktE7BDfdKU034OvAaORu6qC8x6Qcmbr6ws67
        EzJqw8G5+nnLFedFH81bXsUQrXXH4O/jxGCOBiYtsZHv4fhlY1xCmubc2lf5BoMi
        npgV+UnCTJmlSCy1fxGcERpY4IefgqSOHBL16DioauAZ2jxzS5HbM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8F80F19B9A7;
        Tue, 12 Sep 2023 15:01:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EDD2B19B9A6;
        Tue, 12 Sep 2023 15:01:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Arver <linusa@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 2/3] update-index: add --show-index-version
In-Reply-To: <owlybke8kkcf.fsf@fine.c.googlers.com> (Linus Arver's message of
        "Mon, 11 Sep 2023 22:54:08 -0700")
References: <20230818233729.2766281-1-gitster@pobox.com>
        <20230818233729.2766281-3-gitster@pobox.com>
        <owlybke8kkcf.fsf@fine.c.googlers.com>
Date:   Tue, 12 Sep 2023 12:01:12 -0700
Message-ID: <xmqqbke7nrlz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BE9FA2E2-519E-11EE-BEF6-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Arver <linusa@google.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> "git update-index --version N" is used to set the index format
>
> s/--version/--index-version

Good eyes.

>> +	`git add -N`.  With `--verbose` option, also reports the
>
> How about
>
>     `git add -N`.  With `--verbose`, also report the

Yup, that is much better.

>>  		OPT_INTEGER(0, "index-version", &preferred_index_format,
>>  			N_("write index in this format")),
>> +		OPT_SET_INT(0, "show-index-version", &preferred_index_format,
>> +			    N_("show index format version"), -1),
>
> How about
>
>     "show on-disk index format version"

OK.  The entry before that says "write" and it makes it clear enough
that it is talking about the "on-disk" thing, hence "write index" is
sufficient.  The readers, who do not know the "format version"
matters only on-disk and does not matter once the index data gets
slurped into memory, would benefit with "on-disk index" here.  I
will also take your "show" -> "report" suggestion.

>> diff --git a/t/t2107-update-index-basic.sh b/t/t2107-update-index-basic.sh
>> index 89b285fa3a..c78d1e9396 100755
>> --- a/t/t2107-update-index-basic.sh
>> +++ b/t/t2107-update-index-basic.sh
>> @@ -111,4 +111,20 @@ test_expect_success '--chmod=+x and chmod=-x in the same argument list' '
>>  	test_cmp expect actual
>>  '
>>
>> +test_expect_success '--index-version' '
>> +	git commit --allow-empty -m snap &&
>> +	git reset --hard &&
>
> Not sure why this "git reset --hard" is needed here --- is it to clear
> out state from previous test cases? If so, perhaps it's better to run
> this as the very first command in this test case?
>
> But this also makes me wonder why "git commit --allow-empty -m snap" is
> even necessary (if we already have a git repo)?

There is no commit yet in this repository at this point, which means
that "reset --hard [HEAD]" cannot be the first command.  There are
newly added paths in the index, some of which are further modified
in the working tree.  Creating a snapshot commit will record what is
in the index, and a hard reset will make the contents of the working
tree match exactly what was in the index, reverting the modification
made to some paths in the working tree.

Having said that, we may further want to tighten these "clean the
slate" steps for later tests (read on).

>> +	git update-index --index-version 2 >actual &&
>> +	test_must_be_empty actual &&
>
> Before we do "--index-version 2", it may be desirable to run the
> "--show-index-version" flag first to see what we have before modifying
> it with "2".

That was what I specifically wanted to avoid.  I am not interested
in testing what the default version of the day is.  The only thing
this invocation cares about is to (try to) use the version 2; it
will be detected as a failure if the next show-index-version
reported something else ...

>> +	git update-index --show-index-version >actual &&
>> +	echo 2 >expect &&
>> +	test_cmp expect actual &&

... which is checked here.

>> +	git update-index --index-version 4 --verbose >actual &&
>> +	echo "index-version: was 2, set to 4" >expect &&
>> +	test_cmp expect actual

And how a transition is reported with --verbose is tested here.

>> +'
>
> How about adding this check below to check what happens if the newly-set
> version is the same as the existing version?
>
>         git update-index --index-version 4 --verbose >actual &&
>         echo "index-version: was 4, set to 4" >expect &&
>         test_cmp expect actual
>
> And also how about a similar check, but for downgrading from a higher
> version number to a lower one?
>
>         git update-index --index-version 2 --verbose >actual &&
>         echo "index-version: was 4, set to 2" >expect &&
>         test_cmp expect actual

I assumed that the flipping between versions without --verbose had
adequate coverage and the tests this patch adds were solely about
reporting with the "--verbose" option.  It seems there is no such
test coverage, so these may want to be added.  Perhaps we should
flip from 2 to 4 _without_ verbose and make sure we are still silent
as well.

Testing downgrading an index with unspecified [*] contents from 3
(or higher) to 2 would be unwise, as such a conversion may or may
not work depending on the contents.  I will tighten the "clean the
slate" steps and add downgrades to the list, as the initial "try to
set to 2" may not even work with unknown contents in the index.

Thanks.


[Footnote] 

* This is in a very late part of the test script and the state
  previous tests left us will change over time.
