Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18936C433E2
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 18:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACEF521941
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 18:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mwKp9Nh5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgIJSlS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Sep 2020 14:41:18 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59904 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbgIJSkq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Sep 2020 14:40:46 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 18AF86C9AE;
        Thu, 10 Sep 2020 14:40:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pftWS4T3G+JkKxKpSxMp0TjRJgc=; b=mwKp9N
        h5Bqj8vbVxe/Ob5XrxaRTAqh+Gh1oKmtdrzLbX8RXbqnmh80A7vD7JLzapGYXiRC
        JqxExSkosn48/Bt0DDgPgDXZoJbg/hPkCA3QvROnhGHk2pB6BrcnSHpaMcrQy61h
        T1CrWWiepit73zVdxuJD7KAvMpTbYKh6cUtlg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JOg/jmoynV0TO8yTXUXm/zw/zwFmhbGD
        lVr9PMOrxvIPSN2Ckr2sFnwkbFekfCnNQdKB7FnBKTQkKtzu8G1ynCtxZoHw7lnS
        4csZ0W8c1sqQhvuj2hG7hpCukJ1ShFapitBnAPYzYURAmR01J6HCfmNHP9sd49tc
        44R01yeKo/w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 105C56C9AD;
        Thu, 10 Sep 2020 14:40:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7A6C96C9AC;
        Thu, 10 Sep 2020 14:40:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 4/7] quote_path: code clarification
References: <20200908205224.4126551-1-gitster@pobox.com>
        <20200910170159.1278781-1-gitster@pobox.com>
        <20200910170159.1278781-5-gitster@pobox.com>
        <20200910180814.GA1917207@coredump.intra.peff.net>
Date:   Thu, 10 Sep 2020 11:40:42 -0700
In-Reply-To: <20200910180814.GA1917207@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 10 Sep 2020 14:08:14 -0400")
Message-ID: <xmqqblidpj9x.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 220D5B78-F395-11EA-9133-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Sep 10, 2020 at 10:01:56AM -0700, Junio C Hamano wrote:
>
>> Instead we can scan the path upfront to see if the input has SP in
>> it.  If so, we tell quote_c_style_counted() not to enclose its
>> output in a dq-pair, and we add a dq-pair ourselves.  Whether the
>> input had bytes that quote_c_style_counted() uses backslash quoting,
>> this would give us a desired quoted string.  If the input does not
>> have SP in it, we just let quote_c_style_counted() do its thing as
>> usual, which would enclose the result in a dq-pair only when needed.
>
> Nice. I think the result is easier to follow than the original, not to
> mention more efficient. And the fact that we didn't need to touch
> quote_c_style_counted() is the cherry on top.
>
>> +	int force_dq = ((flags & QUOTE_PATH_QUOTE_SP) && strchr(rel, ' '));
>> [...]
>> +	quote_c_style_counted(rel, strlen(rel), out, NULL, !!force_dq);
>
> I think force_dq is already normalized to 0/1 by the &&, so we wouldn't
> need the "!!" here.

True.  CQUOTE_NODQ patch would get rid of it in the end, though ;-)
