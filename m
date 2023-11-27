Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9532131
	for <git@vger.kernel.org>; Mon, 27 Nov 2023 13:31:16 -0800 (PST)
Received: (qmail 25813 invoked by uid 109); 27 Nov 2023 21:31:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 27 Nov 2023 21:31:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3936 invoked by uid 111); 27 Nov 2023 21:31:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 27 Nov 2023 16:31:18 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 27 Nov 2023 16:31:15 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>,
	Willem Verstraeten <willem.verstraeten@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH 2/2] checkout: forbid "-B <branch>" from touching a
 branch used elsewhere
Message-ID: <20231127213115.GB87495@coredump.intra.peff.net>
References: <CAGX9RpFMCVLQV7RbK2u9AabusvkZD+RZNv_UD=R00cSUrjutBg@mail.gmail.com>
 <xmqqjzq9cl70.fsf@gitster.g>
 <xmqqv89tau3r.fsf@gitster.g>
 <xmqqpm01au0w.fsf_-_@gitster.g>
 <bf848477-b4dd-49d3-8e4b-de0fc3948570@gmail.com>
 <xmqqwmu42ccb.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwmu42ccb.fsf@gitster.g>

On Mon, Nov 27, 2023 at 10:51:00AM +0900, Junio C Hamano wrote:

> >> +	if (opts->new_branch_force) {
> >> +		char *full_ref = xstrfmt("refs/heads/%s", opts->new_branch);
> >> +		die_if_switching_to_a_branch_in_use(opts, full_ref);
> >> +		free(full_ref);
> >
> > At the moment this is academic as neither of the test scripts changed
> > by this patch are leak free and so I don't think we need to worry
> > about it but it raises an interesting question about how we should
> > handle memory leaks when dying. Leaving the leak when dying means that
> > a test script that tests an expected failure will never be leak free
> > but using UNLEAK() would mean we miss a leak being introduced in the
> > successful case should the call to "free()" ever be removed.
> 
> Is there a leak here?  The piece of memory is pointed at by an on-stack
> variable full_ref when leak sanitizer starts scanning the heap and
> the stack just before the process exits due to die, so I do not see
> a reason to worry about this particular variable over all the other
> on stack variables we accumulated before the control reached this
> point of the code.

Right, I think the only reasonable approach here is to not consider this
a leak. We've discussed this in the past. Here's a link into a relevant
thread for reference, but I don't think it's really worth anybody's
time to re-visit:

  https://lore.kernel.org/git/Y0+i1G5ybdhUGph2@coredump.intra.peff.net/

> Are you worried about optimizing compilers that behave more cleverly
> than their own good to somehow lose the on-stack reference to
> full_ref while calling die_if_switching_to_a_branch_in_use()?  We
> might need to squelch them with UNLEAK() but that does not mean we
> have to remove the free() we see above, and I suspect a more
> productive use of our time to solve that issue is ensure that our
> leak-sanitizing build will not triger such an unwanted optimization
> anyway.

We did have that problem, but it should no longer be the case after
d3775de074 (Makefile: force -O0 when compiling with SANITIZE=leak,
2022-10-18). If that is not sufficient for some compiler/code combo, I'd
be interested to hear about it.

-Peff
