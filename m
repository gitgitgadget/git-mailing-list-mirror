Return-Path: <SRS0=GLOD=BA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96402C433E0
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 23:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5795720771
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 23:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xaU/6Jc7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731222AbgGUXZK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jul 2020 19:25:10 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61927 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbgGUXZJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jul 2020 19:25:09 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1DA6CF2CBD;
        Tue, 21 Jul 2020 19:25:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7ED2rpT4ovkLs7xB3UWc/UGvGC8=; b=xaU/6J
        c7yP6b/F5PSXsaldpVFsBAiM13/eu13Kf3g9KG+CTBUlUWvKFeFre3UBahBl35Lp
        jiGQC/mFnVe2oVa++kHO53wLAFdX8OJ3EGKMxTUEe9de38uVK6/XAzFMMJT4WBUQ
        IhVC1wJLOatQD5uQE24MH2Xif6EyHE/lT50h8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ix4tZqnJRKuc3m9XI/NXqsvkGo2xfVLI
        R3Y0fRcgdMI3aO8ZcN5bmPUWWHpzM84yCAwOZ4eRe7Kzaj7E0rPYp5fUdL4I+5EL
        ypel2CsQPaxVQmhWxr9OrGcV/2934XEJPWnxN6UlKXbKF27JG/N6/mtdC1JvRmaO
        s6FoQ+SfnfI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 161CFF2CBC;
        Tue, 21 Jul 2020 19:25:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5610CF2CBB;
        Tue, 21 Jul 2020 19:25:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] sha1-file: make pretend_object_file() not prefetch
References: <20200721225020.1352772-1-jonathantanmy@google.com>
Date:   Tue, 21 Jul 2020 16:25:03 -0700
In-Reply-To: <20200721225020.1352772-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Tue, 21 Jul 2020 15:50:20 -0700")
Message-ID: <xmqq8sfc78og.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 68A340B6-CBA9-11EA-A75B-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> To make progress towards solving this, I'm thinking of making a new
> function has_object() that takes a repository, an object ID, and flags,
> and only supports one flag: HAS_OBJECT_RECHECK_PACKED (which has the
> opposite meaning of OBJECT_INFO_QUICK). Checks that should not fetch
> should use has_object(), and checks that should fetch (if they exist - I
> think that most would want additional information about the object, so
> they would use oid_object_info() or similar already) should use
> oid_object_info() or a similar function. That way we can see how many
> uses of has_object_file() we have checked, and at the same time make
> behavior we usually want into the default behavior. Any opinions?

Yes, a new function (or a pair of functions) makes it easy to see
how much progress we made and also gives us easier greppability.

