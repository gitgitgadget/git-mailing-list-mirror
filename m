Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F016F2F2
	for <git@vger.kernel.org>; Mon, 23 Sep 2024 21:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727126565; cv=none; b=LPrWDfky6AsMh+bpC3p3T9zNRn/AI1zfcgfTOEOwI3KJBDXq2PicQvEBAg0E6OhjrmtCsOnvJ3QAloFGWFVjd69ythR32VWzerzBajZP+adeRTP7nUaOj5zhkYuS5BLOSuUV4zBOQANB1IWcrJO71yCutwiFP5t2WnrNyjDHUP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727126565; c=relaxed/simple;
	bh=JbOY9bF7aleNO0nkAnpB3SS8y+6DEpFn/PSYJSUtNho=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Tj79Y6NzdMPgpGXxDSqO8gsAO/vObPXTgTEYuprSqTWpS9EM4Sh3vma+TPQmaYK0wio1S9hBs2argIj7C4d2rzHyoSGmP0MaspLhVkKnHiTBgDhDCouJItLxXOv+aHvzxnsQgDzAtoU16U4nv3qu1+11PuxeDWQfc4t9H53ts04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=sS69wjAk; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="sS69wjAk"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 660042B146;
	Mon, 23 Sep 2024 17:22:42 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=JbOY9bF7aleNO0nkAnpB3SS8y+6DEpFn/PSYJS
	UtNho=; b=sS69wjAkUaCVlZXXv2ur9fiw+05BUr9AwEMXKi2iHzOR3jYNI9TPkJ
	e/im37BsLkrVblIo5AOl/FpTuWw+yCUVN7lziGQrDxY847xW3uV7x+A/+pcFQJwR
	Bvnp2X/VDqwLudPlhhtIAZb2xx1BAxLBVwUAuNyahlRbZjli73itI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5DCA72B145;
	Mon, 23 Sep 2024 17:22:42 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B613F2B144;
	Mon, 23 Sep 2024 17:22:41 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <ericsunshine@charter.net>
Cc: git@vger.kernel.org,  Russell Stuart
 <russell+git.vger.kernel.org@stuart.id.au>,  Eric Sunshine
 <sunshine@sunshineco.com>
Subject: Re: [PATCH] worktree: repair copied repository and linked worktrees
In-Reply-To: <20240923075416.54289-1-ericsunshine@charter.net> (Eric
	Sunshine's message of "Mon, 23 Sep 2024 03:54:16 -0400")
References: <20240923075416.54289-1-ericsunshine@charter.net>
Date: Mon, 23 Sep 2024 14:22:39 -0700
Message-ID: <xmqqh6a6xdy8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F776F4AE-79F1-11EF-9DC4-9B0F950A682E-77302942!pb-smtp2.pobox.com

Eric Sunshine <ericsunshine@charter.net> writes:

> Fix this problem by also checking if a plausible .git/worktrees/<id>
> exists in the *current* repository -- not just in the repository pointed
> at by the worktree's .git file -- and comparing whether they are the
> same. If not, then it is likely because the repository / main-worktree
> and linked worktrees were copied, so prefer the discovered plausible
> pointer rather than the one from the existing .git file.

In other words, before futzing with a repository to point at a
(potentially moved) worktree that points back to it, make sure that
the repository is in a corrupt state---if one of the worktrees we
know correctly points back to us already, that pointer should not be
mucked with, or we would end up spreading the damage further?

It does make sense.

> -If both the main worktree and linked worktrees have been moved manually,
> +If both the main worktree and linked worktrees have been moved or copied manually,
>  then running `repair` in the main worktree and specifying the new `<path>`
>  of each linked worktree will reestablish all connections in both
>  directions.

OK.

> diff --git a/worktree.c b/worktree.c
> index 30a947426e..7d1b60ff9f 100644
> --- a/worktree.c
> +++ b/worktree.c
> @@ -683,6 +683,7 @@ void repair_worktree_at_path(const char *path,
>  	struct strbuf gitdir = STRBUF_INIT;
>  	struct strbuf olddotgit = STRBUF_INIT;
>  	char *backlink = NULL;
> +	/*
> +	 * If we got this far, either the worktree's .git file pointed at a
> +	 * valid repository (i.e. read_gitfile_gently() returned success) or
> +	 * the .git file did not point at a repository but we were able to
> +	 * infer a suitable new value for the .git file by locating a
> +	 * .git/worktrees/<id> in *this* repository corresponding to the <id>
> +	 * recorded in the worktree's .git file.
> +	 *
> +	 * However, if, at this point, inferred_backlink is non-NULL (i.e. we
> +	 * found a suitable .git/worktrees/<id> in *this* repository) *and* the
> +	 * worktree's .git file points at a valid repository *and* those two
> +	 * paths differ, then that indicates that the user probably *copied*
> +	 * the main and linked worktrees to a new location as a unit rather
> +	 * than *moving* them. Thus, the copied worktree's .git file actually
> +	 * points at the .git/worktrees/<id> in the *original* repository, not
> +	 * in the "copy" repository. In this case, point the "copy" worktree's
> +	 * .git file at the "copy" repository.
> +	 */

Tricky, but cannot be avoided in order to help those who "copy".

> diff --git a/t/t2406-worktree-repair.sh b/t/t2406-worktree-repair.sh
> index edbf502ec5..7686e60f6a 100755
> --- a/t/t2406-worktree-repair.sh
> +++ b/t/t2406-worktree-repair.sh
> @@ -197,4 +197,23 @@ test_expect_success 'repair moved main and linked worktrees' '
>  	test_cmp expect-gitfile sidemoved/.git
>  '
>  
> +test_expect_success 'repair copied main and linked worktrees' '
> +	test_when_finished "rm -rf orig dup" &&
> +	mkdir -p orig &&
> +	git -C orig init main &&
> +	test_commit -C orig/main nothing &&
> +	git -C orig/main worktree add ../linked &&
> +	cp orig/main/.git/worktrees/linked/gitdir orig/main.expect &&
> +	cp orig/linked/.git orig/linked.expect &&
> +	cp -R orig dup &&
> +	sed "s,orig/linked/\.git$,dup/linked/.git," orig/main.expect >dup/main.expect &&
> +	sed "s,orig/main/\.git/worktrees/linked$,dup/main/.git/worktrees/linked," \
> +		orig/linked.expect >dup/linked.expect &&
> +	git -C dup/main worktree repair ../linked &&
> +	test_cmp orig/main.expect orig/main/.git/worktrees/linked/gitdir &&
> +	test_cmp orig/linked.expect orig/linked/.git &&
> +	test_cmp dup/main.expect dup/main/.git/worktrees/linked/gitdir &&
> +	test_cmp dup/linked.expect dup/linked/.git
> +'
> +
>  test_done
