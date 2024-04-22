Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34537153BFE
	for <git@vger.kernel.org>; Mon, 22 Apr 2024 18:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713811305; cv=none; b=T1KWeYtrhdHorO1Vrjhs0jA3Lra6rVNEIOmTR7DubvGbtKE6dcfcJfZQRFD4o8/G29h27USH9ysv/R6vTqVTyod1HDpYv7NdThsUeWs/fnJ3pCA5e/GvWnlVzWfvO9Pvx0iI5nxdc7qszdDhGaQ1JRivJ5mETrN11Al8fVViAnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713811305; c=relaxed/simple;
	bh=Buu+Y6P2W+3clan2razB9JkBuFaaS/2bjtiI9b+4pFA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=seaWFjQZqQaM9TixMwS4JUBaZWq9R+G/tUolKa02VY0qNT1i6X7aeWhtXfjF7k7wn1fVKhCn+ry1oSLd2qacmD3kIf0k9Rmh5E50JbNTsdPwWiFtU1+MGoIZjQ7KTh8jkhIIYJgAmfZwktGwDhEtjQtImb9KSf7I5rlvSGvDf8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=lrhlOxvu; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lrhlOxvu"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EECD81EB1C0;
	Mon, 22 Apr 2024 14:41:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Buu+Y6P2W+3clan2razB9JkBuFaaS/2bjtiI9b
	+4pFA=; b=lrhlOxvuYC6bd/MOxYh5twTOPw8sslTpCWI9edSMB0mW2YHYuHD1rU
	bo4OrjZrSNf0v1LCJR5CNyCjhrs3hrYOmeMSbCDBve0a71whbN0XgwxrGDIVjAfm
	pcTJdl16pB/wu1vfKbBbijMTOdOtUuwrFDupULi5Yfu8eoDMdZr9c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E59E01EB1BF;
	Mon, 22 Apr 2024 14:41:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5537C1EB1BE;
	Mon, 22 Apr 2024 14:41:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 09/11] builtin/diff: explicitly set hash algo when there
 is no repo
In-Reply-To: <39e56dab621a2a1e0cbaf67f8de44614c354dcb1.1713519789.git.ps@pks.im>
	(Patrick Steinhardt's message of "Fri, 19 Apr 2024 11:51:48 +0200")
References: <cover.1713519789.git.ps@pks.im>
	<39e56dab621a2a1e0cbaf67f8de44614c354dcb1.1713519789.git.ps@pks.im>
Date: Mon, 22 Apr 2024 11:41:41 -0700
Message-ID: <xmqqedaxxmsa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F6665AA2-00D7-11EF-BC93-25B3960A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> The git-diff(1) command can be used outside repositories to diff two
> files with each other. But even if there is no repository we will end up
> hashing the files that we are diffing so that we can print the "index"
> line:
>
> ```
> diff --git a/a b/b
> index 7898192..6178079 100644
> --- a/a
> +++ b/b
> @@ -1 +1 @@
> -a
> +b
> ```

This will break "git am"; it is customary to indent such sample
patch block in a log message.

> We implicitly use SHA1 to calculate the hash here, which is because
> `the_repository` gets initialized with SHA1 during the startup routine.
> We are about to stop doing this though such that `the_repository` only
> ever has a hash function when it was properly initialized via a repo's
> configuration.
>
> To give full control to our users, we would ideally add a new switch to
> git-diff(1) that allows them to specify the hash function when executed
> outside of a repository. But for now, we only convert the code to make
> this explicit such that we can stop setting the default hash algorithm
> for `the_repository`.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/diff.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/builtin/diff.c b/builtin/diff.c
> index 6e196e0c7d..58ec7e5da2 100644
> --- a/builtin/diff.c
> +++ b/builtin/diff.c
> @@ -465,6 +465,15 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
>  			no_index = DIFF_NO_INDEX_IMPLICIT;
>  	}
>  
> +	/*
> +	 * When operating outside of a Git repository we need to have a hash
> +	 * algorithm at hand so that we can generate the blob hashes. We
> +	 * default to SHA1 here, but may eventually want to change this to be
> +	 * configurable via a command line option.
> +	 */
> +	if (nongit)
> +		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
> +
>  	init_diff_ui_defaults();
>  	git_config(git_diff_ui_config, NULL);
>  	prefix = precompose_argv_prefix(argc, argv, prefix);
