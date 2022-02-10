Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69F1C433EF
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 17:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245025AbiBJRGA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 12:06:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244916AbiBJRF7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 12:05:59 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1FEC10
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 09:06:00 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5AD741187B9;
        Thu, 10 Feb 2022 12:05:59 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sFAHWDtwjQTjTtUjntckU0tjjh5k+6sdze0q/h
        a9XNw=; b=k+QuSsQT8NYtyy/hSAyFJ160jH9XJaFLHVJkNYNM7la0qhYgpcf/rq
        Dhv1x9jqY7dcd1eu9FntuebK9mHFwDOkvh6TyaA4QKEQ9dl4TL7zWoU4uqzJuvON
        HIkrRn1UPQGBKv2C3ebvMMx2dbsUPjhLeJUEKMrLyJnNkJnQKCXeQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 521851187B8;
        Thu, 10 Feb 2022 12:05:59 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B9D771187B7;
        Thu, 10 Feb 2022 12:05:58 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, avarab@gmail.com,
        e@80x24.org, bagasdotme@gmail.com,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v4 3/3] cat-file: add --batch-command mode
References: <pull.1212.v3.git.git.1644353884.gitgitgadget@gmail.com>
        <pull.1212.v4.git.git.1644465706.gitgitgadget@gmail.com>
        <6c51324a6623b62c385ec707a773c21375596584.1644465706.git.gitgitgadget@gmail.com>
        <0b40d1bb-4db1-002f-d665-f51db6c2882c@gmail.com>
Date:   Thu, 10 Feb 2022 09:05:57 -0800
In-Reply-To: <0b40d1bb-4db1-002f-d665-f51db6c2882c@gmail.com> (Phillip Wood's
        message of "Thu, 10 Feb 2022 10:57:02 +0000")
Message-ID: <xmqq5ypmwt1m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B7A94200-8A93-11EC-8BA3-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

>> +	type=$1
>> +	sha1=$2
>> +	size=$3
>> +
>> +	mkfifo input &&
>> +	test_when_finished 'rm input' &&
>> +	mkfifo output &&
>> +	exec 9<>output &&
>> +	test_when_finished 'rm output; exec 9<&-'
>> +	(
>> +		# TODO - Ideally we'd pipe the output of cat-file
>> +		# through "sed s'/$/\\/'" to make sure that that read
>> +		# would consume all the available
>> +		# output. Unfortunately we cannot do this as we cannot
>> +		# control when sed flushes its output. We could write
>> +		# a test helper in C that appended a '\' to the end of
>> +		# each line and flushes its output after every line.
>> +		git cat-file --buffer --batch-command <input 2>err &
>> +		echo $! &&
>> +		wait $!
>> +	) >&9 &
>> +	sh_pid=$! &&
>> +	read cat_file_pid <&9 &&
>> +	test_when_finished "kill $cat_file_pid
>> +			    kill $sh_pid; wait $sh_pid; :" &&
>> +	echo "$sha1 $type $size" >expect &&
>> +	test_write_lines "info $sha1" flush "info $sha1" >input
>
> This closes input and so cat-file exits and flushes its output -
> therefore you are not testing whether flush actually flushes. When I 
> wrote this test in[1] this line was inside a subshell that was
> redirected to the input fifo so that the read happened before cat-file 
> exited.

Yeah, very good point.

> This test is also not testing the exit code of cat-file or
> that the output is flushed on exit. Is there a reason you can't just
> use the test as I wrote it? I'm happy to explain anything that isn't
> clear.

I admit I do not offhand recall what your tests did but help with
this (and more) level of detail with an offer to collaborate is
something I am very happy to see.  Thanks for working well together.

One thing that I wasn't quite sure was how well failure cases are
tested.  If we ask, in a batch mode, "info" for two objects and then
"flush", does the asker get enough clue when to read and when to
stop reading with all four combinations of states, i.e. asking for
two missing objects, one good object and one bad object, one bad
object and one good object, two good objects, for example?

Testing such combinations reliably is tricky---if the asker needs to
react to different response differently, a test that expects good
and then bad may not just fail but can get into deadlock, for
example if the reaction to good response has to read a lot but the
reaction to bad response is to just consume the "bad object" notice,
when a bug in the program being tested makes it issue the response
for a bad case when the asker is expecting a response for a good
object, because the asker will keep waiting for more response to
read which may not come.
