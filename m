Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2987D10F4
	for <git@vger.kernel.org>; Fri, 12 Apr 2024 23:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712965085; cv=none; b=CO0N6yp/E1mM3j2XZ9I6hBFsq+Lh5i+jefcHxFwERRyPtLqs0p4q+VGKKYDlC0PYxMT/NO69vm24OfdsYSJ3OK4zsnyJPQPAcL8/zBprOM+93MOxoaOpvvFuA234sbIo4ps8p+oy3eCuNFuK7ssEqu4GenXBnU3ALdn38AQ4+68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712965085; c=relaxed/simple;
	bh=eQqZ5vdr+r2R97d+NyaMuSSSc1nyJiEe44jk7kBYrCA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nyKIcrqmm6RAslkN8FsXginZs0pLYmaNHks1YphZDI4GINh1fRIciEZr712Gn2S9iZvqXZsQ29eyX1okEswInFqkGxhCxDZ24YzpnEFGe+BL8tTXWjuaswVpxc+67oqWf4RRlorDIjjETkWWqJf3mo/2+9G8R0QT5doND1wdz3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=HZ2eq7xJ; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HZ2eq7xJ"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 988F932C65;
	Fri, 12 Apr 2024 19:38:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=eQqZ5vdr+r2R
	97d+NyaMuSSSc1nyJiEe44jk7kBYrCA=; b=HZ2eq7xJfWjSgy46N64sAedq1iCq
	Tj45wd4uoLS4H3z1P+8uaTkD9DDrOr41OGmLiq3+FfKBx4Q50WSIx1aP/vUqp+XT
	vkzOZp4S0kfEXyYd8CIuGcregikSLwAqbrkTBJ2VTq7JYWDhoc1pXwIQZBwScPYl
	u5ymoE39uI5MYk0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 9005832C64;
	Fri, 12 Apr 2024 19:38:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 07F4432C61;
	Fri, 12 Apr 2024 19:37:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Marcel =?utf-8?Q?R=C3=B6thke?= <marcel@roethke.info>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3] rerere: fix crashes due to unmatched opening
 conflict markers
In-Reply-To: <20240409121708.131542-2-marcel@roethke.info> ("Marcel
 =?utf-8?Q?R=C3=B6thke=22's?=
	message of "Tue, 9 Apr 2024 14:13:51 +0200")
References: <20240218194603.1210895-1-marcel@roethke.info>
	<20240409121708.131542-2-marcel@roethke.info>
Date: Fri, 12 Apr 2024 16:37:58 -0700
Message-ID: <xmqqr0fai23t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 B2985636-F925-11EE-8C26-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Marcel R=C3=B6thke <marcel@roethke.info> writes:

> When rerere handles a conflict with an unmatched opening conflict marke=
r
> in a file with other conflicts, it will fail create a preimage and also
> fail allocate the status member of struct rerere_dir. Currently the
> status member is allocated after the error handling. This will lead to =
a
> SEGFAULT when the status member is accessed during cleanup of the faile=
d
> parse.

Nicely diagnosed.  Yes, such a corrupt preimage should not enter the
rerere database as it is unusable for future replaying of the
resolution.  rerere should be prepared to deal with such an input
more gracefully.

> Additionally, in subsequent executions of rerere, after removing the
> MERGE_RR.lock manually, rerere crashes for a similar reason. MERGE_RR
> points to a conflict id that has no preimage, therefore the status
> member is not allocated and a SEGFAULT happens when trying to check if =
a
> preimage exists.
>
> Solve this by making sure the status field is allocated correctly and a=
dd
> tests to prevent the bug from reoccurring.

Thanks.

> This does not fix the root cause, failing to parse stray conflict
> markers, but I don't think we can do much better than recognizing it,
> printing an error, and moving on gracefully.

I somehow doubt that "parse stray markers" is something we _want_ to
do in the first place.  Is it "the root cause" that we refuse/reject
such a corrupt input from entering the rerere database?  To me, it
seems like that the issue is that we do not do a very good job
rejecting them, keeping the internal state consistent.

>  rerere.c          |  5 ++++
>  t/t4200-rerere.sh | 63 +++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 68 insertions(+)
>
> diff --git a/rerere.c b/rerere.c
> index ca7e77ba68..4683d6cbb1 100644
> --- a/rerere.c
> +++ b/rerere.c
> @@ -219,6 +219,11 @@ static void read_rr(struct repository *r, struct s=
tring_list *rr)
>  		buf.buf[hexsz] =3D '\0';
>  		id =3D new_rerere_id_hex(buf.buf);
>  		id->variant =3D variant;
> +		/*
> +		 * make sure id->collection->status has enough space
> +		 * for the variant we are interested in
> +		 */
> +		fit_variant(id->collection, variant);
>  		string_list_insert(rr, path)->util =3D id;
>  	}
>  	strbuf_release(&buf);

Both the fix, and the newly added tests, look great to me.

Thanks.  Will queue.
