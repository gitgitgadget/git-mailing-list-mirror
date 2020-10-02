Return-Path: <SRS0=3i0n=DJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C93C35257
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 22:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C65C720738
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 22:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mIHsI4I5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725786AbgJBWGJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Oct 2020 18:06:09 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58172 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgJBWGJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Oct 2020 18:06:09 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 85E0FE4528;
        Fri,  2 Oct 2020 18:06:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1H5rKJzsijxQfwAUiD7r2x5WM3g=; b=mIHsI4
        I5BTfPIS/+PXkc70vpO/LBXyAtbYjPAAk+vx2ORg5I/tw6bj8aM0Vy4aGZCj3EP7
        0lq0yNH2iOb5KBUHSO/aHb2nbzhVcmYy4p9+pa5K0/tdxnKuU/izKHE0keYjHyzL
        7AOtvMWI95CM7f5yeglGhyUGRZ3jEJYllxqLw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NAaSNgQYKJIS1fESVBocitiDa7lDuLbg
        czXlBM6T2TVfDhEeMwqBL/QLdhToUvXPYvPbWEpTdPtq1tkBd3B9v5CwXxZiPtgu
        zTzAYKvBGWneNOR7ocm311kPiwqLMbg4PnpfuXwziR+IhNTRUd2z62m8brB3wI1/
        XOKJPgTSAQo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7D170E4527;
        Fri,  2 Oct 2020 18:06:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AF55CE4526;
        Fri,  2 Oct 2020 18:06:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shengfa Lin <shengfa@google.com>
Cc:     jrnieder@gmail.com, git@vger.kernel.org, nathaniel@google.com,
        rsbecker@nexbridge.com, santiago@nyu.edu
Subject: Re: [RFC PATCH 0/1] adding user.hideTimezone for setting UTC timezone
References: <20201001034350.GB2930867@google.com>
        <20201002215656.80643-1-shengfa@google.com>
Date:   Fri, 02 Oct 2020 15:06:01 -0700
In-Reply-To: <20201002215656.80643-1-shengfa@google.com> (Shengfa Lin's
        message of "Fri, 2 Oct 2020 21:56:56 +0000")
Message-ID: <xmqq8sco8era.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 77280D20-04FB-11EB-884B-843F439F7C89-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shengfa Lin <shengfa@google.com> writes:

>> In addition to not having to futz with TZ, I think I like the
>> semantics better.  The motivation that started this thread was not so
>> much "I want to set a custom timezone to blend in" but rather "why are
>> we recording the timezone at all here?"  In that context, it makes
>> sense to me to have a setting such as
>> 
>> 	core.recordTimeZone
>> 
>> that I can turn *off* to say that I don't think datestamp() callers
>> should consider the timezone to be information worth recording (and
>> instead they should write +0000).  To me that seems a little simpler
>> to understand than user.hideTimezone since this focuses on turning
>> some functionality off (recording of the time zone) instead of turning
>> on a new stealth mode.
>> 
>> Thanks,
>> Jonathan
>
> +1, simpler to understand.

Yup.

> If we have a setting of "core.recordTimeZone", do we need to make it
> as a command option as Junio suggested earlier?

Usually we add command line option --[no-]record-time-zone first
without configuration option when introducing a new features like
this one.  Once the feature proves useful, we'd add a matching
configuration variable for convenience, but leave the command line
option (negative form in this case) so that a configured per-user
default can be overridden as needed.
