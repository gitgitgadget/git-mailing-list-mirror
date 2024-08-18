Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94CD288B1
	for <git@vger.kernel.org>; Sun, 18 Aug 2024 17:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.242.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724003046; cv=none; b=EgvJl7tVr6RhUM9b7IijhRccDrqRSTAO52A4RL9Xbl9dJoTujr8HEtxmu7OtiNt2Wz3TGeb09ajulFfbSS4yvfDE7jLUKnqBsH4e2+bSiUABTkcVZKs3gIUwqN3RtOXbpiC6WU+/l7bxGrHML3UyAOVxrQ+XeVvP7AwWjyl2ut0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724003046; c=relaxed/simple;
	bh=NxztY5KGC3rbQnQq0RwSIcmBm33XibKxTLTg/qxnlfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZFyKchar0258Emqi50gCe/ytuBW9jgs4jQSDuFmloSieS1tkspSPKdKZ94UiS5sKb9YwY5ADlyzHw/zIdQtIRvgnqBcIlf+YIe8iEvsr9IxBZjHPL4cgfvGtuc/3Px8QPLP5ejPazkUqVIssqi1xjRNdJgdhYQ8Z/aJlaYFC51k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org; spf=pass smtp.mailfrom=80x24.org; dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b=bBOVb+xC; arc=none smtp.client-ip=173.255.242.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=80x24.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b="bBOVb+xC"
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C5151F47A;
	Sun, 18 Aug 2024 17:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
	s=selector1; t=1724002597;
	bh=NxztY5KGC3rbQnQq0RwSIcmBm33XibKxTLTg/qxnlfM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bBOVb+xCB9fFIxcZDxdT1ltoYTzPfBqTkK2PlFu5x8EZ/G7FKgdwIX7ielDCxi/xz
	 V673TcN4qaI+AfPobAZKJeNTNrc0U0Z/OVYIKMuV7vFpIc+REB7BqbbF7wv9isUdaz
	 6k0EOU09foQMdDKU2Oupx9gswKOUhpZ0QMV21eps=
Date: Sun, 18 Aug 2024 17:36:37 +0000
From: Eric Wong <e@80x24.org>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: assert vs BUG [was: [PATCH v1 05/10] cat-file: use delta_base_cache
 entries directly]
Message-ID: <20240818173637.M96307@dcvr>
References: <20240715003519.2671385-1-e@80x24.org>
 <20240715003519.2671385-6-e@80x24.org>
 <ZqC872ExETzRH60Z@tanuki>
 <20240726074201.M876490@dcvr>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240726074201.M876490@dcvr>

Eric Wong <e@80x24.org> wrote:
> Patrick Steinhardt <ps@pks.im> wrote:
> > We shouldn't use asserts, but rather use `BUG()` statements in our
> > codebase. `assert()`s don't help users that run production builds.
> 
> OK.

Thinking about this more, I still favor assert() in common code
paths since it's only meant to be used during development and
later removed or neutralized (via -DNDEBUG).

IOW, I treat assert() as scaffolding that can/should later be
removed once the code is proven to work well.  We also have
plenty of existing asserts in our codebase.

Furthermore, assert() is also a well known API which reduces the
learning curve for drive-by hackers (I still consider myself
a drive-by since my I do minimal C).
