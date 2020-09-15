Return-Path: <SRS0=NngS=CY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7130FC43461
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 22:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F3C120809
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 22:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CWE/iOC2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbgIOWG4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Sep 2020 18:06:56 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64866 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727537AbgIOUYk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Sep 2020 16:24:40 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0CDECDC236;
        Tue, 15 Sep 2020 16:24:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=G45JFVTHYfkNarKl5xgs3itmFz8=; b=CWE/iO
        C2EYBWA6Pc3ccy5DQDGxIaJA+DaXn8kH6GTVAf4XYqM/pCjJ4uipnUmWMPl+24l1
        yxaDOn7KypP8awBtIQLshL090cFa4NpPdQEPikUp9aaz8VxQXoTj3H0t3ENo9ZJE
        e8ey6k3kqFP/WCnMxVkUrkahVOUOgcTBGCzOQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=r7angPpim90EHn0qgpfYyFHmHCpoWj/r
        hl1G+CJln2jc3eOJ5gMuDq2MJeH1WZPCaxUxZOo1XjeSMACt08nrqyj7ZrklPwgf
        0zU0TYM316voAF2Jhq5Vnnu5fr1Y/7cADGTRnWtoTvp+TyoMg8qOJR/O4GT9jotm
        DOwFOvnAzNQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 060ADDC235;
        Tue, 15 Sep 2020 16:24:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 39D31DC230;
        Tue, 15 Sep 2020 16:24:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Subject: Re: git format-patch with useAutoBase = true
References: <CA+P7+xpjSxEmB0qpWkhkd=yeA9xF-ssVdW1J5NyJdkqfza=GPg@mail.gmail.com>
Date:   Tue, 15 Sep 2020 13:24:22 -0700
In-Reply-To: <CA+P7+xpjSxEmB0qpWkhkd=yeA9xF-ssVdW1J5NyJdkqfza=GPg@mail.gmail.com>
        (Jacob Keller's message of "Mon, 14 Sep 2020 17:13:29 -0700")
Message-ID: <xmqqzh5qzt3d.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 71F66C10-F791-11EA-B2C0-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

> $  git format-patch -1 f7529b4ba3c98470b0e367ba447ad0da84dc308
> fatal: base commit shouldn't be in revision list
> ...
> The failure occurs because the "automatic" base is newer than the
> requested commit. I am wondering if it would make sense to relax this
> restriction and make the format-patch automatically disable
> useAutoBase if it would conflict like this?

I agree that it does make a horrible end-user experience to die with
the message like the above, trying to use a nonsense autobase.
