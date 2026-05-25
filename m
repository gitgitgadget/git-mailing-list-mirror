Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59993BFE33
	for <git@vger.kernel.org>; Mon, 25 May 2026 07:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779693113; cv=none; b=XGuLbc2kv3wWhFGc/PC2DEY8/0ic758gEp1f6BVDDti7OBXwYH9zsEs27N9JssJDXoMujJbtCwg0ee4tMKQgIDkRybUdAiw2bHs+xz7sl4fNNmRCfiBVMzRS1xA25Fi915s5vEZTS8gXZ+YVZ10StFs513GJgrXQTPDnMQLo84o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779693113; c=relaxed/simple;
	bh=K/8b5D6GyUSPgiOhErU1f9G8FxxLjZyYCsA8zQVT1TQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OA6dpA/DpALalIboJJb0HDQ5/sbiEYRdUi+UqgvfR/BB+xZsyfQB9jmE9Ih5ISN2WCFJ+iD+VvpvrwgpIXIyNdJBYo2jmF9P7wNeAf1FF75pdHAePR4gWCoUcApw2WQtbIsmGgT/AzQ9n5v4aFt1M3y1c5Y40mmXhK2raCcWg0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=cTG2SMld; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="cTG2SMld"
Received: (qmail 10069 invoked by uid 106); 25 May 2026 07:11:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=K/8b5D6GyUSPgiOhErU1f9G8FxxLjZyYCsA8zQVT1TQ=; b=cTG2SMld6eCGR+AEPFxg8PEqOM9L7NRuTv+UyX3CDxulpAcY4ZxL1W3fH5haU1ecEKW+6x83Cf5Sn9nUcHYS5ol+fldkrIhRTEy0Bm6IGo+uKSw+KApU3m/CwLL/q5iTyScp3gqUgP1x7JM+pf4AqSrEPO8uvzcZI9olk3t9qnzaIHtuKPOE1vtKzB6GtaZqk2opoiE1bKHBmfeHhBvofDMa3Cb0euWA2yxEy98ixVScVojMSaJIMGIjWGLLX9hSBlrff54Ugn0hQcMORqfVSnFwWi9IwPld0WH1wMKqXcGQ0KX6x5P5GVkky0B5kY9k1+pWBvE5itvQ1+gMOFdGPg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 25 May 2026 07:11:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13731 invoked by uid 111); 25 May 2026 07:11:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 25 May 2026 03:11:54 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 25 May 2026 03:11:50 -0400
From: Jeff King <peff@peff.net>
To: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Kristofer Karlsson <krka@spotify.com>
Subject: Re: [PATCH 3/3] commit-reach: optimize queue scan in ahead_behind
Message-ID: <20260525071150.GC2737798@coredump.intra.peff.net>
References: <pull.2124.git.1779644541.gitgitgadget@gmail.com>
 <711a0e2235103489f17ff867439e007abd0e4291.1779644541.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <711a0e2235103489f17ff867439e007abd0e4291.1779644541.git.gitgitgadget@gmail.com>

On Sun, May 24, 2026 at 05:42:20PM +0000, Kristofer Karlsson via GitGitGadget wrote:

> ahead_behind() already deduplicates queue entries using the PARENT2
> flag (via insert_no_dup), so the counter is maintained through
> insert_no_dup() and mark_stale() using PARENT2 as the queued_flag.

That makes sense, but it does raise one question: since we do not clear
the PARENT2 flag upon popping, is it possible to consider a commit a
second time, after it has been popped?

I suspect the answer is "yes", if you have commits with out-of-order
dates (so we visit X, which has PARENT2 set, and then later visit its
descendant, and try to add X again as a parent).

I guess your counter does not make anything worse, though, because the
same PARENT2 flag that prevents us from incrementing the counter also
prevents us from actually adding it to the queue again.

And I think the current code is OK because we do not care about
de-duping the queue, but about not double-counting commits in the global
space. So PARENT2 effectively acts as a "seen" flag here.

-Peff
