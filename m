Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBF71482ED
	for <git@vger.kernel.org>; Tue, 21 May 2024 17:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716313832; cv=none; b=uiR8LDKhWy7UzX5fkiXunZp9I2QVU2zsTwHNU+NclmKDs/JH6qmFHJiTgJAQ6ndgf6NwQgFyWkt/c2KR1Nc6awl+JXakyDuGo1UW22d6mjJBsPSUp/xmbuRyIN8HPXfndD1u3kDsaaQKllfqZzNy57+fM2ugN2NFuIKR6Obsw4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716313832; c=relaxed/simple;
	bh=FTIBOjwQnQnW2HUZEQzAro5lfs8168gS4UsjmjYJu1c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BVNRXhvwZwrWfx4kQuiikPc9tZb6hHM1di4EQaxSO3Qi9cIhc0XU9gzyJk1yC7f5ujdoHE/lJNW94LpDNLtAbFs8r1fQudZs/+7spE0q1He6+DeIxAITU3zxxkmUUi9BTr37mc9ofsycLUuaf/9PjYupDCwHhfvt3u1WNtxmJLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=g2g3VoaV; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="g2g3VoaV"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 143FF3057C;
	Tue, 21 May 2024 13:50:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=FTIBOjwQnQnW2HUZEQzAro5lfs8168gS4Usjmj
	YJu1c=; b=g2g3VoaVjTz7A7Y2auYh2DJadiejUvOjMxy+tb/KSNSaTpY1q8QEJ/
	WIT+LkYt22NXpYq7Abi8ovfuwmkrW6LJTvFB+J3ERWMdtJVzoWjKexNpFdVsC08q
	JHoGr5ePzUXeBsjswOL8fTZ1+T8u9t7+C1u2z2IGnLxI8cvjNo4Zs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0C4E93057B;
	Tue, 21 May 2024 13:50:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 721173057A;
	Tue, 21 May 2024 13:50:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: tboegi@web.de
Cc: git@vger.kernel.org,  takimoto-j@kba.biglobe.ne.jp
Subject: Re: [PATCH v3 1/1] macOS: ls-files path fails if path of workdir is
 NFD
In-Reply-To: <20240521141452.26210-1-tboegi@web.de> (tboegi@web.de's message
	of "Tue, 21 May 2024 16:14:52 +0200")
References: <20240430032717281.IXLP.121462.mail.biglobe.ne.jp@biglobe.ne.jp>
	<20240521141452.26210-1-tboegi@web.de>
Date: Tue, 21 May 2024 10:50:25 -0700
Message-ID: <xmqqttir9hr2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9B02A632-179A-11EF-A3A0-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

tboegi@web.de writes:

> Add a missing call to precompose_string_if_needed() to this code
> in setup.c :
> `work_tree = precompose_string_if_needed(get_git_work_tree());`

This is new in this iteration, I presume?  The old one did the
precompose only in strbuf_getcwd().  We now precompose also the
result of get_git_work_tree().

Two questions.

 * It is unclear to me why this makes a difference only when the
   precompuse configuration is set only in the local configuration.

 * As the leading part of the value placed in get_git_work_tree()
   comes from strbuf_getcwd() called by abspath.c:real_pathdup()
   that is called by repository.c:repo_set_worktree(), doesn't this
   potentially call precompse twice on the already precomposed early
   parth of the get_git_work_tree() result?

I suspect that with the arrangement in your test, the argument given
to set_git_work_tree() from setup.c:setup_discovered_git_dir() is
always ".", and that dot is passed to repository.c:repo_set_worktree()
which calls abspath.c:real_pathdup() to turn it into an absolute,
where it has a call to strbuf_getcwd().

So with the provided test, I suspect there is no difference between
the previous and this iteration in behaviour, as what is fed to
precompose should be identical?

What this iteration does differently is that inside real_pathdup(),
if the string given to repo_set_worktree() is more than the trivial
".", it is appended to the result of strbuf_getcwd(), and the new
code precomposes after such appending in real_pathdup() happens.  It
will convert the leading part twice [*] and more importantly the
appended part is now converted, unlike the previous one?

	Side note: [*] hopefully precompose is idempotent?  Relying
	on that property somewhat feels yucky, though.

Puzzled...

Will replace and queue, but I couldn't figure out what is going on
with the help by the proposed log message, so...

Thanks.

