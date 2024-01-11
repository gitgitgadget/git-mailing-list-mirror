Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F55C5683
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 07:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 29001 invoked by uid 109); 11 Jan 2024 07:01:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 11 Jan 2024 07:01:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3375 invoked by uid 111); 11 Jan 2024 07:01:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 11 Jan 2024 02:01:17 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 11 Jan 2024 02:01:14 -0500
From: Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org
Subject: Re: Limited operations in unsafe repositories
Message-ID: <20240111070114.GB48154@coredump.intra.peff.net>
References: <ZZr-JLxubCvWe0EU@tapette.crustytoothpaste.net>
 <20240110120531.GA25541@coredump.intra.peff.net>
 <ZZ8pbAMNaBDFgf3G@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZZ8pbAMNaBDFgf3G@tapette.crustytoothpaste.net>

On Wed, Jan 10, 2024 at 11:34:04PM +0000, brian m. carlson wrote:

> On 2024-01-10 at 12:05:31, Jeff King wrote:
> > My thinking is to flip that around: run all code, but put protection in
> > the spots that do unsafe things, like loading config or examining
> > hooks. I.e., a patch like this:
> 
> I think that's much what I had intended to do with not invoking binaries
> at all, except that it was limited to rev-parse.  I wonder if perhaps we
> could do something similar if we had the `--assume-unsafe` argument you
> proposed, except that we would only allow the `git` binary and always
> pass that argument to it in such a case.

I'm not sure what you mean by "invoking binaries". I had assumed that
meant just running other Git sub-processes. But if "--assume-unsafe" is
just setting an environment variable, they'd automatically be protected.

> I don't think reading config is intrinsically unsafe; it's more of what
> we do with it, which is spawning external processes, that's the problem.
> I suppose an argument could be made for injecting terminal sequences or
> such, though.  Hooks, obviously, are definitely unsafe.

Right, it's not config itself that's unsafe; it's that many options are.
We could try to annotate them to say "it is OK to parse core.eol but not
core.pager", presumably with an allow-known-good approach (since so many
ard bad!). But that feels like an ongoing maintenance headache, and an
easy way to make a mistake (your mention of terminal sequences makes me
assume you're thinking of "color.diff.*", etc). A rule like "we do not
read repo-level config at all" seems easier to explain (to me, anyway).

-Peff
