Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88700C0015E
	for <git@archiver.kernel.org>; Tue, 25 Jul 2023 23:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbjGYXvU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jul 2023 19:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbjGYXvT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2023 19:51:19 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9679F212E
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 16:51:16 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 216E633913;
        Tue, 25 Jul 2023 19:51:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tD+J/wc0NowtFdJWmRSQ7c4NRR/ZAncOasQo2C
        cmCpQ=; b=dxSW+UI2YXaMCAoYyXuHz+fsjxQJYX9g7B7e7P+QhvS4prKbPu/Ass
        74kzvOiVqB0XeoUXRJS3CYxMRaZuFYfiwZy5wpAZFa48aPC8uWdZsr1wGYNAv+8z
        G2C2wXW5UMrUCcbniZL49UAvRVDRIV1XJ7uHiy6HJXKYgLIzVJJNk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1903B33912;
        Tue, 25 Jul 2023 19:51:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AC71B3390F;
        Tue, 25 Jul 2023 19:51:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 1/8] pack-objects: allow `--filter` without `--stdout`
References: <20230705060812.2865188-1-christian.couder@gmail.com>
        <20230724085909.3831831-1-christian.couder@gmail.com>
        <20230724085909.3831831-2-christian.couder@gmail.com>
        <ZMBO5A0WxWystYyv@nand.local>
Date:   Tue, 25 Jul 2023 16:51:11 -0700
In-Reply-To: <ZMBO5A0WxWystYyv@nand.local> (Taylor Blau's message of "Tue, 25
        Jul 2023 18:38:28 -0400")
Message-ID: <xmqqcz0fh7o0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 22D674C2-2B46-11EE-A2D4-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Mon, Jul 24, 2023 at 10:59:02AM +0200, Christian Couder wrote:
>> diff --git a/t/t5317-pack-objects-filter-objects.sh b/t/t5317-pack-objects-filter-objects.sh
>> index b26d476c64..2ff3eef9a3 100755
>> --- a/t/t5317-pack-objects-filter-objects.sh
>> +++ b/t/t5317-pack-objects-filter-objects.sh
>> @@ -53,6 +53,14 @@ test_expect_success 'verify blob:none packfile has no blobs' '
>>  	! grep blob verify_result
>>  '
>>
>> +test_expect_success 'verify blob:none packfile without --stdout' '
>> +	git -C r1 pack-objects --revs --filter=blob:none mypackname >packhash <<-EOF &&
>> +	HEAD
>> +	EOF
>> +	git -C r1 verify-pack -v "mypackname-$(cat packhash).pack" >verify_result &&
>> +	! grep blob verify_result
>> +'
>
> Just a couple of style nits here. It's a little strange (for me, at
> least) to see the heredoc into a git process.

FWIW, "git" is after all no different from any other command and
redirecting here-doc, especially with an option like "--stdin" is in
effect, is perfectly sensible, I think.  Preparing an input in a
file (e.g. "cat >file <<EOF" followed by "git cmd <file") might give
you slightly a better debuggability, but I do not sense that it is
what you are worried about.

> ... I am less certain
> about redirecting the output into a file "packhash", only to cat it back
> out.

But that would make the syntax awkward.  Do you mean something along
this line?

	var=$(git ... <<-EOF
		here text
	EOF
	) &&
	git ... mypackname-$var.pack &&
	...

Somehow here-doc and $(command subsitution) does not visually mix
well.

Also, $var will not be inspectable when running this test under "-i
-v", so it hurts debuggability without taking the  output in a
temporary file.  You could do "-x", of course, but that would make
everything ultra verbose, so...
