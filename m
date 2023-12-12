Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51FFAF
	for <git@vger.kernel.org>; Mon, 11 Dec 2023 17:22:21 -0800 (PST)
Received: (qmail 5741 invoked by uid 109); 12 Dec 2023 01:22:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Dec 2023 01:22:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8850 invoked by uid 111); 12 Dec 2023 01:22:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 11 Dec 2023 20:22:20 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 11 Dec 2023 20:22:20 -0500
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: Adam Majer <adamm@zombino.com>, git@vger.kernel.org
Subject: Re: [PATCH] setup: recognize bare repositories with packed-refs
Message-ID: <20231212012220.GD376323@coredump.intra.peff.net>
References: <20231117203253.21143-1-adamm@zombino.com>
 <20231128142845.11523-1-adamm@zombino.com>
 <20231128190446.GA10477@coredump.intra.peff.net>
 <ZWethlRRtuQLDRlJ@nand.local>
 <20231206210836.GA106480@coredump.intra.peff.net>
 <ZXOF75NwxI187QDQ@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZXOF75NwxI187QDQ@nand.local>

On Fri, Dec 08, 2023 at 04:09:03PM -0500, Taylor Blau wrote:

> > I dunno. I am skeptical that there are millions of these. Who really
> > wants to embed bare git repos except for projects related to Git itself,
> > which want test vectors? Is there a use case I'm missing?
> 
> Just picking on GitHub as an example, my copy has a fair number of
> embedded bare repositories:
> 
>     $ find . -mindepth 2 -type d -name '*.git' | wc -l
>     279
> 
> That might be an unfair example in general, since GitHub probably has a
> greater need to embed bare repositories than most other projects. But I
> think that we shouldn't make our decision here based on volume of
> embedded bare repositories, but rather on the number of projects which
> have >1 embedded bare repository.

Right, I meant "I am skeptical there are a lot of projects that have
embedded repositories". It is useful if your project is related to
working on Git itself and you store your test vectors that way. So
github.git is not alone there (there is libgit2, other forges, and so
on). But I don't think it is representative in general.

> Perhaps I'm over-estimating how difficult this transition would be to
> impose on users. But it does make me very leery to make this kind of a
> change without having a better sense of how many of them exist in the
> wild.

Just to be clear: I am not proposing any transition here. It is already
the case that your "refs/" directory is necessary for Git to recognize
the bare repo, and you risk committing a broken state if you have no
loose refs in it.

There's been a proposal elsewhere to require extra steps to recognize an
embedded bare repo. Which I agree will be a pain for folks who use them,
but may be worth it for the security benefit. But here I was only saying
that _if_ we do that other change, then adding extra steps might not be
too bad on top. :)

(BTW, I think libgit2 already faces this problem, because it wants
non-bare repos; so there is some magic where it stores ".gitted"
directories, and then renames them on the fly).

> Searching just on GitHub for `path:**/*.git/config` [^1], it looks like
> there are ~1,400 results. That provides us an upper-bound on the number
> of projects which have embedded bare repositories, so perhaps I really
> am overestimating the burden we'd be imposing on other projects.

Thanks, that's an interesting number, and matches my intuition.

Of course it's not a true upper bound anyway. It wouldn't count private
projects (though maybe it hits github.git in your case), not to mention
stuff that isn't hosted on GitHub.

-Peff
