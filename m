Received: from mail.inka.de (quechua.inka.de [193.197.184.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8DC227E80
	for <git@vger.kernel.org>; Thu, 13 Feb 2025 11:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.197.184.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739446710; cv=none; b=bTlMmLHPOuTiQE6FjaJbId/opw8bwYsPo0pFdEmN+nDuH8ak5XrciimvnzxB/bKbFwmGxBzSQKH1DYN4QgKE8yZYxb5sfIgRTcDgbmQJ+6lx9KXiwa7at04gYUPTh3UwcqhXtHs+NcsV8RV+WMkijzdUMjObATe1sPL9UwJiyws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739446710; c=relaxed/simple;
	bh=vMWj3eT/Hx7/z4f6qR9BuQqATYoeL6QbER/kHsN6x0E=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tlvwskJudc9r9GuhvwNXskAADR87jwFUo4VAMFbxerpnd8v/VVlaPjGLHOMgCa4aTIS2M/hu+mjoV8gqLHViiRA9XDk3J2KvytIQmT2EGVZ5FaNDES2cowUHG7N+7caUu0SD3etgXrO1M8Nv1rqwP6jPucEBINCMDLNVJYA7LxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=raven.inka.de; spf=pass smtp.mailfrom=raven.inka.de; arc=none smtp.client-ip=193.197.184.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=raven.inka.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raven.inka.de
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1tiXXt-007eHf-1k; Thu, 13 Feb 2025 12:38:17 +0100
Received: by raven.inka.de (Postfix, from userid 1000)
	id 6675F60117; Thu, 13 Feb 2025 12:36:14 +0100 (CET)
Date: Thu, 13 Feb 2025 12:36:14 +0100
From: Josef Wolf <jw@raven.inka.de>
To: git@vger.kernel.org
Subject: Collisions while cloning (was: Re: renormalize histroy with
 smudge/clean-filter, again)
Message-ID: <20250213113614.GS30202@raven.inka.de>
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
References: <20250205214726.GA30202@raven.inka.de>
 <20250211235707.GQ30202@raven.inka.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211235707.GQ30202@raven.inka.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi folks,

while investigating/recovering my problems with renormalizing with
clean/smudge filtering, I stumbled on collisions while creating a fresh clone
of the repo from the server:

   $ LANG= git clone ssh://gitrepos@my.server/repo
   smart-home-ets5hashes-removed
   Cloning into 'smart-home-ets5hashes-removed'...
   remote: Enumerating objects: 7499, done.
   remote: Counting objects: 100% (7499/7499), done.
   remote: Compressing objects: 100% (3263/3263), done.
   remote: Total 7499 (delta 3955), reused 7109 (delta 3594), pack-reused 0
   Receiving objects: 100% (7499/7499), 140.12 MiB | 10.54 MiB/s, done.
   Resolving deltas: 100% (3955/3955), done.
   Updating files: 100% (1423/1423), done.
   warning: the following paths have collided (e.g. case-sensitive paths
   on a case-insensitive filesystem) and only one from the same
   colliding group is in the working tree:
   
  'Projects/P-0113/B.ets5hash'
  [more files deleted]

This is on linux, so the FS is _not_ case-insensitive.

The list of files given here is almost identical to the list of files which
always give me collisions during renormalization process.

Here is an explanation of how and why those files ended up in the repo and a
hypothesis of why they might be in conflicting state.

Those files contain hash values of the real data files for a proprietary
application and are re-calculated on every invocation of the application. The
application won't even start up if those hashes don't match. And it won't tell
why it won't start, it just says "Corrupt data".

At the time this repository started, I had no knowledge how the hashes of
those files are calculated, so I had to commit them along with the associated
data files to keep the application happy. This results in conflicts with many
git operastions, of course.

Then I learned how those files can be re-calculated and wrote a smudge-filter
to keep them in sync with the data files.

Since I was now able to recreate those files, I put them into .gitignore and
installed the smudge-filter to recalculate them. But I left the files in the
repo as a fallback, just to be sure. And I kept committing them every now and
then whenever git showed differences, although they already were in
.gitignore.

So I guess those collisions might come from committing the ignored
files. Unfortunately, I could not reproduce this effect on a fresh repo, yet.

And the next question is: why do those conflicts cause the renormalization
process to completely fail, even when the conflicts are resolved during the
renormalization rebase? This, I also could not reproduced on a fresh repo.


On Wed, Feb 12, 2025 at 12:57:07AM +0100, Josef Wolf wrote:
> Still struggling with my filter problem.
> 
> Here is what I do:
> 
> - Set up a clean filter which enforces CRLF (yes, for this specific use
>   case I want CRLF even on linux)
> 
> - Smudge filter does not modify the file at all
> 
> - Set up git to fail when filter fails, so I can double-check that the
>   filter is actually runnning:
> 
>    $ grep -A3 filter..etsfile ~/.gitconfig
>    [filter "etsfile"]
>       required = true
>       clean = ets-utils -c
>       smudge = ets-utils -s %f
> 
> - Specify file as non-text and install the filter:
> 
>     $ grep etsfile .gitattributes
>     */P -text filter=etsfile
>     $ git commit .gitattributes
> 
> - Check that git gets attributes as I want them:
> 
>     $ git --attr-source=$(git rev-parse HEAD) check-attr -a P-0113/P
>     P-0113/P: text: unset
>     P-0113/P: filter: etsfile
>     $ git ls-files --eol P-0113/P
>     i/lf    w/      attr/-text              P-0113/P
> 
> - Create helper for renormalization
> 
>     $ cat renormalization-helper
>     #! /bin/sh -e
>     git add --renormalize .
>     git diff --quiet --cached || \
>         git commit --amend --no-edit
>     
> - Run the renormalization for the linear history:
> 
>     $ git --attr-source=$(git rev-parse HEAD) \
>          rebase --root -X renormalize \
>          -x $(dirname $0)/renormalize-helper
> 
> So at this point, I'd expect the falie to have CRLF line endings. But it
> doesn't, so I do:
> 
>     $ rm -rf P-0113
>     git checkout  --attr-source=$(git rev-parse HEAD) P-0113
> 
> Still no CRLF, so I look at what is stored by git:
> 
>     $ git --attr-source=$(git rev-parse HEAD) show 873a9b:P-0113/P |less -U
> 
> Again, no CRLF.
> 
> So I check all revisions in the history. Resut: no revision has CRLF.
> 
> So the renormalization process does not work for me at all.
> 
> Any ideas?
> 
> -- 
> Josef Wolf
> jw@raven.inka.de
> 
> 

-- 
Josef Wolf
jw@raven.inka.de
