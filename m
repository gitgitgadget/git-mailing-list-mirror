Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE57F2022A
	for <e@80x24.org>; Thu, 27 Oct 2016 00:50:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933757AbcJ0AuM (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Oct 2016 20:50:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51024 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932702AbcJ0AuL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2016 20:50:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4349C4B592;
        Wed, 26 Oct 2016 20:50:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ja0hmE7PbIKOIu6JeL+9wIjem2c=; b=HgKZN3
        8Ulgf9wU+erUm0P1nWvuDHSUZtjh/2TNm2pRUgNHdyBK5z1Pnrsj7iTlz9sJHORd
        YUugcAniECCQqInNrX/DLbeKzB64GXeup1IIleweD3y9pFtTQ4EQsv1YQjkoTYS+
        HBwX5/Nih4wNa8qe133yd5Hn/19NCEpASviSI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Qaydv18fQ3cNPm1NEJ8Oe19wDMzN8mNu
        BvRosnT20wkA4+Vw9NUWtDudvTM3m1ChDO/KrwhdmEBD9oPTfu7xIMYRRw3FNcK+
        Sl4StotCuk2ou+GlEJi/EaOt/5fqW8dPH0XCYx3ZKO/USoA3XsTa5c6y9L56KvoT
        DkuNRwRV4wg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3A57E4B591;
        Wed, 26 Oct 2016 20:50:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A0D0C4B58D;
        Wed, 26 Oct 2016 20:50:09 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        Brandon Williams <bmwill@google.com>,
        Simon Ruderich <simon@ruderich.org>
Subject: Re: [PATCHv2 1/2] attr: convert to new threadsafe API
References: <CAGZ79kYhMVrKHhNGYcf_D9kWEYp+sC+tMGbuE+gnD8AU27dh8g@mail.gmail.com>
        <20161026224104.31844-1-sbeller@google.com>
        <xmqqoa26aek6.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kaR4DddoHQNUUvRAY=_PK5qqS=ws_Wkfa-EXT2seN5b=A@mail.gmail.com>
        <xmqqfuniabo6.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kY00mtzwL4kSz6oXSAb-39=axeTP-ax_FxWcL7Z-sAA4w@mail.gmail.com>
Date:   Wed, 26 Oct 2016 17:50:07 -0700
In-Reply-To: <CAGZ79kY00mtzwL4kSz6oXSAb-39=axeTP-ax_FxWcL7Z-sAA4w@mail.gmail.com>
        (Stefan Beller's message of "Wed, 26 Oct 2016 17:22:05 -0700")
Message-ID: <xmqq7f8uaa4g.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4FA24F42-9BDF-11E6-BF51-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> To explain, you can either have:
>     struct git_attr_result result[2];
> or
>     struct git_attr_result *result = git_attr_result_alloc(check);
> and both are running just fine in a thread. However you should not
> make that variable static. But maybe that is too much common sense
> and hence confusing.

Yup, if you spelled it out that does make sense, but the description
given in the patch was just misleading.

Thanks.
