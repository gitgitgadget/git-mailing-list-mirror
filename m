Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A650126A0FF
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 12:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744117081; cv=none; b=HBcVuwFCroOaI/rGh9DaSZVpvYT4G+uToCwDBJxyXrjZydX/1CqJ4JzN+gqWHiMfc42dJ3jJ1bY5DtICYv/4S07oVIpH72fg2SMXKzEwjGjkex9MWO4u/9QbbuXUk7isfOFEb6a9tsEMH6VJEX92NTGppEw97q4AwbBBW6Etx7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744117081; c=relaxed/simple;
	bh=MbO0aXLTNyIqU9nH4DmBLa1on1nMTMKddxnQ1eeMApY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AH/kvV9lZMX1sWbIbCNNZeB3kL64zXQzQcmHQPTHjEeVMx2QOtBqRUMo94cGtMTkOySlYe6THwLfkaQiWZmvWE11G8C5Atrw7tMfV0AlSGGFllpJM4WqY1zkZfw9+fx89k17vJpSgGpmq6MhjplgSIUuWYZ+1nNB6YwxdqIg4zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-113-3.bstnma.fios.verizon.net [173.48.113.3])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 538CtLmU017278
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 8 Apr 2025 08:55:22 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 170EA2E00E9; Tue, 08 Apr 2025 08:55:21 -0400 (EDT)
Date: Tue, 8 Apr 2025 08:55:21 -0400
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
Message-ID: <20250408125521.GA17892@mit.edu>
References: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com>
 <xmqq4iyzn0vn.fsf@gitster.g>
 <Z/RFQY433muaCW44@ubby>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z/RFQY433muaCW44@ubby>

On Mon, Apr 07, 2025 at 04:36:01PM -0500, Nico Williams wrote:
> This is why I suggested earlier that there need to be multiple change
> IDs, not just one.  Perhaps one is a "code review ID" and another is
> a "commit change ID".  The code review ID would let you link together
> all commits that were reviewed together, so if you have to split or
> squash commits they would all still have that one code review ID.  The
> commit change ID would be shared by all sufficiently-similar versions of
> a commit.  If a commit is dropped or split or squashed then its commit
> ID might get dropped too, but the code review ID would stay the same.

I think "code review ID" makes a lot of sense, although what I would
call it is "patch series ID".  This has very clear semantic: it ties
commits which should be grouped together as a single higher-level set
of changes.  It could be used by "git format-patch" / "git send-email"
to automatically send a group of patches as a logical unit.

I'd include the "patch series ID" in the e-mail that gets sent out, so
that "git apply-message" would be able to retain the patch series ID.
Patchwork could use the Patch series ID to automatically mark a v2
version of patch series as obsoleting the v1 version of the patch
series.  So it would be a lot more useful for than just for
Gerrit-style workflows, and that's a good sign that feature makes
sense from a design perspective.

I'll note that even without the "commit change ID", just simply
knowing that one patch series is a newer version of a pre-existing
patch series is enough to allow Gerrit to intuit which commit is a
newer version of another commit.  For singleton commits, nothing else
is necessary.  For multi-commit patch series, gerrit could use the
one-line commit description to associate commits; it could use
ordering of the patches; it could just see which commit contents are
similar to previous commits, much like how git detects renames.

In my experience looking at how kernel developers use gerrit versus
e-mail workflows, in general, gerrit patch series tend to involve a
smaller number of commits, because looking at how various files change
between commtis is awkward; and with e-mail workflows, the patch
series tend involve a larger number of commits, because reviewing
smaller commits is easier with e-mail.

So if this true for other communities using web-based review
workflows, using an hueristics instead of a "commit change ID" might
be sufficient --- and for those communities that run into problems,
they could continue to use a gerrit-style "Change-ID: " in the footer,
with the hueristics being used if for some reason commits that don't
have the Change-ID make it into Gerrit.

> > Quite frankly, I think the concept of "change ID" is nice but it is
> > not mechanically trustable.  Recording them in the trailers is fine,
> > but I somehow feel that they have a clear-cut semantics everybody
> > can agree on to deserve to be in the header part of commit objects.
> 
> I don't think they need to have such extremely detailed semantics in
> order to be able to get a header.  The semantics will ultimately be
> somewhat project-defined, typically something like "during code review
> you can use these to related newer updates to an MR/PR/CR to older
> versions" and "once integrated you can use these to find the approved
> code review as follows [details]".  The [details] (probably a URI
> template) for finding concluded CRs might vary.  The CR tool might vary.
> The construction of the change IDs might vary.  The intent might not
> vary at all.

I disagree.  From long experience, allowing something into an
interface that doesn't have strongly defined semantics has lead to
*huge* problems.  This has certainly been the case for
Kernel<->Userspace interfaces; so my bias is that if we can't define
strong semantics, then we should probably avoid adding that interface
until we can.  Otherwise, this can lead to a huge number of headaches,
both for developers and users.

People *will* develop automation tools suing an official "commit
change ID", assuming that how their project (or their forge site) uses
the ill-defined Change ID is the One True Way that the badly defined
field should be used.  And other people will developer *other* tools
assuming some other interpreation for that field.  And then the git
developers and users will be left trying to pick up the pieces.

Cheers,

						- Ted
