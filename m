Received: from mail.inka.de (quechua.inka.de [193.197.184.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAFA1519AB
	for <git@vger.kernel.org>; Fri, 14 Feb 2025 20:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.197.184.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739563460; cv=none; b=t02XZwBKu+reX8uKiwbWNnwfRrOq1uGEgxmFYfUNsJ66TXcSvNb6HDRt/epQ0/wpIDHXjz7kyxO/pmaUP6v99Wakd9tiql4nT36fX5ORqOqlb5d6fXYU4y7AprRp4fsXUt2XshZe7EyQKHEZD3Tq8QAm/RoznHLN/Jqmr7ZNhxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739563460; c=relaxed/simple;
	bh=s7mMKCBCho33KV/Muef2WZRn6+7AiquSB1M8p2km9B8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qi3AUW/+znRJg2ssyjmDZMMMP715Zg9Wmmd48huyYdlcsUoSii16geG7abpyeO89Augnlm7v9Tfc4ysMW9igbYnQvVBko+nvln6WfAcRNAgauMzpztRzn0aZHPLcfqWI3GAlJ8/zMDfHdpwFPzcJC7QLTHsJc0lv0H0ZJv20w4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=raven.inka.de; spf=pass smtp.mailfrom=raven.inka.de; arc=none smtp.client-ip=193.197.184.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=raven.inka.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raven.inka.de
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1tj1uw-008L2X-VN; Fri, 14 Feb 2025 21:04:06 +0100
Received: by raven.inka.de (Postfix, from userid 1000)
	id CDCC360117; Fri, 14 Feb 2025 21:03:13 +0100 (CET)
Date: Fri, 14 Feb 2025 21:03:13 +0100
From: Josef Wolf <jw@raven.inka.de>
To: git@vger.kernel.org
Subject: Re: renormalize histroy with smudge/clean-filter, again
Message-ID: <20250214200313.GT30202@raven.inka.de>
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

Since none of the methods using plain git worked, my next try was to reach out
to git-filter-repo:

Again, using my renormalize-helper script:

  $ cat renormalize-helper
  #! /bin/sh -e
  
  git add --renormalize .
  git diff --quiet --cached || \
      git commit --amend --no-edit

So I go with git-filter-repo:
 
   $ git clone ssh://gitrepos@my.server/repo fresh-clone
   $ cd fresh-clone

   $ git-filter-repo \
       --prune-empty always \
       --invert-paths --use-base-name \
       --path-regex '\.ets5hash$'

   $ for branch in branch-1 branch-2 branch-3 ; do
        git checkout -b $branch-renormalized $branch
   
        git add --renormalize .
        git diff --quiet --cached || \
             git commit -m"Renormalize HEAD"
   
        git rebase \
             --root -X renormalize \
             -x $renormalize_helper
     done

This went without problem and contents looked fine, so I really thought I got
it finally.

But then I tried to move .gitattributes to the very beginnig of history:

   $ git rebase -i --root

AGAIN conflicts due to line ending errors. Adding
'--attr-source=$(git rev-parse HEAD)' and '-x renormalize-helper' did not
help beside moving the conflicts to another location.

Thus, although the renormalization process finished successfully, there are
_still_ commits with unclean content in the repository.

I REALLY REALLY REALLY think there should be an option

--always-apply-clean-filter-to-all-content-before-feeding-to-merge-or-diff

or something!



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
