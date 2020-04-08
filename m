Return-Path: <SRS0=ek70=5Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4731C2D0EC
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 00:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AB25206F7
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 00:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BdvReOjA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgDHA0P (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 20:26:15 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56694 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgDHA0P (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 20:26:15 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4536ACAD39;
        Tue,  7 Apr 2020 20:26:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=S+dU51b7wPDGbtD957v2z/0T8kk=; b=BdvReO
        jAdsBighPy+ZxZPEpePzAvbKWSAv9YeK/t1p5N1PY6vFzTJMXAznjCu8hi2lq3Vg
        G4yBWNoJeSD45eYnSw/f6OT9ZOqQ8PJHxdsgfOu4f9ZEda4EMKJ6GN0pz3tgyYMh
        zS+IS+ZVrOIcoa2niqaoViEeMb6n49ZFbbfF0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=q308hHV0c+bO8jyAVMNn/cIQXdbxnj4H
        cx+CKiCo3WJOsCRdnnBT+0iTbBBoOmjglsQN6H/687Adsrh4Zk97dj6CvslFpm4Q
        1BlJYGz5Cgevwsb9JLmePHgI0k4fzTRuGEEDIr8xf02k+dstV7X8yLAubTGwNhxv
        dYvRGu7NUFo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3CF20CAD38;
        Tue,  7 Apr 2020 20:26:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 899BDCAD37;
        Tue,  7 Apr 2020 20:26:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v5 08/22] rebase: use read_oneliner()
References: <cover.1585962672.git.liu.denton@gmail.com>
        <cover.1586269542.git.liu.denton@gmail.com>
        <0cc279fc14dd27ed2606064d236115aa72551dce.1586269543.git.liu.denton@gmail.com>
Date:   Tue, 07 Apr 2020 17:26:08 -0700
In-Reply-To: <0cc279fc14dd27ed2606064d236115aa72551dce.1586269543.git.liu.denton@gmail.com>
        (Denton Liu's message of "Tue, 7 Apr 2020 10:27:55 -0400")
Message-ID: <xmqq8sj6rffj.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8BE6A80A-792F-11EA-81A3-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Since in sequencer.c, read_one() basically duplicates the functionality
> of read_oneliner(), reduce code duplication by replacing read_one() with
> read_oneliner().
>
> This was done with the following Coccinelle script
>
> 	@@
> 	expression a, b;
> 	@@
> 	- read_one(a, b)
> 	+ !read_oneliner(b, a, READ_ONELINER_WARN_NON_EXISTENCE)

WARN_MISSING, you mean?

> -/* Read one file, then strip line endings */
> -static int read_one(const char *path, struct strbuf *buf)
> -{
> -	if (strbuf_read_file(buf, path, 0) < 0)
> -		return error_errno(_("could not read '%s'"), path);
> -	strbuf_trim_trailing_newline(buf);
> -	return 0;
> -}
> -

OK.  Both functions trim the end-of-line marker from the end of the
string, so this is truly a no-op that reduces the code.  Good.
