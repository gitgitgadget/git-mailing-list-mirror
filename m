Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1164FC2D0DB
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 18:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D90EC20707
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 18:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lXGIaBK3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbgA3S5e (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 13:57:34 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62817 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727285AbgA3S5d (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 13:57:33 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7A88AAA463;
        Thu, 30 Jan 2020 13:57:33 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Aq1xf/Qho09ExrDsmcyH9UDIwkg=; b=lXGIaB
        K3vsKxoAPQjC5sQnzmG1KcSQCrVvJ0Cm6RKhqbt772RXUiCzdD6tFbYyjoDe2UcI
        dgW9euKuMzq4qiYqRIM0Q+tLjpAJ0nbuJOiZHN8/4WV/GZu4n9ueP+vJYp3cnkhE
        XTZMt7cD5/ZCVsBQ8i2kALJkarY+NrjJjwICs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TNfS8rpUQQfWTYq2E2KqIX0uEWPSsSUY
        QpaeMTkA+JHaRw5mXOKNbe4uLIToPtR5HDCA7D2Mon2WBKBzPTMEpFMp8bhtLy/5
        XdsuDzIwel767OHn3vnshmmxgwrpQWBk1P1e7mapOvkmjkgzz41zzX9xvn0bq2ip
        bPqXIWv9Pvk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 73A4AAA462;
        Thu, 30 Jan 2020 13:57:33 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7A909AA461;
        Thu, 30 Jan 2020 13:57:29 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] fetch: forgo full connectivity check if --filter
References: <cover.1578802317.git.jonathantanmy@google.com>
        <be1d6aa4c4fd8868f3682b73c01a92d3830534ad.1578802317.git.jonathantanmy@google.com>
        <20200129204326.GB17350@google.com>
Date:   Thu, 30 Jan 2020 10:57:27 -0800
In-Reply-To: <20200129204326.GB17350@google.com> (Jonathan Nieder's message of
        "Wed, 29 Jan 2020 12:43:26 -0800")
Message-ID: <xmqqimksdb6w.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5D248424-4392-11EA-9207-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Jonathan Tan wrote:
>
>> If a filter is specified, we do not need a full connectivity check on
>> the contents of the packfile we just fetched; we only need to check that
>> the objects referenced are promisor objects.
>>
>> This significantly speeds up fetches into repositories that have many
>> promisor objects, because during the connectivity check, all promisor
>> objects are enumerated (to mark them UNINTERESTING), and that takes a
>> significant amount of time.
>>
>> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
>> ---
>> For example, a local fetch was sped up from 6.63s to 3.39s. The bulk of
>> the remaining time is spent in yet another connectivity check
>> (fetch_refs -> check_exist_and_connected) prior to the fetch - that will
>> hopefully be done in a subsequent patch.
>
> Can this information (at least the speedup) be included in the comment
> message?
>
> Or even better, can we demonstrate the impact using a perf test?

It does make sense, but let's queue these two first and then add it
as a follow-up patch on top.

Thanks for writing and reviewing.
