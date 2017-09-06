Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38B631F4DD
	for <e@80x24.org>; Wed,  6 Sep 2017 19:51:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752718AbdIFTvR (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Sep 2017 15:51:17 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61008 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752306AbdIFTvP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2017 15:51:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CFC89A2FAC;
        Wed,  6 Sep 2017 15:51:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=uWHyJ+9DLVN25LtPdQSumQWDPgQ=; b=vCupMfzBnUfHlppAxsVK
        GUs0bXvGWiK2x3Dkh59dMxduzmrC1XoW7Ka29gXfRQRDSR6YF0G7KeS4H4HFKfGN
        Ri46LDqzBgjR8vOT4ylxxsIpfT+EwiTyOoxVAQ4O5/Isn9g0fUv5Bw+FzL5Dl6+W
        feixPbore+Yq5ILawSjQ3sw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=YijwDyrrz2CEURAeQWmPlymQokoztZ89dY2DBAv1t+Kbap
        vd3WiAyj4LAjdkg04R3ipywIoiw0/LQS8gHUpA67V3ZA0PywmWQZFGgLjtG9d/xb
        OuPi1+zcBJeF8c7cEslXRYYO/fl3/mB4/JTYmGP57d6csDaLxI16Nuku9/41M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C73D2A2FAB;
        Wed,  6 Sep 2017 15:51:14 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0818DA2FAA;
        Wed,  6 Sep 2017 15:51:13 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rene Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 27/34] shortlog: release strbuf after use in insert_one_record()
References: <20170830175005.20756-1-l.s.r@web.de>
        <20170830180037.20950-1-l.s.r@web.de>
        <20170830180037.20950-8-l.s.r@web.de>
Date:   Thu, 07 Sep 2017 04:51:12 +0900
Message-ID: <xmqqtw0f61xr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BD406E4E-933C-11E7-901A-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rene Scharfe <l.s.r@web.de> writes:

> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
>  builtin/shortlog.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/builtin/shortlog.c b/builtin/shortlog.c
> index 43c4799ea9..48af16c681 100644
> --- a/builtin/shortlog.c
> +++ b/builtin/shortlog.c
> @@ -50,66 +50,67 @@ static int compare_by_list(const void *a1, const void *a2)
>  static void insert_one_record(struct shortlog *log,
>  			      const char *author,
>  			      const char *oneline)
>  {
> ...
>  	item = string_list_insert(&log->list, namemailbuf.buf);
> +	strbuf_release(&namemailbuf);

As log->list.strdup_strings is set to true in shortlog_init(),
namemailbuf.buf will leak without this.

An alterative, as this is the only place we add to log->list, could
be to make log->list take ownership of the string by not adding a
_release() here but instead _detach(), I guess.

It is also curious that at the end of shortlog_output(), we set the
log->list.strdup_strings again to true immediately before calling
string_list_clear() on it.  I suspect that is unnecessary?

