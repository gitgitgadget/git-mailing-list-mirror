Return-Path: <SRS0=kKTt=BD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DEAEC433E0
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 23:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 643C320737
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 23:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LB4WMzCm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgGXXLe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jul 2020 19:11:34 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62645 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbgGXXLe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jul 2020 19:11:34 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3324D7625E;
        Fri, 24 Jul 2020 19:11:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MOb9zE/qVZ2zPSa+xMld9jkYMaM=; b=LB4WMz
        CmF/E48pOpmSJ9YOvsHXKlsQUESxJUYfiRht1epRQcfn+AQhtAZRfzccSjRCIjij
        h3iBnrTwWfoceq+cakYJ0DCUtcm3Y7LET5RJ9mHrgJ6l1fnly2BuLLxdVo5O9GjV
        zPRUj8AjlnFeFb0ITLVcN9dcVzO3xVbtGqeg0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jPaeoxO2JrY2+fCBqDf8RhTA0Os2Ohcp
        QrW3lxGdohtPewfAXhoaE/TVS1xP0+D2ycg5Uwy2dIU4LycliEmzj0JIZJ4bVoc8
        kiv7VNY0sIhkHvy9FRpN79Fi9jaa2lxcocPz1DEX1G2YPB1RGPgsqX2xgm29qH0c
        DQXlg8NSzxk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2AA847625D;
        Fri, 24 Jul 2020 19:11:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AC7C97625C;
        Fri, 24 Jul 2020 19:11:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH] Modify fetch-pack to no longer die on error?
References: <20200724223844.2723397-1-jonathantanmy@google.com>
Date:   Fri, 24 Jul 2020 16:11:31 -0700
In-Reply-To: <20200724223844.2723397-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Fri, 24 Jul 2020 15:38:44 -0700")
Message-ID: <xmqq7dusjyos.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 02E823AC-CE03-11EA-96A6-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> I think the best way for easy authorship and review is to convert each
> possibly-dying function into a function that either returns a
> possibly-null error string or returns success/failure and writes the
> error string into an "out" parameter.

Ugly.

Rather, if we were to pass an extra parameter through the entire
callchain, I'd rather see that parameter to be what to do when we
see an error.  Depending on that, the callee can die(), return
error(), or silently return -1, or do something else.

I really do no think it is a good idea to pass text string back to
the caller, which invites sentence lego and untranslatable mess.
