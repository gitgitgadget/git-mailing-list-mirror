Return-Path: <SRS0=RXbn=3E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB62C32771
	for <git@archiver.kernel.org>; Wed, 15 Jan 2020 21:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2FD2222C3
	for <git@archiver.kernel.org>; Wed, 15 Jan 2020 21:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KjgeCrVk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729073AbgAOVk7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jan 2020 16:40:59 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62962 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbgAOVk6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jan 2020 16:40:58 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9DC8A2DFE1;
        Wed, 15 Jan 2020 16:40:56 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fqSoX2EQ/YuITl+kGAYRAhJPg+I=; b=KjgeCr
        Vk5e9XJ6fOMYd5Q/oIMADcgitDiJMgAjFUKQFJFXW2Oj4lwKN0M8m695vlemFBaH
        byt0AI9nDm28KKlZMHf4hz5hIrzqefXQHoTxcDfhS9+ajfiTL085dMDauTxQcpTu
        sZOlc1RNxugZPXofOwlqiKxSxGv3n3SoUEnDo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=N24/SAwA/3bd06vpB8yEqC89Ls5ipc/l
        GV3Xt0eQbFg8E57HUHAW2XiKlwfs/8EU+Tu+SuNkWj6wqk743jo9SCjDSATstBew
        vGFl/q3lZgWbJ9rHNWcNBmIucMTOBPi6Tt7scGyng272tPDBf2FfXRAGngD+F0ln
        P3/BydrJRPM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8F5B82DFDF;
        Wed, 15 Jan 2020 16:40:56 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DA3032DFDD;
        Wed, 15 Jan 2020 16:40:55 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>
Subject: Re: [RFC PATCH 02/22] hex: add functions to parse hex object IDs in any algorithm
References: <20200113124729.3684846-1-sandals@crustytoothpaste.net>
        <20200113124729.3684846-3-sandals@crustytoothpaste.net>
Date:   Wed, 15 Jan 2020 13:40:54 -0800
In-Reply-To: <20200113124729.3684846-3-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Mon, 13 Jan 2020 12:47:09 +0000")
Message-ID: <xmqqv9pciejd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B602D03C-37DF-11EA-93A7-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> +/*
> + * NOTE: This function relies on hash algorithms being in order from shortest
> + * length to longest length.
> + */
> +int get_oid_hex_any(const char *hex, struct object_id *oid)
> +{
> +	int i;
> +	for (i = GIT_HASH_NALGOS - 1; i > 0; i--) {
> +		if (!get_hash_hex_algop(hex, oid->hash, &hash_algos[i]))
> +			return i;
> +	}
> +	return GIT_HASH_UNKNOWN;
> +}

Two rather obvious questions are

 - what if we have more than one algos that produce hashes of the
   same length?

 - it feels that GIT_HASH_UNKNOWN being 0 wastes the first/zeroth
   element in the hash_algos[] array.

In the future, I would imagine that we would want to be able to say
"here I have a dozen hexdigits that is an abbreviated SHA2 hash",
and we would use some syntax (e.g. "sha2:123456123456") for that.
Would this function be at the layer that would be extended later to
support such a syntax, or would we have a layer higher than this to
do so?



>  int get_oid_hex(const char *hex, struct object_id *oid)
>  {
>  	return get_oid_hex_algop(hex, oid, the_hash_algo);
> @@ -87,6 +101,14 @@ int parse_oid_hex_algop(const char *hex, struct object_id *oid,
>  	return ret;
>  }
>  
> +int parse_oid_hex_any(const char *hex, struct object_id *oid, const char **end)
> +{
> +	int ret = get_oid_hex_any(hex, oid);
> +	if (ret)
> +		*end = hex + hash_algos[ret].hexsz;
> +	return ret;
> +}
> +
>  int parse_oid_hex(const char *hex, struct object_id *oid, const char **end)
>  {
>  	return parse_oid_hex_algop(hex, oid, end, the_hash_algo);
