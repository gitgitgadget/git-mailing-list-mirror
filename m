Return-Path: <SRS0=w8S9=2S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07172C2D0DA
	for <git@archiver.kernel.org>; Sat, 28 Dec 2019 04:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C598420882
	for <git@archiver.kernel.org>; Sat, 28 Dec 2019 04:00:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DawsIKOH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbfL1Duv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Dec 2019 22:50:51 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56777 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbfL1Duv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Dec 2019 22:50:51 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 19B2AAA27C;
        Fri, 27 Dec 2019 22:50:51 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VrzYWByqfCH9j+XCMH89vcJiWoU=; b=DawsIK
        OHcPKyZzq03KMwccKSCdyEUY06zBRxDImS3decxLaVUMzC3whvwSb+QREQhmsmky
        txaDSsB/dnUkYqV+vEBKmprQCG22rTGq4QvJDnaJVHQFCrGzM63s2iFEzpNemJTf
        aNy1U+pjR0C7pLhZzrduDUU96meNA21ZHLn7A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hsA0KODESr0NgxtJA5X6gEZHAVxTI8If
        uX3f/q0hYGrDZLuZllFI4nXqV313swDDZSanmJoLjIplN6sPBQfsjke1uJNKw3J6
        oNCIT+5/B7dZMbqmmZkTR28UvmyYQ0YqIRLPU3MCDZtYkrydIXYQcoKQRe9507FP
        Dop1kMjFXk8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 11E83AA27B;
        Fri, 27 Dec 2019 22:50:51 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3C1E4AA279;
        Fri, 27 Dec 2019 22:50:48 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, matvore@google.com
Subject: Re: [PATCH] revision: allow missing promisor objects on CLI
References: <20191228003430.241283-1-jonathantanmy@google.com>
Date:   Fri, 27 Dec 2019 19:50:45 -0800
In-Reply-To: <20191228003430.241283-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Fri, 27 Dec 2019 16:34:30 -0800")
Message-ID: <xmqqlfqxhzvu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3BD570C6-2925-11EA-BBCA-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>  	object = get_reference(revs, arg, &oid, flags ^ local_flags);
>  	if (!object)
> -		return revs->ignore_missing ? 0 : -1;
> +		/*
> +		 * Either this object is missing and ignore_missing is true, or
> +		 * this object is a (missing) promisor object and
> +		 * exclude_promisor_objects is true.

I had to guess and dig where these assertions are coming from; we
should not force future readers of the code to.

At least this comment must say why these assertions hold.  Say
something like "get_reference() yields NULL on only such and such
cases" before concluding with "and in any of these cases, we can
safely ignore it because ...".

I think the two cases the comment covers are safe for this caller to
silently return 0.  Another case get_reference() yields NULL is when
oid_object_info() says it is a commit but it turns out that the
object is found by repo_parse_commit() to be a non-commit, isn't it?
I am not sure if it is safe for this caller to just return 0.  There
may be some other "unusual-but-not-fatal" cases where get_reference()
does not hit a die() but returns NULL.

Thanks.

