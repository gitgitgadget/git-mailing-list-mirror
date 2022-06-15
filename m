Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99176C43334
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 20:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237904AbiFOUAP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 16:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbiFOUAO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 16:00:14 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F8C3BFB7
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 13:00:12 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DD5A71A7D1E;
        Wed, 15 Jun 2022 16:00:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JN2t82SsAGBswY8FeB/j4Q98DK2Ede3WEH5Bds
        Zaz/M=; b=Dbr8UgMaaXmatiDUJVMoXc6I44wHArcNNoWRT4HZ1wBRQKEF0u/d10
        POCrLrbSwQnyx6B3syQGRQNIvinys7OScYT31XosHVgFXK/tjz6+eFAUnxF7ZOZn
        fnsqky5rN7lJWNMr/cqrJKo0iqe55auFX+T3QpLLyk+6zHztNsBIU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D4F131A7D1D;
        Wed, 15 Jun 2022 16:00:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8918A1A7D1C;
        Wed, 15 Jun 2022 16:00:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Adam Dinwoodie <adam@dinwoodie.org>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v6+ 2/7] archive --add-virtual-file: allow paths
 containing colons
References: <pull.1128.v6.git.1653145696.gitgitgadget@gmail.com>
        <20220528231118.3504387-1-gitster@pobox.com>
        <20220528231118.3504387-3-gitster@pobox.com>
        <20220615181641.vltm3qtbsckp5s56@lucy.dinwoodie.org>
Date:   Wed, 15 Jun 2022 13:00:07 -0700
In-Reply-To: <20220615181641.vltm3qtbsckp5s56@lucy.dinwoodie.org> (Adam
        Dinwoodie's message of "Wed, 15 Jun 2022 19:16:41 +0100")
Message-ID: <xmqqpmj9zohk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C1DCABEA-ECE5-11EC-BCC2-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adam Dinwoodie <adam@dinwoodie.org> writes:

>> diff --git a/t/t5003-archive-zip.sh b/t/t5003-archive-zip.sh
>> index d6027189e2..3992d08158 100755
>> --- a/t/t5003-archive-zip.sh
>> +++ b/t/t5003-archive-zip.sh
>> @@ -207,13 +207,21 @@ check_zip with_untracked
>>  check_added with_untracked untracked untracked
>>  
>>  test_expect_success UNZIP 'git archive --format=zip --add-virtual-file' '
>> +	if test_have_prereq FUNNYNAMES
>> +	then
>> +		PATHNAME="pathname with : colon"
>> +	else
>> +		PATHNAME="pathname without colon"
>> +	fi &&
>>  	git archive --format=zip >with_file_with_content.zip \
>> +		--add-virtual-file=\""$PATHNAME"\": \
>>  		--add-virtual-file=hello:world $EMPTY_TREE &&
>>  	test_when_finished "rm -rf tmp-unpack" &&
>>  	mkdir tmp-unpack && (
>>  		cd tmp-unpack &&
>>  		"$GIT_UNZIP" ../with_file_with_content.zip &&
>>  		test_path_is_file hello &&
>> +		test_path_is_file "$PATHNAME" &&
>>  		test world = $(cat hello)
>>  	)
>>  '
>
> This test is currently failing on Cygwin: it looks like it's exposing a
> bug in Cygwin that means files with colons in their name aren't
> correctly extracted from zip archives.  I'm going to report that to the
> Cygwin mailing list, but I wanted to note it for the record here, too.

Does this mean that our code to set FUNNYNAMES prerequiste is
slightly broken?  IOW, should we check with a path with a colon in
it, as well as whatever we use currently for FUNNYNAMES?

Something like the attached patch?  

Or does Cygwin otherwise work perfectly well with a path with a
colon in it, but only $GIT_UNZIP command has problem with it?  If
that is the case, then please disregard the attached.

Thanks.

 t/test-lib.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git i/t/test-lib.sh w/t/test-lib.sh
index 55857af601..5dce7d95c9 100644
--- i/t/test-lib.sh
+++ w/t/test-lib.sh
@@ -1620,6 +1620,7 @@ test_lazy_prereq FUNNYNAMES '
 	touch -- \
 		"FUNNYNAMES tab	embedded" \
 		"FUNNYNAMES \"quote embedded\"" \
+		"FUNNYNAMES colon : embedded" \
 		"FUNNYNAMES newline
 embedded" 2>/dev/null &&
 	rm -- \
