Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DC3481C0
	for <git@vger.kernel.org>; Fri, 13 Sep 2024 17:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726248318; cv=none; b=SRKi7XECXQzqbnxNf1LpMf/ObG1aJUtZm1Gfm42yhiN15eS+Avpgb/0oWaTgIKTJHo2/0F6BM/5vV55pn+Ar5ObQs6W6AJF6VmJxy5vLfYDt38NkmQxvVXzx/B3+wqzhq+baDNSEsIAh31tXn64WOGnHqwFYi0p9XuYfnqdSdbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726248318; c=relaxed/simple;
	bh=rwcbcBd2v1rJGAZV11HRvWs+56cHCWQy9NDFprGyphw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TUgDUyPL54Joqzilbnb4Il9M5YzVd+NHnIapJ1BaXsYgathksvwcUK6iLfaPh3a+4sjlKB+zHbV4d/ow0LjK5Qvt/FoKGp8CY49W6r5MynPayD/X2A/2M1zMKwH9Y4Md/M0RKDrj28WzWt1zcT26vNz70CibSrH2H5l3PviI9aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=LtIm1ig/; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LtIm1ig/"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9DE4B1FE88;
	Fri, 13 Sep 2024 13:23:29 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=rwcbcBd2v1rJGAZV11HRvWs+56cHCWQy9NDFpr
	Gyphw=; b=LtIm1ig/S8DzW8vSMh+Ux1DLJEQLT0bb7/uaxlxn1hQ+/mRu+K2v8W
	o3YkPfff3DeaNP0MZmAIDy2v1rDujtaiydHNuMeN90ShehwWJbAmjdpfrLy0CTG5
	nn/6srCmWFnETx4SeYHkgNzz/FkPrZqJ3UC8VQgmsi3FtTMZX4PSA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 964C81FE87;
	Fri, 13 Sep 2024 13:23:29 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0D9D91FE86;
	Fri, 13 Sep 2024 13:23:28 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/2] Simplify "commented" API functions
In-Reply-To: <ZuPYZW3jYas4kJzC@pks.im> (Patrick Steinhardt's message of "Fri,
	13 Sep 2024 08:15:01 +0200")
References: <20240912205301.1809355-1-gitster@pobox.com>
	<ZuPYZW3jYas4kJzC@pks.im>
Date: Fri, 13 Sep 2024 10:23:27 -0700
Message-ID: <xmqqjzffzcvk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E476638A-71F4-11EF-AB31-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> I'm not quite sure I agree. The comment strings we have are in theory
> broken, because they can be configured differently per repository. So if
> you happen to have a Git command that operates on multiple repositories
> at once and that needs to pay attention to that config then it would now
> use the same comment character for both repositories, which I'd argue is
> the wrong thing to do.

Correct.  It needs a move from global to a member in a repository
instance, but the same "hey do not keep passing the same parameter"
motivation behind these patches applies, as the existing call sites
most likely will instead pass "the_repository->comment_line_str" to
these two functions.  The simplification would move that reference
to "the_repository->comment_line_str" down to these two functions.

> The recent patch series that makes "environment.c" aware of
> `USE_THE_REPOSITORY_VARIABLE` already converted some of the global
> config variables to be per-repository, because ultimately all of them
> are broken in the described way. So from my point of view we should aim
> to convert remaining ones to be per-repository, as well.

Yes, I view the environement change somewhat incomplete and it was
annoying to see things other than the_repository itself and those
that implicitly refer to the_repository covered by the CPP macro.

But we need to step back a bit in order to make the environment
change better.  Not everything works inside a repository and you may
not even have a repository but want to refer to a comment character
(say, "git bugreport" run outside a repository, perhaps, and the
bugreport may want to honor end-user configuration for commentChar
to mark its various sections).  Earlier I said it may make sense to
reimplement the global as a member of a repository instance, but
that is not entirely true.  Such a member in a repository struct may
be a good implementation detail for anybody who asks "what comment
character should I be using in the context I am called?", and there
may be "const char *get_comment_line_str(struct repository *)" that
accepts which repository to work with, but such a function would
need to be prepared to work without any repository, working out of
the system and per-user configuration files.

>   - It depends on a repository, but I'd argue it shouldn't such that we
>     can also query configuration in repo-less settings.
>
>   - `prepare_repo_settings()` makes up for a bad calling convention. I
>     think that lazy accessors are way easier to use.
>
> But it is a start, and something we can continue to build on.

Yup.
