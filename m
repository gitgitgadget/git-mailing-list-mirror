Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713CE363C64
	for <git@vger.kernel.org>; Thu, 27 Aug 2026 05:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787808966; cv=none; b=jCZfzYbGsK24S43rWp63w4LQic16NYl3OE6we2gD1jVVilXCwIQ0IRhirCwbZpmUHkhuJPMc87fu/5IE4h0OiMI1XV5azEe7m6GdJNGXgjoTCSNSD6nr4nqsARH73St1rRyTxuXLLdv7WKgMe6Vd5Z2zlSXgu+wZMNGVLg0M0z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787808966; c=relaxed/simple;
	bh=2yeE5SOXrdjbgo98ByiUe6RU1eDyZCEbNeoqkyWsxoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IJo3XLFEDIkcv3POO1Ly+L+0UNdX8rn0lhpJfTdsA5kUh6aZg80R1xbZ/4WoOMRnmexRm7f1BoDbEFpwalg+jmLtxfeprO1ROqwgsQBXiJdTZNg+un36/G5ngQsReGVeMK/pnXiRkR/pSRVBs+U5B6Wne+9RmDF0UZyXLNjuJf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=PHn33+cN; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="PHn33+cN"
Received: (qmail 7290 invoked by uid 106); 27 Aug 2026 05:36:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=2yeE5SOXrdjbgo98ByiUe6RU1eDyZCEbNeoqkyWsxoI=; b=PHn33+cNkkNPQTtmPqtvHj9uOQ4B2K6cQTuO86rH798YAUJMs1JKcsGyhK5kuV7tlM4tfXLk9mOgf1SO3gzwj+hhOaIFQlrIbbgEBtGL2hb4u5/Zx1HyrjRkKwdiVw412TG9/R9+a2gXpJXQC6OesHy2MOGW0XhuB49NRuXr4h4/SaNPMqRKnSDVNZi/Ze1xp7UbHkWEnuwLEpmAl4+fRaYfE4XEekWnEvDVitiUFpQ1lFzRJat3HG5jkfC5TIhTu8QIM+ddDHGYp9II9MYxXopiSdHsIk81ZlU77DgiYSvw77eH/e2waIjSgwW5fOjz6DcrcVrhwQn44P3u25tczA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 27 Aug 2026 05:36:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 36585 invoked by uid 111); 27 Aug 2026 05:36:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 27 Aug 2026 01:36:07 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 27 Aug 2026 01:36:02 -0400
From: Jeff King <peff@peff.net>
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 2/4] mktree: plug per-tree leak in --batch mode
Message-ID: <20260827053602.GA189659@coredump.intra.peff.net>
References: <pull.2207.git.1787092446.gitgitgadget@gmail.com>
 <pull.2207.v2.git.1787684429.gitgitgadget@gmail.com>
 <3f3b75690eea02960c7edc8d318ce7dff654f1bc.1787684429.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3f3b75690eea02960c7edc8d318ce7dff654f1bc.1787684429.git.gitgitgadget@gmail.com>

On Tue, Aug 25, 2026 at 07:00:27PM +0000, Elijah Newren via GitGitGadget wrote:

> In --batch mode "git mktree" reuses its entry buffer across trees,
> resetting `used` to 0 after writing each tree.  It never frees the
> `treeent` structures the previous tree appended, though, so once the
> next tree overwrites those slots the earlier allocations are leaked.  A
> single-tree invocation hides this, as the entries stay reachable through
> the `entries` global until exit.
> 
> Free each entry when resetting the buffer, and free the buffer itself
> before returning.

Yikes. It is sad that we did not catch this in our leak-checking builds,
as it implies that we do not test "mktree --batch" with multiple inputs.
Or grepping for "mktree.*--batch" implies that we do not test the
feature at all!

Looks like that feature comes from f1cf2d8b14 (mktree --batch: build
more than one tree object, 2009-05-14), so I am not surprised that test
coverage was a bit more spotty back then.

I guess you are going to add some coverage incidentally (or else you
would not have found this). That's better than nothing, but I suspect a
few basic directed "mktree --batch" tests would be a good thing to have
in t1010.

#leftoverbits, perhaps?

-Peff
