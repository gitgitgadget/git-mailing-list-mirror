Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F916A004
	for <git@vger.kernel.org>; Wed, 24 Jan 2024 19:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706123359; cv=none; b=Ezd+gusKJtMUQJkeIYLXfXq1Mb+5UxO1zvjDZNzFrTtN6UaW9DFX0Odn+NeGFZLoJduujQzEBb12OOgdyOmTPQQA2kjrFH/geUXCnLO6WankjajhXqafxynBfjSGGejyD+2RrezqXiFcYqDBNUGWNSjxniD4JF5tnJPaMJ72JBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706123359; c=relaxed/simple;
	bh=14X+z0iojGkqaOt1Fa8o67gQ6vAzCJDill7638QPvhM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J6C/lCieFB34Oqa0aK6ROs2acpG5n8G4iOphA92M4E2FRaNNI1xrOXlbaVcQ7FKwdUO6DIkG4t/CCZiU07kI/i6rysdXenobIUgojwmuxcoiPdjlAIKOVy/sdFKKN2/8RGM/1ttaSW3Uf8cDGl1m/wcpnJneD53bvApsALMAdDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=hG4pzSjq; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hG4pzSjq"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2EDFC1E5269;
	Wed, 24 Jan 2024 14:09:11 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=14X+z0iojGkqaOt1Fa8o67gQ6vAzCJDill7638
	QPvhM=; b=hG4pzSjqplIon4dtDRj6KY+og4jfYqC4Pwecpi17Aq3Dlh4njMvABH
	CDBTuG7R0QC3EDRO0q1DZ/l/36z9GmG+4WT73ZFtxThvGcBdgSkbU80l57z1K2YF
	HBSsmotwox3vPI5k1f4kQSrR3asSwVfcwIOFoibP4F2TZA92yOLVg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 268AA1E5268;
	Wed, 24 Jan 2024 14:09:11 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7FD571E5267;
	Wed, 24 Jan 2024 14:09:10 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  phillip.wood123@gmail.com
Subject: Re: [PATCH v2 1/4] refs: introduce `is_pseudoref()` and `is_headref()`
In-Reply-To: <20240124152726.124873-2-karthik.188@gmail.com> (Karthik Nayak's
	message of "Wed, 24 Jan 2024 16:27:23 +0100")
References: <20240119142705.139374-1-karthik.188@gmail.com>
	<20240124152726.124873-1-karthik.188@gmail.com>
	<20240124152726.124873-2-karthik.188@gmail.com>
Date: Wed, 24 Jan 2024 11:09:09 -0800
Message-ID: <xmqqfrymeega.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0E06BBE8-BAEC-11EE-B4A3-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

> We cannot directly add the new syntax checks to `is_pseudoref_syntax()`
> because the function is also used by `is_current_worktree_ref()` and
> making it stricter to match only known pseudorefs might have unintended
> consequences due to files like 'BISECT_START' which isn't a pseudoref
> but sometimes contains object ID.

Well described.

> diff --git a/refs.c b/refs.c
> index 20e8f1ff1f..4b6bfc66fb 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -859,6 +859,38 @@ static int is_pseudoref_syntax(const char *refname)
>  	return 1;
>  }
>  
> +int is_pseudoref(struct ref_store *refs, const char *refname)
> +{
> +	static const char *const irregular_pseudorefs[] = {
> +		"AUTO_MERGE",
> +		"BISECT_EXPECTED_REV",
> +		"NOTES_MERGE_PARTIAL",
> +		"NOTES_MERGE_REF",
> +		"MERGE_AUTOSTASH"

Let's end an array's initializer with a trailing comma, to help
future patches to add entries to this array without unnecessary
patch noise. 

> +	};
> +	size_t i;
> +
> +	if (!is_pseudoref_syntax(refname))
> +		return 0;
> +
> +	if (ends_with(refname, "_HEAD"))
> +		return refs_ref_exists(refs, refname);
> +
> +	for (i = 0; i < ARRAY_SIZE(irregular_pseudorefs); i++)
> +		 if (!strcmp(refname, irregular_pseudorefs[i]))
> +			 return refs_ref_exists(refs, refname);
> +
> +	return 0;
> +}

The above uses refs_ref_exists() because we want these to
successfully resolve for reading.

> +int is_headref(struct ref_store *refs, const char *refname)
> +{
> +	if (!strcmp(refname, "HEAD"))
> +		return refs_ref_exists(refs, refname);

Given that "git for-each-ref refs/remotes" does not show
"refs/remotes/origin/HEAD" in the output when we do not have the
remote-tracking branch that symref points at, we probably do want
to omit "HEAD" from the output when the HEAD symref points at an
unborn branch.  If refs_ref_exists() says "no, it does not exist"
in such a case, we are perfectly fine with this code.

We do not have to worry about the unborn state for pseudorefs
because they would never be symbolic.  But that in turn makes me
suspect that the check done with refs_ref_exists() in the
is_pseudoref() helper is a bit too lenient by allowing it to be a
symbolic ref.  Shouldn't we be using a check based on
read_ref_full(), like we did in another topic recently [*]?


[Reference]

 * https://lore.kernel.org/git/xmqqzfxa9usx.fsf@gitster.g/
