Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4730C2D0E4
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 22:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E50120866
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 22:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="UWYl/4iW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388608AbgKXWPz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 17:15:55 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52314 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388442AbgKXWPz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 17:15:55 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 12BE996FCC;
        Tue, 24 Nov 2020 17:15:53 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Lo56geZuK14WVCNJnHXhXSso67w=; b=UWYl/4
        iWzoQClCoeErj9ABLGi/kd/h3j3aCOBl5rHJRPLmkaFzFWTrrRQSgaRO981pCcGX
        Uz3d2zYiJlnrp1U/xLmV2YUmrfWplT+wGpeo8lhPNi7YmF5oPoS9TN1g216yOcxh
        bW46sFQKL57aQyUdtA+yAz/P9Lt7CAK2O+7x4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PNPVby2+SybvFWe+mVLbIk1kR71Ac/yD
        5687wBsyeyHniqrtIYl7mK1hHlQWTE4OzhM2E6rpqJJpZA7vftcR2AJeA/Yu3+gz
        zWMOMARtjZIP/GpIUeIqXfB3GK1eXBpJoRFpdxmZgsyo859xuBwugvaPml9cklIS
        ZYJaSGFjKV4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 097FC96FCB;
        Tue, 24 Nov 2020 17:15:53 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 89BAF96FC8;
        Tue, 24 Nov 2020 17:15:52 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3] usage: add trace2 entry upon warning()
References: <20201123190412.101265-1-jonathantanmy@google.com>
        <20201124200527.890563-1-jonathantanmy@google.com>
Date:   Tue, 24 Nov 2020 14:15:51 -0800
In-Reply-To: <20201124200527.890563-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Tue, 24 Nov 2020 12:05:27 -0800")
Message-ID: <xmqqzh36h04o.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9D6E9D2A-2EA2-11EB-80E0-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Emit a trace2 error event whenever warning() is called, just like when
> die(), error(), or usage() is called.
>
> This helps debugging issues that would trigger warnings but not errors.
> In particular, this might have helped debugging an issue I encountered
> with commit graphs at $DAYJOB [1].
>
> There is a tradeoff between including potentially relevant messages and
> cluttering up the trace output produced. I think that warning() messages
> should be included in traces, because by its nature, Git is used over
> multiple invocations of the Git tool, and a failure (currently traced)
> in a Git invocation might be caused by an unexpected interaction in a
> previous Git invocation that only has a warning (currently untraced) as
> a symptom - as is the case in [1].
>
> [1] https://lore.kernel.org/git/20200629220744.1054093-1-jonathantanmy@google.com/
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
> Thanks, Junio. That comment looks good. Here is the version with Junio's
> suggested comment included, for everyone's reference.

Heh, I meant it as more of a #leftoverbit, not directly applicable to
this particular patch, but would be a good follow-up topic, as I would
have expected that die/warn/error should lose their own comments where
they call trace2_cmd_error_va() in the same patch that adds the comment
for callers near the function.

Let's use v2 if the difference between v2 and v3 is only the
addition of the comment before trace2_cmd_error_va() function decl
to help the callers.

