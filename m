Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D991E890
	for <git@vger.kernel.org>; Sat,  8 Jun 2024 10:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717842937; cv=none; b=FZwcKoxb/1Q5ycy2UMgNUKAN/fMAsgTWmS6mjI5DxfepiovjEHYW6Awri2okp4kammRejqVB35t2YBqQjbxB4DHTulCHm7CQjQMcYZ50pUprhdI5TD+eDE2xY7F/kGEgluunvaxUb+pGKfLSY1aWo1Jtyo6gc7FEOxH5IwpHcwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717842937; c=relaxed/simple;
	bh=AGzrbyo0sKVQruKpCWmOyhiWPWEV25sgU5fM3pq05fY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GqB87rLkTZaa3Ji2cW9Fy+8MAKHmrlYg612HPpTPIaxQjOBHf0SY4qbYbbgYdmfE83bAhCCzxI7/hohZk50dsbQDr0rYcvO0juA+u8C2wIQxb/xuXJ8eVE1syjV+XcA5ojqG50IRAW0HFyfJZ5UB/r5DGHKL02tpn/sOD4wlU6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 8118 invoked by uid 109); 8 Jun 2024 10:35:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 08 Jun 2024 10:35:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29320 invoked by uid 111); 8 Jun 2024 10:35:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 08 Jun 2024 06:35:31 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 8 Jun 2024 06:35:33 -0400
From: Jeff King <peff@peff.net>
To: ellie <el@horse64.org>
Cc: rsbecker@nexbridge.com, git@vger.kernel.org
Subject: Re: With big repos and slower connections, git clone can be hard to
 work with
Message-ID: <20240608103533.GD2659849@coredump.intra.peff.net>
References: <fec6ebc7-efd7-4c86-9dcc-2b006bd82e47@horse64.org>
 <0be201dab933$17c02530$47406f90$@nexbridge.com>
 <fdb869ef-4ce9-4859-9e36-445fd9200776@horse64.org>
 <0beb01dab93b$c01dfa10$4059ee30$@nexbridge.com>
 <200c3bd2-6aa9-4bb2-8eda-881bb62cd064@horse64.org>
 <20240608084323.GB2390433@coredump.intra.peff.net>
 <bc030171-70fa-41cf-945a-2d20bf237372@horse64.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bc030171-70fa-41cf-945a-2d20bf237372@horse64.org>

On Sat, Jun 08, 2024 at 11:40:47AM +0200, ellie wrote:

> Sorry if I'm misunderstanding, and I assume this is a naive suggestion that
> may not work in some way: but couldn't git somehow retain all the objects it
> already has fully downloaded cached? And then otherwise start over cleanly
> (and automatically), but just get the objects it already has from the local
> cache? In practice, that might already be enough to get through a longer
> clone despite occasional hiccups.

The problem is that the client/server communication does not share an
explicit list of objects. Instead, the client tells the server some
points in the object graph that it wants (i.e., the tips of some
branches that it wants to fetch) and that it already has (existing
branches, or nothing in the case of a clone), and then the server can do
its own graph traversal to figure out what needs to be sent.

When you've got a partially completed clone, the client can figure out
which objects it received. But it can't tell the server "hey, I have
commit XYZ, don't send that". Because the server would assume that
having XYZ means that it has all of the objects reachable from there
(parent commits, their trees and blobs, and so on). And the pack does
not come in that order.

And even if there was a way to disable reachability analysis, and send a
"raw" set of objects that we already have, it would be prohibitively
large. The full set of sha1 hashes for linux.git is over 200MB. So
naively saying "don't send object X, I have it" would approach that
size.

It's possible the client could do some analysis to see if it has
complete segments of history. In practice it won't, because of the way
we order packfiles (it's split by type, and then roughly
reverse-chronological through history). If the server re-ordered its
response to fill history from the bottom up, it would be possible. We
don't do that now because it's not really the optimal order for
accessing objects in day-to-day use, and the packfile the server sends
is stored directly on disk by the client.

-Peff
