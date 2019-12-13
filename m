Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC9DC34377
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83B1924722
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YgJrXXQ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbfLMS7C (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 13:59:02 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57442 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728557AbfLMS7A (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 13:59:00 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 10D1318BEC;
        Fri, 13 Dec 2019 13:58:58 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=Ppl7aJrAenHta3CBpei8o8rS7Ug=; b=YgJrXX
        Q57qgqnBD2lspEdxenJR24qsuS/CXcSLkGgol5tsZeTm2T4s7xlEedkNyqxU82La
        nnk1yFVA2rruS9NTbqRF8jkHEuDw7pD/BSa14GEmC/Wru38w2Jnub7nnhSzs5Yuk
        8Sfg6KlrrB75X9pYpKsLSWYOTSjbuzgCnj6qE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KpjjtkVVOkZCyc1RL7mNo2qaIcCva+o9
        WYcmhpmU/hQeoCdypECPeR4vJN92kJxJunYTFzWeyANldFYli9SkYoZY7XZdsD1g
        oIEiXGamGrtV5uFk8MzdVKM/zN5RMzUP3/F7iZbbl7WqyqkqTSaLKiUXOzQC+HAv
        tmLqmIKGIEo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0898F18BEB;
        Fri, 13 Dec 2019 13:58:58 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6C80418BE9;
        Fri, 13 Dec 2019 13:58:57 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>
Cc:     git@vger.kernel.org
Subject: Re: [BUG] Git bisect extends bisecting range on repeated good/bad data
In-Reply-To: <473FE927-FC11-46A0-8ABB-7A1FDC8C1A6C@linaro.org> (Maxim
        Kuvyrkov's message of "Fri, 13 Dec 2019 19:38:05 +0300")
References: <473FE927-FC11-46A0-8ABB-7A1FDC8C1A6C@linaro.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date:   Fri, 13 Dec 2019 10:58:56 -0800
Message-ID: <xmqq5zikkq6n.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9DBBC62E-1DDA-11EA-B6A3-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org> writes:

> Git bisect may /extend/ bisection range on repeated good/bad data.  Is this expected?

It is not "repeated" that is an issue, but yes this is expected.

The bisection works by finding a mid point to cut the graph into two
pieces of roughly the same size, and the graph is defined by the
set of good commits on the bottom (i.e. "we were told that all these
good commits were good, so there is no point going back the history
beyond any of them") and the single "bad" commit you gave the last.

If you give 'bad' that is in the newer part of the history than the
one that is already known to be bad, then you rewind that single
"bad" commit, to force/allow the machinery to recompute the midpoint
[*1*], and because the area to search would be wider when you do so,
it is very much expected that you'd be offered to test more commits.



[Footnote]

*1* I said force/allow is because allowing the machinery to go back
    and recompute is a way to recover when you gave a "bad" earlier
    by mistake.

