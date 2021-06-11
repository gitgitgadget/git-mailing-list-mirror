Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13E5C48BDF
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 01:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE2F761374
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 01:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhFKBjO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 21:39:14 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56466 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbhFKBjN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 21:39:13 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DDE69148087;
        Thu, 10 Jun 2021 21:37:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Xcdmczgji6qdMaqO2VqlB/N8hakLaybxg7ye49
        LhejM=; b=o2IwOq6LFx74yGdAKdoMcG//Y0hm3WW11jAVDiSwBfJepScG+hS6SN
        7EVBOhNMkC7xG11NSahKaEgvbk5I3Pwy24T1NiXYMxDaN1/ajRo34NtJc3CK6WcD
        PdMlnwIFl+v1ZvXbB6FS2Nofr2XlP/6/NHY4JMSmVoMvtUkd+LxWo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D639F148086;
        Thu, 10 Jun 2021 21:37:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2C7F2148085;
        Thu, 10 Jun 2021 21:37:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Luke Shumaker <lukeshu@lukeshu.com>
Cc:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Luke Shumaker <lukeshu@datawire.io>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/2] subtree: fix the GIT_EXEC_PATH sanity check to work
 on Windows
References: <pull.978.git.1623316412.gitgitgadget@gmail.com>
        <a91ac6c18938116c4a74e19466da456b67376fa5.1623316412.git.gitgitgadget@gmail.com>
        <87bl8d6xoq.wl-lukeshu@lukeshu.com>
Date:   Fri, 11 Jun 2021 10:37:12 +0900
In-Reply-To: <87bl8d6xoq.wl-lukeshu@lukeshu.com> (Luke Shumaker's message of
        "Thu, 10 Jun 2021 18:40:21 -0600")
Message-ID: <xmqqim2l5ghj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8C6DECD4-CA55-11EB-9BFE-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Luke Shumaker <lukeshu@lukeshu.com> writes:

>> +if test -z "$GIT_EXEC_PATH" || {
>> +	test "${PATH#"${GIT_EXEC_PATH}:"}" = "$PATH" && {
>> +		# On Windows, PATH might be Unix-style, GIT_EXEC_PATH not
>> +		! type -p cygpath >/dev/null 2>&1 ||
>> +		test "${PATH#$(cygpath -au "$GIT_EXEC_PATH"):}" = "$PATH"
>
> Nit: That should have a couple more `"` in it:
>
>     test "${PATH#"$(cygpath -au "$GIT_EXEC_PATH"):"}" = "$PATH"
>
> But no need to re-roll for just that.

Does the nit purely cosmetic, or does it affect correctness?  I'd
assume the former, as it would not make sense to say "no need to
reroll" if leaving it as-is would mean a breakage, but trying to
make sure.

Thanks.

> Do we also need to handle the reverse case, where PATH uses
> backslashes but GIT_EXEC_PATH uses forward slashes?
