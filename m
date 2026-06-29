Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76612317143
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 20:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782765338; cv=none; b=acoV9HCoRXpNe0z8NPmUAcMN8eLgbVUIDP0aS56D6s1lf4U8/5beJE6LjRHq8HA32Cs4O2dOMpW7gZoBlnmp57sA5AEyvlVL/NlUTLVgpyToFFW/13CUtlw6Jv/FM4FYAVQKBX54K+lGssYmaJ+v+bM2dB6NsnHUcD7VyizqoCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782765338; c=relaxed/simple;
	bh=nUsiD42GraAFMV73Ht1PcUX000hq2TJHV9GAaejkgSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uH7/8aL3/xUpJUr8i2F0eiFtIUCeRo97IwLAEqpM8803ZkJsADNpxcFP2WaT5mQ75lJgIOnbTcIuvNzdjFd0JxxV/ijf3wT0Uji7D2I4oRH5uD86uZm39V6zJ39m6xmXVlL2nzh/TA28m2Y+DnJGq3pemLAhJt+DdYc08ptI//E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=D7MOxeYj; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="D7MOxeYj"
Received: (qmail 67276 invoked by uid 106); 29 Jun 2026 20:35:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=nUsiD42GraAFMV73Ht1PcUX000hq2TJHV9GAaejkgSU=; b=D7MOxeYjvICviUFYFQr2AF7PfnazdAPjvAxIAUSwMYw98UZx8Z/6nED+4SM4V7ywaj+TmoxQ5CI5CzAXo8iAHRdEoglWSoAEHCdzjdfeYVBY9ZJQ1PDcLZ9cDq4eoIa2uz5D9gHR1rJd5rUSJOVI5+lIkqeRbWbToNYP2E10FhZckDedWqjiVXXjIw9whtcSsU1BqA8O3XJgWcI6iKOSqkprTFyXzD0g7XMtjShDjCG14BS9G2NxIeZewyktd7MEXR+ga6RrjXZWgXplWEs0n5GU7Mi8Al4yziaMgoQW+OKQUl9WRoDoZeXCMqzG/cl6T0uSZT4Cv1SZAKE3IAra9w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 29 Jun 2026 20:35:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 135256 invoked by uid 111); 29 Jun 2026 20:35:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 29 Jun 2026 16:35:28 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 29 Jun 2026 16:35:27 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Michael Montalbo <mmontalbo@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] t5551: pack refs after creating many tags
Message-ID: <20260629203527.GA1895313@coredump.intra.peff.net>
References: <20260628075716.GA3525066@coredump.intra.peff.net>
 <20260628080710.GC107826@coredump.intra.peff.net>
 <akIJQbOUbdBbkTef@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <akIJQbOUbdBbkTef@pks.im>

On Mon, Jun 29, 2026 at 07:57:21AM +0200, Patrick Steinhardt wrote:

> > It would be nice if we had a way to generate all of these refs without
> > writing so many individual files. But even if we taught the ref code to
> > write large cases directly to the packed-refs file, we'd still need to
> > take individual locks. The real solution is a backend like reftable,
> > which shaves ~30% off of the test runtime.
> 
> We kind of already have this with the `REF_TRANSACTION_FLAG_INITIAL`
> flag, but right now it is only used when performing a clone or when
> migrating references. Also, it requires an empty repository that has no
> references yet.
> 
> It raises the question whether we could also extend git-fast-import(1)
> to use it, as it would typically be run on an almost-empty repository.
> It's the "almost" that kills it though, as we already do have at least
> the HEAD reference. So it could be feasible, but it's not as trivial as
> just setting the flag and then we're magically faster.
> 
> And besides, in this particular test here we run git-fast-import(1)
> multiple times in the same repository, so it wouldn't help us.
> 
> We could of course extend all of this so that Git is able to write into
> the packed-refs directly, even with preexisting refs. But I agree with
> your sentiment: it doesn't feel worth it as the reftable backend fixes
> scenarios like this anyway.

Yup. In the past I've pondered exposing this via update-ref, but I think
it's too weird and/or dangerous to do so. Especially because you are
still stuck creating all of the .lock files, so the performance is not
even that much better (though it does save you doing so _twice_ when you
then pack the refs).

So the performance option you really want is "YOLO, just write some
packed-refs without locking". But that is not something I think we want
to expose to users. ;)

We could do it ad-hoc within this test like so:

diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index dcff0bc7d4..276c7ac002 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -389,11 +389,15 @@ create_tags () {
 		echo "from :$1"
 	done | git fast-import --export-marks=marks &&
 
+	# should be mostly a noop, but makes sure we have the right header
+	git pack-refs &&
+
 	# now assign tags to all the dangling commits we created above
+	# It is OK to write directly to the packed-refs file because we know
+	# that our entries are sorted by refname, and that they all
+	# come after what we wrote earlier.
 	tag=$(perl -e "print \"bla\" x 30") &&
-	sed -e "s|^:\([^ ]*\) \(.*\)$|create refs/tags/$tag-\1 \2|" <marks >input &&
-	git update-ref --stdin <input &&
-	rm input
+	sed -e "s|^:\([^ ]*\) \(.*\)$|\2 refs/tags/$tag-\1|" <marks >>packed-refs
 }
 
 test_expect_success 'create 2,000 tags in the repo' '

That gives us the same ~30% speedup that using reftables does, but it
still is quite gross and fragile. And it is not even strictly correct,
because we don't zero-pad the numbered tags (so our file is subtly out
of order).  Plus it would need to be conditional on the ref backend
being used. Yuck.


There's one other thing you might find interesting. While poking at the
timings here the other day, I noticed that reftable is very eager to
stat the tables.list file. Try this:

  git init --ref-format=reftable
  blob=$(echo foo | git hash-object -w --stdin)
  seq -f "create refs/tags/foo-%g $blob" 2000 |
  strace -c git update-ref --stdin

We make 2000 fstat, which strace claims takes 85% of the time. I suspect
this is over-emphasized because strace inherently makes syscalls slow,
but running with perf also highlights it as a non-trivial cost.

It has been a long time since I've thought about reftable internals, but
it feels like we ought to be able to take the lock and then trust that
the stack has not been manipulated.

It may not be worth digging into too much, though. I can make 50,000
refs in 150ms on my system, which is probably good enough (especially
compared to the files backend).

-Peff
