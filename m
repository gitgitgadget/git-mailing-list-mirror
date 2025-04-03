Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4C22417D7
	for <git@vger.kernel.org>; Thu,  3 Apr 2025 10:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743676747; cv=none; b=NxuQYcyjFPZA7Mrx79aBNPzJ7gLzPX9oAZ1z/j2MpjALtR619/2ngZlvpvKqcKjytX/NRwecyy/9deh4Do4j+BYFPaEUsdbB7lC1OYRqr44oODGBLD3UqlL8rTjR5T89cw5Qp3ye8hFxjChmyL66PKZiT973k6kpuL3Vo0Kv4I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743676747; c=relaxed/simple;
	bh=cSXn0OEyX5FIrTkLTPeZ8vowX/hSmf6t+aKCNOLY/JY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=bPOoOY8M4ONTrGaGU1y1RKhsPJiGuyFkvW5voifOH15pa+a6xtdgCdb6KoWK2CI8Cs7c3t8vgBzGbvfzqACCZKGAYgmYAUHHBkEfPzXa6Tpv7nZ6+OHDBnZIldPw0DPTXEDUOx/2hzRzvESN6kQUaRuRHzrc+38/eyoANpPcEvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buenzli.dev; spf=pass smtp.mailfrom=buenzli.dev; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buenzli.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buenzli.dev
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4ZSyrv30khz9sv0;
	Thu,  3 Apr 2025 12:38:55 +0200 (CEST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 03 Apr 2025 12:38:52 +0200
Message-Id: <D8WXTCOESY86.3RRJOR5GPUL47@buenzli.dev>
Cc: "Git Mailing List" <git@vger.kernel.org>, "Edwin Kempin"
 <ekempin@google.com>, "Scott Chacon" <scott@gitbutler.com>,
 "philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Subject: Re: Gerrit, GitButler, and Jujutsu projects collaborating on
 change-id commit footer
From: "Remo Senekowitsch" <remo@buenzli.dev>
To: "Patrick Steinhardt" <ps@pks.im>, "Martin von Zweigbergk"
 <martinvonz@google.com>
References: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com> <Z-5QR57zgSsm6jNP@pks.im>
In-Reply-To: <Z-5QR57zgSsm6jNP@pks.im>

Hi Patrick,

On Thu Apr 3, 2025 at 11:09 AM CEST, Patrick Steinhardt wrote:
> On Wed, Apr 02, 2025 at 11:48:01AM -0700, Martin von Zweigbergk wrote:
>>
>> As mentioned, the three projects would like to use the same
>> storage and format. I think we have a consensus to store it in a
>> Git commit header called `change-id` as a 32 reverse-hex digis.
>> For example: `change-id ywlktllmukprnxnmzzprukpuwyztylwt`.
>
> I don't mind the actual format too much at this point, so I won't
> comment on this part.

Gerrit and GitButler also did not mind the format, which is why they
agreed to adopt the one of Jujutsu. There is also no technical reason
why Jujutsu wouldn't be able to support a free-form id. However,
discussing a standard for the ecosystem gives us the opportunity to
pick something that everybody can rely on and benefit from.

Some benefits of the proposed format include:
- known memory requirement
- change-id as part of a URL never has to be escaped
- it being a hash means the smallest unambiguous prefix is minimized

So, these are mostly practical considerations. If there are notable
benefits to free-form IDs, Jujutsu can hash that again to get an ID in
its internal format if necessary. But it's always easier to go from a
strict format to a loose one later, as opposed to the other way around.

> While there may not be a need to do anything in Git itself I would think
> that supporting change IDs natively in Git would still be sensible.
> Sure, you can emulate them via commit trailers. But I don't consider
> trailers to be particularly great as a storage format for this metadata.
> After all, you will want to filter the commit graph by change ID for
> some of the usecases, and doing that based on a loosely-defined format
> probably isn't great.
>
> So what would it take to get change IDs into Git? I think the most
> important items would be:
>
>   - Generating and writing change IDs in commands that support them.
>     This includes e.g. git-commit(1), git-commit-tree(1), git-merge(1),
>     git-merge-tree(1). This should of course be completely optional and
>     probably be disabled by default.
>
>   - Making tools that rewrite commits aware of change IDs so that they
>     know to retain change IDs. This involves e.g. git-cherry-pick(1),
>     git-rebase(1), git-replay(1).
>
>   - Extending revisions to allow specifying commits by change ID.
>
>   - Allowing us to filter commit graphs by change ID.

I agree with all of that. The first two points are the ones that would
actually allow the ecosystem to start relying on this new header as a
standard and develop related features while staying interoperable with
the rest of the ecosystem. E.g. if the header is preserved by
git-rebase, Git & Jujutsu users will enjoy stable change-ids when a
branch is rebase-merged on a forge. And if git generated the header
itself with git-commit, Gerrit could drop its requirement for clients
to generate a change-id footer via their commit-msg hook.

> The biggest question is of course backwards compatibility -- can we
> introduce a change ID into the commit metadata without breaking existing
> users? I guess you'll already have a lot of experience with this given
> that you essentially already inject change IDs into metadata, and tools
> generally handle this just fine?

Jujutsu has been injecting a 'jj:trees' header into commits to track
more metadata around merge conflicts. There weren't any problems with
that, unless one uses git to rewrite these commits with e.g. git-rebase,
in which case that header is simply lost. But commits with conflicts are
usually not pushed to a remote anyway, so the risk there was minimal.
Scott Chacon with GitButler has more experience in this regard, since
they actually push commits with a change-id in its header to remotes.
He told the Jujutsu community that they didn't encounter any problems,
no misbehaving tools that are fussy about unknown headers. The only
problem is unknown commit headers being dropped by Git itself, depending
on how it is invoked by the remote. (GitHub seems to preserve the header
during a rebase-merge, because they use git-replay. GitLab and Forgejo
drop the header.) With these insights from Scott, Jujutsu is moving
forward to put the change-id in the commit header.

> NB: I'm also quite happy that Jujutsu brings a bit of a new contender
>     to Git into the picture. It has a lot of nice ideas, and in the best
>     case Git might be able to learn a few nice tricks from JJ. After
>     all, I think we can all benefit from some friendly competition.

One of the best features of Jujutsu is that it plays nice with Git.
Most users work in "colocated" repos that have both a .git and a .jj
directory. Git commands continue to work as usual (mostly). If Git
adopted the change-id header, interleaving of Git and Jujutsu commands
would work even better.

So, +1 from me for friendly competition / collaboration. :-)

Remo
