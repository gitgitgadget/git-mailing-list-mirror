Received: from mail.inka.de (quechua.inka.de [193.197.184.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D31243962
	for <git@vger.kernel.org>; Sat,  8 Feb 2025 20:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.197.184.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739048310; cv=none; b=UiDpK6S0kWUYgWCzsbGXjw872pNlCK5lvLkNR+EDbz0GsQPP7Jw1CbZoDr6HIm1sddql/eNA/WP582zVsJOAMPaizucHPhTQIGQRTNpA2rn1k9oCuGA2MUKgNik2m0LA3q56WzlWQq9rMMKxOIt74IEmW3Wfd7XT9u/E9ctOkDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739048310; c=relaxed/simple;
	bh=yfPeTyRVjNZfJ3ZGXzlfWmk/hS0khkRngz8D9s3LJfI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M8x/U0dR5W6dJBq3jcBy8M/cUjbIlYhyYcE04EqnpvT0c1+31pNMck4nKxbU51IUKCQqVfRK57BevvXKWdHkmxrZ+m0jSsqK/xa2t8KuOWyT2wCq7Z5etSx7wfhye41BhMN2tfqnlCsPwhmEvVENz2vTbkuhUF1utQc4JRUkWHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=raven.inka.de; spf=pass smtp.mailfrom=raven.inka.de; arc=none smtp.client-ip=193.197.184.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=raven.inka.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raven.inka.de
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1tgru4-0052pa-Pt; Sat, 08 Feb 2025 21:58:16 +0100
Received: by raven.inka.de (Postfix, from userid 1000)
	id D19A060117; Sat,  8 Feb 2025 21:57:09 +0100 (CET)
Date: Sat, 8 Feb 2025 21:57:09 +0100
From: Josef Wolf <jw@raven.inka.de>
To: git@vger.kernel.org
Subject: Re: renormalize histroy with smudge/clean-filter
Message-ID: <20250208205709.GH30202@raven.inka.de>
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
References: <Z6QCX1QZxxwC7RVQ@tapette.crustytoothpaste.net>
 <CABPp-BFZ3oyKiryKMPph+nfokC=sFa7wn1wdas863273bzy7pA@mail.gmail.com>
 <20250206134006.GC30202@raven.inka.de>
 <20250206200418.GD30202@raven.inka.de>
 <CAPx1Gvc2piLT=p+dvzcJPTMDQAAjQfz__O4KiRWs-fOMg8dpTw@mail.gmail.com>
 <20250207104510.GE30202@raven.inka.de>
 <CAPx1GvcyaZqYK+SvgtfsajqtkMty1jOcVAtwfmam-LpOjyd0jw@mail.gmail.com>
 <CABPp-BFnx2m75jsa3_kTPet97HY+xwb_6JmPiKM5+OARPy=mGA@mail.gmail.com>
 <20250207203248.GG30202@raven.inka.de>
 <CABPp-BFGUa_DRBe1WLVfCOKh53+F15KxW_c_OZAMwZCxuAQCiw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPp-BFGUa_DRBe1WLVfCOKh53+F15KxW_c_OZAMwZCxuAQCiw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Feb 07, 2025 at 04:23:45PM -0800, Elijah Newren wrote:
> I may have misunderstood what folks were saying in my reading &
> skimming of this thread.  I thought some folks were suggesting
> 
>    git rebase --root -X renormalize
>
> as a way to renormalize the history, assuming you have linear history.

Yes. And this did not work.

Then there was Brian's suggenstion, so I tried:

   git rebase --root -x 'git add --renormalize . && git commit --amend --no-edit'

which won't work because not every commit touches a filtered file, so I also
tried:

   git rebase --root -x 'git add --renormalize . && git status --quiet -uno | git commit --amend --no-edit'

which also did not work. Looks like git-status always exits with success. Why?

> I was arguing against that; it's not going to work and isn't meant
> to[1].  I also see I didn't look closely enough at Phillip's
> suggestion, which was:
> 
>    git rebase --root -x 'git add --renormalize . && { git diff --quiet
> --cached || git commit --amend --no-edit; }'
> 
> which will work if you do a lot of manual work to resolve line ending
> difference conflicts.  Since the git add at each step will modify the
> files on which the next commit is based, that causes the application
> of the subsequent commit to conflict, and you probably will have
> difficulty seeing those conflicts since they tend to just be line
> ending differences.

This did not work also: generated LOTS of conflicts.

Oh, have I mentioned that I am not only about line endings? Yes, I mentioned
it in the very first mail. In addition to line endings, I am also about XML
files from a proprietary application which reorders the XML-elements into a
random order every time it ist run. So the clean-filter needs to sort the
XML elements into some "canonical" order.

> But, mixing that with Brian's suggestion, you get:
> 
>   git rebase --root -X renormalize -x 'git add --renormalize . && { git diff --quiet --cached || git commit --amend --no-edit; }'

Yes, this finally works, IF

   git add --renormalize . && git commit --amend --no-edit

is run before starting the rebase process.

BTW: why won't

    git rebase --root -X renormalize \
     -x 'git add --renormalize .' \
     -x 'git diff --quiet --cached || git commit --amend --no-edit'

work?

> Were you trying one of these three?  Or something else?

Yes. And even more...

Oh, the application I am talking about also tracks changes in those XML files
in corresponding hash files. I added those hash files into .gitignore and
re-create them in the smudge-filter. This works fine so far, but it also
generates lots of conflicts during renormalization. So I created a helper for
the -x parameter of the renormalize-process to also remove those hash files:

   #! /bin/sh -e
   
   find gt8/ETS/Projekte/* -maxdepth 1 \
      -name "[BDGIUP].ets5hash" -o \
      -name "P-*.ets5hash" \
      -print0 \
     | xargs -r0 git status --short -uno \
     | sed -n "s/^...\(.*\.ets5hash\)$/\1/p" \
     | xargs -r git rm -f git --attr-source=$(git rev-parse HEAD) diff --quiet --cached || \
           git --attr-source=$(git rev-parse HEAD) commit --amend --no-edit
   
   git --attr-source=$(git rev-parse HEAD) add --renormalize .
   git --attr-source=$(git rev-parse HEAD) diff --quiet --cached || \
       git --attr-source=$(git rev-parse HEAD) commit --amend --no-edit

But no matter how I construt this, the renormalize keeps conflicting on these
files. Whehn I do

    git rm -f gt8/ETS/Projekte/XXX/U.ets5hash
    git --attr-source=$(git rev-parse HEAD) commit --amend --no-edit
    git rebase --continue

manually, it works fine. Why won't the git-rm work when called from git-rebase directly?

> [1] The renormalize option to the merge machinery ensures that new
> blobs produced by the merge have normalized content, and avoid
> conflicts when the only differences between files are normalization
> ones.  This option does not ensure that new trees only reference new
> content nor that they only reference normalized content; _any_
> pre-existing blobs in the repository are fair game for new trees to
> reference.

OK.

But then, non-normalized content should go through the clean-filter before it
is handed over to diff/merge when filtering is active. At least when --renormalize
is in effect. Using smudged content for diff/merge operations is a sure recipe
for failure.

> As per the manual: "renormalize...This runs a virtual
> check-out and check-in of all three stages of a file when resolving a
> three-way merge..."  So, the existing behavior of the renormalize
> option to rebase/cherry-pick/merge is correct.

A virtual check-out and check-in should result in smudge+clean. Running this
on smudged content results in smudge+smudge+clean. Which by definition is
equivalent to a simple clean. No conflicts shoud happen, then.

So the _description_ looks correct. But where do the conflicts coming from?

> It may not be what you want

I don't see how the description matches actual behaviour

-- 
Josef Wolf
jw@raven.inka.de
