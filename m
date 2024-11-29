Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch [79.135.106.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CEB6026A
	for <git@vger.kernel.org>; Fri, 29 Nov 2024 02:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732848586; cv=none; b=Hq1JvXa7hVG7UbxaAhavA+gep5yOmaz88PlCCrZ5/8pLUDE3d0kkJDz8zIgtAK0qEQ0ss2vR82uB+5ahlSZzwx10REkDwZ/nEPp1vKv0Wrcfv8RltfwxRiWEWl5OTTZnXnO40XpCAVYYNKlQbDUyQukJwIHU+Nom7ixPgOVwcrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732848586; c=relaxed/simple;
	bh=sGLv7YpZYRvrMWdUKnmu1aloHgwFFjdI7rsrNNum9mU=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Brwga+IyIMZOCvYhkcxxRh7s6XP9M7dmJnTW3mXgN3rB4AK8McMqRcWn3bHiKOFVHxlIQ5ptcKTykAD/h5Cdt4Oamduv9NfdyYYIbuunGNDYmSP7ZC+oN9Tzc4MDB23CZmlQSgay/8gS+s2FJm0++6d/PAtOfpBqHLsnIiOSA+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=TfOzm9Cn; arc=none smtp.client-ip=79.135.106.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="TfOzm9Cn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1732848576; x=1733107776;
	bh=EpRVCpbRAbe9RmenKgAxl9u8CgmyWZ85F9CluLAClbw=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=TfOzm9CnUizSjOeuM4RLMRZwhq4JqbtWJl1nuk+3UVisLyWkEGRbDGifltu4qES7Z
	 uSsC+JaqQLMJbngToaR+aYfGkyztVoJjbwIZ3uN1E/gQ6CcuTKzm5Jr0j9lxOOoSnd
	 bdM2VFEnJr8AILw3kqXwB6yVSwVD9ORNPPCLhDK/oDqZMNprBulvCKbi+1lyTo8e3J
	 w+sUCh4/kFTCQgSwjWdAnnwc7WKETZwKRgPDsQBoWatULOqEzx3n5C5+MT2n47Junu
	 Wz+TA/F7+7PbNIVKYIhWZoUqh7Zt+bHmq/jTZOm671a1FSRxcYjW/9tm7/1VmHfjRa
	 0PoFo0CXX1w7A==
Date: Fri, 29 Nov 2024 02:49:32 +0000
To: Caleb White <cdwhite3@pm.me>, git@vger.kernel.org
From: Caleb White <cdwhite3@pm.me>
Subject: Re: [PATCH 0/2] Ensure unique worktree ids across repositories
Message-ID: <D5YBJRUXYLUR.8TB0DXCJ6654@pm.me>
In-Reply-To: <20241128-wt_unique_ids-v1-0-30345d010e43@pm.me>
References: <20241128-wt_unique_ids-v1-0-30345d010e43@pm.me>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: ee99c1c83103fff1ba1f37e2493204b81762ba88
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu Nov 28, 2024 at 8:44 PM CST, Caleb White wrote:
> The `es/worktree-repair-copied` topic added support for repairing a
> worktree from a copy scenario. I noted[1,2] that the topic added the
> ability for a repository to "take over" a worktree from another
> repository if the worktree_id matched a worktree inside the current
> repository which can happen if two repositories use the same worktree nam=
e.
>
> This series teaches Git to create worktrees with a unique suffix so
> that the worktree_id is unique across all repositories even if they have
> the same name. For example creating a worktree `develop` would look like:
>
>     foo/
>     =E2=94=9C=E2=94=80=E2=94=80 .git/worktrees/develop-5445874156/
>     =E2=94=94=E2=94=80=E2=94=80 develop/
>     bar/
>     =E2=94=9C=E2=94=80=E2=94=80 .git/worktrees/develop-1549518426/
>     =E2=94=94=E2=94=80=E2=94=80 develop/
>
> The actual worktree directory name is still `develop`, but the
> worktree_id is unique and prevents the "take over" scenario. The suffix
> is given by the `git_rand()` function, but I'm open to suggestions if
> there's a better random or hashing function to use.
>
> [1]: https://lore.kernel.org/git/20241008153035.71178-1-cdwhite3@pm.me/
> [2]: https://lore.kernel.org/git/r4zmcET41Skr_FMop47AKd7cms9E8bKPSvHuAUpn=
YavzKEY6JybJta0_7GfuYB0q-gD-XNcvh5VDTfiT3qthGKjqhS1sbT4M2lUABynOz2Q=3D@pm.m=
e/

I forgot to mention, but the base for this series is obtained by merging
the `cw/worktree-extension` topic (2024-11-26, 20241125-wt_relative_options=
-v5-0-356d122ff3db@pm.me)
onto 090d24e9af.

Best,

Caleb

