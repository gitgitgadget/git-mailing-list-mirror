Received: from mail.inka.de (quechua.inka.de [193.197.184.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C7B27180D
	for <git@vger.kernel.org>; Tue, 11 Feb 2025 23:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.197.184.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739318310; cv=none; b=rS7pDIDqvT4A4fsebb2TlIwJpS+EXxm1IJLrueyVfQcI6oQ16ouCKEm+R58/FPJh3xL/ckWANeQMkt9YQYg3qwOEzQq4l8QOaxcD51bRiHGpvRoxRWbcxP5u0eYrqHYL1TDxe/B2c6eone/cp+oEfug35Q70OBlQye1tJsdJzIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739318310; c=relaxed/simple;
	bh=TUAQHji8GHMx8BxSSElhb1ZsPL8jCp3EyBfgsS2Ub3g=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZwRFHS6XapC1iBuNrja0g4wgpG9kxkXgL2qupihRmgIWKgpYfJioqfTAj9xLo4kzDzGWQTwBzw1YPffnWtyS1U8VsB3vcdnxN9v4LdQZ1gwrufxDJHi1G5fphqHLmIyGROxvsO02QoQVmsqoZx7b6QktswsKtEzrdhEekH115vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=raven.inka.de; spf=pass smtp.mailfrom=raven.inka.de; arc=none smtp.client-ip=193.197.184.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=raven.inka.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raven.inka.de
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1ti08v-006oHZ-7W; Wed, 12 Feb 2025 00:58:17 +0100
Received: by raven.inka.de (Postfix, from userid 1000)
	id 88F0A60117; Wed, 12 Feb 2025 00:57:07 +0100 (CET)
Date: Wed, 12 Feb 2025 00:57:07 +0100
From: Josef Wolf <jw@raven.inka.de>
To: git@vger.kernel.org
Subject: Re: renormalize histroy with smudge/clean-filter, again
Message-ID: <20250211235707.GQ30202@raven.inka.de>
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
References: <20250205214726.GA30202@raven.inka.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205214726.GA30202@raven.inka.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

Still struggling with my filter problem.

Here is what I do:

- Set up a clean filter which enforces CRLF (yes, for this specific use
  case I want CRLF even on linux)

- Smudge filter does not modify the file at all

- Set up git to fail when filter fails, so I can double-check that the
  filter is actually runnning:

   $ grep -A3 filter..etsfile ~/.gitconfig
   [filter "etsfile"]
      required = true
      clean = ets-utils -c
      smudge = ets-utils -s %f

- Specify file as non-text and install the filter:

    $ grep etsfile .gitattributes
    */P -text filter=etsfile
    $ git commit .gitattributes

- Check that git gets attributes as I want them:

    $ git --attr-source=$(git rev-parse HEAD) check-attr -a P-0113/P
    P-0113/P: text: unset
    P-0113/P: filter: etsfile
    $ git ls-files --eol P-0113/P
    i/lf    w/      attr/-text              P-0113/P

- Create helper for renormalization

    $ cat renormalization-helper
    #! /bin/sh -e
    git add --renormalize .
    git diff --quiet --cached || \
        git commit --amend --no-edit
    
- Run the renormalization for the linear history:

    $ git --attr-source=$(git rev-parse HEAD) \
         rebase --root -X renormalize \
         -x $(dirname $0)/renormalize-helper

So at this point, I'd expect the falie to have CRLF line endings. But it
doesn't, so I do:

    $ rm -rf P-0113
    git checkout  --attr-source=$(git rev-parse HEAD) P-0113

Still no CRLF, so I look at what is stored by git:

    $ git --attr-source=$(git rev-parse HEAD) show 873a9b:P-0113/P |less -U

Again, no CRLF.

So I check all revisions in the history. Resut: no revision has CRLF.

So the renormalization process does not work for me at all.

Any ideas?

-- 
Josef Wolf
jw@raven.inka.de
