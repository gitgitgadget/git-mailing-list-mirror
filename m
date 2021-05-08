Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50C4C433ED
	for <git@archiver.kernel.org>; Sat,  8 May 2021 10:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88C24611BE
	for <git@archiver.kernel.org>; Sat,  8 May 2021 10:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbhEHKxi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 May 2021 06:53:38 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64107 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbhEHKxf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 May 2021 06:53:35 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A1EECD4925;
        Sat,  8 May 2021 06:52:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=SrLx22iBzvcg
        gR870mNLSYZUbuz06DnclpPwAaTjY/0=; b=dQEbZ2ttR1v2Z+QePMCnSBRzJMfP
        Yrad6R05dVUNaJSTgwDcNjiULEzodrN309D3Rs3PoKlmKsgu7U0QhRdWOXU0XNpH
        +D89GsbY3t/JvrYx73Vle0B4k+LnMRqxmp/v+HJS9oGU1DLdAW19tkj+M9lCh2gW
        G0Y7i58nfCIytzM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 99824D4924;
        Sat,  8 May 2021 06:52:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 215D3D4923;
        Sat,  8 May 2021 06:52:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 3/6] mailinfo: warn if CR found in decoded base64/QP
 email
References: <20210421013404.17383-1-congdanhqx@gmail.com>
        <cover.1620311544.git.congdanhqx@gmail.com>
        <5aac2ba38e5442019d2816c63d7b65bf2bcf062a.1620311544.git.congdanhqx@gmail.com>
Date:   Sat, 08 May 2021 19:52:32 +0900
In-Reply-To: <5aac2ba38e5442019d2816c63d7b65bf2bcf062a.1620311544.git.congdanhqx@gmail.com>
        (=?utf-8?B?IsSQb8OgbiBUcuG6p24gQ8O0bmc=?= Danh"'s message of "Thu, 6 May
 2021 22:02:21 +0700")
Message-ID: <xmqqzgx5ts3z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7E074A7A-AFEB-11EB-96FF-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

> +test_expect_success 'mailinfo warn CR in base64 encoded email' '
> +	sed "s/%%/$(printf \\015)/" "$DATA/quoted-cr-msg" >expect-cr-msg &&
> +	sed "s/%%/$(printf \\015)/" "$DATA/quoted-cr-patch" >expect-cr-patch =
&&

As we are not interested in a lone CR in the middle of the line, I
wonder if we want to anchor the double per-cent to the end of the
line, i.e. "s/%%$/$(printf \\015)/".

On the other hand, we may want to make sure that the new option does
not disturb CR in the middle of the line, so we may be better off
leaving double per-cent unanchored, but allow replacing more than
once on a line, i.e. "s/%%/$(printf \\015)/g".

If we were to go to the latter route, we'd want to try a file with a
CR in the middle of the line (without a CR at the end of any line)
and make sure we won't warn or strip.
