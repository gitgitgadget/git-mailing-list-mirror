Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B5EC28CBC
	for <git@archiver.kernel.org>; Wed,  6 May 2020 18:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55AFF20747
	for <git@archiver.kernel.org>; Wed,  6 May 2020 18:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ePmCPgoO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730100AbgEFSWl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 14:22:41 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52502 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728619AbgEFSWl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 May 2020 14:22:41 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3E9ACCF7EE;
        Wed,  6 May 2020 14:22:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ckx8DbtjYKD3TATkAtnHicN2PJQ=; b=ePmCPg
        oOtHCFhG4r6sIE9tfEI0rNcYnbtmwy00179Lv/KOqMCq0+sFnOGOTsakwkDt2IXM
        UsUDRdycXW9hfBqiavNWc5RHF5mmyrmGOv5pr5pLKFdHx6Zjqb3ypQr/E7JWeARG
        SMS6IFpCoceL0myZRzqkYsx5EHLHg/gMR3Ge4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Dp0dEitN1+mR0yIeblvNIivUO2PNXEsm
        0D2wnkqxPYZSnfBb5VdI8BV/VMFVqOfGsO4o7KzkxMKtz1ZgGI2s8kVs3/6+sSaA
        c7kqc3Ikz5h5nrd3VhF8wi+g6DRuMnnMc5GEErELRSRTiPdO8eBoXiHGEaiNjdCx
        T63TWu4kpys=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 35DD9CF7ED;
        Wed,  6 May 2020 14:22:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 77E50CF7E6;
        Wed,  6 May 2020 14:22:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        kaartic.sivaraam@gmail.com, liu.denton@gmail.com
Subject: Re: [PATCH v4] submodule: port subcommand 'set-url' from shell to C
References: <20200506073717.9789-1-shouryashukla.oo@gmail.com>
        <xmqqtv0t6l84.fsf@gitster.c.googlers.com>
        <20200506181239.GA5683@konoha>
Date:   Wed, 06 May 2020 11:22:34 -0700
In-Reply-To: <20200506181239.GA5683@konoha> (Shourya Shukla's message of "Wed,
        6 May 2020 23:42:39 +0530")
Message-ID: <xmqqwo5o6hzp.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8FADD000-8FC6-11EA-9C5E-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shourya Shukla <shouryashukla.oo@gmail.com> writes:

>> By the way, looking at print_default_remote() that takes no
>> arguments wants argc to be 1, and resolve_relative_url() that takes
>> only one or two arguments checks for 2 or 3, shouldn't this be
>> checking if argc is 3, not 2?
>
> Aren't `path` and `newurl` the only arguments we should worry about
> here as 'parse_options' will parse out the other arguments ('git
> submodule--helper' and the 'quiet' option) leaving us with only the
> aforementioned arguments. Am I missing something here?

Ah, I misread those examples that suggested that you are supposed to
check for N+1 when you expect N arguments.   They are *not* using
parse_options() and that is where that funny numbering comes from.

This one uses "argc = parse_options(...)" so we should check for N
when we want N args.  Thanks.
