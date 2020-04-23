Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D494C54FD0
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 19:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D6A320728
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 19:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CQWJsdFt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgDWTFX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 15:05:23 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63676 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbgDWTFW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 15:05:22 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4FD78CC9DC;
        Thu, 23 Apr 2020 15:05:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5B3S5kskhQR9eLbGaD2LYm0BMfM=; b=CQWJsd
        Fth1j7orOtd0KQ0prH+tkoTF6BGmyP0nONcvN0biE5MZTYpRp7+PY8Ef1WVRVIOA
        l7qxz+vNics32H6ILzMxwtzSWYpgBTbJA5AimtGQm5I7j3FaosXD0Bs2pjpqPvdS
        pUdLy3lTp/Rya4AOYGEk62iS6/1OBLoRoZYQs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KLu0yPWsoH4OjhNXwYNKi7TsjqdfJtRW
        1lrTYGlWPoBtLADp9IwFnionnUJRnGtHjNpPPVNCCwU/4cyGi0hDhAumJxRqQHpt
        /+sQu2nTffjED1rA/h+CI8xJVjfXsjCDLiA++GaQXh4OHwPMq9jhW8+KplGbeZAV
        dEy85Cdl9O4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 47DADCC9DB;
        Thu, 23 Apr 2020 15:05:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8DCF5CC9D7;
        Thu, 23 Apr 2020 15:05:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        newren@gmail.com, jrnieder@gmail.com, dstolee@microsoft.com
Subject: Re: [PATCH] shallow.c: use 'reset_repository_shallow' when appropriate
References: <8d295389ea43c6b7e008514067b7af6eacba64a5.1587492422.git.me@ttaylorr.com>
        <20200422180245.196132-1-jonathantanmy@google.com>
        <xmqqy2qnidyy.fsf@gitster.c.googlers.com>
        <20200423001438.GC19100@syl.local>
Date:   Thu, 23 Apr 2020 12:05:15 -0700
In-Reply-To: <20200423001438.GC19100@syl.local> (Taylor Blau's message of
        "Wed, 22 Apr 2020 18:14:38 -0600")
Message-ID: <xmqq5zdqhvkk.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5ED6C698-8595-11EA-9DDA-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

>> What I am trying to get at is if it would be safer to have a pair of
>> thin wrapper for rolling back or committing a new version of new
>> shallow file, e.g. rollback_shallow_file() + commit_shallow_file(),
>> and replace calls to {rollback,commit}_lock_file() with calls to
>> them.
>
> Very elegant. Thanks for an excellent suggestion. v2 incoming just as
> soon as 'make test' finishes...

Note that I didn't verify there is a case where we want not to call
reset_repository_shallow() after committing or rolling back, either
for performance or correctness purposes.  As long as the experts on
the codepaths involved are happy with the idea, I'd be happy, too.

JNieder raised the idea of using a different type to avoid calling
the bare rollback/commit functions by mistake.  It appears that, in
addition to these two functions, setup_alternate_shallow() needs to
be updated if we wanted to go that route, and it sounds like a good
idea to gain safety with minimal cost.

Thanks.


