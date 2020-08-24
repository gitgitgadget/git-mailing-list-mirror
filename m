Return-Path: <SRS0=3swP=CC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DB3C433DF
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 21:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BF5520866
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 21:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bq0p4EqK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgHXVCD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Aug 2020 17:02:03 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58242 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgHXVCD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Aug 2020 17:02:03 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 978E4D4CF3;
        Mon, 24 Aug 2020 17:02:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GQ+AcZkysRLEXn6zMrRe0/JKrKg=; b=bq0p4E
        qKYLxNv2Zy7F/9EwcolWIsqnglkPMhTF/iJ1b7+abXO+l4ACUC2NIxGmZgbY2Gwh
        ZtjYfv2ICQ9yngo4JvXCwunpf5VucJEMNTfU5XAfcCU/bKH92AKDjcQ9LWDBGy/u
        gN3Xc8/G94ewoGHodh5gjysfx2ClJyBI6cHzE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AFMXZi7TaQSx8+JGP55JPM9o6UHJiofg
        5slh6aOy7hYenceat0lT9bCZnjRBxafpaYK20maue30vt95BGdQJRov8Bhf4UXdr
        i2qOQRO6tUNR2oS3BkcSK3VVH0cYl7MuM+iwaLrb6arKckvKrZY7CBo9XfBPpfRp
        C+/vBOV7lR4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 917ABD4CF2;
        Mon, 24 Aug 2020 17:02:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AAD61D4CED;
        Mon, 24 Aug 2020 17:01:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, steadmon@google.com
Subject: Re: [PATCH 2/7] index-pack: remove redundant parameter
References: <cover.1598296530.git.jonathantanmy@google.com>
        <648ec34821bd435468a0917167bdeef7ca101c02.1598296530.git.jonathantanmy@google.com>
Date:   Mon, 24 Aug 2020 14:01:56 -0700
In-Reply-To: <648ec34821bd435468a0917167bdeef7ca101c02.1598296530.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Mon, 24 Aug 2020 12:16:33 -0700")
Message-ID: <xmqqsgcb3ghn.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0CA3FB5C-E64D-11EA-A0A5-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> find_{ref,ofs}_delta_{,children} take an enum object_type parameter, but
> the object type is already present in the name of the function. Remove
> that parameter from these functions.

Interesting.  

These "find children" are the only caller for each delta type and
they always pass OFS/REF constant that corresponds to them, so
find_*_delta() can lose the type.  But compare_*_delta_bases()
cannot, as the other one in the objects[] array may be of different
type.

Makes sense.  Thanks.

