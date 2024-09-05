Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0302A19D897
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 16:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725552762; cv=none; b=MgKgOeilNaKrIzFiPT+xr7FJ08Jcn8XLgBBck9ChdfMn3yBcbSmLDOea7D52ISPxSZhDLVecBzkcUkWAUoDDlcyKKLFT+RsRnHrlyawV+Id0/8OfylnPYwHoUa3XThJKmobJ3/s0WYKAsauhcezvG3cRlOyxYtFThqWnoNsw5KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725552762; c=relaxed/simple;
	bh=Duz7ELfukQTk6jckEwryXdFv6izQwffciv8e9dHAArQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KTnNdNW23R8j1BTjbPX6VdBwdRTlglZGy0QkEwBWnQKTBQ5aJtjyozWzg98IvQz3EN7K7Iik1IVYFWojhjtAOhcbJreqyKskFsDezBys11DeDq9jWI2HKgEzCP2kHeryDmBgmiLHlilRfnUHf6fhd9JGHsf1yCLLWud8euzyQb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Md8GQqQ8; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Md8GQqQ8"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id F3A702C463;
	Thu,  5 Sep 2024 12:12:39 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Duz7ELfukQTk6jckEwryXdFv6izQwffciv8e9d
	HAArQ=; b=Md8GQqQ8EDfiPrhlUQwQ7d8bqh86d7eECudS668zWo1MOWvrDXE8nC
	piVadDSa3iT5eXuTX/GA1g1elsZnG4BnjZo5BP03SGTKsuqIDF05EXhA5neQyoEy
	mEjLdkJ4BVCVFRR5Bv9U3SX2OsZRFUztwohbEYMECZI4iKARMJIes=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EBF0E2C462;
	Thu,  5 Sep 2024 12:12:39 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 500352C460;
	Thu,  5 Sep 2024 12:12:39 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  johannes.schindelin@gmx.de,  Derrick Stolee
 <stolee@gmail.com>
Subject: Re: [PATCH] scalar: add --no-tags option
In-Reply-To: <pull.1780.git.1725545614416.gitgitgadget@gmail.com> (Derrick
	Stolee via GitGitGadget's message of "Thu, 05 Sep 2024 14:13:34
	+0000")
References: <pull.1780.git.1725545614416.gitgitgadget@gmail.com>
Date: Thu, 05 Sep 2024 09:12:38 -0700
Message-ID: <xmqq7cbq3wqx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 AC2049DC-6BA1-11EF-87B7-9B0F950A682E-77302942!pb-smtp2.pobox.com

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <stolee@gmail.com>
>
> Some large repositories use tags to track a huge list of release
> versions. While this is choice is costly on the ref advertisement, it is
> further wasteful for clients who do not need those tags. Allow clients
> to optionally skip the tag advertisement.
>
> This behavior is similar to that of 'git clone --no-tags' implemented in
> 0dab2468ee5 (clone: add a --no-tags option to clone without tags,
> 2017-04-26), including the modification of the remote.origin.tagOpt
> config value to include "--no-tags".
>
> One thing that is opposite of the 'git clone' implementation is that
> this allows '--tags' as an assumed option, which can be naturally negated
> with '--no-tags'. The clone command does not accept '--tags' but allows
> "--no-no-tags" as the negation of its '--no-tags' option.

Yuck.  The loophole may be something we may want to close later,
though (and replaced with a proper "--tags" support).

> While testing this option, combine the test with the previously untested
> '--no-src' option introduced in 4527db8ff8c (scalar: add --[no-]src
> option, 2023-08-28).
>
> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---

Makes sense.

This is a tangent, but the "--[no-]tags" option in "git fetch" is
misdesigned; the default is to auto-follow tags that would annotate
objects that are being fetched, and "--no-tags" is a way to decline
the auto-following.  But "--tags" is to say that all tags must be
fetched.  There is no obvious way to say "I want the auto-following
behaviour" (e.g., to override an earlier "--no-tags" or "--tags").
