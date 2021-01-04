Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5362C433DB
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 23:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 919532255F
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 23:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbhADXmL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jan 2021 18:42:11 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53136 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbhADXmL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jan 2021 18:42:11 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8774A10149B;
        Mon,  4 Jan 2021 18:41:29 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=A5V/4KTTvv86hzxNspHQddH0lFI=; b=mYzTW1
        oN/VXtjm4MHQPUpxGwJQlWF81SZ6ld56B/ioIfXH38Gq0J/+c+AKysh7On1TJl4h
        tH1JN230afLXNdvJKzVu5/LQzsIolEcDU7/camFNF6NPdEWyjQg6qVtrJw2Dv8OW
        9F7tnahcNCk69Tgz5Le00SslcbZCR52K/ber4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MscgurjrLXfAC8iCm3LlXoJ6H812ZWVT
        VMKcLhzz8k3JdyG5RfUrjupipdO60y+xTLN+elRD1lYHnFJguZIca6vm8JEetAtB
        DOxTB73dw+kyzvrJuaVWMDFBKfYpRuU73tJuNL00IN2woNyBuTcFswTFYBOvBy3R
        tq5w3aOLab4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8046F101499;
        Mon,  4 Jan 2021 18:41:29 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C926D101498;
        Mon,  4 Jan 2021 18:41:26 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH] bundle: arguments can be read from stdin
References: <20210103095457.6894-1-worldhello.net@gmail.com>
Date:   Mon, 04 Jan 2021 15:41:24 -0800
In-Reply-To: <20210103095457.6894-1-worldhello.net@gmail.com> (Jiang Xin's
        message of "Sun, 3 Jan 2021 04:54:57 -0500")
Message-ID: <xmqqft3g6ziz.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5CA08362-4EE6-11EB-BBA6-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> Therefore, before calling `prepare_revision_walk()` function, make a
> copy on `revs.pending` for later use.

The in-core objects pointed by the list elements are shared between
the original and the copy, and the object flag bits that are used to
control the traversal (like SEEN, SHOWN and BOUNDARY bits) would be
smudged during the traversal.  So depending on how the "later use"
uses the copied list, it may or may not be sufficient to just copy
the list.

Apparently, you've tested the updated code well enough to send to
the list, so it must be sufficient to make a copy of the list to
support the way the updated code uses it, but it is not clear how it
is so, only from what is in the proposed log message.

