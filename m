Return-Path: <SRS0=LMRs=AT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D63C433DF
	for <git@archiver.kernel.org>; Wed,  8 Jul 2020 21:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2ABB02078B
	for <git@archiver.kernel.org>; Wed,  8 Jul 2020 21:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ebXPPprS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgGHVi7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jul 2020 17:38:59 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55576 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgGHVi7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jul 2020 17:38:59 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9667CDEFD4;
        Wed,  8 Jul 2020 17:38:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=czhYr6j3OJyGwOIQHxwmD+S+oro=; b=ebXPPp
        rSsYKFoLzZe3TQ7V5skcE7wWOk39ftgku4Bv0sGu2xuyHp56w/M+gr75GBqlmmL5
        +mI/OrXeA2t40k0zL/Aeva/Jvf8hXKRTUlnxjZmfmrsOPrtT3Zz4Kj2CFkNqjIhE
        G+BgL8ERVJfjWbBjVTuLQt0F/C06xfoK6x7h0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rzXr9RF91/haEOkiLbmLq/MVlzeFEdy5
        Q4cWIu6XSvam+rV6aEziSoIrCcEK4qH469B8lxdFGMxPEO2ibpZxyJO0bw8xm0qD
        Jc5qNw3S2QYoRaHEpMUvcfPaN1/sOX3q6/toUOdPkn3V51t9DaX4NEVJ4Tm95lqG
        vXJsrIoYhzs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8ECE7DEFD3;
        Wed,  8 Jul 2020 17:38:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D9518DEFD1;
        Wed,  8 Jul 2020 17:38:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Miriam Rubio <mirucam@gmail.com>
Cc:     git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>
Subject: Re: [PATCH v4 10/13] bisect--helper: reimplement `bisect_state` & `bisect_head` shell functions in C
References: <20200701133504.18360-1-mirucam@gmail.com>
        <20200701133504.18360-11-mirucam@gmail.com>
Date:   Wed, 08 Jul 2020 14:38:53 -0700
In-Reply-To: <20200701133504.18360-11-mirucam@gmail.com> (Miriam Rubio's
        message of "Wed, 1 Jul 2020 15:35:01 +0200")
Message-ID: <xmqq7dvd1yc2.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6C2DA5AA-C163-11EA-98F5-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Miriam Rubio <mirucam@gmail.com> writes:

> @@ -856,6 +858,81 @@ static int bisect_autostart(struct bisect_terms *terms)
>  
>  		return res;
>  }
> + int mark_for_removal(const char *refname, const struct object_id *oid,
> +			    int flag, void *cb_data)
> +{
> +	struct string_list *refs = cb_data;
> +	char *ref = xstrfmt("refs/bisect%s", refname);
> +	string_list_append(refs, ref);
> +	return 0;
> +}

Funny indentation at the beginning, and worse yet, triggers an error
with -Werror=missing-prototypes.

What is the relationship between this one and the similarly-named on
in bisect.c?



