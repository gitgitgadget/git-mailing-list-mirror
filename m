Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF362561AB
	for <git@vger.kernel.org>; Wed,  9 Apr 2025 12:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744201213; cv=none; b=RfYXzUm5d2xGg1P++X/212Iv5l2os0/GQ6h8z6YDkWJnVR1/L2bRzfQRrdl1yhMR6dIyw9/A128FjugU4iIDuk9iZ8zqkbc/zdSds7cGaARPzuG4IDm4+E69+DvXvhSKTvFi381cXSmeR3N/8E4iZzJg1gdODyOL3oEu3ODwAII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744201213; c=relaxed/simple;
	bh=y2xUS6+oogY+u0lSLrqCmJs7/cj3mt/OPquieiYaImM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jGo3QhzDSIzUaLyXGFE3AE6aEO+siL5qzAD7rYzy2tKuJpIvvcnnIb7B4iBXxoUlKa2IB+to83znPA/Tmn2cO1p457sjoDC1DqlQcGsAWH883tPXV6dFHP1NvSW1XGCU4Xu30xe6wyU3ZPNz6+GuTiUd+v0vjSsl1kFO6paEtC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-82-137.bstnma.fios.verizon.net [173.48.82.137])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 539CJPEY001034
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 9 Apr 2025 08:19:26 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id E7A7B2E00E9; Wed, 09 Apr 2025 08:19:24 -0400 (EDT)
Date: Wed, 9 Apr 2025 08:19:24 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Nico Williams <nico@cryptonector.com>
Cc: Junio C Hamano <gitster@pobox.com>,
        Martin von Zweigbergk <martinvonz@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Edwin Kempin <ekempin@google.com>, Scott Chacon <scott@gitbutler.com>,
        remo@buenzli.dev,
        "philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Subject: Re: Gerrit, GitButler, and Jujutsu projects collaborating on
 change-id commit footer
Message-ID: <20250409121924.GA148735@mit.edu>
References: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com>
 <xmqq4iyzn0vn.fsf@gitster.g>
 <Z/RFQY433muaCW44@ubby>
 <20250408125521.GA17892@mit.edu>
 <Z/VGYrrVZYQ13TLj@ubby>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z/VGYrrVZYQ13TLj@ubby>

On Tue, Apr 08, 2025 at 10:53:06AM -0500, Nico Williams wrote:
> I'm not keen on CR tools "intuiting" from.. similarity checks.  I don't
> love Git's similarity checks for file renames.  I get that for a
> distributed VCS assigning something like "inode numbers" is tricky, but
> as long as devs don't race to create the same files it was always
> possible to have UUIDs as "inode numbers" and avoid the similarity
> checks.

I'm not keen on fields that can have essentially random semantics.
Part of this is because today Change-ID is in the footer, and so
humans can randomly set it to any value they like.  Sometimes they cut
and paste footers, and so completely unrelated commits have the same
Change-Id which show up when you do a Gerrit lookup by Chnage-Id.
Admittedly, this aspect gets better if we shove it into the git commit
header.

Part of it is because some tools will edit the Change-Id when doing a
cherry-pick.  (For example, one tool that I'm familiar which is a CLI
front-end to Gerrit, when you run the command "kdt cherry-pick", will
unconditionally edit the Change-Id to a completely new value) --- and
some will not, because they are just do a "git cherry-pick" without
doing anything else.  And if you live in an ecosystem where some
poeple use "git cherry-pick", and other people do "kdt cherry-pick",
you basically have *no* guarantees about how Change-Id might behave
for different commits.  This *might* get better if we shove it into a
git commit header, although if you give people tools to edit the
Change-Id as part of a "git commit --amend", some tools might end up
changing the Change-Id in random ways again.

But then we have the problem where if patches get merged or split,
what Change-Id is really undefined today.  I could imagine that if a
commit gets split, both descedent commits should retain the same
Change-Id.  Or maybe if a patch stack gets collapsed, all of the
predecessor Change-Id should be included in that collapsed commit,
much like how an "Octopus Merge" might have a half-dozen or more
parent commits.  Defining the semantics here is part of the battle;
the other part of the battle would be how would the tools make sure
these semantics get obeyed.

Perhaps one approach might be that the hueristics that you hate being
used as an automated way to sort it out, might get used to set the
semantics at commit time, with perhaps a way for the user to override
the hueristics, or where the user has to explicitly acknowledge that
the hueristics correctly noticed that the patch has changed radically
and maybe the Change-Id shouldn't be retained any more?

Finally, perhaps there should be some discussion about whether we
think git should be maintaining indexes based on the Commit-Id.
Personally, cutting and pasting a random 17 character ID is painful
and annoying, and when I see it in my shell history, I have no idea
what might have been going on.  So if I need to cut and paste a
Commit-Id, I might as well cut and paste the one-line commit summary,
and do a "git log --grep" search based on that.  But if the Commit-Id
is indexed, then maybe it might be more useful?  I dunno....

> So how much of the [details] do you want specified?  If you want to be
> able to go from "change ID" to CR generically for all CR tools then the
> the best -and perhaps only reasonable- way is to make the change ID a
> URI.  Or if you think the [details] can be elided and still have
> semantics that are well-defined enough then I think you agree with me
> more than you disagree :)

Well, see above about some possible semantics.  I'm *still* not
convinced even with the better-defined semantics it's worth storing
the extra baggage in the commit header.  But that's more of a
value/philosophical question, much like how we "could" store explicit
file rename information in the git commit, but in the very early days
of the git design history, although BitKeeper did track file names,
Linus consciously decided to go down a much simpler path.  So that's
really more of a SMTP vs X.400 preference of simplicity versus
complexity in the protocol versus implementation, which is something
where people of good will might disagree --- and there Junio's
opinions matter far more then mine.  :-)

Cheers,

					- Ted
					
