Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD62A1FC96
	for <e@80x24.org>; Tue,  6 Dec 2016 21:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752190AbcLFVVP (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 16:21:15 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59771 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751396AbcLFVVO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 16:21:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 91646545D4;
        Tue,  6 Dec 2016 16:21:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+BqTFA0Npl2ciFJIeJKp9H4EnX8=; b=TgEMim
        QiJTtFa9ApBBHXhvvQ2AEdnA3WHWt+PxylIIlgW/AbgBTXwoQ9/eoBRSssQDGgOm
        qbVi9xRFXNkjmjZuh4CtmEt1r4Ykrcc1g26NB2oIsLz5/1/9pK0OYRu3hRsI5h/H
        MnGktAM/2hoDgwzXsjP58rXdHgGY4VPaf5zeE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=t2imVJbd+S6qO3tbo8bkdGf8goa9sKcC
        fFHhWd2h8Lo6EKIQx0JtGcfa2I1cxoNwQX2AtVflFv4C4L+CcwxA4pDfHAhxPj2+
        8YMcdif5Q4csUvYCAwx0rq7KZSpY4QTW1hmRVLz6SSuyXFKVglxgoOSjgN8gczlo
        CaMnp8h6g/c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 81A19545D1;
        Tue,  6 Dec 2016 16:21:13 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E186A545CC;
        Tue,  6 Dec 2016 16:21:12 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, Emily Xie <emilyxxie@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: "git add -p ." raises an unexpected "warning: empty strings as pathspecs will be made invalid in upcoming releases. please use . instead if you meant to match all paths"
References: <CAEnOLdvG=SoKFxeJ_pLmamGj_8osC+28TSg+pbFLLTr+ZLcpQA@mail.gmail.com>
        <20161130211100.GA18680@ikke.info>
        <xmqq7f7kd3pj.fsf@gitster.mtv.corp.google.com>
        <xmqqtwaobni5.fsf@gitster.mtv.corp.google.com>
        <20161206180400.GA103573@google.com>
Date:   Tue, 06 Dec 2016 13:21:11 -0800
In-Reply-To: <20161206180400.GA103573@google.com> (Brandon Williams's message
        of "Tue, 6 Dec 2016 10:04:00 -0800")
Message-ID: <xmqqlgvszrco.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EA1785D0-BBF9-11E6-8757-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> On 11/30, Junio C Hamano wrote:
>> Junio C Hamano <gitster@pobox.com> forgot to Cc: the author of the
>> most relevant change to the issue, d426430e6e ("pathspec: warn on
>> empty strings as pathspec", 2016-06-22).
>> ...
>
> I've been doing a bit of work trying to clean up the pathspec
> initialization code and I believe this can be fixed without
> having to add in this work around.  The code which does the munging is
> always trying to prefix the pathspec regardless if there is a prefix or
> not.  If instead its changed to only try and prefix the original if
> there is indeed a prefix, then it should fix the munging.

Thanks; sounds like a plan.
