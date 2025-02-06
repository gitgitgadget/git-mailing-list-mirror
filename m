Received: from mail.inka.de (quechua.inka.de [193.197.184.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C040A1EA7F6
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 13:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.197.184.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738849226; cv=none; b=SOaLzHodNbXoEKR69KHSdooq9CeHXVpR/WegWB3GJ1mqbbNTjKoRqpSj7kBraliHiBaz5FxC6wnNtzxPgA4gthAegvpWT/cQRynweAoBye4FKW30jjHPx+WP3UbpD5IxQAXcUeG2ROM2eDT4hVrtN1WqAyUfaasZ02lxn33gCD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738849226; c=relaxed/simple;
	bh=cuDlYH9OXxDLhaDxC/7DzJ0NashIrKcpzSaZFmWgf4A=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hDySNqyNP5mXF4XrTlxdxE6aXydsuCjMP8h5Ae3yaBu7k+95j06onuMLUaEp6z/TX95EyxfhnpqmfGq6I4TFZp7V2UiBdyfGFCLPkdXq6xxD5dOhtg2uFa+DHSOz4kjJuDC5kClP+9Z57DxvvgDiqjT1DZhs8hyYDeL8f/VLGLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=raven.inka.de; spf=pass smtp.mailfrom=raven.inka.de; arc=none smtp.client-ip=193.197.184.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=raven.inka.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raven.inka.de
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1tg277-003iTf-3P; Thu, 06 Feb 2025 14:40:17 +0100
Received: by raven.inka.de (Postfix, from userid 1000)
	id 0DF2B60117; Thu,  6 Feb 2025 14:40:07 +0100 (CET)
Date: Thu, 6 Feb 2025 14:40:06 +0100
From: Josef Wolf <jw@raven.inka.de>
To: git@vger.kernel.org
Subject: Re: renormalize histroy with smudge/clean-filter
Message-ID: <20250206134006.GC30202@raven.inka.de>
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
References: <20250205214726.GA30202@raven.inka.de>
 <Z6PsXGnxM3UBR3nM@tapette.crustytoothpaste.net>
 <20250205235931.GB30202@raven.inka.de>
 <Z6QCX1QZxxwC7RVQ@tapette.crustytoothpaste.net>
 <CABPp-BFZ3oyKiryKMPph+nfokC=sFa7wn1wdas863273bzy7pA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BFZ3oyKiryKMPph+nfokC=sFa7wn1wdas863273bzy7pA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Thanks for all the insights and explanations!

I have to admit that I have a hard time to understand why the merges (and even
conflicts) happen.

I have a totally linear history here. Thus, I'd expect the rebase to do
something like (in pseudo-code)

   foreach $commit original-branch-commits
       git cherry-pick $commit

So I tried this and I see that cherry-pick seems to ignore the clear-filter
setting and commits the smudge'd version?

My expectation would have been that every operation would run the clear filter
before storing it in the repo.

Why is not everything going into the repo cleared?

On Thu, Feb 06, 2025 at 12:07:00AM -0800, Elijah Newren wrote:
> On Wed, Feb 5, 2025 at 4:29 PM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> >
> > On 2025-02-05 at 23:59:31, Josef Wolf wrote:
> > > > > BTW: It does not make any difference whether I add "-c merge.renormalze=true"
> > > >
> > > > That option also does not exist.
> > >
> > > Well, this is described in git(1) manpage:
> > >
> > >    [ ... ]
> > >    SYNOPSIS
> > >        git [-v | --version] [-h | --help] [-C <path>] [-c <name>=<value>]
> > >    [ ... ]                                            ^^^^^^^^^^^^^^^^^^^
> > >
> >
> > The -c option does exist, and apparently the merge.renormalize option
> > does as well, so I apologize.  It looks like it's only used in
> > merge-recursive and not merge-ort.c, so I'm not sure if it's still
> > effective.  Elijah would know for certain, since he's the author of
> > merge-ort as well.
> 
> init_*merge_options() are defined in merge-recursive.c, and these call
> merge_recursive_config() which is also in merge-recursive.c, but the
> parsed options are shared between the two backends; you'll note that
> merge-ort.h includes merge-recursive.h to get all these.  And
> merge-ort does have the necessary code to use and understand the
> merge.renormalize option.  (Of course, the fact that renormalization
> *requires* an index made it a bit nasty, because merge-ort was written
> to avoid the index as a data structure, so I had to do some ugly
> shenanigans in order to support that option --
> https://lore.kernel.org/git/CABPp-BE1TvFJ1eOa8Ci5JTMET+dzZh3m3NxppqqWPyEp1UeAVg@mail.gmail.com/.
> But that's beside the point here.)
> 
> 

-- 
Josef Wolf
jw@raven.inka.de
