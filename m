Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA18C2BA19
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 20:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBD6120787
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 20:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ud+qX7qo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438092AbgDOUg1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 16:36:27 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62486 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438090AbgDOUgX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Apr 2020 16:36:23 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CB3FC4BBDC;
        Wed, 15 Apr 2020 16:36:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=94UPLuGhRYQU83osyoh4UOzLDec=; b=ud+qX7
        qoanqkoxQFRG9g6rcYDBFyzGItCJzOUWf2x012WiGXVh+tmh7iw1gpvQEokY2u5k
        Oebuh7iIecXEKASp+yPZ5VXbqflm9r0iU5uwoVzBK7YYi5WyNy54rvp/e62QRNE0
        6K4XFLSpIsdzhJ6J/2X3+IVXgjhRLIuKi3uPg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JFxvLNSt8IEMxRqDKY7sxZxqEj/4NET5
        OqAeMwnEF8q1R9E1qmxU08Ehns1oEL3H+WwGeZsoju3mYaw80ttMMiS/9Ybwimse
        9tbYgRjQkkupmHM1dEOx6nJS9VmRt+Llq0CGHLJuAJSlWYd41usnWgjUckIm5Kzy
        V+TqXaeJkUc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C451A4BBDA;
        Wed, 15 Apr 2020 16:36:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5DE8A4BBD9;
        Wed, 15 Apr 2020 16:36:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v12 4/7] send-pack: extension for client-side status report
References: <xmqq3697cax0.fsf@gitster.c.googlers.com>
        <20200414123257.27449-5-worldhello.net@gmail.com>
Date:   Wed, 15 Apr 2020 13:36:19 -0700
In-Reply-To: <20200414123257.27449-5-worldhello.net@gmail.com> (Jiang Xin's
        message of "Tue, 14 Apr 2020 08:32:54 -0400")
Message-ID: <xmqqh7xk5vwc.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C39E68E4-7F58-11EA-B968-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> +		if (msg)
> +			hint->remote_status = xstrdup(msg);
> +		else if (extended_status)
> +			hint->remote_status = xstrdup(extended_status);

contrib/coccinelle/xstrdup_or_null.cocci suggests to rewrite the
above like so:

		if (msg)
			hint->remote_status = xstrdup(msg);
		else
			hint->remote_status = xstrdup_or_null(extended_status);

I'll queue a fix-up patch to keep 'pu' passing the test suite for now.
