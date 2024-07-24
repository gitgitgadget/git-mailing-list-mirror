Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8573915DBBA
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 15:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721835594; cv=none; b=hclyRdop0GCM/MlC+Z8e8EVyWzBLWgfwDE2kqPV0Ew6NpfusKy0QTlovwAzFnTqlIjReEcuKkqplJ7+2mujTRQKsWKJ/HHP+JXR6L38Et4IlVJhFwucpbDwxKsKCQ8Clm9UwkZ/n2pMuNLf5naG4L0x0JQtLcgATbOPG9qDYoEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721835594; c=relaxed/simple;
	bh=t5yIyvsP1YNoYTqWLglQ1UOCHme5XcJVTThnaDgtmOE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=krO3bY+wi4RbFRn1R8K+s9c+UszLABfZ585aCyZjjckHUUgOkP3dqk/yK30Z9Lc26tWqCQlru6ZZst4QUn4h97tC1uGdZRe20fkmy8Bl76wOQlJqbEHOJMeA3UPMRpooSGTww6KwIa6oY8pu1BH5BvQp7DukQy3sE3CSMykorpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=g5f7L5Nq; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="g5f7L5Nq"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 71024189E4;
	Wed, 24 Jul 2024 11:39:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=t5yIyvsP1YNoYTqWLglQ1UOCHme5XcJVTThnaD
	gtmOE=; b=g5f7L5NqdZ4dzDvhIvdnDYOkGCJvl+vieG+w5K4iMDFUsS7hjix/fS
	AzgOmTnh8x1VKC59c9kz4YItmvltjyerc7+BWWc8pDBf+6hsQu1TViBECMMirKTM
	vT+v/xvY5B6eoY3vUgriJ3KauxUkh7XP0FiN240FE35SB61uwNyag=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 690C5189E3;
	Wed, 24 Jul 2024 11:39:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C93C6189E2;
	Wed, 24 Jul 2024 11:39:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Jin, Di" <di_jin@brown.edu>
Cc: git@vger.kernel.org,  Nikos Vasilakis <nikos_vasilakis@brown.edu>,
  michael@greenberg.science
Subject: Re: EXDEV when re-init with --separate-git-dir option
In-Reply-To: <CAKOkDnMGRfQoNygYLiAxPZB2q=VMYvw8kyu1dM=pM843-FH41Q@mail.gmail.com>
	(Di Jin's message of "Tue, 23 Jul 2024 22:47:19 -0400")
References: <CAKOkDnMGRfQoNygYLiAxPZB2q=VMYvw8kyu1dM=pM843-FH41Q@mail.gmail.com>
Date: Wed, 24 Jul 2024 08:39:49 -0700
Message-ID: <xmqq1q3iztmi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F70A73BE-49D2-11EF-A558-34EEED2EC81B-77302942!pb-smtp1.pobox.com

"Jin, Di" <di_jin@brown.edu> writes:

> We discovered that re-init with option --separate-git-dir will throw
> an EXDEV when the target directory is not on the same file system as
> the original directory.

Yup, it is hitting the limitation of your filesystem.  The code
wants to move the original .git directory together with its contents
to a new place, and it makes a single rename() system call to do so.
When the system cannot do so, you'd get the error message you are
seeing ("fatal: unable to move X to Y").

The code path could probably borrow some code to recursively "copy"
directory from the local "git clone" code path, and then invent a
new code to recursively remove the original ".git", and trigger that
new code when rename() fails.

But at that point, only as a fall-back measure, it might be simpler
and much less error prone to spawn a "mv src dst" as a subprocess
using the run_command() API.

It would make a good bite-sized #leftoverbits project for aspiring
new Git contributors.  Any takers?  ;-)

Thanks.

