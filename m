Received: from sirabella.org (sirabella.org [207.246.81.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15068062A
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 07:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.246.81.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709625256; cv=none; b=L9MIALl1Pm51INimb/gFt2sHznmuwu6fwvEIYi2ONM4fs716AZFyocmiKtaM+9pynN81lJUneEk6kk4IBnGfT6qlcKF7E83QoK4qRr5haQpwk1UDOsz4Rg6hR8gsC8YxbPIFSzx398hKFQEQ906rc+JUpuv0jJpn+g3vCeiBjJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709625256; c=relaxed/simple;
	bh=EKiPtKePlyZethdzF+Qb2NtmfkGY6SxVXZyI4sJgMmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fuiKUAgiCah+Rp27GJ6kj4Eyr7qVSvkeLGKS73h54qZeEadFEvXsLRvGE1ef5RN03s2PGUcSuPYtIZHIGwGxCwumeU1XXQ3/Ivk37/u2ZZf2GGnugaNWNm0mGplQ+2A3AXUpCdSGoe9uXTHHNefgavXJQounLBSe5w5frSZhe7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sirabella.org; spf=pass smtp.mailfrom=sirabella.org; dkim=pass (1024-bit key) header.d=sirabella.org header.i=@sirabella.org header.b=WPAG4Enz; arc=none smtp.client-ip=207.246.81.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sirabella.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sirabella.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sirabella.org header.i=@sirabella.org header.b="WPAG4Enz"
Date: Mon, 4 Mar 2024 23:53:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sirabella.org;
	s=mail; t=1709625253;
	bh=xdDAjdgH/adCQ8OuLiQFBQ5A+raKbvAcBa/FxnS45fk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WPAG4EnzEHdYEK02I0zuurOxHDQVKRHhUEqdlv0ZIHKP4R/KwZxGRqHbKsN8CccqE
	 IrGnseCFm/MsdJJnyOtQBeX4RtG8KkFjtpSMi9ACguxYpJJyhBhd78McnftEUSy7/b
	 MRF7m94S2nwVRrqi65WB6GGuZbUCSejV0e9noRMA=
From: Marco Sirabella <marco@sirabella.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] gpg-interface: Look up signing keys with only email
 address
Message-ID: <20240305075339.tpmaa4xobng7zvbz@Ne0Ridl3y>
References: <20240305020815.2980-1-marco@sirabella.org>
 <xmqqy1ax5k5w.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy1ax5k5w.fsf@gitster.g>

> > Sometimes gpg signing key UIDs include a comment between the name and
> > parenthesis in the form of:
> >
> >   John Smith (example) jsmith@example.com
> >
> > There's no way for git to find signing keys associated with just these
> > UIDs, so look up a partial match on the email only.
> 
> This codepath is about finding the key for the current user who is
> in control of what committer is found by the git_committer_info()
> call, no?  It is not like we are finding the key that corresponds to
> a random name and e-mail address on "From:" line, right?
> 
> Assuming that it is the case, it is unclear where the claim "There's
> no way for git to find" comes from.  It isn't a statement that is so
> obviously true, at least to me, without some explanation.

Hi, yeah. This statement was in referral to specifically gpg UIDs with
comments, the parenthetical that finds itself between the full name &
email. 

A workaround could be to set the committer name to "Full Name (comment)"
but that would end up being embedded in the git committer info too.

> > -	return git_committer_info(IDENT_STRICT | IDENT_NO_DATE);
> > +	return git_committer_info(IDENT_NO_NAME | IDENT_STRICT | IDENT_NO_DATE);
> 
> With this change, those who use more than one identities associated
> with the same e-mail address, but different human-readable names,
> will get their workflow broken, won't they?
> 
> They may be using "Will <a@dd.re.ss>" when they work on a project,
> while using "Bill <a@dd.re.ss>" for another project, configured via
> their .git/config in the repositories used for these two projects.
> And each name+address combination they have may map to a distinct
> GPG key, used to sign for each project.  With this change, since the
> call no longer returns the name they were using to differentiate the
> two keys, one of the projects they manage would lose out, no?

This is true, yes. This is a backwards incompatible change and if you
think there's a reasonable / used use case for multiple GPG keys with
the same emails but different names then yeah, this commit breaks that
workflow.

But also as you've mentioned user.signingkey is a very easy workaround
to resolve this.

> So, I am not convinced that the patch is trying to address the right
> problem, and I have a mild suspicion that the proposed solution to
> tweak NO_NAME may simply be robbing Peter to pay Paul.  If you have
> named your GPG key in your keyring with a name-email pair that is
> different from how you configured your committer identity, the right
> solution for such a case already exists in the form of user.signingkey
> configuration variable already.

I currently have a GPG key in my keyring with an identical name-email
pair to my git committer info, but it has an *additional* gpg UID
comment that introdues text within parenthesis that falls between the
owner full name & email and results in git's key lookup not working.

I appreciate the swift response!

-- 
Marco Sirabella
