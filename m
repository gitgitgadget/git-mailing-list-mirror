Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9821342919
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 22:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iVPHztuY"
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3160B112
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 15:05:56 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 561151CB21E;
	Thu, 19 Oct 2023 18:05:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=mgvikFlrM/0OTSo3pevRmwf6TkZ72Ze0Rj4pZb
	Vz0Sg=; b=iVPHztuY24uqKr80gcWO7YZmDP2IqLQnNUV4asCAMEF5tmURDMi0ux
	d4oFQpm4WOxO0z77NJHdykfnP0e1h6mcC43pS+wr2WYlrG9yrLwLctxSNA9dldZU
	4wZrUgZVqPzbm8nux4ITXjD0Etvl/ahE7L5i4KA8GcnOi6lJh2PSE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4822F1CB21D;
	Thu, 19 Oct 2023 18:05:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A37DC1CB21C;
	Thu, 19 Oct 2023 18:05:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v3 3/3] rev-list: add commit object support in
 `--missing` option
In-Reply-To: <20231019121024.194317-4-karthik.188@gmail.com> (Karthik Nayak's
	message of "Thu, 19 Oct 2023 14:10:24 +0200")
References: <20231016103830.56486-1-karthik.188@gmail.com>
	<20231019121024.194317-1-karthik.188@gmail.com>
	<20231019121024.194317-4-karthik.188@gmail.com>
Date: Thu, 19 Oct 2023 15:05:53 -0700
Message-ID: <xmqq4jimuv26.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 AC85266E-6ECB-11EE-B44D-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

> diff --git a/object.h b/object.h
> index 114d45954d..b76830fce1 100644
> --- a/object.h
> +++ b/object.h
> @@ -62,7 +62,7 @@ void object_array_init(struct object_array *array);
>  
>  /*
>   * object flag allocation:
> - * revision.h:               0---------10         15             23------27
> + * revision.h:               0---------10         15             22------28
>   * fetch-pack.c:             01    67
>   * negotiator/default.c:       2--5
>   * walker.c:                 0-2
> @@ -82,7 +82,7 @@ void object_array_init(struct object_array *array);
>   * builtin/show-branch.c:    0-------------------------------------------26
>   * builtin/unpack-objects.c:                                 2021
>   */
> -#define FLAG_BITS  28
> +#define FLAG_BITS  29
>  
>  #define TYPE_BITS 3

I am afraid that this is not a good direction to go, given that the
way FLAG_BITS is used is like this:

    /*
     * The object type is stored in 3 bits.
     */
    struct object {
            unsigned parsed : 1;
            unsigned type : TYPE_BITS;
            unsigned flags : FLAG_BITS;
            struct object_id oid;
    };

28 was there, not as a random number of bits we happen to be using.
It was derived by (32 - 3 - 1), i.e. ensure the bitfields above are
stored within a single word.

sizeof(struct object) is 40 bytes on x86-64, with offsetof(oid)
being 4 (i.e. the bitfields fit in a single 4-byte word).  If we
make FLAG_BITS 29, we will add 4 bytes to the structure and waste
31-bit per each and every in-core objects.

Do we really need to allocate a new bit in the object flags, which
is already a scarce resource?
