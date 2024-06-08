Received: from mail.ekdawn.com (mail.ekdawn.com [159.69.120.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B10225AE
	for <git@vger.kernel.org>; Sat,  8 Jun 2024 11:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.120.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717844752; cv=none; b=jIj23G+MdoP1qcPjs4mhuKbUyZ7IuEGAgdd3ri8HfD4z1kdXRzWs77k+TLprtYSYvPs90hA48tqkP/rEJzDSGrMcDDbDoiloGP4qcHAr8h7LooMN/+QcRAMlze1fZ1MuG6Z72xxjepMDVm3549m0aXKzssBukf7QW4C/yZZmPhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717844752; c=relaxed/simple;
	bh=ZbK/Sp0XmpVYvuhQJ+OMV7BarJSD14Y2L1LZmb0G1MQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EsulCOD6SNWKpV2jXpKvvtG/Z6nltGKzUfmyptUmXYHBUE8wQXcLI1fSndLyEu5NRv2Uw9qBjT7bgOEN/ogHgg1cH3n1dI7K9gTA2Hx5FwUyQpmnKK3WS5kkxikyqsoi4jhPIhaMGNQNe7QIOLNLbWx/sswSckpDQRm1R8dziLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=horse64.org; spf=pass smtp.mailfrom=horse64.org; arc=none smtp.client-ip=159.69.120.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=horse64.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=horse64.org
Received: from [10.42.0.97] (dynamic-176-007-192-159.176.7.pool.telefonica.de [176.7.192.159])
	by mail.ekdawn.com (Postfix) with ESMTPSA id E9DEC185CBA;
	Sat,  8 Jun 2024 11:04:43 +0000 (UTC)
Message-ID: <a424b43f-d477-46bf-a28e-9d7a87a0130e@horse64.org>
Date: Sat, 8 Jun 2024 13:05:47 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: With big repos and slower connections, git clone can be hard to
 work with
To: Jeff King <peff@peff.net>
Cc: rsbecker@nexbridge.com, git@vger.kernel.org
References: <fec6ebc7-efd7-4c86-9dcc-2b006bd82e47@horse64.org>
 <0be201dab933$17c02530$47406f90$@nexbridge.com>
 <fdb869ef-4ce9-4859-9e36-445fd9200776@horse64.org>
 <0beb01dab93b$c01dfa10$4059ee30$@nexbridge.com>
 <200c3bd2-6aa9-4bb2-8eda-881bb62cd064@horse64.org>
 <20240608084323.GB2390433@coredump.intra.peff.net>
 <bc030171-70fa-41cf-945a-2d20bf237372@horse64.org>
 <20240608103533.GD2659849@coredump.intra.peff.net>
Content-Language: en-US
From: ellie <el@horse64.org>
In-Reply-To: <20240608103533.GD2659849@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


I see! Unfortunate, but I'm thankful for your detailed explanation.

The "shallow-cloning and deepening is [...] expensive for the server" 
makes me sadder about the current situation. I don't like that I need to 
make the server's life hard just because my connection is shaky... :-|

 > It's possible the client could do some analysis to see if it has
 > complete segments of history. In practice it won't, because of the way
 > we order packfiles (it's split by type, and then roughly
 > reverse-chronological through history). If the server re-ordered its
 > response to fill history from the bottom up, it would be possible.

I wonder if that would be the most feasible idea, if any at all...?

My main take-away is that I don't know enough to suggest a good way out, 
and that git is even more impressive and complex tech than I thought. 
Thanks so much for the detailed responses, and I hope at least some of 
my uninformed rambling was of any use.

Regards,

Ellie

On 6/8/24 12:35 PM, Jeff King wrote:
> On Sat, Jun 08, 2024 at 11:40:47AM +0200, ellie wrote:
> 
>> Sorry if I'm misunderstanding, and I assume this is a naive suggestion that
>> may not work in some way: but couldn't git somehow retain all the objects it
>> already has fully downloaded cached? And then otherwise start over cleanly
>> (and automatically), but just get the objects it already has from the local
>> cache? In practice, that might already be enough to get through a longer
>> clone despite occasional hiccups.
> 
> The problem is that the client/server communication does not share an
> explicit list of objects. Instead, the client tells the server some
> points in the object graph that it wants (i.e., the tips of some
> branches that it wants to fetch) and that it already has (existing
> branches, or nothing in the case of a clone), and then the server can do
> its own graph traversal to figure out what needs to be sent.
> 
> When you've got a partially completed clone, the client can figure out
> which objects it received. But it can't tell the server "hey, I have
> commit XYZ, don't send that". Because the server would assume that
> having XYZ means that it has all of the objects reachable from there
> (parent commits, their trees and blobs, and so on). And the pack does
> not come in that order.
> 
> And even if there was a way to disable reachability analysis, and send a
> "raw" set of objects that we already have, it would be prohibitively
> large. The full set of sha1 hashes for linux.git is over 200MB. So
> naively saying "don't send object X, I have it" would approach that
> size.
> 
> It's possible the client could do some analysis to see if it has
> complete segments of history. In practice it won't, because of the way
> we order packfiles (it's split by type, and then roughly
> reverse-chronological through history). If the server re-ordered its
> response to fill history from the bottom up, it would be possible. We
> don't do that now because it's not really the optimal order for
> accessing objects in day-to-day use, and the packfile the server sends
> is stored directly on disk by the client.
> 
> -Peff
