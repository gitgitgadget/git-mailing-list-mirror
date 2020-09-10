Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B633BC43461
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 22:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B30821556
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 22:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="b5NUuMF5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725763AbgIJWVw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Sep 2020 18:21:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55586 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbgIJWVv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Sep 2020 18:21:51 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4E74C6EA36;
        Thu, 10 Sep 2020 18:21:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QAAJ/9gimMewicFUa4QqCJIWSzw=; b=b5NUuM
        F5G9wEZElfFcEwhUvPejVZUMG2/lH82i8KBSxNw2suk55UMNeDaHpb8VKIPb1JcG
        8BXvqUV3UJQkEpcgwChS1WO9mQy9fStFe41e7pNEyx1Ni/x6Hsl2TrGHISizbz0V
        UpWno5DH0nwTxPdxAeMTEh2sITNu0BFmBsK7w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nheRq46qjlrLKHNlqPEEsi2SDUHXVZoi
        9oRS0hNwIdYawTVsC0m7UgW/fK+60GpBgxh3Ywr6yo/Ap5VHPD4NO0XyEBzk7rFr
        /MlfZ5noaebmPhaK5MvhJpfOiP7fumbUgDTXQlENdmrLie7YuHxjbzc2RKmMNgKy
        RmBCEepsGg4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 467DB6EA34;
        Thu, 10 Sep 2020 18:21:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BE1B16EA33;
        Thu, 10 Sep 2020 18:21:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v4 8/9] commit: use config-based hooks
References: <20200909004939.1942347-1-emilyshaffer@google.com>
        <20200909004939.1942347-9-emilyshaffer@google.com>
        <a81b058c-b193-7020-30c9-9238407889ba@gmail.com>
Date:   Thu, 10 Sep 2020 15:21:47 -0700
In-Reply-To: <a81b058c-b193-7020-30c9-9238407889ba@gmail.com> (Phillip Wood's
        message of "Thu, 10 Sep 2020 14:50:39 +0100")
Message-ID: <xmqqy2lhnuh0.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 042D9C20-F3B4-11EA-84B0-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

>> +	const char *arg;
>> +	struct strvec hook_args = STRVEC_INIT;
>> +	struct strbuf hook_name = STRBUF_INIT;
>>   	int ret;
>>   +	strbuf_addstr(&hook_name, name);
>
> Seeing this makes me wonder if it would be better for run_hooks() to
> take a string for the name rather than an strbuf, I suspect that
> virtually all callers have a fixed hook name.

Yeah, that is a good point.  It is always a good discipline to keep
the type of the parameters callers need to pass to the minimum.



