Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9C81C282
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 22:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707256984; cv=none; b=iaQ6O6sop0hpuhTtKXEQjM/Ooqd8TKSz9T7BnhTprrwHLnvrAm4zrGkJpKCUB6zzF/UmUVIQo9p//kq6278GQDeZQkwSr1T17obIoMq9l8PWij4sTpYuQSf8fFq+PC4bV1an35LE8cshCZ1R8DeIi4x0/CywL7/FY9FZka3iqYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707256984; c=relaxed/simple;
	bh=NvRESZDJ9te/0pkASMm1GRZ+S59pRPYS5HD2bWuv9qU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F3Efsi0cobQZ2YpZIAT1b26/J3CcOrbyO3TYUybyYr/3j8iHxYeUpXdJK3fMKb7fDKRdqXZ14vIxIr6XSuep/mWXjD1bXl5B9dQaofkRPF/IPCkRBdHmLD4W71xRJu54c7hr6yyfSuYIK7+Ia8O7rhCGeyuTcmGAdUyKho9HPUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=h4AzB2B/; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="h4AzB2B/"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9A3AE1CEB60;
	Tue,  6 Feb 2024 17:03:01 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=NvRESZDJ9te/0pkASMm1GRZ+S59pRPYS5HD2bW
	uv9qU=; b=h4AzB2B/a8Zqrg1U5XjxHyforwX27/sb0wHFr2bix8+Ypc4k51SnDh
	KA4qGxu7tptrc8HoFIN/4N6K70zKexZixgaq9aVXbRA1Aj17JbTXSQjOk4GMlEpT
	FwUcyLnEGwUU2IZjlZW7KWkCzMVPYfursvY09Sk66GEJmrVoPouD8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 918401CEB5F;
	Tue,  6 Feb 2024 17:03:01 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D82F51CEB5D;
	Tue,  6 Feb 2024 17:03:00 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] Always check the return value of `repo_read_object_file()`
In-Reply-To: <pull.1650.git.1707143753726.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Mon, 05 Feb 2024 14:35:53
	+0000")
References: <pull.1650.git.1707143753726.gitgitgadget@gmail.com>
Date: Tue, 06 Feb 2024 14:02:59 -0800
Message-ID: <xmqqplx9fdyk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7E605C4C-C53B-11EE-8514-25B3960A682E-77302942!pb-smtp2.pobox.com

> diff --git a/builtin/grep.c b/builtin/grep.c
> index c8e33f97755..982bcfc4b1d 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -571,6 +571,8 @@ static int grep_cache(struct grep_opt *opt,
>  
>  			data = repo_read_object_file(the_repository, &ce->oid,
>  						     &type, &size);
> +			if (!data)
> +				die(_("unable to read tree %s"), oid_to_hex(&ce->oid));
>  			init_tree_desc(&tree, data, size);
>  
>  			hit |= grep_tree(opt, pathspec, &tree, &name, 0, 0);

This caught my attention during today's integration cycle.  Checking
nullness for data certainly is an improvement, but shouldn't we be
checking type as well to make sure it is a tree and not a random
tree-ish or even blob?
