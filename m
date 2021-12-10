Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC95C433EF
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 21:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344508AbhLJVsz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 16:48:55 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58282 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239438AbhLJVsy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 16:48:54 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 842CFFD765;
        Fri, 10 Dec 2021 16:45:18 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RVzq6916Qg8uQPZLczwM2b7khUXtMOZ//rgRyp
        ZO+S8=; b=ObOxZ52X4Rdszm+pNxQwN/LBs5ym9md6ges7TOs0v/3M15Zv/JRDvI
        qkf9DocHlzqFK97OANY4tMcxp+3/VCIFo39WVSBba7GWqotJMJlmVz63W47Jjo+Z
        VfWc+z6fWl1wO5V5da6ekvVthF6VJCks/1gNewrodKiOSXl4d8X/M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7AEB2FD764;
        Fri, 10 Dec 2021 16:45:18 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D2F4FFD762;
        Fri, 10 Dec 2021 16:45:17 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     chooglen@google.com, git@vger.kernel.org, avarab@gmail.com
Subject: Re: [PATCH v6 2/2] config: include file if remote URL matches a glob
References: <kl6lwnkean33.fsf@chooglen-macbookpro.roam.corp.google.com>
        <20211209223919.513113-1-jonathantanmy@google.com>
Date:   Fri, 10 Dec 2021 13:45:16 -0800
In-Reply-To: <20211209223919.513113-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Thu, 9 Dec 2021 14:39:19 -0800")
Message-ID: <xmqqmtl8m8wj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 774139A0-5A02-11EC-AB66-C48D900A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> The explanation is rather long, though. It goes something like this:
>
>   If the main config is:
>
>   [remote a]
>     url = bar
>   [includeif hasconfig:remote.*.url:foo]
>     path = foo
>   [includeif hasconfig:remote.*.url:bar]
>     path = bar
>
>   and "bar" contains:
>
>   [remote b]
>     url = foo
>
>   Should "foo" be included? For now, we avoid these situations
>   completely by prohibiting URLs from being configured in "includeif
>   hasconfig".
>
> If you can think of a concise explanation, maybe we can include it.

Perhaps it is easier to approach it from the viewpoint of a new
user who is unfamiliar with what you designed.

I would imagine that most users would find it natural if a single
pass precedure read and processed lines as it sees them.

That is, when the first includeif is evaluated, we have seen only
'remote.a.url' whose value is 'bar', so the condition does not hold.
and then when the second includeif is evaluated, it gets included,
and we read 'bar'.  But that is wher configuration reading ends;
remote.b.url is not asked for after we process the second includeif
til the end.

If you explain

 (1) why such a simplest design would not work well; and

 (2) how the actual design is different from that simplest design to
     overcome it.

it would be easier to grok?

Thanks.
