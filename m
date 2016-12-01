Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 900A61FBB0
	for <e@80x24.org>; Thu,  1 Dec 2016 20:22:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934263AbcLAUWl (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 15:22:41 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56283 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932845AbcLAUWk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 15:22:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 679925448C;
        Thu,  1 Dec 2016 15:22:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=z4poiWG38byzSOM+rca/6iDyTF4=; b=w1yvvQ
        ubECbFRAULWi2yLlzSUXGGoo21J+gSALGIaBne0KP7q6P08qgwhT9VLtBL4J2ubL
        rux1ULHPjh+EEAc5wZs7noYdenQDw0AQkGhEmK1S6VnD2zh2YtOuGLXvwT0wD0Qu
        XB/2Inkd4fu6w7D23bgc76avDlpzD8YYfMW9s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sA/CNbSVhqrzhPD95jNcssectYqh4kue
        CakZIRt4E/lpGdqSZ9GcNyQoYysbsgSCzSWkzRXYwfj3AUvo+nuOlJDxLA+PSI02
        ZdFNvR33zDiWUQlR70CZwVS8qJQ7VCqqM1q9upTHaLKuASqv4iEl2qJZgQdBjRfE
        gSYRly5DhYs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5F1395448B;
        Thu,  1 Dec 2016 15:22:39 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C2C4054489;
        Thu,  1 Dec 2016 15:22:38 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/3] compat: add qsort_s()
References: <3083fbf7-d67e-77e4-e05f-94a7e7e15eba@web.de>
        <fc602a66-a06c-203e-b50b-55fd7b258b54@web.de>
        <20161201193556.j2odwy3sepaxxq5a@sigill.intra.peff.net>
        <xmqq7f7j9zkd.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 01 Dec 2016 12:22:37 -0800
In-Reply-To: <xmqq7f7j9zkd.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 01 Dec 2016 12:14:42 -0800")
Message-ID: <xmqqy3zz8kmq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E767E342-B803-11E6-91A7-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Eh, wait.  BSD and Microsoft have paramters reordered in the
> callback comparison function.  I suspect that would not fly very
> well.

Hmm.  We could do it like this, which may not be too bad.

#if APPLE_QSORT_R
struct apple_qsort_adapter {
	int (*user_cmp)(const void *, const void *, void *);
	void *user_ctx;
}

static int apple_qsort_adapter_cmp(void *ctx, const void *a, const void *b)
{
	struct apple_qsort_adapter *wrapper_ctx = ctx;
	return wrapper_ctx->user_cmp(a, b, wrapper_ctx->user_ctx);
}
#endif

int git_qsort_s(void *b, size_t n, size_t s,
      	   int (*cmp)(const void *, const void *, void *), void *ctx)
{
	if (!n)
		return 0;
	if (!b || !cmp)
		return -1;
#if GNU_QSORT_R
	qsort_r(b, n, s, cmp, ctx);
#elif APPLE_QSORT_R
	{
		struct appple_qsort_adapter a = { cmp, ctx };
		qsort_r(b, n, s, &a, appple_qsort_adapter_cmp);
	}
#endif
      return 0;
}
