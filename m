Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B2DC433B4
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 21:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C28DC60FD7
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 21:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233214AbhDNVca (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Apr 2021 17:32:30 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57589 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232302AbhDNVcZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Apr 2021 17:32:25 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6C4FE11A291;
        Wed, 14 Apr 2021 17:32:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ymLynaUbv0DmLyil4/7Rgu0uzD8=; b=irt6dX
        AzDR94luwZMV/ktigNSlKGiao/NXRBhoxgqEA62Qq4vN9SWhE9GNDkM0UChPF4Q2
        NjMl4NKAKHGObeOzeqI1fNpm+/HEPNIZ/43Rz/X4Jk8I0ZbMDV380UQDf5yU15Zq
        ZU6XilVSqzCzSxVI+6X/nmblCqpuz7gfaCD44=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tv8qa0nOhvxJCMEpSQFPTjbG1qSUGqrx
        lIA+PN71FrK8CAu22DPrMLlZYW7NwRRUzplV5X1x0yw0qu5qt14jcLeGneBPbP+t
        EOCDZMpqs528IsIVzNrNwhPLGsOB38y2iqYhJjZOPcmKxsLAIPNt20W/U0JMspNF
        f4joYB8CCO0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6622211A290;
        Wed, 14 Apr 2021 17:32:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9A9DE11A283;
        Wed, 14 Apr 2021 17:31:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: What's cooking (draft for #4's issue this month)
References: <xmqqmtu1zn3o.fsf@gitster.g> <YHa5NE3tj/R5kF8N@ncase>
Date:   Wed, 14 Apr 2021 14:31:57 -0700
In-Reply-To: <YHa5NE3tj/R5kF8N@ncase> (Patrick Steinhardt's message of "Wed,
        14 Apr 2021 11:43:16 +0200")
Message-ID: <xmqq7dl4y2lu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D8542D1C-9D68-11EB-BBCF-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> The other breakages I see are caused by hn/reftable, where all tests in
> t0031-reftables.sh cause segfaults. The root cause seems to be that
> reading refs via the reftable backend doesn't initialize the `algo`
> field of the OID, which is fixed via the following patch.

OK.  On 'master' without bc/hash-transition-interop-part-1,
hashcpy() and oidread() both use the size from the_hash_algo
but with the topic, oidread() becomes the way to declare that
the given oid uses the_hash_algo.

static inline void hashcpy(unsigned char *sha_dst, const unsigned char *sha_src)
{
	memcpy(sha_dst, sha_src, the_hash_algo->rawsz);
}

static inline void oidread(struct object_id *oid, const unsigned char *hash)
{
	size_t rawsz = the_hash_algo->rawsz;
	memcpy(oid->hash, hash, rawsz);
	memset(oid->hash + rawsz, 0, GIT_MAX_RAWSZ - rawsz);
	oid->algo = hash_algo_by_ptr(the_hash_algo);
}

So the patch makes sense to directly squashed into hn/reftable topic
to (1) be a benign no-op in the master and to (2) fix an expected
semantic conflict with bc/hash-transition-interop-part-1 topic.

Thanks.



> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> index 130fd90e45..35fb7dd0a2 100644
> --- a/refs/reftable-backend.c
> +++ b/refs/reftable-backend.c
> @@ -251,10 +251,10 @@ static int reftable_ref_iterator_advance(struct ref_iterator *ref_iterator)
>  		ri->base.flags = 0;
>  		switch (ri->ref.value_type) {
>  		case REFTABLE_REF_VAL1:
> -			hashcpy(ri->oid.hash, ri->ref.value.val1);
> +			oidread(&ri->oid, ri->ref.value.val1);
>  			break;
>  		case REFTABLE_REF_VAL2:
> -			hashcpy(ri->oid.hash, ri->ref.value.val2.value);
> +			oidread(&ri->oid, ri->ref.value.val2.value);
>  			break;
>  		case REFTABLE_REF_SYMREF: {
>  			int out_flags = 0;
> @@ -299,7 +299,7 @@ static int reftable_ref_iterator_peel(struct ref_iterator *ref_iterator,
>  	struct git_reftable_iterator *ri =
>  		(struct git_reftable_iterator *)ref_iterator;
>  	if (ri->ref.value_type == REFTABLE_REF_VAL2) {
> -		hashcpy(peeled->hash, ri->ref.value.val2.target_value);
> +		oidread(peeled, ri->ref.value.val2.target_value);
>  		return 0;
>  	}
>
> @@ -977,7 +977,7 @@ git_reftable_reflog_ref_iterator_advance(struct ref_iterator *ref_iterator)
>
>  		free(ri->last_name);
>  		ri->last_name = xstrdup(ri->log.refname);
> -		hashcpy(ri->oid.hash, ri->log.update.new_hash);
> +		oidread(&ri->oid, ri->log.update.new_hash);
>  		return ITER_OK;
>  	}
>  }
> @@ -1090,8 +1090,8 @@ static int git_reftable_for_each_reflog_ent_newest_first(
>  			break;
>  		}
>
> -		hashcpy(old_oid.hash, log.update.old_hash);
> -		hashcpy(new_oid.hash, log.update.new_hash);
> +		oidread(&old_oid, log.update.old_hash);
> +		oidread(&new_oid, log.update.new_hash);
>
>  		full_committer = fmt_ident(log.update.name, log.update.email,
>  					   WANT_COMMITTER_IDENT,
> @@ -1157,8 +1157,8 @@ static int git_reftable_for_each_reflog_ent_oldest_first(
>  		struct object_id new_oid;
>  		const char *full_committer = "";
>
> -		hashcpy(old_oid.hash, log->update.old_hash);
> -		hashcpy(new_oid.hash, log->update.new_hash);
> +		oidread(&old_oid, log->update.old_hash);
> +		oidread(&new_oid, log->update.new_hash);
>
>  		full_committer = fmt_ident(log->update.name, log->update.email,
>  					   WANT_COMMITTER_IDENT, NULL,
> @@ -1330,8 +1330,8 @@ git_reftable_reflog_expire(struct ref_store *ref_store, const char *refname,
>  		if (err > 0 || strcmp(log.refname, refname)) {
>  			break;
>  		}
> -		hashcpy(ooid.hash, log.update.old_hash);
> -		hashcpy(noid.hash, log.update.new_hash);
> +		oidread(&ooid, log.update.old_hash);
> +		oidread(&noid, log.update.new_hash);
>
>  		if (should_prune_fn(&ooid, &noid, log.update.email,
>  				    (timestamp_t)log.update.time,
> @@ -1410,7 +1410,7 @@ static int git_reftable_read_raw_ref(struct ref_store *ref_store,
>  		strbuf_addstr(referent, ref.value.symref);
>  		*type |= REF_ISSYMREF;
>  	} else if (reftable_ref_record_val1(&ref) != NULL) {
> -		hashcpy(oid->hash, reftable_ref_record_val1(&ref));
> +		oidread(oid, reftable_ref_record_val1(&ref));
>  	} else {
>  		*type |= REF_ISBROKEN;
>  		errno = EINVAL;
>
>
> Patrick
