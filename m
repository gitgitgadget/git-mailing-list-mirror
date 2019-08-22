Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AC7E1F461
	for <e@80x24.org>; Thu, 22 Aug 2019 16:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733077AbfHVQ1c (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Aug 2019 12:27:32 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54437 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729213AbfHVQ1c (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Aug 2019 12:27:32 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8CE596EB20;
        Thu, 22 Aug 2019 12:27:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=up7raP3aiBeflqekfXKge5yHPbU=; b=YZShkW
        a5DcaSFJCW2oy1nyMPGpAe+m2p8P6i51jIna0dyswroB7cBRgfB2mYBOlJYpptHg
        D4Zpk4AAIzTKe0/TrXTqLN06T327Y4Ts3YPxznnVaXbYcv9YFinyeQpTIxyvGUQb
        6Gz7u0oT+yhYbiPxUnUkvhTqcbZopmwdlG0gs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UFxQkwOsXYtVibFpFcy8o/+FOBU10T4q
        bJkPTv1ZrtgMQfeD3Yo+dvwG8MVe3s5qwTpVovy7eogW4rlptLtFkhGODzehon5d
        LHIk6uXll7qZbJSBE1sRMxGJbIFRyX17JNX/JrGKghOtMhIISeBKg5Xa0p5jjkxf
        fddivU/hqew=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 852776EB1F;
        Thu, 22 Aug 2019 12:27:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B32A96EB1E;
        Thu, 22 Aug 2019 12:27:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/2] Skip ls-refs if possible for HTTP
References: <cover.1566425828.git.jonathantanmy@google.com>
Date:   Thu, 22 Aug 2019 09:27:25 -0700
In-Reply-To: <cover.1566425828.git.jonathantanmy@google.com> (Jonathan Tan's
        message of "Wed, 21 Aug 2019 15:20:08 -0700")
Message-ID: <xmqqtva9p3ma.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BB29BF20-C4F9-11E9-A3FE-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> This was discovered by one of my colleagues when using a partial clone.
> I thought I had resolved the problem with the commits mentioned in patch
> 1 (e70a3030e7 and ancestors), but apparently that is not the case (that
> only worked for native protocols). So here is a fix for HTTP.
>
> I'm not sure of the value of the test in patch 2, but that test does
> fail if I don't update fetch_refs_from_bundle() to first call
> get_refs_from_bundle() if it hasn't already been called.

This probably is totally off-tangent, but do any of these "let's
advertise fewer" changes at the protocol level have to take into
account the use of --prune option on the client side?

> Jonathan Tan (2):
>   transport-helper: skip ls-refs if unnecessary
>   transport: teach all vtables to allow fetch first
>
>  t/t5607-clone-bundle.sh | 11 +++++++++++
>  t/t5702-protocol-v2.sh  | 13 +++++++++++++
>  transport-helper.c      | 38 ++++++++++++++++++++++++++++++++------
>  transport-internal.h    |  6 ------
>  transport.c             | 18 ++++++------------
>  5 files changed, 62 insertions(+), 24 deletions(-)
