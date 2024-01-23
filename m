Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0CF4E1D8
	for <git@vger.kernel.org>; Tue, 23 Jan 2024 00:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969968; cv=none; b=XUD0JBEnYD/OUbQ6DvwKs4nfDNgJnFzS7WPZleiPzxS7Nn6r+5NCirKXJj/EUGe11fp8/xtVBhWj5MKcFQfEwCYstNMLvXcVOwtEiKb4cQC3mT8ognPa24BLrurv7vfVL+qSxKbOQhuM6vbI0fKB1vd3tYxfcVtbxOQAr2uPEcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969968; c=relaxed/simple;
	bh=p31wzEDjNv5lQj9ibba0s7gE7z4giUH7lZJndAmSO3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZTpnDoIXXTnzQwUrZOgoFAGoPM4rcu/ZYDmmBpLphySnwHCtNMfhNAj0beXUQ3MJx3huA2wglhYUxlkfTZ4iyMTQqFC7uwUe7D6/f1O30gJ5TgDz6yw77swohbBc/uiQv/BKph2y5lDU20CTAVZa3Wf6jECF8pRL9LYvqDofC3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 12581 invoked by uid 109); 23 Jan 2024 00:32:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 23 Jan 2024 00:32:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10903 invoked by uid 111); 23 Jan 2024 00:32:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 22 Jan 2024 19:32:46 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 22 Jan 2024 19:32:44 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] reftable/stack: fix race in up-to-date check
Message-ID: <20240123003244.GB827890@coredump.intra.peff.net>
References: <cover.1705585037.git.ps@pks.im>
 <713e51a25c1c4cfa830db97f71cd7c39e85864d4.1705585037.git.ps@pks.im>
 <20240120010559.GE117170@coredump.intra.peff.net>
 <Za5ELqZps0DLbb5q@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Za5ELqZps0DLbb5q@tanuki>

On Mon, Jan 22, 2024 at 11:32:14AM +0100, Patrick Steinhardt wrote:

> > I didn't think too hard about the details, but does this mean that
> > every user of stat_validity_check() has the same issue? The other big
> > one is packed-refs (for which the code was originally written). Should
> > this fix go into that API?
> 
> In theory, the issue is the same for the `packed-refs` file. But in
> practice it's much less likely to be an issue:

Thanks for laying this all out. It does concern me a little that there's
still a possible race, because they can be so hard to catch and debug in
practice. But I think you make a compelling argument that it's probably
not happening a lot in practice, and especially...

> Also, applying the same fix for the packed-refs would essentially mean
> that the caching mechanism is now ineffective on Windows systems where
> we do not have proper `st_dev` and `st_ino` values available. I think
> this is a no-go in the context of packed-refs because we don't have a
> second-level caching mechanism like we do in the reftable backend. It's
> not great that we have to reread the "tables.list" file on Windows
> systems for now, but at least it's better than having to reread the
> complete "packed-refs" file like we'd have to do with the files backend.

...here that the performance profile is so different. If the "fix"
means re-reading the whole packed-refs file constantly, that's going
to be quite noticeable.

Given that this race has been here forever-ish, I agree with you that we
should leave it be.

-Peff
