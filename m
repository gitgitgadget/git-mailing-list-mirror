Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1187C48BD1
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 03:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF4DA60D07
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 03:36:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbhFKDiN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 23:38:13 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58212 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbhFKDiM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 23:38:12 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8B005133612;
        Thu, 10 Jun 2021 23:36:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wOBjT+JwVwZWpSWCFwA0L9ODzLjHp/JEzUSGHn
        rV1mI=; b=Fp7DFohqb+rAZaLjYIbWIp+gb2/Uq1EzFZcqyjqaZlkNCz0QSLVUFL
        vjQvnF5j8HXaWvkBq6cYi5nGS4H89z+jZiRjI7Ptzf0pdc+c8tHfaNdoYmjBlne7
        p8z6YLoJQsLqLPgDqFkM5jrYjD9d1shnlAiU/R7rS1Jy0DUenzm0Y=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 84EDB133611;
        Thu, 10 Jun 2021 23:36:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C856B133610;
        Thu, 10 Jun 2021 23:36:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] ll_binary_merge(): handle XDL_MERGE_FAVOR_UNION
References: <YMIKwsEFnkqz6PWa@coredump.intra.peff.net>
        <YMIMIdnDB1Jq+lzp@coredump.intra.peff.net>
Date:   Fri, 11 Jun 2021 12:36:10 +0900
In-Reply-To: <YMIMIdnDB1Jq+lzp@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 10 Jun 2021 08:57:05 -0400")
Message-ID: <xmqq4ke55az9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2ACADA12-CA66-11EB-91B4-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Prior to commit a944af1d86 (merge: teach -Xours/-Xtheirs to binary
> ll-merge driver, 2012-09-08), we always reported a conflict from
> ll_binary_merge() by returning "1" (in the xdl_merge and ll_merge code,
> this value is the number of conflict hunks). After that commit, we
> report zero conflicts if the "variant" flag is set, under the assumption
> that it is one of XDL_MERGE_FAVOR_OURS or XDL_MERGE_FAVOR_THEIRS.
>
> But this gets confused by XDL_MERGE_FAVOR_UNION. We do not know how to
> do a binary union merge, but erroneously report no conflicts anyway (and
> just blindly use the "ours" content as the result).
>
> Let's tighten our check to just the cases that a944af1d86 meant to
> cover. This fixes the union case (which existed already back when that
> commit was made), as well as future-proofing us against any other
> variants that get added later.

Makes sense.

> Note that you can't trigger this from "git merge-file --union", as that
> bails on binary files before even calling into the ll-merge machinery.
> The test here uses the "union" merge attribute, which does erroneously
> report a successful merge.

Nice discovery.

Thanks.
