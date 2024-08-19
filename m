Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97AD28F3
	for <git@vger.kernel.org>; Mon, 19 Aug 2024 19:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724097151; cv=none; b=oKJEOrd+v/8iHQKkxQyAAfm88cHqaJ6mYutXdPNlOJHGJxnjrh2UXO0/QVOMAtO/suS3qmvj5qrP1AHlcbjcbnv2lpuyz65gBdD93t+mtbaSc32dWeF5GrCVdoiwI8NCleSdv6r1HiVPrvRnO2hk/1tMAJ5UUFFzxD04lb3iiDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724097151; c=relaxed/simple;
	bh=UqX7x8LlZUkkKJGugonnnuVITwt70bejzRbGKfcwjqA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XR6rrL99nsigL0sHhG05+zvTxZ3VHX63XtL99QjgrMwyUMo0SunSJAyqCN50uy9V+jkB/ai3wAHwRbbv4913uT1NjQ2wGFEGYqiHa67Q+/yXBcPo7yS21NtrJvusbhaVO54lHeykbZ/IH0haiHYfniPJTIgDsZr0jqtk5Adi9Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=B6NqYXsg; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="B6NqYXsg"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7EAB9233EA;
	Mon, 19 Aug 2024 15:52:28 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=UqX7x8LlZUkkKJGugonnnuVITwt70bejzRbGKf
	cwjqA=; b=B6NqYXsgk3nxed6cdK4Lrzugmn2YHeMwYT7LikPb7ydG5DipGgtB8v
	jgblGFW+Sx/R7MX0k53NIh7OSAuEWYw12xwxkgmY4aG/Iy0veJHy07hPEe+3ztUK
	DvEspMbb7j8OYsduksZ4Dq1VTznDq2EyO6gzuqB1Dj05xVCmxqIVE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 76BB1233E9;
	Mon, 19 Aug 2024 15:52:28 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E133C233E8;
	Mon, 19 Aug 2024 15:52:27 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  vdye@github.com,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 0/4] git for-each-ref: is-base atom and base branches
In-Reply-To: <pull.1768.v3.git.1723631490.gitgitgadget@gmail.com> (Derrick
	Stolee via GitGitGadget's message of "Wed, 14 Aug 2024 10:31:26
	+0000")
References: <pull.1768.v2.git.1723397687.gitgitgadget@gmail.com>
	<pull.1768.v3.git.1723631490.gitgitgadget@gmail.com>
Date: Mon, 19 Aug 2024 12:52:26 -0700
Message-ID: <xmqqed6ke1dx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 901DEF72-5E64-11EF-AB8D-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> There are benefits to users both on client-side and server-side. In an
> internal monorepo, this base branch detection algorithm is used to determine
> a long-lived branch based on the HEAD commit, mapping to a group within the
> organizational structure of the repository, which determines a set of
> projects that the user will likely need to build; this leads to
> automatically selecting an initial sparse-checkout definition based on the
> build dependencies required. An upcoming feature in Azure Repos will use
> this algorithm to automatically create a pull request against the correct
> target branch, reducing user pain from needing to select a different branch
> after a large commit diff is rendered against the default branch. This atom
> unlocks that ability for Git hosting services that use Git in their backend.

Thanks for an update.  This iteration looks good to me.

