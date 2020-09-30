Return-Path: <SRS0=XLsf=DH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9924C4363D
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 22:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DD11206CA
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 22:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GDAxb/TR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731231AbgI3WHT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 18:07:19 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59757 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730269AbgI3WHT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 18:07:19 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EC18188E52;
        Wed, 30 Sep 2020 18:07:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Ei8l08YxzL4s/vcbv8Pl9gzU7h4=; b=GDAxb/
        TR0VBAT3mdcoTVyHtWVXaqFLTPlSfCuPIJ5ZtIPIMtsIKWxz5EBM2FsQlmQWHZbX
        JaJUZOCwZKpAamgWYAo+/4+pVs3EI0ecXTsnImo+QZGU1gyVpBjxo9eCEXeE0yTY
        OTJaqH/mP+seK1R9QBysFL5wxMt2y0jOSBrxU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mTBpEz//6U+gAyijKBWQDVUNia+lRjWn
        DdTjUeNBAX8f5KWFxY7zy/ygDLXgZ7hL8QRUqMo550JSZW0suKxGDhzfCKWWjNYl
        xwtZUU0h6zMpBTCkdS5h47aCnAUt3skW1hcWmfygKNy5Rt6FOfilAdmx2wpV43F8
        uO6PCObL7ds=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DD33C88E51;
        Wed, 30 Sep 2020 18:07:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 63B7288E50;
        Wed, 30 Sep 2020 18:07:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] combine-diff: handle --find-object in multitree code path
References: <20200930115240.GA1899467@coredump.intra.peff.net>
Date:   Wed, 30 Sep 2020 15:07:15 -0700
In-Reply-To: <20200930115240.GA1899467@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 30 Sep 2020 07:52:40 -0400")
Message-ID: <xmqqmu16gbqk.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4D0F5734-0369-11EB-8C11-01D9BED8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>  2. It doesn't catch all cases where a particular path is interesting.
>     Consider a merge with parent blobs X and Y for a particular path,
>     and end result Z. That should be interesting according to "-c",
>     because the result doesn't match either parent. And it should be
>     interesting even with "--find-object=X", because "X" went away in
>     the merge.
>
>     But because we perform each pairwise diff independently, this
>     confuses the intersection code. The change from X to Z is still
>     interesting according to --find-object. But in the other parent we
>     went from Y to Z, so the diff appears empty! That causes the
>     intersection code to think that parent didn't change the path, and
>     thus it's not interesting for "-c".

Hmmmm....

> +test_expect_success 'do not detect merge that does not touch blob' '
> +	git checkout -B merge interesting &&
> +	git merge -m "untouched blob" base &&
> +	git diff-tree --format=%s --find-object=$blob -c --name-status HEAD >actual &&

You learn new things every day ;-)

I've always thought that for --find-object to do a good job, you'd
need "--full-history" and perhaps "-m".  Especially, I didn't expect
"-c" or "--cc" to make a difference.


