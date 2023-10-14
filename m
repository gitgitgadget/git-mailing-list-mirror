Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B31134A8
	for <git@vger.kernel.org>; Sat, 14 Oct 2023 19:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="l+B5hKg4"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A13ABF
	for <git@vger.kernel.org>; Sat, 14 Oct 2023 12:42:07 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 8015D34F8F;
	Sat, 14 Oct 2023 15:42:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=alm2iJ6TfNQvVdoarCf+iOMgOzZJ4lvTd1yI7u
	jv5Vk=; b=l+B5hKg4wTWx+fKEI4iA/KbNYl3JtqO26+NfUD49OMYFoOYwU5j19k
	T4K27B4e8D/Gf61uB/TpVVUVBdoKVD7Eoh5WiVZo/9FCT4GmIwRSJvtGbkjbuFt5
	yva1u2e2FAIU2YsRM1BtETrG8hqiYlvbIVgr12ncNpir/kzs7MpjY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 7A29334F8E;
	Sat, 14 Oct 2023 15:42:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id ECADB34F8D;
	Sat, 14 Oct 2023 15:42:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 21/20] t5319: make corrupted large-offset test more robust
In-Reply-To: <20231014004348.GA43880@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 13 Oct 2023 20:43:48 -0400")
References: <20231009205544.GA3281950@coredump.intra.peff.net>
	<20231014004348.GA43880@coredump.intra.peff.net>
Date: Sat, 14 Oct 2023 12:42:01 -0700
Message-ID: <xmqq4jitt2ie.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BF8F38F4-6AC9-11EE-9EE5-A19503B9AAD1-77302942!pb-smtp21.pobox.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Jeff King <peff@peff.net> writes:

>   4b. But sometimes we hit a different error. If another object points
>       to X as a delta base, then trying to find the type of that object
>       requires walking the delta chain to the base entry (since only the
>       base has the concrete type; deltas themselves are either OFS_DELTA
>       or REF_DELTA).
>
>       Normally this would not require separate offset lookups at all, as
>       deltas are usually stored as OFS_DELTA, specifying the relative
>       offset to the base. But the corrupt idx created in step 1 is done
>       directly with "git pack-objects" and does not pass the
>       --delta-base-offset option, meaning we have REF_DELTA entries!
>       Those do have to consult an index to find the location of the base
>       object, and they use the pack .idx to do this. The same pack .idx
>       that we know is corrupted from step 1!

Tricky.

> The set of objects created in the test is deterministic. But the delta
> selection seems not to be (which is not too surprising, as it is
> multi-threaded).

So, the offsets of the objects are also not deterministic?

> I have seen the failure in Windows CI but haven't
> reproduced it locally (not even with --stress). Re-running a failed
> Windows CI job tends to work. But when I download and examine the trash
> directory from a failed run, it shows a different set of deltas than I
> get locally. But the exact source of non-determinism isn't that
> important; our test should be robust against any order.

Yeah, thanks for digging this tricky situation through.

>   b. The "objects64" setup could use --delta-base-offset. This would fix
>      our problem, but earlier tests have many hard-coded offsets. Using
>      OFS_DELTA would change the locations of objects in the pack (this
>      might even be OK because I think most of the offsets are within the
>      .idx file, but it seems brittle and I'm afraid to touch it).

I am not sure I follow, as it does not sound a solution to anything
if the offsets are not deterministic (and "earlier tests" that have
hard coded offsets are broken no matter what, which is not a problem
this patch introduces).  Puzzled, but not curious enough to think
about it further, as you have already rejected this approach ;-)

>   d. We could ask directly about object X, rather than enumerating all
>      of them. But that requires further hard-coding of the oid (both
>      sha1 and sha256) of object X. I'd prefer not to introduce more
>      brittleness.

Right.

>   e. We can use a --batch-check format that looks at the pack data, but
>      doesn't have to chase deltas. The problem in this case is
>      %(objecttype), which has to walk to the base. But %(objectsize)
>      does not; we can get the value directly from the delta itself.
>      Another option would be %(deltabase), where we report the REF_DELTA
>      name but don't look at its data.
>
> I've gone with option (e) here. It's kind of subtle, but it's simple and
> has no side effects.

Nice.

> @@ -1129,8 +1129,10 @@ test_expect_success 'reader bounds-checks large offset table' '
>  		git multi-pack-index --object-dir=../objects64 write &&
>  		midx=../objects64/pack/multi-pack-index &&
>  		corrupt_chunk_file $midx LOFF clear &&
> -		test_must_fail git cat-file \
> -			--batch-check --batch-all-objects 2>err &&
> +		# using only %(objectsize) is important here; see the commit
> +		# message for more details
> +		test_must_fail git cat-file --batch-all-objects \
> +			--batch-check="%(objectsize)" 2>err &&

A rather unfriendly message to readers, as it is unclear which
commit you are talking about, and a fun thing is that you cannot
say which one.

Will queue.  Thanks.

