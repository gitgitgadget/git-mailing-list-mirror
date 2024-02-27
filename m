Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C76B3D68
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 14:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.206.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709045830; cv=none; b=DzahfyOiNOEhxJvXMHqIlZ9IF3CqXb5N0HCUX4ReltUGb+X9fxq2GqAPAw7PXk6YpwbGfRVAJfI+Xm8IHIjYJWTOi7cb0C/wzTUZArzrOqCNF1lDSRKZR1crKt51ynQE7sudD/cBp2n5QWFAG4ILUNjo04EjCCTZA9m0Zu8IUZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709045830; c=relaxed/simple;
	bh=UQDVo/kgUSR9IMG90XnzqASyihAZYAdsvcEB2d3KgAs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hHhXabMzxDFtMu316YLt27UQ5syCvCpOWDBs+nx/0GyvOq6rqfT3+VnDhN/cbyeNNz2JW13Gr26YuijXEzRPhpa1EbHDjxNyMf14VkN4XJX4cusDteQoACKM5Go7xgKLGenpRCUtpgMl5gVzPfiVeBJvtw+bK7N/fazQBB7iSnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net; spf=pass smtp.mailfrom=gouders.net; dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b=saW/rFxq; arc=none smtp.client-ip=202.61.206.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="saW/rFxq"
Received: from localhost ([193.175.198.193])
	(authenticated bits=0)
	by mx10.gouders.net (8.17.1.9/8.17.1.9) with ESMTPSA id 41REv1Pr003862
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 27 Feb 2024 15:57:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
	t=1709045821; bh=UQDVo/kgUSR9IMG90XnzqASyihAZYAdsvcEB2d3KgAs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=saW/rFxqp6OQlaCwvHa8C96wqK623LgDs+ceHlDX+/VFu4aTYFJJCuKhr6r+KMwGT
	 MixA67FSyCbx/1VYXUf5EEN54v7U90iSfIitBj8s+WbS1jn9n5rw60GmWYfJisZiv1
	 BJ/jCPCgGjFp7WmZhPO3zSW6YvWKVVI5tNPEwZwU=
From: Dirk Gouders <dirk@gouders.net>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
        Johannes
 Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 05/11] commit-reach: start reporting errors in
 `paint_down_to_common()`
In-Reply-To: <85332b58c37717b5b8b6c826a2a3388dce3b0daa.1709040499.git.gitgitgadget@gmail.com>
	(Johannes Schindelin via GitGitGadget's message of "Tue, 27 Feb 2024
	13:28:11 +0000")
References: <pull.1657.v2.git.1708608110.gitgitgadget@gmail.com>
	<pull.1657.v3.git.1709040497.gitgitgadget@gmail.com>
	<85332b58c37717b5b8b6c826a2a3388dce3b0daa.1709040499.git.gitgitgadget@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Tue, 27 Feb 2024 15:56:56 +0100
Message-ID: <gh34tenefb.fsf@gouders.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Let's start at the bottom of the stack by teaching the
> `paint_down_to_common()` function to return an `int`: if negative, it
> indicates fatal error, if 0 success.

Kind of pedantic but the above doesn't describe the real change, i.e. a
value != 0 indicates a fatal error:

> -		common = paint_down_to_common(r, array[i], filled,
> -					      work, min_generation, 0);
> +		if (paint_down_to_common(r, array[i], filled,
> +					 work, min_generation, 0, &common)) {
> +			clear_commit_marks(array[i], all_flags);
> +			clear_commit_marks_many(filled, work, all_flags);
> +			free_commit_list(common);
> +			free(work);
> +			free(redundant);
> +			free(filled_index);
> +			return -1;
> +		}

Dirk
