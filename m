Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00294381AA
	for <git@vger.kernel.org>; Tue, 30 Jan 2024 05:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706592074; cv=none; b=DpkjL7Y76kH5g5kJIgDcpLmQzmUs4NoyQY4Ye1/aboVxa4VGZrGA3eja08bf2wnPvkzZln8vtIH6oiFN1PmiGWks5PMS6e/PYSaxImgUDiKVt6HLtO8Ac0j+aMJ9pg2HqDf6zTp9qkQjZ3s6LoiQarEwohAV68xbOKoyUTQczYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706592074; c=relaxed/simple;
	bh=1ysakf5Dl6ZlZzRmvd2ZEAmDaM7rB01cL6Yuo3AKxeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jjalYwhKjTodkEZtNa9Van5gltxgsmkCHwZzVon4qOvjqQmSzdZdBaNRdDilfqbAFcamFl/5o4HtqJGbIABkgPBMPCS8GSiGE3NYOp2w7bBLbd2inGB4+Y7sBT9/93Uzot9FUJnP3uhnnE2dNbieALCctO9pCvBQpCNktODW/9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 8533 invoked by uid 109); 30 Jan 2024 05:21:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 30 Jan 2024 05:21:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28951 invoked by uid 111); 30 Jan 2024 05:21:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 30 Jan 2024 00:21:06 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 30 Jan 2024 00:21:04 -0500
From: Jeff King <peff@peff.net>
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 1/2] Makefile: use order-only prereq for UNIT_TEST_BIN
Message-ID: <20240130052104.GA154684@coredump.intra.peff.net>
References: <20240129031540.GA2433764@coredump.intra.peff.net>
 <20240129031816.GA2433899@coredump.intra.peff.net>
 <20240129202201.GA9612@szeder.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240129202201.GA9612@szeder.dev>

On Mon, Jan 29, 2024 at 09:22:01PM +0100, SZEDER Gábor wrote:

> > If it is a problem, there are two alternatives:
> > 
> >   - we can just "mkdir -p" in the recipe to build the individual
> >     binaries. This will mean some redundant "mkdir" calls, but only when
> >     actually invoking the compiler.
> > 
> >   - we could stop making the directory on the fly, and just add it with
> >     a .gitignore of "*". This would work fine, but might be awkward when
> >     moving back and forth in history.
> 
> A third alternative is to use $(call mkdir_p_parent_template) in the
> recipe and get rid of the thus unnecessary UNIT_TEST_BIN dependency
> and target.  It will only run mkdir when needed, and it's a well
> established pattern in our Makefile, so you won't have to spend a
> paragraph or two arguing about potential problems with GNU-isms :)

Thanks, I somehow didn't know about that (and didn't find it when
grepping around for similar cases, probably because "mkdir -p" no longer
appears in those cases ;) ).

I agree it's a better solution here. I'll send a v2 in a moment with
that.

(Ironically, that template requires "call" which is in make 3.81, but
the commit adding it didn't discuss that at all).

> On a related note, 'make clean' doesn't remove this 't/unit-tests/bin'
> directory.

Not the end of the world, as we do clean out the contents, so "ls-files
-o" would not mention any leftover cruft. But I agree that we should
strive for "make clean" to be the opposite of "make" as much as
possible.

I'll add in a patch to v2.

-Peff
