Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E7E1BDDB
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 22:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707257261; cv=none; b=UBut0sEXMDHcitafhpSCBjNmLjrcUEHPJ2norHyWGTSJY7J5/o7I+tdaDx4/pMQ6sGd9Qct775efWRL0/QofYLloH9KKpJ+6Dips63xdABFqLDNtJfII8imHeusvY9TY6YvlGcePMfKFjnCXDTU4Zznqmi6CDODVtIFTu//i9BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707257261; c=relaxed/simple;
	bh=AHp2AVk4SK8tfKQfQZlgze5IchU8NdSvugqGNJMJNgY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ktyfwhya003aOInuI2gyGfmau7n8I6gJFVsdIxhU67QXL5Z1Pnfq/z4NzewbTrYskBiRsgnm2Ch22G4qu+i/450HbyoXx3pQ6ynosqtGdHKeqKqnR2/IgqcGScTc3gNSn1Um4b5PHbsDWe4hHdHLEYsvildKk/LdgLOiKfd0rX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=CtoYboOn; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CtoYboOn"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8501A1CEBB8;
	Tue,  6 Feb 2024 17:07:38 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=AHp2AVk4SK8tfKQfQZlgze5IchU8NdSvugqGNJ
	MJNgY=; b=CtoYboOnmHD8aceyfqCksnSu6qqRIVfALav0IcI16K8yVKtvMV4gH/
	Bzil72u2aOCnLOCrIUeSHBn2Nj/Q+7Yj79bNSe2fu+675DA9eWd3L/ziHqC7dX+G
	9uxZnCcmbM26vZmTjZFlzZwfLhYB5gJif3cbAKm32R+m2gYUv3cFY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7D5491CEBB6;
	Tue,  6 Feb 2024 17:07:38 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DBE0A1CEBB4;
	Tue,  6 Feb 2024 17:07:37 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 4/4] Always check `parse_tree*()`'s return value
In-Reply-To: <93abd7000b81bbcd7f5422715b4bbb60c69a7cde.1707212981.git.gitgitgadget@gmail.com>
	(Johannes Schindelin via GitGitGadget's message of "Tue, 06 Feb 2024
	09:49:41 +0000")
References: <pull.1651.git.1707212981.gitgitgadget@gmail.com>
	<93abd7000b81bbcd7f5422715b4bbb60c69a7cde.1707212981.git.gitgitgadget@gmail.com>
Date: Tue, 06 Feb 2024 14:07:36 -0800
Message-ID: <xmqqh6ilfdqv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 237D2C6E-C53C-11EE-9C4E-25B3960A682E-77302942!pb-smtp2.pobox.com

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> @@ -707,7 +707,8 @@ static int reset_tree(struct tree *tree, const struct checkout_opts *o,
>  	init_checkout_metadata(&opts.meta, info->refname,
>  			       info->commit ? &info->commit->object.oid : null_oid(),
>  			       NULL);
> -	parse_tree(tree);
> +	if (parse_tree(tree) < 0)
> +		return 128;
>  	init_tree_desc(&tree_desc, tree->buffer, tree->size);

Another thing that caught my attention during today's integration
cycle was that this "parse the tree object in variable tree and then
call init_tree_desc on it" is a recurring pattern.  After the dust
settles, we might want to have a helper function perhaps like

    int init_tree_desc_from_tree(struct tree_desc *desc, struct tree *tree)
    {
	if (parse_tree(tree))
		return -1;
	init_tree_desc(desc, tree->buffer, tree->size);
    }

It was a bit irritating as another topic in flight changes the
function signature for init_tree_desc(), causing a textual conflict
that could be easily avoided.

