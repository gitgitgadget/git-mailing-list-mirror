Received: from delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95430282F0E
	for <git@vger.kernel.org>; Sat,  4 Apr 2026 15:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775315963; cv=none; b=ZKjuuseDV9tYR0vpB3ugm3RjcpPgQ/L2KH5W9TasEWOqCn7cTYJTOe8oaB7L7GPCsb8hH0ElUk2sxZ6RGOdf16pKgu3caFm13gBgLj8FdmykKI0cErcAgqg+U5ENYwmyw0+wlSyo4OqkizJHw8RKmxoheVftzLUKetnSghtzDwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775315963; c=relaxed/simple;
	bh=Wahg/pF+s0wY8sYYwvgYx2KmTNp+EnsXTOV/eUrAc74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WgXRpaZsOXe3wnanF+hIVBqb+Fodfr7igKkSRzNyTbPc1AHd3/8rP/NpyWYcA+H4WJcu3SMCOWPOKePLgxLgcyeWfIgvaRg0U5M1qfTCQoQoWRPJnAubGbShixwvJT8Kw4+MxW3ZgUiRdhsoQu3AVWysEV9HLkQuhfYcBRP3RM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=KZ4yBd3C; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="KZ4yBd3C"
Date: Sat, 4 Apr 2026 17:19:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1775315953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o1C+K0c0tQTyog3Bb3ksim18K+7Rpg5f2e49mdlRbvQ=;
	b=KZ4yBd3CwO+WlmHdTU80p/A1+qpKpN47mlv1tOIWYZQ8XzLqhKKhc7CNptCR7D4qti4fxM
	eHweZkgA2sjdJGBN+8iiZ0TDU1UIl0YVPyGxEO/P85xAzil655+NjXr3b94zQa61+lRlLy
	1lVRosQx8PKP45a3qj1NX82J4UjUJHKRvAiekJjCrZxesnqDOghE6kqzBZUkXmulZ+bc5H
	lMDyaDd9VKapw5ZMbBZ2ncPb7M/EBqrfza7zeMs7UqID7myKBxoSE5F5vI4Rfp2cHP3cQx
	2iVnlDbwlblHAcO9VHeAJ7e5iYcxFKd4jMlhxO/E0+G1+p5nrKNsu3ucCRTcUw==
Authentication-Results: delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: Deveshi Dwivedi <deveshigurgaon@gmail.com>
Cc: git@vger.kernel.org, ben.knoble@gmail.com, quentin.bernet@bluewin.ch, 
	gitster@pobox.com
Subject: Re: [PATCH] stash: infer "push" when push-specific options are given
Message-ID: <adEqzZognqqY6OPb@exploit>
References: <20260404143640.6679-1-deveshigurgaon@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260404143640.6679-1-deveshigurgaon@gmail.com>
X-Spamd-Bar: -

On Sat, Apr 04, 2026 at 02:36:40PM +0000, Deveshi Dwivedi wrote:
> +test_expect_success 'assume push when options imply push' '
> +	git reset --hard &&
> +	echo changed >file &&
> +	git add file &&
> +	git stash -m "implied push" file &&
> +	git stash pop &&
> +
> +	git add file &&
> +	git stash --staged file &&
> +	git stash pop &&
> +
> +	git add file &&
> +	git stash --keep-index file &&
> +	git stash pop &&
> +
> +	echo untracked >untracked-file &&
> +	git stash --include-untracked untracked-file &&
> +	test_path_is_missing untracked-file &&
> +	git stash pop
> +'
> +
>  test_expect_success 'stash --invalid-option' '
>  	echo bar5 >file &&
>  	echo bar6 >file2 &&

The last 'untracked-file' remains in the working tree after the pop. I
know it doesn't affect later tests but can you clean it up anyway? I
recently fixed a test that failed due to poor cleanup and I would like
to see people prevent that too.

Thank you
