Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138E114E2C1
	for <git@vger.kernel.org>; Fri,  2 Feb 2024 18:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706898291; cv=none; b=uY3zHUfNaYM0StNQ7oZ5Af2RVyyJcT9tViXtk3Jv4XrZx6mtuM3aOhkIijKqwePev353ppUQzpohx32YVGL6OqNjiQUiDyvHNoNelS3KgOS/VAG3NYPiPjscLcPCbDqx5GGrd+0HGpUEaAmieYCq63qNugHy4RXxkL5Q3obtiW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706898291; c=relaxed/simple;
	bh=NWAfzR1jRhVikSbJhmpufnXSGvgJAsNzHm8xTWPXQpY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Fujm75hWLAeyibnS1dgUss/ALQ0ZTCuLL9xXHFrImfMilAazDcXdcurUt5p6e9uB+xqqg7jq2DA/3sJgKeWCpUzllurwhFEqyXuAQT3AD+BRE55fhVgd6028Bc0nAxAx51CFXdaXmRv2QFggVwrvY/ikmFsBQJNKQktRG5Hv794=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=GkxhtCOd; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GkxhtCOd"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 956C31C7369;
	Fri,  2 Feb 2024 13:24:48 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=NWAfzR1jRhVikSbJhmpufnXSGvgJAsNzHm8xTW
	PXQpY=; b=GkxhtCOdtX+lTC2vyFHb9h5PSnlsm5XDhXloHkN2ltKRDfEu2aGFNS
	cyx6BbbRBIb1+t60a5W2A3CIhCl4P97UH2DZUXROeSOXNWxpxz+9TaOhTd9NyG32
	c9kw2TmmneBPWHJwO/uJHK/j/F6y6LFdblxxhrGo9UtzEL6TyjiyA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8DF2B1C7368;
	Fri,  2 Feb 2024 13:24:48 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EE0331C7366;
	Fri,  2 Feb 2024 13:24:47 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Jeff Hostetler <jeffhostetler@github.com>
Subject: Re: [PATCH] sparse-index: pass string length to index_file_exists()
In-Reply-To: <pull.1649.git.1706897095273.gitgitgadget@gmail.com> (Jeff
	Hostetler via GitGitGadget's message of "Fri, 02 Feb 2024 18:04:54
	+0000")
References: <pull.1649.git.1706897095273.gitgitgadget@gmail.com>
Date: Fri, 02 Feb 2024 10:24:46 -0800
Message-ID: <xmqqo7cysp01.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 58BD1732-C1F8-11EE-A7E3-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Jeff Hostetler <jeffhostetler@github.com>
>
> The call to index_file_exists() in the loop in expand_to_path() passes
> the wrong string length.  Let's fix that.
>
> The loop in expand_to_path() searches the name-hash for each
> sub-directory prefix in the provided pathname. That is, by searching
> for "dir1/" then "dir1/dir2/" then "dir1/dir2/dir3/" and so on until
> it finds a cache-entry representing a sparse directory.
>
> The code creates "strbuf path_mutable" to contain the working pathname
> and modifies the buffer in-place by temporarily replacing the character
> following each successive "/" with NUL for the duration of the call to
> index_file_exists().
>
> It does not update the strbuf.len during this substitution.

Meaning we memihash() the full pathname munged with '/' -> NUL through
to the end of the original, when we should memihash() the truncated
leading pathname.  This is bad, and the ...

>
> Pass the patched length of the prefix path instead.

... fix looks quite straight-forward.

> Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
> ---

The problem description and the fix makes sense, but did you
actually see an end-user visible breakage due to this bug?  I am
wondering how you found it, and if it is reasonable to have a test
demonstrate the breakage.

>  sparse-index.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/sparse-index.c b/sparse-index.c
> index 1fdb07a9e69..093708f6220 100644
> --- a/sparse-index.c
> +++ b/sparse-index.c
> @@ -579,8 +579,9 @@ void expand_to_path(struct index_state *istate,
>  		replace++;
>  		temp = *replace;
>  		*replace = '\0';
> +		substr_len = replace - path_mutable.buf;
>  		if (index_file_exists(istate, path_mutable.buf,
> -				      path_mutable.len, icase)) {
> +				      substr_len, icase)) {

There is a break out of this loop when the condition for this "if"
statement holds, but the value of substr_len does not affect what
happens after this index_file_exists() call (correctly) computes its
result.  The fix looks good.

Thanks.

>  			/*
>  			 * We found a parent directory in the name-hash
>  			 * hashtable, because only sparse directory entries
> @@ -593,7 +594,6 @@ void expand_to_path(struct index_state *istate,
>  		}
>  
>  		*replace = temp;
> -		substr_len = replace - path_mutable.buf;
>  	}
>  
>  cleanup:
>
> base-commit: 43c8a30d150ecede9709c1f2527c8fba92c65f40
