Return-Path: <SRS0=GnTn=7I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B6CC433DF
	for <git@archiver.kernel.org>; Tue, 26 May 2020 16:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97FA820787
	for <git@archiver.kernel.org>; Tue, 26 May 2020 16:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="oPgEPyBt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbgEZQXJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 May 2020 12:23:09 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61566 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727110AbgEZQXJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 May 2020 12:23:09 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4C22DC0D18;
        Tue, 26 May 2020 12:23:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+qBC8HaeRAKfizVth1SmW1IYzzE=; b=oPgEPy
        Bt4pZLqdzg/0zhRxq3WDxwAnAdKloh1oqeM/lLuAtuox24ERd0xhiUpH5KrsEWe7
        V3tCppnQGq3b1MS+nQ9lJYNukRyZEJ4JEh8Nff1psJXZuOkzD72Bx62NK3BwjXnY
        AsMWx/NSgFrt6B0pevevBo3q0a2UoccixlGaw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TohmV6oQNozwvPFwKo4J1xYBhvUnhTpv
        GBCNVQ2FqYuk4HWy5Zb8ABSGikuc5e+cftKtzp1bh2AXvCFmL52t2BtVYI8GRXqV
        kj1aT9cB8COyNiTRGQk3YvNzV1kNR/7RURz/uwmOtqRhdAiO3y0xZudjlaSxI58x
        BXUFqDOo1AU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 43B5FC0D17;
        Tue, 26 May 2020 12:23:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8BD95C0D16;
        Tue, 26 May 2020 12:23:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     ydirson@free.fr
Cc:     git <git@vger.kernel.org>
Subject: Re: [BUG] diff algorithm selection issue
References: <540830445.1034524732.1590485817611.JavaMail.root@zimbra39-e7>
        <xmqqh7w2oexd.fsf@gitster.c.googlers.com>
Date:   Tue, 26 May 2020 09:23:02 -0700
In-Reply-To: <xmqqh7w2oexd.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 26 May 2020 09:10:22 -0700")
Message-ID: <xmqqd06qoec9.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2D25541A-9F6D-11EA-A805-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> the issue, but anyway, somebody seems to be OR'ing in diff_algorithm
> to xdl_opts field after we see --diff-algorithm=minimal and replaced
> XDF_DIFF_ALGORITHM_MASK bits in xdl_opts field in this function, ...

Well, I am not so sure about that diagnosis, actually.  I should
probably have taken a bit of caffeine before writing my e-mails.

There is no patch needed. --- I simply had misread your report.

> When the config has diff.algorithm=patience set, "git diff --minimal" seems to
> be ignored, and does not give the same output as "git diff --diff-algorithm=minimal",
> but really the same as "git diff --diff-algorithm=patience".

As I wrote, that is absolutely the intended behaviour.  

When patience and other algorithm learns how to trade cycles off
with output size, --minimal may make a difference, but unlike
"--diff-algorithm=minimal" that forces Myers algorithm, the
"--minimal" option should not change the underlying algorithm.

Thanks.
