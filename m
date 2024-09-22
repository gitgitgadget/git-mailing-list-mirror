Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79B72AE66
	for <git@vger.kernel.org>; Sun, 22 Sep 2024 06:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726987999; cv=none; b=ru1WISkDcR5NSaXKvA1K/ptE68oSHZgaHfGSmLmpMd6836QyP3S+IN2UDODpiSD0KYPnph45qepZtKMKZfCq/a2a5ojHmQkJS08tSvVMBGLl0goq/C8bX+fhk1Zme7dQHglXflOQ8NbWj/hqBbAY7pU+RfE0Bl7NLKk0pWZZcRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726987999; c=relaxed/simple;
	bh=pUz00DD3j5Ez1F8EPZSAksnobLNOULYY1wsXOQ2GO7Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ueg2m4r/9NA5thhujyiqPXPij8ZvtyJgMRFL+6G8lQM3toa6q8NV5likjnT46dhcPYcTUd/1g1w53nmz8L3S1C0qUrzyvZYZ/i72xMX4kqGTj/P2Gc328Ifb8Gz8kDElG7DTsS8CC+4bO/EdGOZTYBkqLUOy5ClISq8CYqCmEFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=DXxtFgPm; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DXxtFgPm"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C59AC36D9F;
	Sun, 22 Sep 2024 02:53:16 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=pUz00DD3j5Ez1F8EPZSAksnobLNOULYY1wsXOQ
	2GO7Q=; b=DXxtFgPmYiWXzmNJ+pAfOow0p4DgCDYEHJB6d7OaKLtyDSkWVE8tlx
	GTTMl2dO0ClpCVEUZ84O0KB85Gxp3Sn0rXz3C4c8O9r49mqke2umAhgdzz/+lKf0
	+8S2Ucu0+NbSj2/ZbUtS7ujoolCMI9whZMTv7jUk5CCzf5p0NkC8s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AE2DF36D9E;
	Sun, 22 Sep 2024 02:53:16 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 10C0336D9D;
	Sun, 22 Sep 2024 02:53:15 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Calvin Wan <calvinwan@google.com>
Cc: git@vger.kernel.org,  hanyang.tony@bytedance.com,
  jonathantanmy@google.com,  sokcevic@google.com
Subject: Re: [PATCH 2/2] fetch-pack.c: do not declare local commits as
 "have" in partial repos
In-Reply-To: <20240919234741.1317946-3-calvinwan@google.com> (Calvin Wan's
	message of "Thu, 19 Sep 2024 23:47:41 +0000")
References: <20240802073143.56731-1-hanyang.tony@bytedance.com>
	<20240919234741.1317946-3-calvinwan@google.com>
Date: Sat, 21 Sep 2024 23:53:14 -0700
Message-ID: <xmqqr09c89id.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 57E31DE8-78AF-11EF-B630-9B0F950A682E-77302942!pb-smtp2.pobox.com

Calvin Wan <calvinwan@google.com> writes:

> In a partial repository, creating a local commit and then fetching
> causes the following state to occur:
>
> commit  tree  blob
>  C3 ---- T3 -- B3 (fetched from remote, in promisor pack)
>  |
>  C2 ---- T2 -- B2 (created locally, in non-promisor pack)
>  |
>  C1 ---- T1 -- B1 (fetched from remote, in promisor pack)
>
> During garbage collection, parents of promisor objects are marked as
> UNINTERESTING and are subsequently garbage collected. In this case, C2
> would be deleted and attempts to access that commit would result in "bad
> object" errors (originally reported here[1]).

Understandable.

> This is not a bug in gc since it should be the case that parents of
> promisor objects are also promisor objects (fsck assumes this as
> well).

I am not sure where this "not a bug" claim comes from.  Here, the
definition of "promisor objects" seems to be anything that are
reachable from objects in promisor packs, but isn't the source of
the bug that collects C2 exactly that "gc" uses such a definition
for discardable objects that can be refetchd from promisor remotes?

> When promisor objects are fetched, the state of the repository
> should ensure that the above holds true. Therefore, do not declare local
> commits as "have" in partial repositores so they can be fetched into a
> promisor pack.

Could you clarify what it means in the context of the above example
you gave in an updated version of the proposed log message?

We pretend that C2 and anything it reaches do not exist locally, to
force them to be fetched from the remote?  We'd end up having two
copies of C2 (one that we created locally and had before starting
this fetch, the other we fetched when we fetched C3 from them)?
This sounds like it is awfully inefficient both network bandwidth-
and local disk-wise.

I was hoping to see that the issue can be fixed on the "gc" side,
regardless of how the objects enter our repository, but perhaps I am
missing something.  Isn't it just the matter of collecting C1, C3
but not C2?  Or to put it another way, if we first create a list of
objects to be packed (regardless of whether they are in promisor
packs), and then remove the objects that are in promisor packs from
the list, and pack the objects still remaining in the list?

> diff --git a/fetch-pack.c b/fetch-pack.c
> index 58b4581ad8..c39b0f6ad4 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -1297,12 +1297,23 @@ static void add_common(struct strbuf *req_buf, struct oidset *common)
>  
>  static int add_haves(struct fetch_negotiator *negotiator,
>  		     struct strbuf *req_buf,
> -		     int *haves_to_send)
> +		     int *haves_to_send,
> +		     int from_promisor)
>  {
>  	int haves_added = 0;
>  	const struct object_id *oid;
>  
>  	while ((oid = negotiator->next(negotiator))) {
> +		/* 
> +		 * In partial repos, do not declare local objects as "have"
> +		 * so that they can be fetched into a promisor pack. Certain
> +		 * operations mark parent commits of promisor objects as
> +		 * UNINTERESTING and are subsequently garbage collected so
> +		 * this ensures local commits are still available in promisor
> +		 * packs after a fetch + gc.
> +		 */
> +		if (from_promisor && !is_in_promisor_pack(oid, 0))
> +			continue;
>  		packet_buf_write(req_buf, "have %s\n", oid_to_hex(oid));
>  		if (++haves_added >= *haves_to_send)
>  			break;
> @@ -1405,7 +1416,7 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
>  	/* Add all of the common commits we've found in previous rounds */
>  	add_common(&req_buf, common);
>  
> -	haves_added = add_haves(negotiator, &req_buf, haves_to_send);
> +	haves_added = add_haves(negotiator, &req_buf, haves_to_send, args->from_promisor);
>  	*in_vain += haves_added;
>  	trace2_data_intmax("negotiation_v2", the_repository, "haves_added", haves_added);
>  	trace2_data_intmax("negotiation_v2", the_repository, "in_vain", *in_vain);
> @@ -2178,7 +2189,7 @@ void negotiate_using_fetch(const struct oid_array *negotiation_tips,
>  
>  		packet_buf_write(&req_buf, "wait-for-done");
>  
> -		haves_added = add_haves(&negotiator, &req_buf, &haves_to_send);
> +		haves_added = add_haves(&negotiator, &req_buf, &haves_to_send, 0);
>  		in_vain += haves_added;
>  		if (!haves_added || (seen_ack && in_vain >= MAX_IN_VAIN))
>  			last_iteration = 1;
> diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
> index 8415884754..cba9f7ed9b 100755
> --- a/t/t5616-partial-clone.sh
> +++ b/t/t5616-partial-clone.sh
> @@ -693,6 +693,35 @@ test_expect_success 'lazy-fetch in submodule succeeds' '
>  	git -C client restore --recurse-submodules --source=HEAD^ :/
>  '
>  
> +test_expect_success 'fetching from promisor remote fetches previously local commits' '
> +	# Setup
> +	git init full &&
> +	git -C full config uploadpack.allowfilter 1 &&
> + 	git -C full config uploadpack.allowanysha1inwant 1 &&
> +	touch full/foo &&
> +	git -C full add foo &&
> +	git -C full commit -m "commit 1" &&
> +	git -C full checkout --detach &&
> +
> +	# Partial clone and push commit to remote
> +	git clone "file://$(pwd)/full" --filter=blob:none partial &&
> +	echo "hello" > partial/foo &&
> +	git -C partial commit -a -m "commit 2" &&
> +	git -C partial push &&
> +
> +	# gc in partial repo
> +	git -C partial gc --prune=now &&
> +
> +	# Create another commit in normal repo
> +	git -C full checkout main &&
> +	echo " world" >> full/foo &&
> +	git -C full commit -a -m "commit 3" &&
> +
> +	# Pull from remote in partial repo, and run gc again
> +	git -C partial pull &&
> +	git -C partial gc --prune=now
> +'
> +
>  . "$TEST_DIRECTORY"/lib-httpd.sh
>  start_httpd
