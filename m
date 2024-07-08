Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CB61CA89
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 19:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720465393; cv=none; b=hqlLJO0vBwWzo0d8vgEeRZy8VkdSorZYi+vINGBwyyssKn6+Q+L77EqxTQ865xXjDH9JRcR6ffvOh5lORw0zzM67DlgOGJ4ZOgHw20Xx4lVoXtO50gqrhzUwVNEh6voBh3ZN9rpZHYucdNN5WbLs4gl8MNkVVQtD5rUv8qQ9R54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720465393; c=relaxed/simple;
	bh=YazqikYg7bkoKKB47AOZhijPxLfRu2GwngMxKAUKi6o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jhXziGdg32I7u24D2eB7UdUSMCU7SIWkbDraUte/owVhi2v/JyvZvaeliQG54ponEHEVsseGwddt1HuysFLhTOlwZKNrO0pfBFcRm4P03y0YK8ryvlByOpNi6XL4wZIvKIMLlGZ3t2VUsLb62yhhJJCaHROJ+7FT2I8XnCnAc3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=mfH8AMM3; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mfH8AMM3"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id CED96359B1;
	Mon,  8 Jul 2024 15:03:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=YazqikYg7bkoKKB47AOZhijPxLfRu2GwngMxKA
	UKi6o=; b=mfH8AMM3nLEeZpQlm7+fJrs4padFyeUGZMZ8+01IDVCPdO6OvQAivh
	AGzDj2M8Nzy5QodazZx9RwlO7DbzFn7UeTyvYzWKQBuYWXfcC12WOiLS5ShtvxlV
	M1FdIrtDCvmTZeN36K5Xx8HHt6gwMSPTKa8gveN9B9ft5apQMLn9Q=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id BDA44359B0;
	Mon,  8 Jul 2024 15:03:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1A0A7359AF;
	Mon,  8 Jul 2024 15:03:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] var(win32): do report the GIT_SHELL_PATH that is
 actually used
In-Reply-To: <pull.1760.git.1720443778074.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Mon, 08 Jul 2024 13:02:57
	+0000")
References: <pull.1760.git.1720443778074.gitgitgadget@gmail.com>
Date: Mon, 08 Jul 2024 12:03:06 -0700
Message-ID: <xmqq7cdvg105.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B694147A-3D5C-11EF-B2A5-C38742FD603B-77302942!pb-smtp20.pobox.com

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> diff --git a/builtin/var.c b/builtin/var.c
> index 5dc384810c0..f4b1f34e403 100644
> --- a/builtin/var.c
> +++ b/builtin/var.c
> @@ -51,7 +51,13 @@ static char *default_branch(int ident_flag UNUSED)
>  
>  static char *shell_path(int ident_flag UNUSED)
>  {
> +#ifdef WIN32
> +	char *p = locate_in_PATH("sh");
> +	convert_slashes(p);
> +	return p;
> +#else
>  	return xstrdup(SHELL_PATH);
> +#endif
>  }

We have done well without any ugly conditional compilation in this
file so far.  If we needed to report dynamic path on certain
platforms, we'd need something a bit cleaner, like

 * rename "shell_path()" to something that is unlikely to conflict
   with others (e.g., "git_shell_path()") and make it extern

 * allow it to be overridden from compat/

which is often how we hide such an implementation quirk from the
general code paths.

>  static char *git_attr_val_system(int ident_flag UNUSED)
> diff --git a/t/t0007-git-var.sh b/t/t0007-git-var.sh
> index ff4fd9348cc..9fc58823873 100755
> --- a/t/t0007-git-var.sh
> +++ b/t/t0007-git-var.sh
> @@ -157,7 +157,7 @@ test_expect_success POSIXPERM 'GIT_SHELL_PATH points to a valid executable' '
>  test_expect_success MINGW 'GIT_SHELL_PATH points to a suitable shell' '
>  	shellpath=$(git var GIT_SHELL_PATH) &&
>  	case "$shellpath" in
> -	*sh) ;;
> +	[A-Z]:/*/sh.exe) test -f "$shellpath";;
>  	*) return 1;;
>  	esac
>  '
>
> base-commit: 06e570c0dfb2a2deb64d217db78e2ec21672f558
