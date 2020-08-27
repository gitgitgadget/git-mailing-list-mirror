Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1100C433E1
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 00:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2BED2074A
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 00:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="In0Xrpat"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgH0AWx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Aug 2020 20:22:53 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63334 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbgH0AWx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Aug 2020 20:22:53 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6FFF4EF91E;
        Wed, 26 Aug 2020 20:22:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+fdmeIHsKgaOlMkzd+dy0la8Z+A=; b=In0Xrp
        ats5SYuB+K+6909OfGw3rnRZ1PMZzY1QUpcabFCphRXRWTTBit/KyKPJK+ugbxqQ
        RUAe2Qn2Dn2YHt2APLaAeladAhS+zF7JeYTUM2QbEGEyMj5OQ92hFLfEN9oUE2LF
        a8Oy0FLVmdoGM0i94bc+uewHNYVaDd9jSYd7s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oIbLfVcJSzFT9cC15YSLi/w7xpcLANKM
        wYZyDP/a7Cem267uiKQdBaMEosCcdGO6UxhFxQKWvmYDXTAiQo7dSJ6vOYOOW5wZ
        trQzsQftxukEiM3A1hTPAbwXErGRn06ta+I3ernfkYmIB4Dm6QK9Equd9oWfUmSa
        ZlS25uWBdOM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 68D96EF91D;
        Wed, 26 Aug 2020 20:22:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B0ACAEF91B;
        Wed, 26 Aug 2020 20:22:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Tom Rutherford <tmrutherford@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: post-checkout hook aborts rebase
References: <CAHr-Uu_KeAJZrd+GzymNP47iFi+dZkvVYsWQPtzT_FQrVnWTDg@mail.gmail.com>
        <xmqq7dtlt080.fsf@gitster.c.googlers.com>
Date:   Wed, 26 Aug 2020 17:22:47 -0700
In-Reply-To: <xmqq7dtlt080.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 26 Aug 2020 17:13:19 -0700")
Message-ID: <xmqq3649szs8.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6FD6B5FC-E7FB-11EA-A68C-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> ...  If "git rebase" or whatever
> command wanted to place files and the index into some state by using
> "git checkout" command, and if the post-checkout hook mucked with
> the state in such a way that contradicts with what the "git rebase"
> command wanted them to be in, it is not surprising the hook's behavior
> broke "git rebase"'s operation.

Having said all that, I actually think that "rebase" shouldn't be
invoking "git checkout" (and its equivalent) internally when
switching to a specific version, in such a way that it would trigger
any end-user specified hooks and allow them to muck with the working
tree and the index state.

I haven't checked the actual implementation of "git rebase" for
quite some time to be sure, but we have lower-level plumbing
commands that are not affected by the end-user hooks for exactly
that kind of "build higher-level commands by synthesis of
lower-level machinery", and it is very possible that what we are
looking at is actually a bug that needs to be fixed.  I dunno.

Thanks.
