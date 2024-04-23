Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBA214600E
	for <git@vger.kernel.org>; Tue, 23 Apr 2024 21:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713908663; cv=none; b=B0Kd53Ck6c903/K1msLOwqXXUE6dLfJyLINBDcp6bxYUHtuSJnzy3Uz3ZH17CT1AVhmaaJ0/GAQd8/oplwghsR5z/xNmcPR/o2PoFV7s1I2OxsE1xj9G6RZpnAxEbHxRv68BVJ9KsG9pZhg3gkIolTQn1ytAHWcYmpiHeqZEG48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713908663; c=relaxed/simple;
	bh=/ZPXA7W5ZgdxFDDOkcA+gymT9Z6HrXWGybSQam/B4zI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V30sxA9sMmGhvq/MYLdKnBLBg1zm2OVfWSDOobv8+WpV0NqeenqD9UuDxmBicF+9N21eHDU3hz50UgMzUhMhwjvFCcv9qfrKR+vIe8EXJdIrVEG3v4/2ihV18PAh2ofPxfgozn2vPAlaNlW+Y60/EBQY8RFBgEv8LVvxpuJpwZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 7876 invoked by uid 109); 23 Apr 2024 21:44:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 23 Apr 2024 21:44:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4942 invoked by uid 111); 23 Apr 2024 21:44:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 23 Apr 2024 17:44:22 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 23 Apr 2024 17:44:19 -0400
From: Jeff King <peff@peff.net>
To: Adam Johnson via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "Randall S. Becker" <randall.becker@nexbridge.ca>,
	Adam Johnson <me@adamj.eu>
Subject: Re: [PATCH] stash: fix "--staged" with binary files
Message-ID: <20240423214419.GB1172807@coredump.intra.peff.net>
References: <pull.1722.git.1713781694490.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1722.git.1713781694490.gitgitgadget@gmail.com>

On Mon, Apr 22, 2024 at 10:28:14AM +0000, Adam Johnson via GitGitGadget wrote:

> From: Adam Johnson <me@adamj.eu>
> 
> "git stash --staged" would crash with binary files, after saving the stash.
> This behaviour dates back to the addition of the feature in 41a28eb6c1
> (stash: implement '--staged' option for 'push' and 'save', 2021-10-18).
> Adding the "--binary" option of "diff-tree" fixes this. The "diff-tree" call
> in stash_patch() also omits "--binary", but that is fine since binary files
> cannot be selected interactively.
> 
> Helped-By: Jeff King <peff@peff.net>
> Helped-By: Randall S. Becker <randall.becker@nexbridge.ca>
> Signed-off-by: Adam Johnson <me@adamj.eu>

I had to dig in the archive to remember what I might have helped with. ;)

The patch looks good to me, though one thing I noticed:

> +test_expect_success 'stash --staged with binary file' '
> +	printf "\0" >file &&
> +	git add file &&
> +	git stash --staged &&
> +	git stash pop &&
> +	printf "\0" >expect &&
> +	test_cmp expect file
> +'

I wonder if test_cmp would ever have problems with binary files on any
platforms (and yes, I was the one who suggested using it). We use "diff"
on most platforms, but a few (like old SunOS) set GIT_TEST_CMP to "cmp"
because they don't have "diff -u" at all. I'm content to leave it as-is
until somebody turns up a platform that complains, and then the escape
hatch is "OK, so set GIT_TEST_CMP=cmp".

-Peff
