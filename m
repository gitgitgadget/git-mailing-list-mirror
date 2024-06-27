Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA26E2139AC
	for <git@vger.kernel.org>; Thu, 27 Jun 2024 21:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719522872; cv=none; b=M9lOwpTXerIwVElsiEPW5YtvsqyVdSmUTEzzHqrKMq0bXiqkiNue8aFtnYvbh11rsMj30TyWVxefr4t4tH/SKgHA0Rvx1jAMCgqtI43Paepn5jLakxysTs0F3Iv6D+L3n6rHyfEMyZax98BpwABgRUvk0qctpkmmIW+/fydltA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719522872; c=relaxed/simple;
	bh=HG5Crqu7ga8qDvvRpcmsgtIa7yjsfc4yC7lJI+2SVDs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ikiL3PpwPN2z4L4E7UitTpL4yOmmkPiNqzlJ/bHA9q5bB6iM1ms6tfTZP1ftN5dTg49nLbAH+wI+ZWrB9PpINs08D0Xi1sGgazkyeB6fbEAOFf37cq37D2sltTttApcp10BVBsKVyKYySHvF3SXTXBfggabkxvJvEe7WykXOmr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=w/XiH59b; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="w/XiH59b"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8695D2D223;
	Thu, 27 Jun 2024 17:14:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=HG5Crqu7ga8qDvvRpcmsgtIa7yjsfc4yC7lJI+
	2SVDs=; b=w/XiH59bxZ7awWTUN+ceVvv0q+0iJJouVRg5tQxwZuDXcdvVrfn9n6
	LzWhKbrsHjVcSKMGUnAusX13ZT9m6tey5O8MFSS75h0YgYGmSYx8ksdGJU9gCHxA
	H02OABJz5qj6xUIaCtMVIC6GdPXnhnVbZ4DdeFD56/0pfaJo53vQU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7D40E2D222;
	Thu, 27 Jun 2024 17:14:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E588B2D221;
	Thu, 27 Jun 2024 17:14:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  newren@gmail.com,  anh@canva.com,  Derrick Stolee
 <stolee@gmail.com>
Subject: Re: [PATCH v2 5/5] sparse-index: improve lstat caching of sparse paths
In-Reply-To: <0cb344ac14fa942f781221663e2324fd2225fb5f.1719412192.git.gitgitgadget@gmail.com>
	(Derrick Stolee via GitGitGadget's message of "Wed, 26 Jun 2024
	14:29:51 +0000")
References: <pull.1754.git.1718899877.gitgitgadget@gmail.com>
	<pull.1754.v2.git.1719412192.gitgitgadget@gmail.com>
	<0cb344ac14fa942f781221663e2324fd2225fb5f.1719412192.git.gitgitgadget@gmail.com>
Date: Thu, 27 Jun 2024 14:14:22 -0700
Message-ID: <xmqqy16qrsup.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3A65D8B0-34CA-11EF-A78D-965B910A682E-77302942!pb-smtp2.pobox.com

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  struct path_found_data {
> +	/**
> +	 * The path stored in 'dir', if non-empty, corresponds to the most-
> +	 * recent path that we checked where:
> +	 *
> +	 *   1. The path should be a directory, according to the index.
> +	 *   2. The path does not exist.
> +	 *   3. The parent path _does_ exist. (This may be the root of the
> +	 *      working directory.)
> +	 */
>  	struct strbuf dir;
> -	int dir_found;
>  	size_t lstat_count;
>  };
>  
>  #define PATH_FOUND_DATA_INIT { \
> -	.dir = STRBUF_INIT, \
> -	.dir_found = 1 \
> +	.dir = STRBUF_INIT \
>  }
>  
>  static void clear_path_found_data(struct path_found_data *data)
> @@ -455,49 +462,108 @@ static void clear_path_found_data(struct path_found_data *data)
>  	strbuf_release(&data->dir);
>  }
>  
> +/**
> + * Return the length of the largest common substring that ends in a

"largest" here is understandable (it means longest).

> + * slash ('/') to indicate the largest common parent directory. Returns

here I find it a bit confusing.  It is the deepest common parent
directory between the two (or "the common parent directory with the
longest path"), but my initial reaction was "largest common parent
directory?  wouldn't the root level by definition the 'largest'
(having the largest number of paths underneath) directory that is
common?)".

> + * zero if no common directory exists.
> + */
> +static size_t max_common_dir_prefix(const char *path1, const char *path2)
> +{
> +	size_t common_prefix = 0;
> +	for (size_t i = 0; path1[i] && path2[i]; i++) {
> +		if (path1[i] != path2[i])
> +			break;
> +
> +		/*
> +		 * If they agree at a directory separator, then add one
> +		 * to make sure it is included in the common prefix string.
> +		 */
> +		if (path1[i] == '/')
> +			common_prefix = i + 1;
> +	}
> +
> +	return common_prefix;
> +}

Looking good.  I assume that these two paths are relative to the
top-level of the working tree (in other words, they do not begin
with a slash)?

>  static int path_found(const char *path, struct path_found_data *data)
>  {
> ...
> +	 * At this point, we know that 'path' doesn't exist, and we know that
> +	 * the parent directory of 'data->dir' does exist. Let's set 'data->dir'
> +	 * to be the top-most non-existing directory of 'path'. If the first
> +	 * parent of 'path' exists, then we will act as though 'path'
> +	 * corresponds to a directory (by adding a slash).
>  	 */
> -	newdir = strrchr(path, '/');
> -	if (!newdir)
> -		return 0; /* Didn't find a parent dir; just return 0 now. */
> +	common_prefix = max_common_dir_prefix(path, data->dir.buf);
> ...
> +	strbuf_setlen(&data->dir, common_prefix);
> +	while (1) {

Oooh, nice.  So you learned /a/b/c/d did not exist, so check /a/b/c,
and then /a/b/ and stop, because you know /a does exist already.
With luck, our next query is for /a/b/c/e or for /a/b/f, and knowing
that /a/b/ does not exist would allow us to say "no, they do not
exist" without having to lstat().  OK.

