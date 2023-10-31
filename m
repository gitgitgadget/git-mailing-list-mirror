Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9DA1DDC1
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 19:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B886A3
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 12:36:31 -0700 (PDT)
Received: (qmail 20422 invoked by uid 109); 31 Oct 2023 19:36:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 31 Oct 2023 19:36:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24814 invoked by uid 111); 31 Oct 2023 19:36:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 31 Oct 2023 15:36:32 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 31 Oct 2023 15:36:29 -0400
From: Jeff King <peff@peff.net>
To: phillip.wood@dunelm.org.uk
Cc: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH v2 5/5] ci: add support for GitLab CI
Message-ID: <20231031193629.GB875658@coredump.intra.peff.net>
References: <cover.1698305961.git.ps@pks.im>
 <cover.1698398590.git.ps@pks.im>
 <37a507e9b255dd40c0536438dfe3fa05b067f08f.1698398590.git.ps@pks.im>
 <ZTuYjzOfG0y27Sho@ugly>
 <d00b02e9-fb05-44bc-90ee-1851ef98dd26@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d00b02e9-fb05-44bc-90ee-1851ef98dd26@gmail.com>

On Fri, Oct 27, 2023 at 02:17:02PM +0100, Phillip Wood wrote:

> On 27/10/2023 12:01, Oswald Buddenhagen wrote:
> > On Fri, Oct 27, 2023 at 11:25:41AM +0200, Patrick Steinhardt wrote:
> > > +    export GIT_PROVE_OPTS="--timer --jobs $(nproc)"
> > > +    export GIT_TEST_OPTS="--verbose-log -x"
> > > 
> > fwiw (as this is again only copied), export with assignment is a
> > bash-ism
> 
> Not according to https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#export
> 
>     SYNOPSIS
> 
>         export name[=word]...
> 
>     DESCRIPTION
> 
>         The shell shall give the export attribute to the variables
>         corresponding to the specified names, which shall cause them
>         to be in the environment of subsequently executed commands. If
>         the name of a variable is followed by = word, then the value
>         of that variable shall be set to word.
> 
> It is true that in our test suite we separate a variable assignment when
> exporting. Presumably that is because someone reported that their shell did
> not support the "export name=WORD" syntax in the past. As we're already
> using this syntax with the same docker images in Github Actions I think we
> can assume it is safe here.

I've wondered about the origin of this myself, and tried to do some
digging. All of the commits I found removing "export var=val" vaguely
say "unportable" or "some shells can't handle", etc.

The oldest mention I found on the mailing list was this thread:

  https://lore.kernel.org/git/7vfyb0wexo.fsf@assigned-by-dhcp.cox.net/

which is even more explicit about its vagueness.

I wouldn't be surprised if SunOS/Solaris /bin/sh had problems with it,
as that has been a common headache shell in the past. But I think we
finally declared it unusable for other reasons (and they ship a more
capable shell in /usr/xpg6, if anybody even still wants to build on
those operating systems these days).

So it's possible that avoiding "export var=val" is mostly superstition,
and we could loosen our rules these days. But some things to consider:

  1. Some people may prefer reading the separated form (Junio indicates
     such in the thread linked above, but I don't know how strong a
     preference that is).

  2. We won't really know if there is a odd-ball shell that rejects it
     unless we make a change and wait for a while to see if anybody
     screams. The existing ones in ci/ show that it is not a problem for
     the platforms where we run CI, but I suspect the scripts in t/ see
     a wider audience.

I don't think this has any real bearing on the patches being proposed,
but I have been curious about this for our other scripts for a while
now.

-Peff
