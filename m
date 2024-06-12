Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E0B4A12
	for <git@vger.kernel.org>; Wed, 12 Jun 2024 19:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718221554; cv=none; b=HMEdaaaWwBVkbjdU0hcBWhivn98RqD+GwvZTZT2DVojOG7P+QFpR3k6JpuPoAWi3BcTcGGq3QWDYXJIkGvqmj+Ql0UiC4uggmun+tyTZdATym91kmll9daRcx6AO5k+hm0ivGWOcdnyWQABu+hCMzJhHWqWoSXEBUF/Pn+ZnXP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718221554; c=relaxed/simple;
	bh=f9OYZut/HDU2APbYRBiQ1FFprQpmJ9ZshkavP/pHKE8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X9sCl3CE8BwbvVgdN02YNLKgyD6SRlfugP7trS+MlWjqDL4rf3bEaRvYhSYHWzbakH2u3PPh1Wm3/of8DeKdQ3V1pj2sVwdXgVs6+Y3Mev4iGy9cK7faek7mOqZA0xwNbwpOEe/t0iK97cPfqtu9fAkRMUXiswo1ar3qNHAn9ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=L/5cCI+a; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="L/5cCI+a"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1F19E2275B;
	Wed, 12 Jun 2024 15:45:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=f9OYZut/HDU2APbYRBiQ1FFprQpmJ9ZshkavP/
	pHKE8=; b=L/5cCI+aEVl2X9BfR9JzRbg2f2f9f5zoznEzK3DNguW4hykgcuSHrT
	3t70Mjg/2wT5hZHS20vTHOLPNnOMTrrxj0K6jOSz1g9Th51VWHC1EsthoIBEw+dK
	UEb9o/evKpOqIXh12f5cDSULQMhNRu535JeFbkHHbcsrXJ/Zz74MA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1757722759;
	Wed, 12 Jun 2024 15:45:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8740922758;
	Wed, 12 Jun 2024 15:45:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Victoria Dye <vdye@github.com>
Cc: Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH 09/16] mktree: validate paths more carefully
In-Reply-To: <63fd367e-4246-46a8-9b95-6353a5a54b36@github.com> (Victoria Dye's
	message of "Wed, 12 Jun 2024 12:01:24 -0700")
References: <pull.1746.git.1718130288.gitgitgadget@gmail.com>
	<4f9f77e693cfc4fbe72a2ae739bc7e236a3b82d3.1718130288.git.gitgitgadget@gmail.com>
	<xmqq34pirj51.fsf@gitster.g>
	<63fd367e-4246-46a8-9b95-6353a5a54b36@github.com>
Date: Wed, 12 Jun 2024 12:45:44 -0700
Message-ID: <xmqqh6dyosgn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5C325C70-28F4-11EF-984A-5B6DE52EC81B-77302942!pb-smtp1.pobox.com

Victoria Dye <vdye@github.com> writes:

> It might be a bit niche, but 'git ls-files -s --sparse' does print
> directories with a trailing slash, ...

OK.
