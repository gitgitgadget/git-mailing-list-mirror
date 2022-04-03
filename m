Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBDAAC433EF
	for <git@archiver.kernel.org>; Sun,  3 Apr 2022 21:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376516AbiDCVvi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Apr 2022 17:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiDCVvg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Apr 2022 17:51:36 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30DC72F032
        for <git@vger.kernel.org>; Sun,  3 Apr 2022 14:49:42 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D2E9F1861C4;
        Sun,  3 Apr 2022 17:49:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zFE5nWjmm0hDWx7sWoB4aLsv14nt5ZbKSyi3Cz
        KW6o0=; b=ihoeu2mE6MNM8KT5urO7NbYFiczqgGoj9rkG9GzTFqSN/6K94TePlh
        Y8mf3pgnPQt+NEuF86h7xSV4Ptbr/XaRZlSvnCZuDwBeSU3+vAOJ+jpnRcz9rTxj
        rdZJ4dfWA5L6bGJrKo83EuUmiz4J/SvfwF6Kf/TgjVgH0hA2qlxHw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CCD5D1861C3;
        Sun,  3 Apr 2022 17:49:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3B3131861C1;
        Sun,  3 Apr 2022 17:49:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v4 13/27] revisions API users: use release_revisions()
 in builtin/log.c
References: <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com>
        <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com>
        <patch-v4-13.27-02ca92660af-20220331T005325Z-avarab@gmail.com>
        <14c17fa9-e9ff-ac5f-dbda-4a566ed09fd3@gmail.com>
Date:   Sun, 03 Apr 2022 14:49:38 -0700
In-Reply-To: <14c17fa9-e9ff-ac5f-dbda-4a566ed09fd3@gmail.com> (Phillip Wood's
        message of "Sat, 2 Apr 2022 10:22:44 +0100")
Message-ID: <xmqq5ynpvnv1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F6236B28-B397-11EC-B3BA-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

>>   +static int cmd_log_deinit(int ret, struct rev_info *rev)
>> +{
>> +	release_revisions(rev);
>> +	return ret;
>> +}
>
>
>>   /*
>>    * This gives a rough estimate for how many commits we
>>    * will print out in the list.
>> @@ -558,7 +564,7 @@ int cmd_whatchanged(int argc, const char **argv, const char *prefix)
>>   	cmd_log_init(argc, argv, prefix, &rev, &opt);
>>   	if (!rev.diffopt.output_format)
>>   		rev.diffopt.output_format = DIFF_FORMAT_RAW;
>> -	return cmd_log_walk(&rev);
>> +	return cmd_log_deinit(cmd_log_walk(&rev), &rev);
>
> This is a rather unusual pattern, at first I wondered if there were
> going to be more added to the body of cmd_log_deinit() in later
> commits but there isn't so why not just call release_revisions() here
> to be consistent with the other release_revisions() call that are
> added in other patches?

It is being cute and clever by not requiring a temporary variable
ret, where you would normally say

	int ret = 0; /* assume success */

	... a lot of code ...
	ret = cmd_log_walk(&rev);
        release_revisions(&rev);
	return ret;

I agree that this looks confusing; if this pattern can become
majority locally in the file, I guess it would be OK---at that point
we can claim that it is the (new) usual pattern ;-).




