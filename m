Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050DBC433E0
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 21:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B94AA221F5
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 21:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lcGtU99Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbgFSVtx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 17:49:53 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64495 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728105AbgFSVtv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jun 2020 17:49:51 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9AF087313B;
        Fri, 19 Jun 2020 17:49:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9EVixYHuN/cJZhFaB/TvGEAQUro=; b=lcGtU9
        9QS53Y65uE2yhYv9HWCNTyGoIQTz2h4zDek6kqFlsV+CS6uoMyoA4Thy1X5rcH4T
        mk+PybZRC457IspqXFTlXt9Y5iaNNxFsl/ivFZwT6wfP8cR3mtMlHFh0pRzHD+KM
        TD0iNRe1p1WbWQPRGF7JbXCl3hwXT7LCDKvAg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ID+rSPO1MaIJb3bJeZ8pm0Vtk+BFPQMF
        N6wakxxHfEl/SXKpMyUA5Dy3UMCpo+mVpTKRAskUM6NQzikVHGyT4u1V4f5FaXvW
        lAvIi2dhRhiW94rKEZuIcRjhQ0v6Fc/8EWWF+tL5T0vnkmAXwYjGdoLdxMDLEkqk
        Q24sCqbBICI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 92E207313A;
        Fri, 19 Jun 2020 17:49:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1712173139;
        Fri, 19 Jun 2020 17:49:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Mike Hommey <mh@glandium.org>
Cc:     Sergey Organov <sorganov@gmail.com>, git@vger.kernel.org
Subject: Re: Annoyance wrt ref@{1} and reflog expiry
References: <xmqqzh8zgcfp.fsf@gitster.c.googlers.com>
        <87o8pe3ou6.fsf@osv.gnss.ru> <xmqqwo42g5ld.fsf@gitster.c.googlers.com>
        <20200619203639.i5jto4i52ptsihrs@glandium.org>
Date:   Fri, 19 Jun 2020 14:49:48 -0700
In-Reply-To: <20200619203639.i5jto4i52ptsihrs@glandium.org> (Mike Hommey's
        message of "Sat, 20 Jun 2020 05:36:39 +0900")
Message-ID: <xmqqblleg1z7.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CC43E1D0-B276-11EA-A0C2-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mike Hommey <mh@glandium.org> writes:

>> Or we could change the lookup side to use the value of the ref
>> itself when asked for @{0}, and use the "old" side of the only entry
>> when asked for @{1}.  That way, we do not need to play games with an
>> artificial entry at all, which may be a better solution.
>
> Or more generally, use the old side from @{n} when asked for @{n+1} when
> there are only n entries in the reflog.

Yup, I agree that it is the natural consequence.
