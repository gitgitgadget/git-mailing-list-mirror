Return-Path: <SRS0=p0jH=64=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C01C433E0
	for <git@archiver.kernel.org>; Thu, 14 May 2020 21:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDCE220727
	for <git@archiver.kernel.org>; Thu, 14 May 2020 21:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SIWuarR4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgENV4c (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 May 2020 17:56:32 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64513 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbgENV4b (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 May 2020 17:56:31 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A4FB95ECD0;
        Thu, 14 May 2020 17:56:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AZ84HWND3auGiHPHAbnUCPbXHpM=; b=SIWuar
        R4pqNNWKbk9JPqXZNRD+BQNgfIhyonyGkW/rnOMIEFjdRSyYKhjdJasvmoBEgOMi
        7zjiR7Lo8E38xyz0bUNEGv3kmyTcjq/Xz81hfkSYHp/37Sw7koey3Xf6q+rw+fPm
        +JGx5o1STuBC6Ath7MxnxY2w0pNP0cngHT5Bc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ek9hVUwqtlWRkVjjz5BCvJNvbA4wxyw7
        yofWc5e/Lv2DKoVcOAnMy64O8xJDOHwLzsKoiufwhwrNp7yRykvFcT7tlefpwtVQ
        Z1VgRipW5unUEKViS2jZSYVGcepI/ScamyToLwfwKoPMD0+T3315VW8DPQoiwJoU
        04q9W7RlsNQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9C7515ECCE;
        Thu, 14 May 2020 17:56:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 158815ECCD;
        Thu, 14 May 2020 17:56:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Caleb Gray <hey@calebgray.com>
Cc:     git@vger.kernel.org
Subject: Re: Add a "Flattened Cache" to `git --clone`?
References: <CAGjfG9a-MSg7v6+wynR1gL0zoe+Kv8HZfR8oxe+a3r59cGhEeg@mail.gmail.com>
        <20200514203326.2aqxolq5u75jx64q@chatter.i7.local>
        <20200514210501.GY1596452@mit.edu>
        <CAGjfG9bsQh2C6WP242v4LoiaSdghZDPuqns0VO82Txe-V54_KA@mail.gmail.com>
Date:   Thu, 14 May 2020 14:56:27 -0700
In-Reply-To: <CAGjfG9bsQh2C6WP242v4LoiaSdghZDPuqns0VO82Txe-V54_KA@mail.gmail.com>
        (Caleb Gray's message of "Thu, 14 May 2020 14:33:06 -0700")
Message-ID: <xmqqmu6ap4dw.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C33672A2-962D-11EA-A5E7-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Caleb Gray <hey@calebgray.com> writes:

> To Clarify: I'm talking about a server-side only cache which behaves
> much like a `tar` file: it is a flat version of exactly(*) what ends
> up on the client's storage. When a client runs `git --clone` and
> there's a valid cache on the other end, that's all that gets streamed.

So this is to save server processing time only.  It does not save
bandwidth (the "cache" is bit-for-bit idential replay of the clone
request it served earlier), and it does not save client processing
cycles (as the receiving end must validate the whole packdata it
received before it can even know what objects it received).

OK.




