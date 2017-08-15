Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE49B208B8
	for <e@80x24.org>; Tue, 15 Aug 2017 18:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752501AbdHOSXG (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 14:23:06 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58790 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751723AbdHOSXG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 14:23:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 718349A707;
        Tue, 15 Aug 2017 14:23:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gE59B2pAej6PEV66TiEC0kIWQ14=; b=Y7hwAj
        EyzkyVVXHq2sl17hEbTYZi02jpqkALl8iJ1aHKrBx8jUe7JIYh6OfNYCMHp9xPNs
        LjtOI37WwhukHmIaVwue2+qXF04XIF3ri4eGQUCLVhl1ex3a3weG4tD0GbclaSPj
        t8ukAh3qw7p5pL5NosCnz45XDcbckGulN9oBA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RYtUimdcGTDp2xymAEbGGYGO3zniC2dn
        yv5btvCzdxjbb38A4VQJI/r18/+wf3ulcrDerVwVO7eL0590NV/iJes8nt7gRJP/
        sKr6cpluZRevX6NfrGvlmGVRA+VDdBVMBDqzVmmh6Fq1kguXya5zSM+wX+BIJdhM
        Qd4Q7tNrPBQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6A47E9A706;
        Tue, 15 Aug 2017 14:23:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D39589A702;
        Tue, 15 Aug 2017 14:23:02 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patryk Obara <patryk.obara@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 2/5] sha1_file: fix hardcoded size in null_sha1
References: <cover.1502796628.git.patryk.obara@gmail.com>
        <cover.1502796628.git.patryk.obara@gmail.com>
        <a21088f049390828cdee957f88503e8466e1d34e.1502796628.git.patryk.obara@gmail.com>
Date:   Tue, 15 Aug 2017 11:23:01 -0700
In-Reply-To: <a21088f049390828cdee957f88503e8466e1d34e.1502796628.git.patryk.obara@gmail.com>
        (Patryk Obara's message of "Tue, 15 Aug 2017 13:49:03 +0200")
Message-ID: <xmqq1socsnay.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C660DAE8-81E6-11E7-8510-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patryk Obara <patryk.obara@gmail.com> writes:

> This prevents compilation error if GIT_MAX_RAWSZ is different than 20.
>
> Signed-off-by: Patryk Obara <patryk.obara@gmail.com>
> ---
>  sha1_file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I think this is OK for "null" thing, but in general I feel
ambivalent when I see the use of "MAX" thing.

Use of "MAX" here implies that we wish to support multiple hashes at
the same time in a single binary, so that longer or shorter hashes
fit there.  But in such a case, the callers would want a union of
some sort so that they can say "I am using SHA2, give me the null
thing"?  

I said this is OK for "null" because we assume we will use ^\0{len}$
for any hash function we choose as the "impossible" value, and for
that particular use pattern, we do not need such a union.  Just
letting the caller peek at an appropriate number of bytes at the
beginning of that NUL buffer for hash the caller wants to use is
sufficient.

Thanks.

>
> diff --git a/sha1_file.c b/sha1_file.c
> index b60ae15..f5b5bec 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -32,7 +32,7 @@
>  #define SZ_FMT PRIuMAX
>  static inline uintmax_t sz_fmt(size_t s) { return s; }
>  
> -const unsigned char null_sha1[20];
> +const unsigned char null_sha1[GIT_MAX_RAWSZ];
>  const struct object_id null_oid;
>  const struct object_id empty_tree_oid = {
>  	EMPTY_TREE_SHA1_BIN_LITERAL
