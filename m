Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E51381B7
	for <git@vger.kernel.org>; Fri, 12 Jan 2024 07:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 9516 invoked by uid 109); 12 Jan 2024 07:01:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 12 Jan 2024 07:01:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14966 invoked by uid 111); 12 Jan 2024 07:01:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 12 Jan 2024 02:01:45 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 12 Jan 2024 02:01:42 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Justin Tobler via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH 1/2] t1401: generalize reference locking
Message-ID: <20240112070142.GD618729@coredump.intra.peff.net>
References: <pull.1634.git.1704912750.gitgitgadget@gmail.com>
 <cb78b549e5e826ffef39c55bd726164e6b7bb755.1704912750.git.gitgitgadget@gmail.com>
 <20240111071329.GC48154@coredump.intra.peff.net>
 <ZZ_MPK2huH2j6CGd@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZZ_MPK2huH2j6CGd@tanuki>

On Thu, Jan 11, 2024 at 12:08:44PM +0100, Patrick Steinhardt wrote:

> > (note that you get a different error message if the refs are packed,
> > since there we can notice the d/f conflict manually).
> 
> If all we care for is the exit code then this would work for the
> reftable backend, too:
> 
> ```
> $ git init --ref-format=reftable repo
> Initialized empty Git repository in /tmp/repo/.git/
> $ cd repo/
> $ git commit --allow-empty --message message
> [main (root-commit) c2512d3] x
> $ git symbolic-ref refs/heads refs/heads/foo
> $ echo $?
> 1
> ```

Yep, exactly. That should work for both and cover what the test was
originally trying to do.

> A bit unfortunate that there is no proper error message in that case,
> but that is a different topic.

Yeah, I would call that an outright bug. It does not have to be part of
this patch, but is worth fixing (and testing). I suspect it's not going
to be the only place with this problem. Most of the files-backend ref
code is very happy to spew to stdout using error(), but the reftable
code, having been written from a more lib-conscious perspective,
probably doesn't.

The obvious quick fix is to sprinkle more error() into the reftable
code. But in the longer term, I think the right direction is that the
ref code should accept an error strbuf or similar mechanism to propagate
human-readable error test to the caller.

-Peff
