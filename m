Received: from mail.inka.de (quechua.inka.de [193.197.184.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E641519B0
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 00:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.197.184.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738800024; cv=none; b=S+y3583jZCy6RxYj/MungmLpQ8gPDq3CtcUM+ssShOO0KGGTNejegBI3+IVaetBxTib12H8UzSKqUn+mCN0FMr6cNrYnitX7oXNA5f9M83QfUxg0atiX/BUMtNwYxO5kr+leQGxX6qEXBc7gFuWxe4TpuXX1d1ZmqIahR/6Kg2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738800024; c=relaxed/simple;
	bh=vHqHlo2tT9uaYO5GfySy0EUWOXmbfAfvqYXV89EVrCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hpdqzIXfPy+ZSIMuAZx2dSQgRHqnZWbHAUXs35sNSxThP34O0rpLNc6B/R6nUkk8Y5Pz+lB29BKKVhpF33PgPZ0p2QtbBjeAv69ormHc8xjsdM5nih2VgCH6cT8GeEraFhC3bVzhRslTmy1K7AXPA7oMLDTbmWyaglBqdorqlro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=raven.inka.de; spf=pass smtp.mailfrom=raven.inka.de; arc=none smtp.client-ip=193.197.184.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=raven.inka.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raven.inka.de
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1tfpJZ-003Pu7-1a; Thu, 06 Feb 2025 01:00:17 +0100
Received: by raven.inka.de (Postfix, from userid 1000)
	id 5A70860117; Thu,  6 Feb 2025 00:59:31 +0100 (CET)
Date: Thu, 6 Feb 2025 00:59:31 +0100
From: Josef Wolf <jw@raven.inka.de>
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>
Subject: Re: renormalize histroy with smudge/clean-filter
Message-ID: <20250205235931.GB30202@raven.inka.de>
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>
References: <20250205214726.GA30202@raven.inka.de>
 <Z6PsXGnxM3UBR3nM@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6PsXGnxM3UBR3nM@tapette.crustytoothpaste.net>
User-Agent: Mutt/1.10.1 (2018-07-13)

Thanks for your help, Brian!

On Wed, Feb 05, 2025 at 10:55:24PM +0000, brian m. carlson wrote:
> On 2025-02-05 at 21:47:26, Josef Wolf wrote:
> > 
> > Huh? I never entered a command "merge-renormalize"
> 
> When you use command like `--strategy foo` with a custom strategy, Git
> calls a binary called `git merge-foo` to implement that strategy.  So
> while you didn't explicitly invoke that, when you used the nonstandard
> strategy `renormalize` (which, by the way, does not exist), Git invoked
> it when you rebased, since rebases by default use merges under the hood.

Uh, You're right: renormalize is not a merge-strategy on its own but an option
to the ort strategy.

   $ git rebase --root --strategy ort -X renormalize
   Updating files: 100% (372/372), done.
   error: Your local changes to the following files would be overwritten by merge:
       gt8/P-0113/G
       gt8/P-0113/P-0113-0_A-2
       gt8/P-0113/U
   Please commit your changes or stash them before you merge.
   Aborting
                        
Those are (some) of the files which are subject to the filtering. I can go
further with:

  $ git add --renormalize . && git commit --amend --no-edit && git rebase --continue

So this approach works. Although it needs some manual intervention.

> > BTW: It does not make any difference whether I add "-c merge.renormalze=true"
> 
> That option also does not exist.

Well, this is described in git(1) manpage:

   [ ... ]
   SYNOPSIS
       git [-v | --version] [-h | --help] [-C <path>] [-c <name>=<value>]
   [ ... ]                                            ^^^^^^^^^^^^^^^^^^^


> git rebase --root -x 'git add --renormalize . && git commit --amend --no-edit'

Unfortunately, this runs the command on every commit and gives a warning when
a cmmit don't touch a filtered file:

  $ git rebase --root -x 'git add --renormalize . && git commit --amend --no-edit'
  [ ... ]
  No changes
  You asked to amend the most recent commit, but doing so would make
  it empty. You can repeat your command with --allow-empty, or you can
  remove the commit entirely with "git reset HEAD^".

Is there a way to run the command only when rebase halts?

-- 
Josef Wolf
jw@raven.inka.de
