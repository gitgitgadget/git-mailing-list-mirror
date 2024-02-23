Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF58C17995
	for <git@vger.kernel.org>; Fri, 23 Feb 2024 08:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708676289; cv=none; b=YvcK6gs/HUzohuFANIHWtsU3JdN75ZNLgOQCNGLN8X9kWKrLoTwjSdfr4BJtjMh1ndx+RPKkPvJ+jZ6EEhYTmER5+JSXIX4tRuYzsqfTBztLVgQHKwNRhAduTIwTP6QdbA0sRVljNMoF7TorLF+F4PV2l2+RmT3qoT94CG5qXTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708676289; c=relaxed/simple;
	bh=+s+f+oQLj8tTBcW7u0454k78dT2elBuz/zWBhbT/BGw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jUaF7xdoieykWG54lvtXbEnGeEOdcU0O8IR6tU2eBlYHiku8zTqetHV5S9o/mydWvrwy39z/wGt1ME3PQQVpoJAJ7AskDrD3K63wtQxH4s4S+DjWCWj8oqLuWVJhqA8U3ZRoYhb9dlR8mJhifIsCTTz6j47CTsp0F+VsVn9DhDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=JkTsmSrP; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JkTsmSrP"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 3B9F01F4C4;
	Fri, 23 Feb 2024 03:18:07 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=+s+f+oQLj8tTBcW7u0454k78dT2elBuz/zWBhb
	T/BGw=; b=JkTsmSrPjz5x3EDDViX4Ktl0ptvAdQcZkG95g6MbKH6/8sJjRhGyRa
	rzBD8O8gB2o6KY/9vF6e0fUybuxbDRZht5vsde9LUenZPdrUUFd/DLiB86nALivv
	+3cXdKPSgUJ/dwJUwva6/kVdJYYbB1eTY/Gwc7pHyoEr6Bg37Rar8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 3316F1F4C3;
	Fri, 23 Feb 2024 03:18:07 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5EFAE1F4C0;
	Fri, 23 Feb 2024 03:18:03 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Jeff Hostetler
 <git@jeffhostetler.com>,  Jeff Hostetler <jeffhostetler@github.com>
Subject: Re: [PATCH v2 06/16] fsmonitor: refactor refresh callback for
 non-directory events
In-Reply-To: <7ee6ca1aefd34a37d749300e317df10d80ef2b29.1708658300.git.gitgitgadget@gmail.com>
	(Jeff Hostetler via GitGitGadget's message of "Fri, 23 Feb 2024
	03:18:10 +0000")
References: <pull.1662.git.1707857541.gitgitgadget@gmail.com>
	<pull.1662.v2.git.1708658300.gitgitgadget@gmail.com>
	<7ee6ca1aefd34a37d749300e317df10d80ef2b29.1708658300.git.gitgitgadget@gmail.com>
Date: Fri, 23 Feb 2024 00:18:01 -0800
Message-ID: <xmqq5xyf1tmu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1096CFB6-D224-11EE-ABEC-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Jeff Hostetler <jeffhostetler@github.com>
>
> Move the code handle unqualified FSEvents (without a trailing slash)
> into a helper function.

-ECANNOTPARSE.  "code handle" -> "code that handles"?

In the patch text itself, there is nothing unexpected.  Looking
good.

Thanks.

> Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
> ---
>  fsmonitor.c | 67 +++++++++++++++++++++++++++++++----------------------
>  1 file changed, 39 insertions(+), 28 deletions(-)
>
> diff --git a/fsmonitor.c b/fsmonitor.c
> index 29cce32d81c..364198d258f 100644
> --- a/fsmonitor.c
> +++ b/fsmonitor.c
> @@ -183,6 +183,43 @@ static int query_fsmonitor_hook(struct repository *r,
>  	return result;
>  }
>  
> +static void handle_path_without_trailing_slash(
> +	struct index_state *istate, const char *name, int pos)
> +{
> +	int i;
> +
> +	if (pos >= 0) {
> +		/*
> +		 * We have an exact match for this path and can just
> +		 * invalidate it.
> +		 */
> +		istate->cache[pos]->ce_flags &= ~CE_FSMONITOR_VALID;
> +	} else {
> +		/*
> +		 * The path is not a tracked file -or- it is a
> +		 * directory event on a platform that cannot
> +		 * distinguish between file and directory events in
> +		 * the event handler, such as Windows.
> +		 *
> +		 * Scan as if it is a directory and invalidate the
> +		 * cone under it.  (But remember to ignore items
> +		 * between "name" and "name/", such as "name-" and
> +		 * "name.".
> +		 */
> +		int len = strlen(name);
> +		pos = -pos - 1;
> +
> +		for (i = pos; i < istate->cache_nr; i++) {
> +			if (!starts_with(istate->cache[i]->name, name))
> +				break;
> +			if ((unsigned char)istate->cache[i]->name[len] > '/')
> +				break;
> +			if (istate->cache[i]->name[len] == '/')
> +				istate->cache[i]->ce_flags &= ~CE_FSMONITOR_VALID;
> +		}
> +	}
> +}
> +
>  /*
>   * The daemon can decorate directory events, such as a move or rename,
>   * by adding a trailing slash to the observed name.  Use this to
> @@ -225,7 +262,7 @@ static void handle_path_with_trailing_slash(
>  
>  static void fsmonitor_refresh_callback(struct index_state *istate, char *name)
>  {
> -	int i, len = strlen(name);
> +	int len = strlen(name);
>  	int pos = index_name_pos(istate, name, len);
>  
>  	trace_printf_key(&trace_fsmonitor,
> @@ -240,34 +277,8 @@ static void fsmonitor_refresh_callback(struct index_state *istate, char *name)
>  		 * for the untracked cache.
>  		 */
>  		name[len - 1] = '\0';
> -	} else if (pos >= 0) {
> -		/*
> -		 * We have an exact match for this path and can just
> -		 * invalidate it.
> -		 */
> -		istate->cache[pos]->ce_flags &= ~CE_FSMONITOR_VALID;
>  	} else {
> -		/*
> -		 * The path is not a tracked file -or- it is a
> -		 * directory event on a platform that cannot
> -		 * distinguish between file and directory events in
> -		 * the event handler, such as Windows.
> -		 *
> -		 * Scan as if it is a directory and invalidate the
> -		 * cone under it.  (But remember to ignore items
> -		 * between "name" and "name/", such as "name-" and
> -		 * "name.".
> -		 */
> -		pos = -pos - 1;
> -
> -		for (i = pos; i < istate->cache_nr; i++) {
> -			if (!starts_with(istate->cache[i]->name, name))
> -				break;
> -			if ((unsigned char)istate->cache[i]->name[len] > '/')
> -				break;
> -			if (istate->cache[i]->name[len] == '/')
> -				istate->cache[i]->ce_flags &= ~CE_FSMONITOR_VALID;
> -		}
> +		handle_path_without_trailing_slash(istate, name, pos);
>  	}
>  
>  	/*
