Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900111CABB
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 20:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F810F5
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 12:18:09 -0800 (PST)
Received: (qmail 2194 invoked by uid 109); 14 Nov 2023 20:18:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 14 Nov 2023 20:18:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19441 invoked by uid 111); 14 Nov 2023 20:18:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Nov 2023 15:18:10 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 14 Nov 2023 15:18:08 -0500
From: Jeff King <peff@peff.net>
To: phillip.wood@dunelm.org.uk
Cc: Ondra Medek <xmedeko@gmail.com>, git@vger.kernel.org
Subject: Re: Feature request: git status --branch-only
Message-ID: <20231114201808.GE2092538@coredump.intra.peff.net>
References: <CAJsoDaFX7YdncsTy7UsjxaM1GCKs36-H5RhJ6kzgBUFBJyoGZQ@mail.gmail.com>
 <47fa8400-1e5f-437f-84b8-50bb09580325@gmail.com>
 <CAJsoDaHX3t9bViq0F7gmJPD+PoE-ZqmJS5h=u-W900x9KEMmYA@mail.gmail.com>
 <00033c86-dbd7-4c88-bfbd-8f6766cd66c9@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <00033c86-dbd7-4c88-bfbd-8f6766cd66c9@gmail.com>

On Tue, Nov 14, 2023 at 03:02:04PM +0000, Phillip Wood wrote:

> Hi Ondra
> 
> On 14/11/2023 12:40, Ondra Medek wrote:
> > Hi Phillip,
> > 
> > it does not work for a fresh clone of an empty repository
> > 
> >      git for-each-ref --format="%(upstream:short)" refs/heads/master
> > 
> > outputs nothing, while
> 
> Oh dear, that's a shame. I wonder if it is a bug because the documentation
> says that
> 
> 	--format="%(upstream:track)"
> 
> should print "[gone]" whenever an unknown upstream ref is encountered but
> trying that on a clone of an empty repository gives no output.

I think it would print "gone" if the upstream branch went missing. But
in this case the actual local branch is missing. And for-each-ref will
not show an entry at all for a ref that does not exist. The
"refs/heads/master" on your command line is not a ref, but a pattern,
and that pattern does not match anything. So it's working as intended.

I think a more direct tool would be:

  git rev-parse --symbolic-full-name master@{upstream}

That convinces branch_get_upstream() to return the value we want, but
sadly it seems to get lost somewhere in the resolution process, and we
spit out an error. Arguably that is a bug (with --symbolic or
--symbolic-full-name, I think it would be OK to resolve names even if
they don't point to something, but it's possible that would have other
unexpected side effects).

-Peff
