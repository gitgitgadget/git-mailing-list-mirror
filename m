Received: from mail.inka.de (quechua.inka.de [193.197.184.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4C81DF27D
	for <git@vger.kernel.org>; Wed, 12 Feb 2025 08:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.197.184.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739348412; cv=none; b=tTyRZLCXFNzFpnECgBVigRp+dq9FWpZkYKB+MNpUaYf444BdRiVosHpEOSk0Rj/RySL6DYS15ZHhTvT8cvX18HqHYqIUoEe0OXU4NjvyVbUnh2eLAdyInVMexmHrLHVrQJta6J/H3rezELn5+P1BmfdIciS5UnfHWgF1IVdw8lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739348412; c=relaxed/simple;
	bh=+1aEvbb5o5HOtE80RxVFis/Xr/wdzm+uDbRQIJzUCJg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FUo+7L5Ofco70zE2jH+hzZHxlZebTXjIw0moRd4cdmsvQbSK0/n6MRFniA4XDvxmAc62WfiCjkTNKfzaNB7b3DWR8dY+V7vXnSqxUbuKdw+jawGx6MZhttsdh/0QpZqig6ZrZO4/QZj4Y8y33IF1jPoQUBOffrs0YpvufoCQ+bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=raven.inka.de; spf=pass smtp.mailfrom=raven.inka.de; arc=none smtp.client-ip=193.197.184.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=raven.inka.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raven.inka.de
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1ti7yW-006zzr-NH; Wed, 12 Feb 2025 09:20:04 +0100
Received: by raven.inka.de (Postfix, from userid 1000)
	id 9040B60117; Wed, 12 Feb 2025 09:18:42 +0100 (CET)
Date: Wed, 12 Feb 2025 09:18:42 +0100
From: Josef Wolf <jw@raven.inka.de>
To: git@vger.kernel.org
Subject: Re: renormalize histroy with smudge/clean-filter, again
Message-ID: <20250212081842.GR30202@raven.inka.de>
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
References: <20250205214726.GA30202@raven.inka.de>
 <20250211235707.GQ30202@raven.inka.de>
 <20250212061236.GA990@tb-raspi4>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250212061236.GA990@tb-raspi4>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Torsten,

On Wed, Feb 12, 2025 at 07:12:36AM +0100, Torsten Bögershausen wrote:

> > - Set up a clean filter which enforces CRLF (yes, for this specific use
> >   case I want CRLF even on linux)
> 
> In general, clean filters do their work when 'git add' or 'git commit file'
> is run.

Yes. This is done in the renormalise-helper shell script, which I included
into my description below:

> >     $ cat renormalization-helper
> >     #! /bin/sh -e
> >     git add --renormalize .
> >     git diff --quiet --cached || \
> >         git commit --amend --no-edit

> Does the filter do the CRLF conversion ?

As I wrote above: yes, the clean filter enforces CRLF

> Or is it done in .gitattributes ?

No. .gitattributes states that git should not modify the file since I have set
it -text, as I wrote:

> >     */P -text filter=etsfile


> > - Run the renormalization for the linear history:
> >
> >     $ git --attr-source=$(git rev-parse HEAD) \
> >          rebase --root -X renormalize \
> >          -x $(dirname $0)/renormalize-helper
> 
> That will change the index, the repo, but not the working tree on disk,
> right ?

"git reset --hard" or even "rm -rf P-0113; git checkout P-0113", also do not
bring the CRLF into the file, see below.

> > So at this point, I'd expect the falie to have CRLF line endings. But it
> > doesn't, so I do:
> >
> >     $ rm -rf P-0113
> >     git checkout  --attr-source=$(git rev-parse HEAD) P-0113
> >
> > Still no CRLF, so I look at what is stored by git:
> >
> >     $ git --attr-source=$(git rev-parse HEAD) show 873a9b:P-0113/P |less -U
> >
> > Again, no CRLF.
> 
> Just to make sure:
> You want to see the CRLF in the files on disk ?

In the first place I want to see them in the repo. And a fresh checkout should
bring them into the files on disk, since -text is in effect.

> Do you have a valid .gitattributes file on disk now ?

git recognizes my setting -text and filter=etsfile, as I wrote:

> >     $ git --attr-source=$(git rev-parse HEAD) check-attr -a P-0113/P
> >     P-0113/P: text: unset
> >     P-0113/P: filter: etsfile

> If yes, what does 'git ls-files --eol P-0113' say ?

As I wrote above:

> >     $ git ls-files --eol P-0113/P
> >     i/lf    w/      attr/-text              P-0113/P

> What does 'git status' say ?

Nothing, since

  git add --renormalize . && git commit --amend --no-edit

have been done by the helper script on every commit of the history

> > So I check all revisions in the history. Resut: no revision has CRLF.
> > So the renormalization process does not work for me at all.
> 
> In general, renormalization is about the content inside the repo.
> If a filter is applied, or .gitattributes are changed, the files
> on disk are not updated automatically.

This is why I checkd the contents which are stored in the repo:

> >     $ git --attr-source=$(git rev-parse HEAD) show 873a9b:P-0113/P |less -U

> 'mv -f P-0113 /tmp && git checkout P-0113' may be needed.

Well, I did this instead:

> >     $ rm -rf P-0113
> >     git checkout  --attr-source=$(git rev-parse HEAD) P-0113

> Yes. The best thing to do (tm) would be to create a dummy repo,
> do all all the operations from scratch and post the stuff here.
> In other words, write a shell script that creates an empty repo,
> fills it with content, and does all the operations.
> That would enable people to reproduce it and look what is going on.
> Hope that make sense.

Well, if I _knew_ what triggers the problem, I could create such a script.

As long as I can not figure what triggers the problem, I have to dig into
internals of this old repo with long-running history.

-- 
Josef Wolf
jw@raven.inka.de
