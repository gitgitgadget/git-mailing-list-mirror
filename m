Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6762941B
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 17:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727200729; cv=none; b=MR7D7r6Vax8Cpk/ppNhy/v6cXMdt+GjvAR/3q1er/7ACK/ngrG7kdzoTP/G9duX/+Wm6XZdu8zNp3IXdoyycMxJGJARey91jopZPPuo36ilggPpB8D/15sfku3m3mFdNSjadYuiz+g5MWiuSkDs+2n5FhymB2VRRWPP0H0dgewg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727200729; c=relaxed/simple;
	bh=K+roAEaJN6XwgrXao7nGdp0bs+tjY6Rc02dgiFbCkdA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rb2xqGFHhtsCfzXYu1hML4KVF7enJd4Srqty7W0weSrnKo/xZNlH17UfbV2D4bekbipVavQfPM6E5PtGp/WeG53U/doHQJyV8cbNSlTGf8XZfzsUgOmTHmj1VaexMabdHOsnL3S6Txb0lRcdmWh2jzTdGI4oFAlL0E2xlsgk7OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=uuvGDZdT; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uuvGDZdT"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 83C131B046;
	Tue, 24 Sep 2024 13:58:46 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=K+roAEaJN6XwgrXao7nGdp0bs+tjY6Rc02dgiF
	bCkdA=; b=uuvGDZdTZtClFmLs633C8G4xU+00AD9tFuCQJJXTqbtrEMupxauP/I
	5un9tYo0mpAwdC2CSNAE/EPoyN0aynsMcRfiWudRHUWCIU3zIaMceGKsJsA9hIHH
	Y0t4VjWEOMR69dwDxzdh3tSqNCKjur5APgnJyu72gXBmytQT+OSWg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7A8AC1B045;
	Tue, 24 Sep 2024 13:58:46 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DD0621B044;
	Tue, 24 Sep 2024 13:58:45 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 1/4] git: pass in repo for RUN_SETUP_GENTLY
In-Reply-To: <eceb2d835be7168081d6eeffbce57bba89b5f423.1727185364.git.gitgitgadget@gmail.com>
	(John Cai via GitGitGadget's message of "Tue, 24 Sep 2024 13:42:41
	+0000")
References: <pull.1788.git.git.1727185364.gitgitgadget@gmail.com>
	<eceb2d835be7168081d6eeffbce57bba89b5f423.1727185364.git.gitgitgadget@gmail.com>
Date: Tue, 24 Sep 2024 10:58:44 -0700
Message-ID: <xmqqjzf1szl7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A4BFBF22-7A9E-11EF-89A5-9B0F950A682E-77302942!pb-smtp2.pobox.com

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: John Cai <johncai86@gmail.com>
>
> commands that have RUN_SETUP_GENTLY potentially need a repository.
> Modify the logic in run_builtin() to pass the repository to the builtin
> if a builtin has the RUN_SETUP_GENTLY property.

Ah, I remember mentioning this as a potiential future direction
while reviewing the other series that added the repository argument
to the cmd_foo() interface.

Nice to see the idea getting followed up.

Let's see how [Patches 2-4/4] can make effective use of this.

> Signed-off-by: John Cai <johncai86@gmail.com>
> ---
>  git.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/git.c b/git.c
> index 2fbea24ec92..e31b52dcc50 100644
> --- a/git.c
> +++ b/git.c
> @@ -480,7 +480,10 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv, struct
>  	trace2_cmd_name(p->cmd);
>  
>  	validate_cache_entries(repo->index);
> -	status = p->fn(argc, argv, prefix, (p->option & RUN_SETUP)? repo : NULL);
> +	status = p->fn(argc,
> +		       argv,
> +		       prefix,
> +		       ((p->option & RUN_SETUP) || (p->option & RUN_SETUP_GENTLY))? repo : NULL);
>  	validate_cache_entries(repo->index);
>  
>  	if (status)
