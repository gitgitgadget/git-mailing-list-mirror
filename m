Return-Path: <SRS0=GLOD=BA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570D6C433DF
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 01:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AD292080D
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 01:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vQNByrk+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbgGUBA6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jul 2020 21:00:58 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54531 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbgGUBA5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jul 2020 21:00:57 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 479837C233;
        Mon, 20 Jul 2020 21:00:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LobhjN1AQaZTFPtFzMEfcDSXDtQ=; b=vQNByr
        k+dcv40OSPaI1EmV6s37hyTcRY0zB/5ro+0z6wn90dgDOybEqy1+WbN6QtIiIHkq
        OQrRi6fct/ZH+no5nXocM7LwVvbTtR5Y5A0cQ3Z1kF0Kx9Nzz6plyLzOzm9k18h2
        IbSyIxcnEoXlS3wwleogfzn54iYj6lPd4O7qg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=a8LVSJTbma2AVeFE3zliRiQMravjZH/F
        w98IfIhpt7HHRr/sSoOrtJYppYl4WX+Qe872PpKXbtPgwBcImVErIxvmGjEFW1fu
        wvamXQJhhR2QAo7YlmpEfjtfFDLCUdk2O0c5DiNmZqFpssyaDSQU5pgwEvMJTsi4
        yHSoo8dWoNw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3E5637C232;
        Mon, 20 Jul 2020 21:00:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C37FD7C231;
        Mon, 20 Jul 2020 21:00:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, sluongng@gmail.com
Subject: Re: [PATCH 2/2] pack-objects: prefetch objects to be packed
References: <cover.1595290841.git.jonathantanmy@google.com>
        <b87764b711621ea3c614dbc8f9e49a8598a25cb1.1595290841.git.jonathantanmy@google.com>
Date:   Mon, 20 Jul 2020 18:00:50 -0700
In-Reply-To: <b87764b711621ea3c614dbc8f9e49a8598a25cb1.1595290841.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Mon, 20 Jul 2020 17:21:44 -0700")
Message-ID: <xmqqd04p8ywt.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9EC79B40-CAED-11EA-821D-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> When an object to be packed is noticed to be missing, prefetch all
> to-be-packed objects in one batch.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---

Hmph, the resulting codeflow structure feels somewhat iffy.  Perhaps
I am not reading the code correctly, but

 * There is a loop that scans from 0..to_pack.nr_objects and calls
   check_object() for each and every one of them;

 * The called check_object(), when it notices that a missing and
   promised (i.e. to be lazily fetched) object is in the to_pack
   array, asks prefetch_to_pack() to scan from that point to the end
   of that array and grabs all of them that are missing.

It almost feels a lot cleaner to see what is going on in the
resulting code, instead of the way the new "loop" was added, if a
new loop is added _before_ the loop to call check_object() on all
objects in to_pack array as a pre-processing phase when there is a
promisor remote.  That is, after reverting all the change this patch
makes to check_object(), add a new loop in get_object_details() that
looks more or less like so:

	QSORT(sorted_by_offset, to_pack.nr_objects, pack_offset_sort);

+	if (has_promisor_remote())
+		prefetch_to_pack(0);
+
	for (i = 0; i < to_pack.nr_objects; i++) {


Was the patch done this way because scanning the entire array twice
is expensive?  The optimization makes sense to me if certain
conditions are met, like...

 - Most of the time there is no missing object due to promisor, even
   if has_promissor_to_remote() is true;

 - When there are missing objects due to promisor, pack_offset_sort
   will keep them near the end of the array; and

 - Given the oid, oid_object_info_extended() on it with
   OBJECT_INFO_FOR_PREFETCH is expensive.

Only when all these conditions are met, it would avoid unnecessary
overhead by scanning only a very later part of the array by delaying
the point in the array where prefetch_to_pack() starts scanning.

Thanks.

> There have been recent discussions about using QUICK whenever we use
> SKIP_FETCH_OBJECT. I don't think it fully applies here, since here we
> fully expect the object to be present in the non-partial-clone case.
> Having said that, I wouldn't be opposed to adding QUICK and then, if the
> object read fails and if the repo is not a partial clone, to retry the
> object load (before setting the type to -1).
> ---
>  builtin/pack-objects.c | 36 ++++++++++++++++++++++++++++++++----
>  t/t5300-pack-object.sh | 36 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 68 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index e09d140eed..ecef5cda44 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -35,6 +35,7 @@
>  #include "midx.h"
>  #include "trace2.h"
>  #include "shallow.h"
> +#include "promisor-remote.h"
>  
>  #define IN_PACK(obj) oe_in_pack(&to_pack, obj)
>  #define SIZE(obj) oe_size(&to_pack, obj)
> @@ -1704,7 +1705,26 @@ static int can_reuse_delta(const struct object_id *base_oid,
>  	return 0;
>  }
>  
> -static void check_object(struct object_entry *entry)
> +static void prefetch_to_pack(uint32_t object_index_start) {
> +	struct oid_array to_fetch = OID_ARRAY_INIT;
> +	uint32_t i;
> +
> +	for (i = object_index_start; i < to_pack.nr_objects; i++) {
> +		struct object_entry *entry = to_pack.objects + i;
> +
> +		if (!oid_object_info_extended(the_repository,
> +					      &entry->idx.oid,
> +					      NULL,
> +					      OBJECT_INFO_FOR_PREFETCH))
> +			continue;
> +		oid_array_append(&to_fetch, &entry->idx.oid);
> +	}
> +	promisor_remote_get_direct(the_repository,
> +				   to_fetch.oid, to_fetch.nr);
> +	oid_array_clear(&to_fetch);
> +}
> +
> +static void check_object(struct object_entry *entry, uint32_t object_index)
>  {
>  	unsigned long canonical_size;
>  	enum object_type type;
> @@ -1843,8 +1863,16 @@ static void check_object(struct object_entry *entry)
>  	}
>  
>  	if (oid_object_info_extended(the_repository, &entry->idx.oid, &oi,
> -				     OBJECT_INFO_LOOKUP_REPLACE) < 0)
> -		type = -1;
> +				     OBJECT_INFO_SKIP_FETCH_OBJECT | OBJECT_INFO_LOOKUP_REPLACE) < 0) {
> +		if (has_promisor_remote()) {
> +			prefetch_to_pack(object_index);
> +			if (oid_object_info_extended(the_repository, &entry->idx.oid, &oi,
> +						     OBJECT_INFO_SKIP_FETCH_OBJECT | OBJECT_INFO_LOOKUP_REPLACE) < 0)
> +				type = -1;
> +		} else {
> +			type = -1;
> +		}
> +	}
>  	oe_set_type(entry, type);
>  	if (entry->type_valid) {
>  		SET_SIZE(entry, canonical_size);
> @@ -2065,7 +2093,7 @@ static void get_object_details(void)
>  
>  	for (i = 0; i < to_pack.nr_objects; i++) {
>  		struct object_entry *entry = sorted_by_offset[i];
> -		check_object(entry);
> +		check_object(entry, i);
>  		if (entry->type_valid &&
>  		    oe_size_greater_than(&to_pack, entry, big_file_threshold))
>  			entry->no_try_delta = 1;
> diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
> index 746cdb626e..d553d0ca46 100755
> --- a/t/t5300-pack-object.sh
> +++ b/t/t5300-pack-object.sh
> @@ -497,4 +497,40 @@ test_expect_success 'make sure index-pack detects the SHA1 collision (large blob
>  	)
>  '
>  
> +test_expect_success 'prefetch objects' '
> +	rm -rf server client &&
> +
> +	git init server &&
> +	test_config -C server uploadpack.allowanysha1inwant 1 &&
> +	test_config -C server uploadpack.allowfilter 1 &&
> +	test_config -C server protocol.version 2 &&
> +
> +	echo one >server/one &&
> +	git -C server add one &&
> +	git -C server commit -m one &&
> +	git -C server branch one_branch &&
> +
> +	echo two_a >server/two_a &&
> +	echo two_b >server/two_b &&
> +	git -C server add two_a two_b &&
> +	git -C server commit -m two &&
> +
> +	echo three >server/three &&
> +	git -C server add three &&
> +	git -C server commit -m three &&
> +	git -C server branch three_branch &&
> +
> +	# Clone, fetch "two" with blobs excluded, and re-push it. This requires
> +	# the client to have the blobs of "two" - verify that these are
> +	# prefetched in one batch.
> +	git clone --filter=blob:none --single-branch -b one_branch \
> +		"file://$(pwd)/server" client &&
> +	test_config -C client protocol.version 2 &&
> +	TWO=$(git -C server rev-parse three_branch^) &&
> +	git -C client fetch --filter=blob:none origin "$TWO" &&
> +	GIT_TRACE_PACKET=$(pwd)/trace git -C client push origin "$TWO":refs/heads/two_branch &&
> +	grep "git> done" trace >donelines &&
> +	test_line_count = 1 donelines
> +'
> +
>  test_done
