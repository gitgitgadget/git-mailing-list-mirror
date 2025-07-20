Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EB615A8
	for <git@vger.kernel.org>; Sun, 20 Jul 2025 00:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752969850; cv=none; b=cCAC+0dH7z4OZCyFYwLcSiKry/PRUqFWzohm4TIcBDuaW+0yrXRSkLZBUwjCIhECLl96T5o9uzOR96O1ruBMntCMPlUQ1fB75Ww5nez53z4UbI1tQPaXnQz+0xnrQNLUURyzctGhYxb17+htB1PA2NDLLuIBYl954oU4mxcJb5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752969850; c=relaxed/simple;
	bh=N7SZwZJlMz0hcc9vR2pI1TN/SUdPIngF22Hx/RySXEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xybn/pRcRzrAuclngAeDIpQKbtEQFRJIy8lFPYxpchaaT4WnHK5tIC+N8HhcxF7LfKBkr6SuL6XUy6jQvYe3G3GMD88N3UlCMcvEUOjaFtOsz5PBoUE/TPnfs+XIGYm5oeoUJFHhrE3cBKBUkhyOph/VfjKkiXZMN55MR3ObviY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=CY285dhO; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="CY285dhO"
Received: (qmail 3028 invoked by uid 109); 20 Jul 2025 00:04:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=N7SZwZJlMz0hcc9vR2pI1TN/SUdPIngF22Hx/RySXEI=; b=CY285dhO7MDSViOnpI4NcBGLerX7hrZJxVvTny1fWnYKZwHBYNNcqgY7LBq3+q4iQPXodcDaCwPa48lsiNu3feX9W8fKlRlXQli9C8wTO18R1GCRQBAF3KA8PECgjluRQwCseXEAGtYBV0xOeFMuvJk4nu2CksRA8N+vCJ0A006lberJFgFKm96ireKRZES93mXqLX/wsWtaKENDiUGuxc+3a+55FQf/JqjhhBLiMEOkwRb1IGjZswnOZhYvFsLFz31eq1UR7NF4kVV6xFgu3lws7D2WM3r4aSeoyavyzKqtYXS0TgbxDZYzBx1NqADrpiS0WOcEKxz46CfrRsGe4Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 20 Jul 2025 00:04:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17048 invoked by uid 111); 20 Jul 2025 00:04:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 19 Jul 2025 20:04:02 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 19 Jul 2025 20:03:59 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/3] commit: convert pop_most_recent_commit() to
 prio_queue
Message-ID: <20250720000359.GA743449@coredump.intra.peff.net>
References: <bc079b3c-a472-4f5d-95ca-390f9de25196@web.de>
 <bfb0a65d-c9dd-47d9-a88d-9fec43538b0c@web.de>
 <20250716050540.GB1396022@coredump.intra.peff.net>
 <b0950e32-b4fa-4aff-8b5c-58c734b880b2@web.de>
 <20250719065558.GD705356@coredump.intra.peff.net>
 <37f34e15-f44f-4b8a-b684-bda27a977775@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <37f34e15-f44f-4b8a-b684-bda27a977775@web.de>

On Sat, Jul 19, 2025 at 01:15:28PM +0200, René Scharfe wrote:

> > Hmm, I would have thought prio_queue had less memory overhead. You're
> > spending one pointer per entry in a packed array, versus list nodes. But
> > it's true that it doesn't shrink as items are removed (though that is
> > something we _could_ implement).
> 
> If we just count the net data then a commit_list item has two pointers
> and a prio_queue_entry has a pointer and an ID for stability.  That's a
> tie.  ALLOC_GROW overallocates by ca. 50%, so that's 25% more on
> average for the prio_queue.  No idea what overhead malloc() needs per
> allocation, but I guess it's enough to tilt the scale back against
> commit_lists.

Oh right, I totally forgot about the extra counter.

-Peff
