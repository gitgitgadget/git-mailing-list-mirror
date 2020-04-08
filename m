Return-Path: <SRS0=ek70=5Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E60C2D0EC
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 00:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8C142054F
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 00:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Mfs/qVby"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgDHALx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 20:11:53 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58725 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgDHALx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 20:11:53 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 824384862F;
        Tue,  7 Apr 2020 20:11:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fDlUtbnLSJeQd35g9D6b221NzE4=; b=Mfs/qV
        byHKLS8E04hCEBHzIV7CspG6uTDkmBiLynVc0f/HgWrK+HV4GwQYyo1ENHHuu30X
        4RnN/8KwWJD8szfnZdACOskB1jnFIPDrudk4cXgBgLZnJ2th03T7Mdyq27byDIUJ
        OgZrdS2IOaNy5SJI8LQKBE/eYsZpYFCaKi9C8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Jrsv9JzqsS8DJf1wlgcn98yCWDxek/G2
        hwscaq3SEtin56xz5K0mS9PjACu72VeFA3ZGKfXFJRP1rCpTejXk+SQbFKRD1PIA
        kiqdDlck1lOW4tKrjVQTqNzjGxYfOuZrXRp3BihP2DvjYRgV6GuzPDjDpNYRfO9F
        TqKxOh2EFyA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7A2AD4862E;
        Tue,  7 Apr 2020 20:11:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F34334862D;
        Tue,  7 Apr 2020 20:11:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v5 05/22] sequencer: make read_oneliner() accept flags
References: <cover.1585962672.git.liu.denton@gmail.com>
        <cover.1586269542.git.liu.denton@gmail.com>
        <f30ad07823c6e8f47c217ac24a06e02d3e0af554.1586269543.git.liu.denton@gmail.com>
Date:   Tue, 07 Apr 2020 17:11:50 -0700
In-Reply-To: <f30ad07823c6e8f47c217ac24a06e02d3e0af554.1586269543.git.liu.denton@gmail.com>
        (Denton Liu's message of "Tue, 7 Apr 2020 10:27:52 -0400")
Message-ID: <xmqqd08irg3d.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8B8FD144-792D-11EA-B5B5-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> In a future commit, we will need read_oneliner() to accept flags other
> than just `skip_if_empty`. Instead of having an argument for each flag,
> teach read_oneliner() to accept the bitfield `flags` instead. For now,
> only recognize the `READ_ONELINER_SKIP_IF_EMPTY` flag. More flags will
> be added in a future commit.

Good move.  Looked sensible.

Thanks.
