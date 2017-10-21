Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A51F202A2
	for <e@80x24.org>; Sat, 21 Oct 2017 02:06:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753345AbdJUCGP (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Oct 2017 22:06:15 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55347 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753320AbdJUCGO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Oct 2017 22:06:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E1126B2DD9;
        Fri, 20 Oct 2017 22:06:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=26A4z6T5ovJ+HLYNq3HYIpvNEQk=; b=HS6iGD
        VGMTRVlb4bpCp+9slVjnuUIlqV84ojO6T1S1mZX3M6ZLT35KULr/7eTZ+QhsxB10
        Lcr3m4nPTgxlCYHx/qWLm6XkyEGiceHZhHJXvv8usQlS58VxKYTjMuJa/7C9YS6Y
        NJgUEysH5KLfHlAvxrLTj9PFEBMLPR814Y6gM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=X2gXthzyQ6D08YUjR5qWCRU6+l79oy5Y
        HTCESuYnN8HEL+JET/SeDYuE3NgSPMncxpSxaj/LZZX9EFEzFZB+B196B/vKaX2z
        X4DAlPc8HcRowDhpQ2vn6T8pHdp4GFP9PRNdsWMdI2kF7VuB3wE6S+Cj0+4mtlFs
        DxKX2oeVX/w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D6620B2DD8;
        Fri, 20 Oct 2017 22:06:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 24427B2DD6;
        Fri, 20 Oct 2017 22:06:13 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Alex Vandiver <alexmv@dropbox.com>, git@vger.kernel.org
Subject: Re: [PATCH 4/4] fsmonitor: Delay updating state until after split index is merged
References: <20171020011136.14170-1-alexmv@dropbox.com>
        <05670bb6e3c6378119b1649144c80dd6d72bfe29.1508461850.git.alexmv@dropbox.com>
        <alpine.DEB.2.21.1.1710201503380.40514@virtualbox>
        <7c6bfaef-d05a-4c06-5a53-4f7811c81aec@gmail.com>
Date:   Sat, 21 Oct 2017 11:06:11 +0900
In-Reply-To: <7c6bfaef-d05a-4c06-5a53-4f7811c81aec@gmail.com> (Ben Peart's
        message of "Fri, 20 Oct 2017 17:47:50 -0400")
Message-ID: <xmqq376dgsq4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 69F1853A-B604-11E7-BC0D-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <peartben@gmail.com> writes:

>>> +	} else {
>>> +		trace_printf_key(&trace_fsmonitor, "fsmonitor not enabled");
>>> +	}
>>> +
>
> I'd remove the trace statement above as it isn't always
> accurate. fsmonitor could be enabled but just hasn't written/read the
> extension yet.

I agree; when it is not enabled, we shouldn't be paying the penalty,
either.  I wonder if tweak_*() function can return early upfront if
we know fsmonitor is not enabled to make it even more obvious.

>>> +	if (ignore_fsmonitor)
>>> +		trace_printf_key(&trace_fsmonitor, "Ignoring fsmonitor for %s", ce->name);
>>
>> This is the code path I am fairly certain should not be penalized if
>> tracing is disabled.
>
> Definitely agree with the need to remove this tracing as it will get
> called a lot and we don't want to pay the perf penalty.

Yes.
