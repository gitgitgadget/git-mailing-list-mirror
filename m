Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31151C433E6
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 05:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8A8322D01
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 05:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbhAFFGI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 00:06:08 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64222 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbhAFFGI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 00:06:08 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5A8EF9C687;
        Wed,  6 Jan 2021 00:05:24 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=rhkUJxvJvlhp5mo+MWOEBwEh/RQ=; b=GUAaSKKIEHQxhrLjNODQ
        nTTxUCgQQagpzzx1hpmL04sChqGLmNytLqlnCodP1SuBmxONZ3NcrpJHz2gYhtiA
        tjpDra5B7bbsA3l25JXDPLdK3qeqsJGJAKjXIQPcE0ZC56vLVo0AtADSmKNk4N/+
        gGylBx9ZlmdnNef5E0IoSRc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=gx3vexDZRGDQSqkxoYAmkyB7Vv6TXCiB88J2n2FAsb3jSc
        dgGMBQB0HD2BYkKmFvb4Adp9jgZmqdaJGSQNmK5YUS5rMPV9JbhIZFZXycgPSDgz
        ZhwqmqYiIM7sDtwYhLchDZQ2/TNGI+AH60FFHRhWKAwcmfidGPAwrUX85cbLs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4E1A99C686;
        Wed,  6 Jan 2021 00:05:24 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8DFCC9C685;
        Wed,  6 Jan 2021 00:05:23 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Abhishek Kumar <abhishekkumar8222@gmail.com>
Cc:     Antonio Russo <aerusso@aerusso.net>, git@vger.kernel.org
Subject: Re: [PATCH] t6016: move to lib-log-graph.sh framework
References: <6dc37f6b-1afd-544d-126e-2be9422571c6@aerusso.net>
        <X/K1BgP8tpsgNe2x@Abhishek-Arch>
Date:   Tue, 05 Jan 2021 21:05:22 -0800
Message-ID: <xmqq1reywt7x.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C8413BA6-4FDC-11EB-AD9B-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Abhishek Kumar <abhishekkumar8222@gmail.com> writes:

> On Sun, Jan 03, 2021 at 07:30:35PM -0700, Antonio Russo wrote:
>> t6016 manually reconstructs git log --graph output by using the reported
>> commit hashes from `git rev-parse`.  Each tag is converted into an
>> environment variable manually, and then `echo`-ed to an expected output
>> file, which is in turn compared to the actual output.
>> 
>> The expected output is difficult to read and write, because, e.g.,
>> each line of output must be prefaced with echo, quoted, and properly
>> escaped.  Additionally, the test is sensitive to trailing whitespace,
>> which may potentially be removed from graph log output in the future.
>> 
>> In order to reduce duplication, ease troubleshooting of failed tests by
>> improving readability, and ease the addition of more tests to this file,
>> port the operations to `lib-log-graph.sh`, which is already used in
>> several other tests, e.g., t4215.  Give all merges a simple commit
>> message, and use a common `check_graph` macro taking a heredoc of the
>> expected output which does not required extensive escaping.
>> 
>
> Glad to see others using `lib-log-graph.sh` as well!
>
> The changes look alright to me but maybe you could have split the two
> changes into two different commits: Using tags directly instead of
> environment variables and using `check_graph` instead of manually
> `echo`-ing to an expected output and comparing with the actual output.

Perhaps.  Also I am wondering if the tests still need to create tags
after this change---isn't the output all matched by the commit title
now?

That is ...

>>  . ./test-lib.sh
>> +. "$TEST_DIRECTORY"/lib-log-graph.sh
>> +
>> +check_graph () {
>> +	cat >expect &&
>> +	lib_test_cmp_graph --format=%s "$@"
>> +}

... this only shows the title, and ...

>> -	git merge B C &&
>> +	git merge B C -m A4 &&

... that is why we need to have the title here.

>>  	git tag A4 &&

Now, does this A4 used anywhere?

>> -	# Store commit names in variables for later use
>> -	A1=$(git rev-parse --verify A1) &&
>> -	A2=$(git rev-parse --verify A2) &&
>> -	A3=$(git rev-parse --verify A3) &&
>> -	A4=$(git rev-parse --verify A4) &&

It certainly used to be needed here, but ...
>> +	check_graph --all <<-\EOF
>> +	* A7
>> +	*   A6
>> +	|\
>> +	| * C4
>> +	| * C3
>> +	* | A5
>> +	| |
>> +	|  \
>> +	*-. | A4

... not anymore in the new version.

>> +	|\ \|
>> +	| | * C2
>> +	| | * C1
>> +	| * | B2
>> +	| * | B1
>> +	* | | A3
>> +	| |/
>> +	|/|
>> +	* | A2
>> +	|/
>> +	* A1
>> +	EOF
>> +'
>>  
