Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D71737151
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 16:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cVyIjurP"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11719F
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 09:08:10 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 498541AF86A;
	Wed, 18 Oct 2023 12:08:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=hahVYRJiExLewzFLaASmHm85dVr4cxa2Cj5ZWD
	2fIM0=; b=cVyIjurPyJwXiCaQutc23KwXB4syT+bVKuG26rI9xKYxmi//Jheu8d
	lswJ0T8z0+LwDCouIu47a08z9+9PyQZ+A/0GHwLdgF384Z9e45xgTIb5NGlp5VPc
	BgEOUFcI9y/XfulJgNitH5PWg7itPbyQyoAATNjjvUZoI7M4UmBBE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4021F1AF868;
	Wed, 18 Oct 2023 12:08:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8AD0E1AF866;
	Wed, 18 Oct 2023 12:08:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 02/11] t: allow skipping expected object ID in
 `ref-store update-ref`
In-Reply-To: <1f615d62f99e9ab47d37500f05b29615bafffba2.1697607222.git.ps@pks.im>
	(Patrick Steinhardt's message of "Wed, 18 Oct 2023 07:35:12 +0200")
References: <cover.1697607222.git.ps@pks.im>
	<1f615d62f99e9ab47d37500f05b29615bafffba2.1697607222.git.ps@pks.im>
Date: Wed, 18 Oct 2023 09:08:08 -0700
Message-ID: <xmqqil73ud5j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 87E86A4C-6DD0-11EE-927F-25B3960A682E-77302942!pb-smtp2.pobox.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Patrick Steinhardt <ps@pks.im> writes:

> We require the caller to pass both the old and new expected object ID to
> our `test-tool ref-store update-ref` helper. When trying to update a
> symbolic reference though it's impossible to specify the expected object
> ID, which means that the test would instead have to force-update the
> reference. This is currently impossible though.
>
> Update the helper to optionally skip verification of the old object ID
> in case the test passes in an empty old object ID as input.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  t/helper/test-ref-store.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)

Good.

Even better would be to make the old one optional, though.

> diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
> index 7400f560ab6..7dc83137584 100644
> --- a/t/helper/test-ref-store.c
> +++ b/t/helper/test-ref-store.c
> @@ -322,16 +322,19 @@ static int cmd_update_ref(struct ref_store *refs, const char **argv)
>  	const char *new_sha1_buf = notnull(*argv++, "new-sha1");
>  	const char *old_sha1_buf = notnull(*argv++, "old-sha1");
>  	unsigned int flags = arg_flags(*argv++, "flags", transaction_flags);
> -	struct object_id old_oid;
> +	struct object_id old_oid, *old_oid_ptr = NULL;
>  	struct object_id new_oid;
>  
> -	if (get_oid_hex(old_sha1_buf, &old_oid))
> -		die("cannot parse %s as %s", old_sha1_buf, the_hash_algo->name);
> +	if (*old_sha1_buf) {
> +		if (get_oid_hex(old_sha1_buf, &old_oid))
> +			die("cannot parse %s as %s", old_sha1_buf, the_hash_algo->name);
> +		old_oid_ptr = &old_oid;
> +	}
>  	if (get_oid_hex(new_sha1_buf, &new_oid))
>  		die("cannot parse %s as %s", new_sha1_buf, the_hash_algo->name);
>  
>  	return refs_update_ref(refs, msg, refname,
> -			       &new_oid, &old_oid,
> +			       &new_oid, old_oid_ptr,
>  			       flags, UPDATE_REFS_DIE_ON_ERR);
>  }
