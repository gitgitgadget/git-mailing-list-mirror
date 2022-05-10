Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9775EC433F5
	for <git@archiver.kernel.org>; Tue, 10 May 2022 22:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235596AbiEJWXR convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 10 May 2022 18:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235500AbiEJWXP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 May 2022 18:23:15 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690D71D5250
        for <git@vger.kernel.org>; Tue, 10 May 2022 15:23:13 -0700 (PDT)
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [174.119.96.21] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 24AMN5g2019516
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 10 May 2022 18:23:06 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'Johannes Schindelin via GitGitGadget'" <gitgitgadget@gmail.com>
Cc:     <git@vger.kernel.org>,
        "=?utf-8?Q?'Ren=C3=A9_Scharfe'?=" <l.s.r@web.de>,
        "'Taylor Blau'" <me@ttaylorr.com>,
        "'Derrick Stolee'" <stolee@gmail.com>,
        "'Elijah Newren'" <newren@gmail.com>,
        "'Johannes Schindelin'" <johannes.schindelin@gmx.de>
References: <pull.1128.v3.git.1651677919.gitgitgadget@gmail.com>        <pull.1128.v4.git.1652210824.gitgitgadget@gmail.com>        <fdba4ed6f4d5ed4f78404e0a0c5b338c22678533.1652210824.git.gitgitgadget@gmail.com> <xmqqmtfp6ohc.fsf@gitster.g>
In-Reply-To: <xmqqmtfp6ohc.fsf@gitster.g>
Subject: RE: [PATCH v4 2/7] archive --add-file-with-contents: allow paths containing colons
Date:   Tue, 10 May 2022 18:23:01 -0400
Organization: Nexbridge Inc.
Message-ID: <03d801d864bc$85fe62a0$91fb27e0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKQWb69+l7J8EAL2VRwkE+mUiRXFgGWHZmgAloL258CqO2kQatz++rA
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On May 10, 2022 5:57 PM, Junio C Hamano wrote:
>"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
>writes:
>
>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>>
>> By allowing the path to be enclosed in double-quotes, we can avoid the
>> limitation that paths cannot contain colons.
>> ...
>> +		struct strbuf buf = STRBUF_INIT;
>> +		const char *p = arg;
>> +
>> +		if (*p != '"')
>> +			p = strchr(p, ':');
>> +		else if (unquote_c_style(&buf, p, &p) < 0)
>> +			die(_("unclosed quote: '%s'"), arg);
>
>Even though I do not think people necessarily would want to use colons in their
>pathnames (it has problems interoperating with other systems), lifting the
>limitation is a good thing to do.  I totally forgot that we designed
>unquote_c_style() to self terminate and return the end pointer to the caller so the
>caller does not have to worry, which is very nice.
>
>Even if this step weren't here in the series, I would have thought the mode bits
>issue was more serious than "no colons in path"
>limitation, but given that we address this unusual corner case limitation, I would
>think we should address the hardcoded mode bits at the same time.
>
>> diff --git a/t/t5003-archive-zip.sh b/t/t5003-archive-zip.sh index
>> 8ff1257f1a0..5b8bbfc2692 100755
>> --- a/t/t5003-archive-zip.sh
>> +++ b/t/t5003-archive-zip.sh
>> @@ -207,13 +207,21 @@ check_zip with_untracked  check_added
>> with_untracked untracked untracked
>>
>>  test_expect_success UNZIP 'git archive --format=zip --add-file-with-content' '
>> +	if test_have_prereq FUNNYNAMES
>> +	then
>> +		QUOTED=quoted:colon
>> +	else
>> +		QUOTED=quoted
>> +	fi &&
>
>;-)
>
>>  	git archive --format=zip >with_file_with_content.zip \
>> +		--add-file-with-content=\"$QUOTED\": \
>>  		--add-file-with-content=hello:world $EMPTY_TREE &&
>>  	test_when_finished "rm -rf tmp-unpack" &&
>>  	mkdir tmp-unpack && (
>>  		cd tmp-unpack &&
>>  		"$GIT_UNZIP" ../with_file_with_content.zip &&
>>  		test_path_is_file hello &&
>> +		test_path_is_file $QUOTED &&
>
>Looks OK, even though it probably is a good idea to have dq around $QUOTED, so
>that future developers can easily insert SP into its value to use a bit more common
>but still a bit more problematic pathnames in the test.

A test case for .gitignore in this would be good too. People on our exotic platform do this stuff as a matter of course. As an example, a name of $Z3P4:12399334 being used as a named pipe (associated with the unique name of a process) actually has been seen in the wild recently. My solution was to wild card this and/or contain it in an ignored directory.
Regards,
Randall

