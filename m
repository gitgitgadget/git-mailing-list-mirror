Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09146117
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 00:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709685703; cv=none; b=Uw4af5gaIcVd/Y8sNsj4aWqCixqXfMLqCbMSeiC1DfEZUtCOaMjX0euey0EX2IYdfuXeT5xpqLTm2MR0TBpKbbDeBDZyTV+9nLrRlpvpnm7W1GKrccp3VacXZk+Hnl2qo4nwmNgUKscPoGhl17uAbV4jwcc3MOpMYwgSv5aDx3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709685703; c=relaxed/simple;
	bh=+D6J6BhpsDqD/B4Ku87mOaT2gAzEGpK25IBFt0/Wsjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lGVrt4oMQzhvM/Gv4KzRDmc/ot1VlETMmczH1umg8fI1iEjyUnxGH/rKr4eRz5pKTIFiJNWLT77eGW/4rje4ncTlnQVxPXxLVW5mOONvarDmrtQFngVZh8+2jev4MU+OafSntY4WbxEr4JQqcJSxe/9FiHjS9AfZhd/GRF9t0uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 22517 invoked by uid 109); 6 Mar 2024 00:41:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 06 Mar 2024 00:41:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30195 invoked by uid 111); 6 Mar 2024 00:41:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 05 Mar 2024 19:41:43 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 5 Mar 2024 19:41:39 -0500
From: Jeff King <peff@peff.net>
To: John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH] show-ref: add --unresolved option
Message-ID: <20240306004139.GB3797463@coredump.intra.peff.net>
References: <pull.1684.git.git.1709592718743.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1684.git.git.1709592718743.gitgitgadget@gmail.com>

On Mon, Mar 04, 2024 at 10:51:58PM +0000, John Cai via GitGitGadget wrote:

> From: John Cai <johncai86@gmail.com>
> 
> For reftable development, it would be handy to have a tool to provide
> the direct value of any ref whether it be a symbolic ref or not.
> Currently there is git-symbolic-ref, which only works for symbolic refs,
> and git-rev-parse, which will resolve the ref. Let's add a --unresolved
> option that will only take one ref and return whatever it points to
> without dereferencing it.

What about "git rev-parse --symbolic-full-name"? I don't think that
behaves quite the same as your patch here:

  - it is actually not a true no-deref; it resolves to the final name
    and then prints it (so the behavior is the same for a single-level
    symref, but I believe a multi-level symref chain like
    one->two->three will print "three" when resolving "one").

  - it always prints the resolved name, whereas your patch prints an oid
    for non-symrefs

I'm not sure if those are important or not, as I don't quite understand
what you're trying to accomplish. I'd probably have just run:

  git symbolic-ref -q $name || git rev-parse --verify $name

I'm not opposed to making that more ergonomic, but I think we should
avoid redundant plumbing options if we can (I'm not sure yet if this is
redundant or not, but in general I find "show-ref" to be a weird mix of
"rev-parse" and "for-each-ref" that I'd be just as happy if it did not
exist).

-Peff
