Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FBB2C11EB
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 10:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760004709; cv=none; b=PkWnNgxXWE2eVRQEHnmTy+GfWNsY5BC66ajIQ5xjKjes+McOuef8GS5Y/Q2L2PJcEhz5GMnkj/i/sE3YjgNuT6IGD5V0MzmfVMQ4z5gEjxFA9rgGVWGud4A7kRUx0ic35/rL64u9V3h2fZtAtOhPiXhHFWkw+dSjSIk/WRwz1kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760004709; c=relaxed/simple;
	bh=EPVpqhjo7DxyM3Dgd0V1wQ7xqfOJC2HJrADsCEjTy5k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gC3krg0tEdNIFwDHfGEqQKCO+aZ27ZN74fjVzH6xqPvLnr8Bw089Cwaju2uXz1ri5UO36dV2smcJXz4Nt2ZjiLoNU3DIoVozWrTwnJTt7EvohEjfiR8kIIs566QBauNWveiFSCZBRX4dTLK9focQi9JytXsBKKGG/W+Wyic2g/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=Yg7kcg+1; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="Yg7kcg+1"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1760004701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+6kjUTkOVeDcKcuQumwyVnEJ9CY0TUmm7Skbv6M60ao=;
	b=Yg7kcg+11OISbcPNBBS9CNUDfn+1Mm4EgY9/UZBcD5Rp7bSPWCDIBeqkGUP871EbmwQD/1
	+W4nuXvK67Zx/0lJS9YdpppFS3Ku6fjBcCJsoLLGSE4fHJJtmFfSsQp9kg1WxYjUouMJhx
	otXwWHL37/KPCOVT1/gE9+faYOzfsJc=
From: Toon Claes <toon@iotcl.com>
To: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>, Karthik Nayak <karthik.188@gmail.com>,
 Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>, Justin
 Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 00/14] refs: improvements and fixes for peeling tags
In-Reply-To: <20251009063956.GA1622884@coredump.intra.peff.net>
References: <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-0-916cc7c6886b@pks.im>
 <20251008-b4-pks-ref-filter-skip-parsing-objects-v2-0-76e30d5c9542@pks.im>
 <20251009053825.GB1614343@coredump.intra.peff.net>
 <aOdRsR-k77uTWJRb@pks.im>
 <20251009063956.GA1622884@coredump.intra.peff.net>
Date: Thu, 09 Oct 2025 12:11:31 +0200
Message-ID: <87ecrcbd0s.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Jeff King <peff@peff.net> writes:

>> > I do have one minor complaint, though: the name of that struct. I have a
>> > feeling that the name "struct reference" may cause confusion down the
>> > road because it's so generic, and because "references" and "refs" are so
>> > common in the code. From the names, when would I know when to use
>> > "struct reference" and when "struct ref"?
>> > 
>> > Could we give it a name that ties it to the iteration interface?
>> > Something like iterated_ref, each_ref_data, etc?
>> > 
>> > I know this is minor (and will be annoying to adjust your series), but
>> > I'd rather raise the point now than realize later that it's confusing
>> > and try to change it then.

When I was reviewing these patches, I also had some doubts whether
`reference` was the best name for this struct. Especially because the
comment above says:

    /* A reference passed to `for_each_ref()`-style callbacks. */

But on the other hand, I agree with Patrick:

>> what it contains is as close as you get to a representation of a
>> reference.

So, I'd be fine if this comment was rewritten a little bit, into
something like:

    /* A representation of a reference, for example to be passed to
     * `for_each_ref()`-style callbacks. */

> I am not so much arguing that "struct reference" is misnamed, as that it
> is sufficiently generic that people will reach for it when it is not the
> appropriate tool. It is for passing the ref data to the iterator
> callback, but it probably doesn't make sense in other contexts. Would we
> ever expect anybody to declare their own "struct reference" in a local
> function? I don't think so.

Personally I'd say it's hard to predict something like that. Usually I
tend to lean toward naming that doesn't assume anything that might
happen in the future. And because I think this struct contains what a
reference _is_, I think this name is fine. And whenever we run into the
issue that we need something else to be named `reference`, we revisit
this decision.

> And yes, "struct ref" suffers somewhat from the same problem. It is
> mostly about using refs in one specific space, but the name does not
> really help clarify that. I wouldn't mind seeing that improved, but yes,
> it would be a noisy patch. I don't know if remote_ref is the right name,
> though (the "peer_ref" links mean we store both local and remote refs in
> it, IIRC).





-- 
Cheers,
Toon
