Return-Path: <SRS0=m/64=4N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8290AC35E01
	for <git@archiver.kernel.org>; Tue, 25 Feb 2020 19:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BC5220CC7
	for <git@archiver.kernel.org>; Tue, 25 Feb 2020 19:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PXryWBi+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731408AbgBYTZy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Feb 2020 14:25:54 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60219 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728367AbgBYTZy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Feb 2020 14:25:54 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 18327A1FCE;
        Tue, 25 Feb 2020 14:25:52 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+4ybHxU537AzhJAFsWSLM9s9KRk=; b=PXryWB
        i+2EbUJPlXKKEidcBQoDyk8j0TySNsQb/eE5pfPUli8qpTsrqYj3MOid8HQ2gJVs
        YxM3DLEsKmDvgQCrp6QZvfjfeshn2PWG918CjgyxAS50VnhiW7NprOrWqHcARXCK
        KUb55mGCLiza6Pw9vz8NtsjP43NTCCvEGOk28=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lYn2zl4eXxiRK3jNBxKRUCVgkKmEIEAd
        xf1Kuf/SPKs7iDIbjTmvIMGPdbiKdaeuG4iYurglDcV8/mp9jTxflwxf/8HEVIQq
        jZCO4JLPgwWx7/9qQfbaHuD7fCyaSoI5MvFEIw+mS6l0KZClZnQ7JZvtePVD2u9y
        3aB89Zgg31g=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1077CA1FCD;
        Tue, 25 Feb 2020 14:25:52 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 41D33A1FCC;
        Tue, 25 Feb 2020 14:25:49 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 18/24] gpg-interface: improve interface for parsing tags
References: <20200222201749.937983-1-sandals@crustytoothpaste.net>
        <20200222201749.937983-19-sandals@crustytoothpaste.net>
        <nycvar.QRO.7.76.6.2002251127320.46@tvgsbejvaqbjf.bet>
Date:   Tue, 25 Feb 2020 11:25:46 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2002251127320.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 25 Feb 2020 11:29:26 +0100 (CET)")
Message-ID: <xmqqh7zemptx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A105A11A-5804-11EA-A4DD-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>>  	/* parse signature first; we might not even have a subject line */
>> -	*sig = buf + parse_signature(buf, strlen(buf));
>> -	*siglen = strlen(*sig);
>> +	parse_signature(buf, end - buf, &payload, &signature);
>> +	*sig = strbuf_detach(&signature, siglen);
>
> While I like the spirit of this patch, it makes the Windows build fail. I
> put this on top of Git for Windows' `shears/pu` branch to fix it (maybe
> you could adopt a variation of it?):

FWIW, it's of course not just Windows, but on anything whose size_t
!= ulong, e.g. https://travis-ci.org/git/git/jobs/654661788 (Linux32)
