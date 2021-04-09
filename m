Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DEEAC433B4
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 22:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A20861165
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 22:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234997AbhDIWb7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 18:31:59 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59735 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234602AbhDIWb7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 18:31:59 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 77DA3121074;
        Fri,  9 Apr 2021 18:31:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QqB+wViKkzprFiEkdld2v2DK2AM=; b=G4EWhN
        nhowzheR/cqvIlAi7QdTX7k13WoC0Ypwe6LorTFshSVnor0SgFztQJw+xwTSvyCW
        YfVKVCXwrXLJmSR7ZqZrpS9I1QI8JBS1XvZKzLIWuYWG1jmyMhWDZ1aezLB2t2Yb
        Wu2+oIv9OkYMk3EXMbUFo6jrhcrkgth/6/UoE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ePsbzbCnZlegPT3adQoxXVmiqexxivBv
        VNdaa7E0hlndM29XzpqEELYkUisO3pv8K5crze1gUjuwHYCwu5mg9ugSKdV4dWcH
        DE3MlbdPehL0j/hSuX9Ei2Z0VzhM9tVE+FrsRkZ1tYek/AlKaOUlLupUD6VCf4oL
        WJduvZB/jQU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7130D121073;
        Fri,  9 Apr 2021 18:31:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B7F18121072;
        Fri,  9 Apr 2021 18:31:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/2] blob.c: remove buffer & size arguments to
 parse_blob_buffer()
References: <cover-00.11-00000000000-20210328T021238Z-avarab@gmail.com>
        <cover-0.3-0000000000-20210409T080534Z-avarab@gmail.com>
        <patch-1.3-68a7709fe5-20210409T080534Z-avarab@gmail.com>
        <YHCUFwZMitOXELpq@coredump.intra.peff.net>
Date:   Fri, 09 Apr 2021 15:31:41 -0700
In-Reply-To: <YHCUFwZMitOXELpq@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 9 Apr 2021 13:51:19 -0400")
Message-ID: <xmqqeefjm6nm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5BF807AE-9983-11EB-842C-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> OK. Calling it parse_blob_buffer() is a little silly since it doesn't
> even take a buffer anymore. But I guess parse_blob() might imply that it
> actually loads the contents from disk to check them (which the other
> parse_foo() functions do), so that's not a good name.

mark_object_as_parsed(), perhaps?

> So this might be the least bad thing. Given that there are only two
> callers, just setting blob->object.parsed might not be unreasonable,
> either. But I don't think it's worth spending too much time on.

Yup.
