Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32376671F3
	for <git@vger.kernel.org>; Thu, 14 Dec 2023 22:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 8865 invoked by uid 109); 14 Dec 2023 22:05:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 14 Dec 2023 22:05:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11848 invoked by uid 111); 14 Dec 2023 22:05:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 14 Dec 2023 17:05:03 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 14 Dec 2023 17:05:03 -0500
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: AtariDreams via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Seija Kijin <doremylover123@gmail.com>
Subject: Re: [PATCH] Use ^=1 to toggle between 0 and 1
Message-ID: <20231214220503.GA3320432@coredump.intra.peff.net>
References: <pull.1620.git.git.1702401468082.gitgitgadget@gmail.com>
 <20231212200920.GC1127366@coredump.intra.peff.net>
 <8bea38fe-38a3-412a-b189-541a6596d623@web.de>
 <20231213080143.GA1684525@coredump.intra.peff.net>
 <4d0b2a5f-305b-4350-b164-44923cb250d8@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4d0b2a5f-305b-4350-b164-44923cb250d8@web.de>

On Thu, Dec 14, 2023 at 02:08:31PM +0100, René Scharfe wrote:

> > I don't even know that we'd need much of a weather-balloon patch. I
> > think it would be valid to do:
> >
> >   #ifndef bool
> >   #define bool int
> >
> > to handle pre-C99 compilers (if there even are any these days). Of
> > course we probably need some conditional magic to try to "#include
> > <stdbool.h>" for the actual C99. I guess we could assume C99 by default
> > and then add NO_STDBOOL as an escape hatch if anybody complains.
> 
> The semantics are slightly different in edge cases, so that fallback
> would not be fully watertight.  E.g. consider:
> 
>    bool b(bool cond) {return cond == true;}
>    bool b2(void) {return b(2);}

Yeah. b2() is wrong for passing "2" to a bool. I assumed that the
compiler would warn of that (at least for people on modern C99
compilers, not the fallback code), but it doesn't seem to. It's been a
long time since I've worked on a code base that made us of "bool", but I
guess that idea is that silently coercing a non-zero int to a bool is
reasonable in many cases (e.g., "bool found_foo = count_foos()").

I guess one could argue that b() is also sub-optimal, as it should just
say "return cond" or "return !cond" rather than explicitly comparing to
true/false. But I won't be surprised if it happens from time to time.

> A coding rule to not compare bools could mitigate that.  Or a rule to
> only use the values true and false in bool context and to only use
> logical operators on them.

That seems more complex than we want if our goal is just supporting
legacy systems that may or may not even exist. Given your example, I'd
be more inclined to just do a weather-balloon adding <stdbool.h> to
git-compat-util.h, and using "bool" in a single spot in the code. If
nobody screams after a few releases, we can consider it OK. If they do,
it's a trivial patch to convert back.

-Peff
