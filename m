Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF418C433EF
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 21:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92F906103C
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 21:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240063AbhIPV6D (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 17:58:03 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61120 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234142AbhIPV6C (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 17:58:02 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C3F82150793;
        Thu, 16 Sep 2021 17:56:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TjykSLExhHPw+320E4U470ZDwp2KbPswoozj8o
        v2lg0=; b=r4uclRjeGotdD5HfWbyAuquLWn/5fDc5YCnRrTOOOYJtCnc9Xag++H
        Q/8M+5kc8BDG+fTIXtjsyZOQc92386gBVoV2g8Jsn2pnJBs8WUJ6auKiDslBsYpD
        iinMCAZ/iy6GajnmKpwXadwiABe0LNDAAUSMqiKox2xCcypqcYB0o=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BC77B150792;
        Thu, 16 Sep 2021 17:56:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0E3DC15078F;
        Thu, 16 Sep 2021 17:56:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     hanwen@google.com, chooglen@google.com, git@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] refs: make _advance() check struct repo, not flag
References: <CAFQ2z_ML_g6DTiG92srq8UCCu_D8bi6z1mP_znt24TJagVfi2g@mail.gmail.com>
        <20210916172609.1074157-1-jonathantanmy@google.com>
Date:   Thu, 16 Sep 2021 14:56:37 -0700
In-Reply-To: <20210916172609.1074157-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Thu, 16 Sep 2021 10:26:09 -0700")
Message-ID: <xmqqilz0rxpm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F82A45A0-1738-11EC-83A9-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> On Wed, Sep 15, 2021 at 12:41 AM Glen Choo <chooglen@google.com> wrote:
>> > In the current state of affairs, the files ref store and the packed ref
>> > store seem to behave as a single logical ref database. An example of
>> > this (that I care about in particular) is in refs/files-backend.c where
>> > the files backend validates oids using the_repository's odb.
>> > refs/packed-backend.c doesn't do any such validation, and presumably
>> > just relies on the correctness of refs/files-backend.c. I assume that
>> > this also explains why some functions in refs_be_packed are stubs.
>> 
>> The loose/packed storage is implemented in terms of files backend (the
>> public entry point) that defers to a packed backend in some cases. The
>> latter is implemented as a ref backend, but for no good reason.
>
> Yes, the packed backend doesn't need to be a ref backend.

Sorry, I do not follow.  Do you mean we cannot have a version of Git
that offers say a read-only access to the repository without any
loose refs, with the default ref backend being the packed one?

Or do you mean that we can ignore such a hypothetical use case and
could reimplement the files backend that can also understand the
$GIT_DIR/packed-refs file directly without "deferring to another ref
backend which is 'packed'"?

