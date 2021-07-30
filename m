Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 835EDC4338F
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 17:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5357260F4A
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 17:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbhG3RcP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jul 2021 13:32:15 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52855 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbhG3RcO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jul 2021 13:32:14 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EFDFEE8CA3;
        Fri, 30 Jul 2021 13:32:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xbmwm9cFGr1TDgcDh55RIIX8OfPGusx4yHJ1qO
        +U8DI=; b=jgr+qTxmiKDrDVVNF4rBJXY9jyuEjV6HUjEk3Sd6Kn/Jc6TrcL+djb
        RSll/0hRupr8tH7vnYbBhw1ukjZzg5TTf/FH5dzs5/c5rYoXHLVc3UXff1WC4XhA
        0PRHHH1IKS3iPeGVYtmbKb2LE4O41y/KZCjfkqyWvtyrNkTuW3HP8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E06EEE8CA2;
        Fri, 30 Jul 2021 13:32:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0CEBBE8CA1;
        Fri, 30 Jul 2021 13:32:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Ben Boeckel <mathstuf@gmail.com>, git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 1/1] config: support a default remote tracking setup
 upon branch creation
References: <20210728135041.501850-1-mathstuf@gmail.com>
        <20210729020125.746206-1-mathstuf@gmail.com>
        <20210729020125.746206-2-mathstuf@gmail.com>
        <bcbe13a8-7f22-7564-77cd-674c7b2acbf6@gmail.com>
Date:   Fri, 30 Jul 2021 10:32:07 -0700
In-Reply-To: <bcbe13a8-7f22-7564-77cd-674c7b2acbf6@gmail.com> (Philippe
        Blain's message of "Fri, 30 Jul 2021 09:35:49 -0400")
Message-ID: <xmqqim0r1ze0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 107C8986-F15C-11EB-8B9D-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain <levraiphilippeblain@gmail.com> writes:

>> diff --git a/environment.c b/environment.c
>> index 2f27008424..d550deabbd 100644
>> --- a/environment.c
>> +++ b/environment.c
>> @@ -60,6 +60,8 @@ int global_conv_flags_eol = CONV_EOL_RNDTRP_WARN;
>>   char *check_roundtrip_encoding = "SHIFT-JIS";
>>   unsigned whitespace_rule_cfg = WS_DEFAULT_RULE;
>>   enum branch_track git_branch_track = BRANCH_TRACK_REMOTE;
>> +const char* git_branch_remote = NULL;
>> +const char* git_branch_merge = NULL;

Style:
 (1) asterisk sticks to the identifier, not type, in our codebase.
 (2) do not initialize globals and statics to 0 or NULL.

> Can the new settings be implemented without adding more global variables ?

This is worth considering in the longer term.  For things like these
new configuration items and existign git_branch_track, we already
have reasonably made abstraction that branch.c is where interesting
actions happen (like setting up remote tracking, etc), so there is
no reason for them to be in environment.c or *.h to be visible to
anywhere outside branch.c file.

I wonder if it is a matter of moving git_default_branch_config() to
branch.c from config.c and make it global, while moving these global
variables also to branch.c and make them file-local?

I am still unsure without the expected use-case well documented, if
it is clear enough for users to learn how and when these new
configurations should be used (as opposed to following the
traditional triangular workflow) with only the documentation updates
in this patch, but at least I can trust others like you to give
input to polish this into a reasonable shape.

Thanks for a review (and thanks for starting the effort, Ben).




