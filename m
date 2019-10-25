Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 454571F4C0
	for <e@80x24.org>; Fri, 25 Oct 2019 02:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390200AbfJYCiH (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 22:38:07 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56143 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728416AbfJYCiH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 22:38:07 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 377A196F49;
        Thu, 24 Oct 2019 22:38:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=T3tbqc5k0JvrDRfGQ/OX0evgbEw=; b=c+R8WF
        Y+Yf0/Dh6OwSTuMp0XTOmhN5AeJfdzzamN3UuYDZoydYGt1fIZ6lfQIzW9R16qiu
        ZR4XTFVlnTCxz/31dpVIrJ+UmLS7ZNLvRmiPDYbTPLc8zEMdLAMrXfZt34FCYSJN
        Xne4TsQ2FMSpisDmOJhbiyfzkXVcxtvS7TMrE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=a5JKlVE7WVXwlXQ6xi1Bf3ltbvDQOIuf
        qr9OyptvS/ooeXRcWhkQZ4NCF/1x0/3j8m5e45y1YKCo85sGUA1JicGNYsGKwq0G
        mo4OMQtgxLX4efPdHYY0Ju+9GeZiyfmyZZ5TLQuaG8o2lnfQzWs6TmVCZVDnfuuK
        qettuMVVQVM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3107796F47;
        Thu, 24 Oct 2019 22:38:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 61C8B96F45;
        Thu, 24 Oct 2019 22:38:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, emilyshaffer@google.com
Subject: Re: [PATCH v3] fetch: delay fetch_if_missing=0 until after config
References: <xmqqo8y6g3yu.fsf@gitster-ct.c.googlers.com>
        <20191024191804.57275-1-jonathantanmy@google.com>
Date:   Fri, 25 Oct 2019 11:38:00 +0900
In-Reply-To: <20191024191804.57275-1-jonathantanmy@google.com> (Jonathan Tan's
        message of "Thu, 24 Oct 2019 12:18:04 -0700")
Message-ID: <xmqqv9sdeeif.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 77266496-F6D0-11E9-83CD-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> To me, this is moving a band-aid, not adding another one. But to the

Fair enough.

> Sifting calls into two categories might work, but it's error-prone in
> that we would have to do the same line-by-line analysis we did when we
> added the repository argument to many functions, and we would have to
> modify functions like parse_commit() to take a flag similar to
> OBJECT_INFO_SKIP_FETCH_OBJECT. Also, we would have to do the same
> careful inspection for future patches.

Absolutely.  That is the price to pay for the lazy-fetch feature.

> Instead, we can control whether a region of code lazy-fetches...

The approach "from here to there, we can set global to forbid
lazy-fetch" may prolong the life support of the quick-and-dirty
mechanism, but it has to assume you can say "from here to there"; it
would mean that we cannot go multi-threaded until we get off of it.

That is why I said it may be time for us to wean us off of the
quick-and-dirty hack that helped us bootstrapping the initial
implementation of lazy clone.
