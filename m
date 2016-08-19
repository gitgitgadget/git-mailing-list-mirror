Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C5741F859
	for <e@80x24.org>; Fri, 19 Aug 2016 16:06:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754030AbcHSQG1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Aug 2016 12:06:27 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57638 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751817AbcHSQG0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2016 12:06:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B45383509A;
        Fri, 19 Aug 2016 12:06:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SLZO7LMy5WNcqr+ZQCoUXwEKk7c=; b=dHSc56
        FtRF8tjYs5Uqa7F3VQI/3D7uXRP8YH2f878NNYCBmveUXvw2axhd2iqmzbN7TZs6
        rWCZglg76AJTOXnW0M4mh75rlY9f/FG1uYurfmqnJXLk7xEj95wKmQhHQ4tvJz24
        iMNuAjlgQLTdGjHq1wMMyFnTrD6Ln6Rawx7c4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QurDkhH/NilSw6JyHu2SHc423ExOpTc0
        pRMfp7amulrJT6rqRV0djX6fuivqdTT/IHOLNl0aTJwVF8YgnNKeXoTjdRhd3Szq
        ItAKMCQPm0NVTOG4XQk97Du+Prweh84AZmokpS7w/iLV5xMJDaMCW185IZlgmRaR
        1sC+eHjhrkw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ABE9335098;
        Fri, 19 Aug 2016 12:06:25 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3596F35097;
        Fri, 19 Aug 2016 12:06:25 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/4] cat-file: introduce the --filters option
References: <cover.1471524357.git.johannes.schindelin@gmx.de>
        <f1e188907f31abef9e82bd6b0da120ab7d9bd4a7.1471524357.git.johannes.schindelin@gmx.de>
        <20160818154908.GB17141@tb-raspi>
        <alpine.DEB.2.20.1608191426470.4924@virtualbox>
Date:   Fri, 19 Aug 2016 09:06:23 -0700
In-Reply-To: <alpine.DEB.2.20.1608191426470.4924@virtualbox> (Johannes
        Schindelin's message of "Fri, 19 Aug 2016 14:37:43 +0200 (CEST)")
Message-ID: <xmqq7fbc4ubk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E113A4D8-6626-11E6-BACA-FCB17B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Actually, I find it much harder to debug these "the output must match
> these precise bytes, else we fail" type of test cases. Instead, I describe
> in a natural way what is expected:
>
> 	! has_cr actual
>
> Now, when the test fails, whoever is that poor soul tasked with debugging
> and fixing the breakage knows *what* goes wrong, conceptually.

I am of two minds but 60% in favor of the "We only care about
presense of CR" approach.  Of course, the remaining 40% is "other
people may break the code in such a way that still has CR at the end
of the line but change ealier bytes on the line in the future (an
obvious way to do so is to turn an input "ABC\n" into "AB\r\n"), and
we would want to catch it".  But the conversion machinery is tested
elsewhere in the test suite, and this test is more about the cat-file
command making a call into the conversion machinery when and only
when it is necessary, so that sways me towards "has_cr is what we
want here".

> Could you please start surrounding your replies by empty lines?

Good suggestion.  I have exactly the same problem whenever I read
messages without blanks at paragraph boundaries.

Thanks.
