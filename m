Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E5F28D8D0
	for <git@vger.kernel.org>; Sun, 25 Jan 2026 17:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.233.160.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769361637; cv=none; b=Y/Bl4sBBbWiUED8WsjdA8TZ1on8KzzAsEpJ4HVmV4gMKRortlKDX4KfjWqemO0UlRS5S9Fa2I260sjFH9gSa0FQIRtf2vRriHV89feeUIFtaht/x3aIAXWfe3RHy5wQ4nJUPebUR2zdrqUWMwvqX0oCv0biMBB4tUTYHGxiy6EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769361637; c=relaxed/simple;
	bh=EvVKc7h2vLG/hIrDxEVeHDNmEktcspK0Nuj8KaEHZ6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=SOSCIAHNZcUnqwIdqiw4gqbxk+O6giMrtbba7Xihl3/tboSd2LYNSRXg3UHPaQk35qcEkFTv3kOK/hHCQ+3rVtd2S3vKFaAZteeqL1amWITGJxqtakV0vJ8x6IYDS2bpabrWT++Z9WoQk28zPLAOxXJNC446r22GPJQEDTjYRvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iee.email; spf=pass smtp.mailfrom=iee.email; dkim=pass (1024-bit key) header.d=iee.email header.i=@iee.email header.b=miNPI62S; arc=none smtp.client-ip=85.233.160.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iee.email
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iee.email
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iee.email header.i=@iee.email header.b="miNPI62S"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=iee.email;
	s=2025082600; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:To:Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID; bh=zxA5APL0dX/Y3hwA7g+WNO4xRT/mL0MT/jJkiXc08yU=; b=miNPI6
	2SeaMM3R6WIkiYVoUEpG1aSWRdXAEN6XD4XEsC0ZSgTF+KdrqjmpCltKY328GynNRLlxTF4xN1H2h
	MRlka7KUgpvqVt+uZs5nODNlTHTHPdI5OpN8OXM+I7iMMtBeA10axCOEUrbyJJkzXcxonCxswwZI2
	CxTAD1UNAKw=;
Received: from host-78-146-7-210.as13285.net ([78.146.7.210] helo=[192.168.1.57])
	by smtp.hosts.co.uk with esmtpa (Exim)
	(envelope-from <philipoakley@iee.email>)
	id 1vk2FV-00000000Ae3-651N;
	Sun, 25 Jan 2026 15:42:02 +0000
Message-ID: <f6cc0420-1be6-4855-8c0f-b79c683203ee@iee.email>
Date: Sun, 25 Jan 2026 15:42:00 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Missing and omitted objects
To: Simon Richter <Simon.Richter@hogyros.de>, git <git@vger.kernel.org>
References: <a612ea8e-a741-436d-8ed2-6ff09ba7945b@hogyros.de>
From: Philip Oakley <philipoakley@iee.email>
Content-Language: en-GB
Cc: Jeff King <peff@peff.net>
In-Reply-To: <a612ea8e-a741-436d-8ed2-6ff09ba7945b@hogyros.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 21/01/2026 11:54, Simon Richter wrote:
> Hi,
> 
> we're having a bit of a discussion in Debian.
> 
> The goal is to move towards git based storage for source packages, away
> from tarballs; ideally we'd like to reuse the upstream git archive as
> far as possible, so it is easy to check for differences.
> 
> However, some projects are shipping files that aren't redistributable,
> or that we want to omit for other reasons (such as vendored
> dependencies, when there is a perfectly working common version
> available, and we really really want to make sure these don't get used
> accidentally).

There was a discussion about allowing objects to be 'redacted' back at
the Git Merge 2020 (https://git-merge.com/),
under [TOPIC 3/17] Obliterate.
https://lore.kernel.org/git/5B2FEA46-A12F-4DE7-A184-E8856EF66248@jramsay.com.au/

> 
> The goal here is to allow the recipient of such a bundle to verify that
> any files received are unmodified, and get a list of paths that were
> removed (which may be an entire subdirectory). Ideally, they could also
> continue working on a clone of this and generate commits on top as long
> as the affected paths aren't touched.
> 
That discussion on redacting objects didn't reach any actionable
conclusion that allows objects to be omitted/redacted, while keeping the
branch based directed graph flow. I've continued to consider options for
deliberately creating 'counterfeit' objects (old name/oid, but
new/limited content) which could then be 'verified' through a facsimile
object with the same new/limited content but a properly hashed name/oid.
I haven't shared any of that with the list.

> The minimal amount of data we'd want to archive is a single commit and
> its tree and dependencies, plus optionally a signed tag pointing at it
> if it exists (i.e. the same information we get if we use git-archive,
> plus the signature on the tag, plus the option to clone from such a
> snapshot). For the simple case where nothing is removed, this already
> works well and covers most of the use cases, but, sadly, not all of them.

You could simply branch that special commit that will have all the
deletions, plus a 'deletions' file diff file (assuming you want to
highlight those deletions..), and then leave that branch as a stub, with
a tag, and remove that old branch name such that the tag is the thing
that retains the special commit in the hierarchy, and it's parent still
holds within the regular git commit graph.
> 
> As a side effect, this could make recovery of a broken repository that
> is missing objects more robust.

Broken repos are scarce, more often than not being compatibility issues
between (*nix) Git and Git-for-Windows (case sensitivity, sizeof(long),
character limits, etc.). However redaction and overlarge files still fit
into the 'Don't do that' category (expect the unexpected..).

There is also the distinction between the meta-data and content. The
former also includes the data that holds together the commit graphs
integrity (hash of hashes) and filenames, directory names and commit
texts (point 15 of the Git Merge discussion). Being inside the hash
verified meta data makes it "hard" to break and create exceptions.

A mechanism for marking leaf objects as 'removed'/abscissed/absconded
would help here. It's tricky to do that safely for a commit, as it also
carries parent information which must be retained.

For a blob (leaf) object, with its free form text, it is possible to
have a fixed format, fixed length (hash specific) counterfeit object,
e.g. "Git redact abcd01245.."(*) which would then also exist as a
facsimile (i.e.has a true hash oid) object within some authenticated
part of the graph, and the counterfeit exist in place of the 'broken'
blob object with that self referential "abcd01245.." oid.

For trees, it becomes necessary to locate a bit of free text in the meta
data to provide self reference, and make it appear as either the empty
tree or empty file(blob). The true oid of such a counterfeit tree
likewise would need a way of existing within some authenticated part of
the wider graph. Perhaps a step too far at this stage of hand waving.

> 
> Right now, I'd like some feedback whether someone has a better idea, and
> if such a feature could ever work or if it violates some fundamental
> design principles.

It's a big ask. Finding one specific feature (just on) that could
actually be made to work would provide a toe hold for discussion.

At least this is a solid desire from within the community's infrastructure..

At present there is no mechanism for assuming that a piece of blob
*content* is "correct" but that the oid it is stored under is incorrect
/ does not match. We already have/had the `--literally` option for
creating arbitrary content, but not it's corollary `--use-oid=abcd01245..`.
see
https://lore.kernel.org/git/20250516045010.GL22242@coredump.intra.peff.net/
Peff cc'd
> 
>    Simon
> 
(*) I more wanted "Git redact abcd01245.hexoid Base64oid" to reduce
accidental creation of such objects and allow double checking of the
oid. But maybe that's too cute.  ;-)
