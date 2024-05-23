Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2591C3E
	for <git@vger.kernel.org>; Thu, 23 May 2024 05:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716443402; cv=none; b=HZrn092yoq3hQgEWaAGh6kSCB/rKG0UY6Z/sg3Pa+OzienyBHSq41xaNEjnw8WCFgWDmByWdol96gw68aUe4mhlRgN0YIGoA83/nnnJZdiW+cPCbgAKYmEK2Fxp2qBa/JpZg00O11xmwJBO9RE3prFb+1fQ+98Ghtivax3wrYUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716443402; c=relaxed/simple;
	bh=oQtGHaXQz1hw15563Zlbux1tpuFctECidhli3F2c+5c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aPjf9HhovBmGuAQDln+mls/U0G7vYLHaHTJvPHdwaaxoGPrdCWlrJh1M26E2BVb0HRF0V8A5PsWx320/aYNgzuzadrcu4cOgcL2r/D9I8nCc6Rca6X6yQiIw6r9KaLY30Mq4ksCVdio886UHLizgM36IdvtXAGXsal7VuBmiBvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=P90xXqHG; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="P90xXqHG"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 9A0BD19BDD;
	Thu, 23 May 2024 01:50:00 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=oQtGHaXQz1hw15563Zlbux1tpuFctECidhli3F
	2c+5c=; b=P90xXqHGb9nlGR3tljO2JfHOaFfz2WaPN9TBG/1CN7giBMU/bVBEC1
	/lafZReJBVv27gkRGnrhCae1/+TtW7icVX4L4ch+XDd82DOgCJdWlKnQbQYtXVUZ
	fvwI4Qdgk1wmbCws/pQ9nQHcc0WeFhW5/yG0Ay6PYkfDuVfyB2g2M=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 933D319BDB;
	Thu, 23 May 2024 01:50:00 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2BE4319BDA;
	Thu, 23 May 2024 01:49:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: git@vger.kernel.org, Joey Hess <id@joeyh.name>
Subject: Re: [PATCH 00/12] Fix various overly aggressive protections in
 2.45.1 and friends
In-Reply-To: <Zk3ChIHr5amGh8Mt@kitenet.net> (Joey Hess's message of "Wed, 22
	May 2024 06:01:40 -0400")
References: <20240521195659.870714-1-gitster@pobox.com>
	<Zk3ChIHr5amGh8Mt@kitenet.net>
Date: Wed, 22 May 2024 22:49:55 -0700
Message-ID: <xmqqv835xekc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 492C9032-18C8-11EF-8D6F-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Joey Hess <id@joeyh.name> writes:

> Junio C Hamano wrote:
>> As people have seen, the latest "security fix" release turned out to
>> be a mixed bag of good vulnerability fixes with a bit over-eager
>> "layered defence" that broke real uses cases like git-lfs.
>
> "fsck: warn about symlink pointing inside a gitdir"
> (a33fea0886cfa016d313d2bd66bdd08615bffbc9) also broke pushing git-annex
> repositories to eg Gitlab and has several other problems including dodgy
> PATH_MAX checks that cause new OS interoperability problems. (I posted
> details to an earlier thread but have now found this current one, oops.)
>
> Please also revert it, or at least the portions for 
> and symlinkPointsToGitDir and symlinkTargetLength. The
> checks for symlinkTargetBlob and symlinkTargetMissing seem worth
> keeping.

Looking at the change in question, in a33fea08 (fsck: warn about
symlink pointing inside a gitdir, 2024-04-10), you said:

> fsck: warn about symlink pointing inside a gitdir
> 
> In the wake of fixing a vulnerability where `git clone` mistakenly
> followed a symbolic link that it had just written while checking out
> files, writing into a gitdir, let's add some defense-in-depth by
> teaching `git fsck` to report symbolic links stored in its trees that
> point inside `.git/`.
> 
> Even though the Git project never made any promises about the exact
> shape of the `.git/` directory's contents, there are likely repositories
> out there containing symbolic links that point inside the gitdir. For
> that reason, let's only report these as warnings, not as errors.
> Security-conscious users are encouraged to configure
> `fsck.symlinkPointsToGitDir = error`.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

I can make a few observations (in addition to what Joey already
observed in the code around PATH_MAX, etc. [*]):

 - Yes, if git-annex wants to keep its private data in a private
   directory .git/annex/objects it carved out for itself and want to
   point at them from the working tree with symbolic links, the
   extra check would trigger as fsck would see the symbolic link
   contents pointing into the .git/ directory, so certainly they
   would be affected.

 - The extra check seems to have meant to target the symbolic links
   that point at objects, refs, config, and anything _we_ care
   about, as opposed to random garbage (from _our_ point of view)
   files third-parties throw into .git/ directory.  Would it have
   made a better trade-off if we tried to make the check more
   precise, only complaining about the things we care about (in
   other words, what _we_ use), or will it become too brittle
   because what we care about will change over time?

 - In any case, if it is merely warnings, not errors, these checks
   can be configured out.  Wouldn't that be an escape-hatch enough?

So, I am ambivalent.  I have prepared a revert queued on maint-2.39
and cascaded it up to the maintenance track, which I tentatively
queued on top of 'seen', to see how much damage such a reversion
involves (and it did not look too bad), but

 (1) I am not sure if this is such a huge deal that requires a
     revert;

 (2) I am not sure which one is more practical between ripping
     everything out and demoting these new fsck error types with
     FSCK_WARN to FSCK_IGNORE.  If the structure of the code to
     perform these checks is more or less good and the actual check
     the code implements is bad, the latter might give us a better
     foundation to build on than rebuilding everything from scratch.
     On the other hand, if we are redoing things in the open, it may
     be better to forget about the code in 2.45.1/2.39.4 and to build
     from scratch for those reviewers and developers who will offer
     help.

 (3) As I look at the change by a33fea08 again, it actually adds a
     few new fsck error types with FSCK_ERROR.  Perhaps that is a
     good enough reason to do a straight revert for now?

Thanks.  It is past my bedtime so I won't be pushing out the 'seen'
with the revert I prepared as a practice, at least tonight.

[Reference]

 * https://lore.kernel.org/git/Zk2_mJpE7tJgqxSp@kitenet.net/
