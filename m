Received: from mail-106113.protonmail.ch (mail-106113.protonmail.ch [79.135.106.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1EC393DE3
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 08:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780561042; cv=none; b=JPemGlmQDJvYDK68JBbommwFHTmgGIwkjleTxMN5VCN60wTH77wwkf0bjvy6l6Lu+jHKQHbvA9LiV5STq6xZMsSSDmZdAAR2BJCK8lX8TwCK+bocPsA9iWDE6QTsQOuPC/FWRbpKd5m09LPFVPiMPE+jBf1iwb1jXqRtpWfTKM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780561042; c=relaxed/simple;
	bh=trgLJePvvu+rkebMk8i/K4eeE1eDlLX3ddJnJ1ZDjoA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WmHMIvEH1ABz134l/Xqe6QjCzt68zf4W9HGEXkqXMhr3GL4pxls3fa1y397CjGdVfoDd6NWKQqvUrBE8e0rP5Guh2mtft+yPeTPcNpwoVuDoQSwZFMFbDnCYM+SYqAHT06egqvUSZtkcOW5JDnrbBACJImDXqg2RpASK25xKDBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rasmusvillemoes.dk; spf=pass smtp.mailfrom=rasmusvillemoes.dk; dkim=pass (2048-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b=PSIRT3M3; arc=none smtp.client-ip=79.135.106.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="PSIRT3M3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rasmusvillemoes.dk;
	s=protonmail; t=1780561029; x=1780820229;
	bh=trgLJePvvu+rkebMk8i/K4eeE1eDlLX3ddJnJ1ZDjoA=;
	h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=PSIRT3M3H3AowBJ7+VSlF5R4Awl7XXY2GA112REsbx8dSZOYOzCeD0BKn7EyCOHz2
	 +Ucv2Bf1mZNDo5UOebmxaEXSfIrHPKZ+CLLcPGz8m7+RkDriYxn7AfXt4pJcey82Ki
	 ke/JkhyS+hFSDUBkprXpVuyfDNwibbWdL3h4eh6TDq+QmmXCjUf8hoojELbpKlPYHD
	 SrZydvbZSh1x996mboEK/3MWGydtGWjX5CDIK5r6a0uSpqRZfbbSXA0gDfqBEK36Wm
	 5iTLN66GSk4u7xU+BfbK9cXba2ffZ1iEsHoMLKsjBmh2beYpxl54b6eAjLjb/iTHrc
	 5pf80wTZDGlCQ==
X-Pm-Submission-Id: 4gWHVD0Jr7z2ScPL
From: Rasmus Villemoes <rv@rasmusvillemoes.dk>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: git history feedback
Date: Thu, 04 Jun 2026 10:17:07 +0200
Message-ID: <87ecimhg8s.fsf@rasmusvillemoes.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi

As soon as I saw the announcement of 'git history', I knew that was
something I was gonna use a lot. Especially the split functionality has
always been somewhat of a hassle (at least for me) to do via an
interactive rebase. I've played around with it a little, and it seems to
work as it says on the tin.

So today I had occasion to put it to real use, and then I found two
things I'd like to be able to do with it:

When a commit needs to be split into three or more commits, it is a
little cumbersome to do iteratively, since the new commit to split
obviously has a new sha, so one first has to figure out what that new id
is and then do another "git history split". For higher values of "three"
that becomes rather tedious. So it would be nice if there was an
iterative mode, which after splitting off the first commit would
automatically start again with the new child commit.

If "git add -p" had an answer meaning "yes to this hunk and all
following in this file and all remaining files as well", this could
probably even be the default behaviour of "git history split", as it
would just require that one extra answer to be given after the first
commit is split off in order to keep the current behaviour. Otherwise,
I'd also be happy to have "git history iter-split" or "git history split
--iter" or any other spelling.

The other thing I'd like is a sort of ultimate version of the above:
What I needed in the concrete case at hand was actually to split two
commit into n individual hunks each, then do an interactive rebase to combine
those 2n commits to n commits (I had done changes "row-wise", but needed
to change them to "column-wise"). For that, I would like to have had a
completely automatic "git history atomize" that would split a commit
into individual hunks, prefixing the commit subject with
e.g. "[<filename> -- hunk #nn]". A subsequent 'git rebase -i' could then easily
rearrange those and squash the related hunks.

Aside: are experimental commands eligible for teaching the completion
logic about them? I.e., can we add a __git_history() to
git-completion.bash? Aside from the obvious "let it know about existing
subcommands", I'd love for "git history split <TAB>" to show the most
recent ~20 (or something) commits in one-line format, stopping if
there's a merge commit.

Thanks,
Rasmus
