Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E02E1F461
	for <e@80x24.org>; Tue,  3 Sep 2019 17:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbfICRnQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Sep 2019 13:43:16 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57449 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727364AbfICRnQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Sep 2019 13:43:16 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CBD08171EA;
        Tue,  3 Sep 2019 13:43:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=4RQjsg6HXpVy
        njlvWlFKJHzsZjU=; b=aH4J6y0SF4rvdoN3LEzJH9bSfi1ZO5YHM0+9RTHVRib/
        vMPza0VbiLGj2/Vlq6TVN6U0nE1ZKRX2/+gYtSC1d4LWos0KPJt/YFvNe69x+CIK
        hCRQ9IvE003fSbka9ttkqtgdnTy5yuyC94N6vJKNlDu5o1UCOr7gPHPvnBxvYE4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=OAdweO
        eaUwkRDAPpHyAPqTZj0I2/npRLzZZfc8sWqkghyapR6v8Caq9aNJV0ZLKNsnWHlf
        uKiny8AQFm3+ECq82mdJ9/OkBfyHRdonYFeEwDvI5jqiQaHbeCpSxypu20CIRoXU
        CTT8/oXfRE7GQD4nAQgdoyDWOR8qYEywFz3vU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C2F55171E9;
        Tue,  3 Sep 2019 13:43:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 27FA1171E8;
        Tue,  3 Sep 2019 13:43:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Joel Teichroeb <joel@teichroeb.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/3] factor out refresh_and_write_cache function
References: <20190827101408.76757-1-t.gummerer@gmail.com>
        <20190829182748.43802-1-t.gummerer@gmail.com>
        <20190829182748.43802-2-t.gummerer@gmail.com>
        <CAN0heSqZOG6NMJE4=RReKzG3eD_w1mh8EcYaAQWN6WBY3WuZ1Q@mail.gmail.com>
        <xmqq8srazipr.fsf@gitster-ct.c.googlers.com>
        <20190902171539.GB77876@cat>
Date:   Tue, 03 Sep 2019 10:43:10 -0700
In-Reply-To: <20190902171539.GB77876@cat> (Thomas Gummerer's message of "Mon,
        2 Sep 2019 18:15:39 +0100")
Message-ID: <xmqqsgpdtgwh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4C376CFC-CE72-11E9-8D2F-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> On 08/30, Junio C Hamano wrote:
>> Martin =C3=85gren <martin.agren@gmail.com> writes:
>> ...
>> > The above makes me think that once this new function is in good shap=
e,
>> > the commit introducing it could sell it as "this is hard to get righ=
t --
>> > let's implement it correctly once and for all". ;-)
>>=20
>> Yes, that is a more severe issue.
>
> With this do you mean what you quoted above, or that the lockfile is
> not rolled back?  I agree that the lockfile not being rolled back if
> 'refresh_cache()' fails is indeed the bigger issue, and I'll fix that
> in v3.  I can also add something like the above to the commit message,
> just wanted to make sure I'm not missing something subtle in what you
> quoted above.

You didn't miss anything, other than that I trimmed my quote too
much and ended up confusing you.

Thanks.

