Return-Path: <SRS0=iK8c=5M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0CF6C43331
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 21:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB818206DB
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 21:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="stTZcw8s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbgC0Von (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Mar 2020 17:44:43 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55250 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbgC0Von (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Mar 2020 17:44:43 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B35CF557C7;
        Fri, 27 Mar 2020 17:44:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aMqEPMVAxYHo3LOeLII9Rf4NP0c=; b=stTZcw
        8sjL2U4aGyeTbLrz6fYjUqeiBy5K8QC2HeCvmUW+H6nVOkdu2cU0NG2Yebqq9IyG
        RsrKh2EA3+Q8bFzIN/18EyPrtEAbMYWwLaVRB/+tFXtrWfod5C0ZwKc3IPbuzCvW
        /rM0NJDl2xBJXkZEgNEKnV9ktKxr6MlD4DWJQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=X/qp3ubzd7zSRVkc8lK+YLQY8qAww6HO
        fzuWT6JuSzIvwtwc00+zTLLJauXkZpsXb31rXrEL3J1wECblhiWvVogY+cG+Ta/s
        6Xh2uqgZQG0WcJJ9Bmn56pwgb2CTBXjym1GgkM7ePCy6nsPbwjHB5grUX6P8PGrZ
        BIBV7RCTjTQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AC303557C6;
        Fri, 27 Mar 2020 17:44:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 39C99557C3;
        Fri, 27 Mar 2020 17:44:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 7/9] update-ref: move transaction handling into `update_refs_stdin()`
References: <cover.1585129842.git.ps@pks.im>
        <bd92a649d79cde43260358ca939baee0f1a2f076.1585129842.git.ps@pks.im>
Date:   Fri, 27 Mar 2020 14:44:40 -0700
In-Reply-To: <bd92a649d79cde43260358ca939baee0f1a2f076.1585129842.git.ps@pks.im>
        (Patrick Steinhardt's message of "Wed, 25 Mar 2020 10:54:16 +0100")
Message-ID: <xmqqsghtealz.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2A11885C-7074-11EA-ADD4-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> While the actual logic to update the transaction is handled in
> `update_refs_stdin()`, the transaction itself is started and committed
> in `cmd_update_ref()` itself. This makes it hard to handle transaction
> abortion and commits as part of `update_refs_stdin()` itself, ...

It is not offhand clear why it makes any difference, especially
because there is only a single caller of update_refs_stdin()
function, but let's see how this move makes things easier in [8/9]
and [9/9].

The patch itself looks like a bug-free no-op change.

Thanks.
