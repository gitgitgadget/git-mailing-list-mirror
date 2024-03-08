Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E679D15CB
	for <git@vger.kernel.org>; Fri,  8 Mar 2024 22:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709937021; cv=none; b=q2WtV1ERsGT6lw0nowAHc/6BvE7bi1NLMF4zm58M1jR6xcYKcgOn3t6DSZs6LDx25jYlV36cLct3nh+xLiGMwYQhdiHcvAdnNIPT0d6J9oTgw9kgvYMnNQiY8s1RzBu+cZSeO/6MDlBbjdZulM8XyJhu5OVVvUEBqwWWX4F9zIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709937021; c=relaxed/simple;
	bh=PCwSfdlH5TirLceOPr+sQ0p1Yr/5Yk55CdCgaxnbDe4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jy73lhKumVpIVqQvxv5QtjJ+lllQ5LUIv8W9dB6/mLjoUHFZhIfclrYBStiZHzhus5IkpvpbB1rUtYU0wTftpa0flKNZZK/o1LjdiaIHk3xEy5NbChxImWBaGz49Z8d903yeblaiLTaSJ+fEMQiDqzdMf4dvIHaoZg1mGz+XNTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=QfVF4Ohw; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QfVF4Ohw"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 576131E2E22;
	Fri,  8 Mar 2024 17:30:13 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=PCwSfdlH5TirLceOPr+sQ0p1Yr/5Yk55CdCgax
	nbDe4=; b=QfVF4Ohwrfs3mt/ZuNZrvv3Cp6ti+04iKTnVbSB5OOrirXSw5O8MGK
	I+RcxjR3Zav3WPwHjm8NJopBTelpybsS+O9zNGxeUCDTQMjBTPUwsPfDYN5X3kSl
	Zw+6BpvgYEbGGEOOVGxyebfCyVLr5Eo5B2XV7LzdtYzw/bLRaT9SM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4E24D1E2E21;
	Fri,  8 Mar 2024 17:30:13 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A05B81E2E20;
	Fri,  8 Mar 2024 17:30:12 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Kyle Lippincott <spectral@google.com>
Subject: Re: [PATCH 2/2] setup: make bareRepository=explicit work in GIT_DIR
 of a secondary worktree
In-Reply-To: <20240308211957.3758770-3-gitster@pobox.com> (Junio C. Hamano's
	message of "Fri, 8 Mar 2024 13:19:57 -0800")
References: <xmqqv85zqniu.fsf@gitster.g>
	<20240308211957.3758770-1-gitster@pobox.com>
	<20240308211957.3758770-3-gitster@pobox.com>
Date: Fri, 08 Mar 2024 14:30:11 -0800
Message-ID: <xmqqil1wfjbg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6DCAF7F2-DD9B-11EE-8DF9-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> In the previous commit, we created a helper function to house the
> logic that checks if a directory that looks like a bare repository
> is actually a part of a non-bare repository.  Extend the helper
> function to also check if the apparent bare-repository is a $GIT_DIR
> of a secondary worktree, by checking three things:
>
>  * The path to the $GIT_DIR must be a subdirectory of
>    ".git/worktrees/", which is the primary worktree [*].
>
>  * Such $GIT_DIR must have file "gitdir", that records the path of
>    the ".git" file that is at the root level of the secondary
>    worktree.
>
>  * That ".git" file in turn points back at the $GIT_DIR we are
>    inspecting.
>
> The latter two points are merely for checking sanity.  The security
> lies in the first requirement.
>
> Remember that a tree object with an entry whose pathname component
> is ".git" is forbidden at various levels (fsck, object transfer and
> checkout), so malicious projects cannot cause users to clone and
> checkout a crafted ".git" directory in a shell directory that
> pretends to be a working tree with that ".git" thing at its root
> level.  That is where 45bb9162 (setup: allow cwd=.git w/
> bareRepository=explicit, 2024-01-20) draws its security guarantee
> from.  And the solution for secondary worktrees in this commit draws
> its security guarantee from the same place.

I wrote the "[*]" mark but forgot to add a footnote with an
additional information for it.  Something like this was what I had
in mind to write there:

[Footnote]

 * This does not help folks who create a new worktree out of a bare
   repository, because in their set-up, there won't be "/.git/" in
   front of "worktrees" directory.  It is fundamentally impossible
   to lift this limitation, as long as safe.bareRepository is
   considered to be a meaningful security measure.  The security of
   both the loosening for a secondary worktree's GIT_DIR as well as
   the loosening for the GIT_DIR of the primary worktree, hinge on
   the fact that ".git/" directory is impossible to create as
   payload to be cloned.
