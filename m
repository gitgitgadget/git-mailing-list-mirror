Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66C3720A10
	for <e@80x24.org>; Thu, 28 Sep 2017 22:03:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751710AbdI1WDK (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Sep 2017 18:03:10 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56670 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751107AbdI1WDJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Sep 2017 18:03:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7129596867;
        Thu, 28 Sep 2017 18:03:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hgTK20/lCZxLl92pkKGa/b6mmoU=; b=QGHWMF
        SzBtjHQJPZH8MjO7IcXfrXfq9mhEOpKG6an+0mlNyD9h6Alt9poBNBf+XIcjcCxB
        OVoGo3wMed7Af9v4AVjN5TY2mvXkstRfcaaHmfCk7LxnCVoaeGe0KtgI8UnupS7g
        bisF+ychi+/YNITNllAJPfxNam3NQOyQNYd2E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XbXA/q/2wegigQDuRyJkPFnvrdebdkR+
        LTB7wHVjf0MWELu0tIE/0wTi5LxBTHhebhG4w4J5BmH7VFQZuFzSsvqUaSgWfWg1
        dxABcneE6t+qcSfWNM2cQrV7lLsyE+dnHaFGlRW4rVwHtIbHt92FA7Zjalki0l1H
        J144t31FqVY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 65D1896866;
        Thu, 28 Sep 2017 18:03:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AAB4F96863;
        Thu, 28 Sep 2017 18:03:08 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Max Kirillov <max@max630.net>, Paul Mackerras <paulus@ozlabs.org>,
        git@vger.kernel.org
Subject: Re: [PATCH] gitk: expand $config_file_tmp before reporting to user
References: <20170928041417.28947-1-max@max630.net>
        <xmqq4lrn30bz.fsf@gitster.mtv.corp.google.com>
        <xmqqzi9f1lb2.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1709281428170.40514@virtualbox>
Date:   Fri, 29 Sep 2017 07:03:07 +0900
In-Reply-To: <alpine.DEB.2.21.1.1709281428170.40514@virtualbox> (Johannes
        Schindelin's message of "Thu, 28 Sep 2017 14:31:17 +0200 (CEST)")
Message-ID: <xmqqzi9ezdk4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CFD924A2-A498-11E7-AF77-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > Max Kirillov <max@max630.net> writes:
>> >
>> >> Tilda-based path may confise some users. First, tilda is not known
>> >> for Window users, second, it may point to unexpected location
>> >> depending on various environment setup.
> ...
> As familiar, as it is unfamiliar to Windows users.
>
> So I would actually suggest to make this a conditional on the platform: on
> Windows, use the native name, everywhere else, not.
>
> Sound good?

Not really.  

I agree with and (more importantly) consider the second rationale
Max cites a more relevant one for this change.  

This is about reporting an error, and using the short-hand ~/$rest
that could be pointing at a location different from what the user
_thinks_ it points at for whatever reason (miconfigured HOME, some
intermediate process setting it to something else, etc.) can hide
the real issue.  The problem can be more easily noticed and
diagnosed if the message shows the result of 'nativename'.  

And that rationale holds whether you are seeing the error message on
Windows or non-Windows.

