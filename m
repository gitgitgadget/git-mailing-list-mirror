Return-Path: <SRS0=eTRQ=EM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 130FEC2D0A3
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 19:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8984F2151B
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 19:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="n099d+EL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbgKFTSU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Nov 2020 14:18:20 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58428 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728167AbgKFTSU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Nov 2020 14:18:20 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8FE83EA4F3;
        Fri,  6 Nov 2020 14:18:18 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=C9m5l1jaKq0Iob95OI9FhAKZ6/I=; b=n099d+
        ELDiDmunGCyHOEFq+hEIzPXF8NahH0ix8Hp5u6FNUI4UAZdntxIIN2X3GXZcDOJI
        DEs97ohIzraPt+gX2I4XBpcgytIjfZbhu1ZF6JHcTlRYzZXuwgNePDGh7bB36HoQ
        iJRZzMI/BpzMqvCgN+BfaT9Sa98+HHyFNxXV4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ClpO3f9I6PeSzfoebKsUAh10Bade+oHq
        f0mY1fL617UgH2Un6guIfab1qyVfXZ/m88S/Gt4JMjEup/1AFTu7PHB1ZoLqoGKw
        wb++3gsxvU7La7ob16nzpNjjy24X24Y+02SPACMUclp6p42bfiPwNKJlfchK/X9R
        8BUocy3nZNo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8883FEA4F2;
        Fri,  6 Nov 2020 14:18:18 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D2421EA4F1;
        Fri,  6 Nov 2020 14:18:15 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jinoh Kang <luke1337@theori.io>
Cc:     Junio C Hamano <junio@pobox.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] diff: handle NULL filespecs in run_external_diff
References: <aeb24944-17af-cf53-93f4-e727f9fe9988@theori.io>
        <xmqq4km4lppy.fsf@gitster.c.googlers.com>
        <a0513d6f-1f69-683d-d6c5-75b17b8b6890@theori.io>
Date:   Fri, 06 Nov 2020 11:18:13 -0800
In-Reply-To: <a0513d6f-1f69-683d-d6c5-75b17b8b6890@theori.io> (Jinoh Kang's
        message of "Fri, 6 Nov 2020 17:02:19 +0000")
Message-ID: <xmqqimaifg5m.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D21B3AAC-2064-11EB-92FD-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jinoh Kang <luke1337@theori.io> writes:

> However, I humbly opine that the free() semantics do not apply to
> `diff_free_filespec_data`; rather, I prefer to see it as a function
> that simply transitions a diff_filespec from one state to another.

The reason why you prefer is unclear, but let's suppress puzzlement
and read on.

> I would put the blame on its name, since "data" feels too generic
> and makes the function sound like freeing the filespec _itself_.
> diff_filespec carries a lot of other things besides just `data`
> and `cnt_data`.

It frees resources held by its content data without freeing the
shell.  "struct diff_filespec" has a handful of pointer fields,
but data and cnt_data are the only allocated fields, no?

> I was unable to find any callsites that explicitly check for
> NULL-ness _immediately_ before calling diff_free_filespec_data.

OK, so a change to make diff_free_filespec_data() more cautious does
*not* help existing code; it changes the (so far) wrong assumption
made by 3aef54e8 (diff: munmap() file contents before running
external diff, 2019-07-11) that calling it with NULL was a safe
thing to do---after such a change, the assumption two calls added by
the commit makes become valid.

I dunno.  I am OK with either direction, but it feels to me that
making the helper more cautious would help us avoid similar
mistakes in the future.  Dscho, what do you think?

Thanks.
