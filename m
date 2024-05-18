Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D8F624
	for <git@vger.kernel.org>; Sat, 18 May 2024 00:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715991650; cv=none; b=lNWny0rlt3o3ZhFIda3mCIPbr0SdFBJDevwaUgfMHdkAFEoTgV9BXevdnm8AsK0xS4QFQHVeC2FaiUz5MIyAiN6wAnEhxrEkwE5m7hhUVH4kQUr33ce0lNExYURxJ6SxjdUdjA9qM4xSdQNE2wBGJ90/ANmukfUk8T4DqJ4rmjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715991650; c=relaxed/simple;
	bh=lX7jNCbnZnzh30DLyLl4BdbdBYcml7Kkv5ba2EL4Ns0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gpwxRXLD9+7EMvxbPta9/Ow2wKg9ABYa/4zVIWLqVDUumpXaSLx/U8Gmq1U3BSxlrAJkQsAGVn3ZsgW9QuMyJwknBU9whXBoopLVCXuaByFr9oty9r+o02e/DkOfMsdKt/MA+xHHQZS5pbAxZt5KfhQjP2ldUgKBnpfY+JS0Ugo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=c89117Oh; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="c89117Oh"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id B3D4432506;
	Fri, 17 May 2024 20:20:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=lX7jNCbnZnzh30DLyLl4BdbdBYcml7Kkv5ba2E
	L4Ns0=; b=c89117Oh/YUvj1opfm4/u5c4niQ40i1Rs/9/cW3UgwHAuwsX/bd1K7
	MMsNfd1XdNMHVahb5ODR9hpqp4YiH6uTLEc90/1JayYqXKom2OG9CUdtDJOcvsAv
	/YhZO0BFT+P4j4VyR2zKCzvJfn5C1zVTXu3lBmo5dzA2vMpmSV/G8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id AC12C32505;
	Fri, 17 May 2024 20:20:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3A1BF32504;
	Fri, 17 May 2024 20:20:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 6/8] hooks(clone protections): special-case current Git
 LFS hooks
In-Reply-To: <98465797e72cf039ace4138ab1e03e4fc7465ea2.1715987756.git.gitgitgadget@gmail.com>
	(Johannes Schindelin via GitGitGadget's message of "Fri, 17 May 2024
	23:15:54 +0000")
References: <pull.1732.git.1715987756.gitgitgadget@gmail.com>
	<98465797e72cf039ace4138ab1e03e4fc7465ea2.1715987756.git.gitgitgadget@gmail.com>
Date: Fri, 17 May 2024 17:20:43 -0700
Message-ID: <xmqqwmnsc6n8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 78088192-14AC-11EF-913B-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> +	/* Hard-code known-safe values for Git LFS v3.4.0..v3.5.1 */
> +	if ((!strcmp("pre-push", name) &&
> +	     !strcmp(sha256, "df5417b2daa3aa144c19681d1e997df7ebfe144fb7e3e05138bd80ae998008e4")) ||
> +	    (!strcmp("post-checkout", name) &&
> +	     !strcmp(sha256, "791471b4ff472aab844a4fceaa48bbb0a12193616f971e8e940625498b4938a6")) ||
> +	    (!strcmp("post-commit", name) &&
> +	     !strcmp(sha256, "21e961572bb3f43a5f2fbafc1cc764d86046cc2e5f0bbecebfe9684a0b73b664")) ||
> +	    (!strcmp("post-merge", name) &&
> +	     !strcmp(sha256, "75da0da66a803b4b030ad50801ba57062c6196105eb1d2251590d100edb9390b")))
> +		return 1;
> +
>  	if (!safe_hook_sha256s_initialized) {
>  		safe_hook_sha256s_initialized = 1;
>  		git_protected_config(safe_hook_cb, &safe_hook_sha256s);


Not that it makes a huge difference, but if I were doing this patch
I would have instead added the special case hashes to the
safe_hook_sha256s hashmap inside this "if we haven't been
initialized" block.  That way, the checking of the hash can be done
at the central place with the same code as used to check other
custom hooks.
