Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F30333730
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 15:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774883538; cv=none; b=CzLrx/k44RYj83eDNzOurKt3KHbEu5+73uFC/RXYbIkMcqSI5rIgWulAPPjV5ZlF6dMLHh1n/l09PdVsLi7asauzPbZElEaLi5Ib7Wcr3BgO9CF048PB0RfliQP2xDUQoZIsxqQBTqjAOXWuusRF7YU/7MUaiOafBOq9wLLrt7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774883538; c=relaxed/simple;
	bh=HYMWm8HnH260rL95XN1y4vsjZBt6TrkQxf+VMIJ90C0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=P7p5Ds141nO0r5IuBdGlyLU4CZbsEywKXUB7s7OO3EwNyizAD+zy2ZEGqiogxOZWv2JP8Qs7zrKkJWHR4GDUQgyHsaZIIuSqNxVmJqSYD556uGr3PgD9KUEkN11A1oCjqu4UhIBd6gVKIc+xtevB5qcXVTB50/7c02oMK0Tdq8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=h1p/8NIL; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="h1p/8NIL"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1774883533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kdzk8z6qwbjeIL5K+hHzvM+wWjPuesIPSdZFTCm4CQI=;
	b=h1p/8NILjwo6i/vdwpUlAIUCBxpMaMjBsHOBHpGQ2IbjdP//1z3nIPX80yXRjmn41HZe0x
	/Rp8SoBDQ0303xDKKjQ6gcLgwFUAJPl9/olrXHGw1qFiI+J3ESZsr0XdvjnaHaqt6K+Mqt
	JBCy0Mp+Evu66ETXe+pbstuvOGSPKqc=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 08/14] object-name: backend-generic `get_short_oid()`
In-Reply-To: <20260320-b4-pks-odb-source-abbrev-v2-8-fe65dcd8c735@pks.im>
References: <20260320-b4-pks-odb-source-abbrev-v2-0-fe65dcd8c735@pks.im>
 <20260320-b4-pks-odb-source-abbrev-v2-8-fe65dcd8c735@pks.im>
Date: Mon, 30 Mar 2026 17:12:02 +0200
Message-ID: <87cy0lmjwd.fsf@toon--20250203-5JQV3.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> The function `get_short_oid()` takes as input an abbreviated object ID
> and tries to turn that object ID into the full object ID. This is done
> by iterating through all objects that have the user-provided prefix. If
> that yields exactly one object we know that the abbreviated object ID is
> unambiguous, otherwise it is ambiguous and we print the list of objects
> that match the prefix.
>
> We iterate through all objects with the given prefix by calling both
> `find_short_packed_object()` and `find_short_object_filename()`, which
> is of course specific to the "files" backend. But we now have a generic
> way to iterate through objects with a specific prefix.
>
> Refactor the code to use `odb_for_each_object()` instead so that it
> works with object backends different than the "files" backend.
>
> Remove the now-unused `find_short_packed_object()` function.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  object-name.c | 32 ++++++--------------------------
>  1 file changed, 6 insertions(+), 26 deletions(-)
>
> diff --git a/object-name.c b/object-name.c
> index 4c3ace150e..7a224ab4af 100644
> --- a/object-name.c
> +++ b/object-name.c
>
> [snip]
>
> @@ -499,6 +477,7 @@ static enum get_oid_result get_short_oid(struct repository *r,
>  					 struct object_id *oid,
>  					 unsigned flags)
>  {
> +	struct odb_for_each_object_options opts = { 0 };
>  	int status;
>  	struct disambiguate_state ds;
>  	int quietly = !!(flags & GET_OID_QUIETLY);
> @@ -526,8 +505,10 @@ static enum get_oid_result get_short_oid(struct repository *r,
>  	else
>  		ds.fn = default_disambiguate_hint;
>  
> -	find_short_object_filename(&ds);
> -	find_short_packed_object(&ds);
> +	opts.prefix = &ds.bin_pfx;

This `ds` is initialized by init_object_disambiguation(), which calls
parse_oid_prefix() already. That's nice to see!

-- 
Cheers,
Toon
