Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5533CC4338F
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 20:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 336C260F57
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 20:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbhGZUMg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 16:12:36 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52570 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232959AbhGZUMe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 16:12:34 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EA626D124C;
        Mon, 26 Jul 2021 16:53:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Wb/b7w6eLwFDk/a4gb1qxMWPUCRiDIraMcyWnx
        6YFmw=; b=XVT9D7uHElraeMDU9S2sRnkjIhYBI/a8d+QVy5hoBX23deSYwW3sNp
        ONlViMcdLL5quH7CnGD1PNI11qoRWke/DnmBPsa321uaPnYy+h3dyI9Sl1dDUdQC
        O3NguXhJk+mJ34AuJGjWIvyEvOXoumT2dYzf8ILXc34kDjo82adIQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AB87CD124A;
        Mon, 26 Jul 2021 16:53:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A2944D1249;
        Mon, 26 Jul 2021 16:53:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com, avarab@gmail.com
Subject: Re: [PATCH v3 3/3] packfile-uri.txt: support for excluding commit
 objects
References: <cover.1627292424.git.dyroneteng@gmail.com>
        <01ab2cbb34e6eb5f9b421d34ac368ea4e266fcd1.1627292425.git.dyroneteng@gmail.com>
Date:   Mon, 26 Jul 2021 13:52:59 -0700
In-Reply-To: <01ab2cbb34e6eb5f9b421d34ac368ea4e266fcd1.1627292425.git.dyroneteng@gmail.com>
        (Teng Long's message of "Mon, 26 Jul 2021 17:46:14 +0800")
Message-ID: <xmqqr1fkhk5w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 76BF089C-EE53-11EB-9C81-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teng Long <dyroneteng@gmail.com> writes:

> +++ b/Documentation/technical/packfile-uri.txt
> @@ -35,13 +35,16 @@ include some sort of non-trivial implementation in the Minimum Viable Product,
>  at least so that we can test the client.
>  
>  This is the implementation: a feature, marked experimental, that allows the
> +server to be configured by one or more entries with the format:
> +
> +    uploadpack.excludeobject=<object-hash> <recursively> <pack-hash> <uri>
> +
> +Value <object-hash> is the key of entry, and the object type can be a blob
> +or commit. Whenever the list of objects to be sent is assembled, all such
> +objects are excluded, replaced with URIs. At the same time, for the old
> +configuration `uploadpack.blobPackfileUri=<sha1> <pack-hash> <uri>` is
> +still compatible for now, but this configuration only supports the
> +exclusion of blob objects.

Do not hint deprecation and future removal with "still" and "for
now", before seeing a concensus that it should be deprecated and
removed.

The new thing, <recursively>, deserves some explanation.  What are
the acceptable values (yes/no? spatial/time/both? infinitely/limited?)
and what do these values mean?

Why is this limited to only <blob> and <commit>?

There isn't a fundamental reason why I shouldn't be able to say
"v2.32.0" instead of ebf3c04b262aa27fbb97f8a0156c2347fecafafb (or
"v2.32.0~0") to say "I want anything reachable from v2.32.0 (in
other words, that version and everything before it)", is there?

For that matter, "everything reachable from this tree object" may
also be a reasonable way to specify which set of objects are
offloaded to an out-of-band URI.

Thanks.
