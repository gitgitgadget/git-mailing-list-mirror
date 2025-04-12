Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D6CF4ED
	for <git@vger.kernel.org>; Sat, 12 Apr 2025 23:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744499629; cv=none; b=KfyYanm+3szB4UgR8peCn4xWRRnEUY2sPVwGclnSwQDUUgZY9lCWRZwNw3LT/tsjte0YkHTOFio0cBslwXvzo7cxEl9RDdXMf1zDWqu5ec4oByXQ9DboVM1pceTMkyGokpmoc1m8ejqSIy85jRr66x+hWYVahjBavVlPmy/SY0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744499629; c=relaxed/simple;
	bh=xAP5sbztR0aO47nRm/5GyX6qWJhN36aXhJH+bXpMtJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G0YGY8W6dBZju9CTVWuQIl4ryJwfMFnttknUi0gQRFTsK8saJ7giExgc+YLJF9vd1P5PgrXGoG6bJXz3ljiuoCnSvBlHWpLaKqo3v99Rzr2sXuoolb1J2klcr0DZ2krkzgQcaU73UBEq6Krg8VfEkFjDB/k/qw5rwSL7RAjzsx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-82-137.bstnma.fios.verizon.net [173.48.82.137])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 53CNDIo4001527
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 12 Apr 2025 19:13:19 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 59C952E00E9; Sat, 12 Apr 2025 19:13:18 -0400 (EDT)
Date: Sat, 12 Apr 2025 19:13:18 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Junio C Hamano <gitster@pobox.com>
Cc: Nico Williams <nico@cryptonector.com>,
        Martin von Zweigbergk <martinvonz@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Edwin Kempin <ekempin@google.com>, Scott Chacon <scott@gitbutler.com>,
        remo@buenzli.dev,
        "philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Subject: Re: Semantics of change IDs (Re: Gerrit, GitButler, and Jujutsu
 projects collaborating on change-id commit footer)
Message-ID: <20250412231318.GG13132@mit.edu>
References: <20250408125521.GA17892@mit.edu>
 <Z/VGYrrVZYQ13TLj@ubby>
 <20250409121924.GA148735@mit.edu>
 <Z/amMj/eg0RbXdkS@ubby>
 <xmqqv7rdqkla.fsf@gitster.g>
 <Z/a+AVopz+HLa1eL@ubby>
 <20250410134426.GB13132@mit.edu>
 <xmqqy0w8ng5r.fsf@gitster.g>
 <20250411154839.GC648081@mit.edu>
 <xmqqfriemw38.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqfriemw38.fsf@gitster.g>

On Fri, Apr 11, 2025 at 10:44:43AM -0700, Junio C Hamano wrote:
> 
> The submitting contributor must make a conscious arrangement to give
> a "patch set ID" shared among the messages in a single iteration,
> and everybody who are responding must make sure they do not add the
> same ID to the messages they throw at the thread in response.  Those
> who use format-patch and send-email can do that with convention and
> automation and there is no reason to rely on In-Reply-To: header
> (which may confuse the automated recipient of manually created
> follow-up messages).

So it all depends on how the patch set ID is implemented.  Here's one
way that I had in mind.  The reason why I like like this over the
Change-ID approach is that the semantics can be very clearly defined,
and the only thing we rely on is the user saying "this new commit is
part of patch series which I'm putting together". 

By default when creating a new commit, the field is empty (in which
case the patch set ID is presumed to be the same as the commit ID), or
if the user gives a command-line flag say, "git commit --series"
which indicates that it is part of a patch series in which case the
patch set ID of the commit is set to the patch set ID of the current
commit (i.e., eventully, its parent commit).

Whenever the commit is amended or rebased or cherry picked, if the
patch series ID is NULL, then it is set to the original commit ID.
Otherwise, the existing patch set ID is preserved.

The patch set ID will be output by git format-patch (perhaps as "Patch
Series ID: sha has" immediately after the --- line.  And if it is
present, "git am" will import that patch series ID into git commit
which creates when it sucks in the e-mail.

The net affect of this is that for new versions of git which implement
the Patch Set ID, all new commits are treated as patch series of
length 1, unless a subsequent commit is created using "git commit
--series".  And the Patch Set ID will be preserved across
cherry-picks, rebase operations, and git send-email/git apply-message
operations.

So if someone replies to an existing e-mail thread with a new commit,
git format-patch will give it a different patch set ID, so we can
distinguish it from an amended  copy of a patch in the patch series.

It also means that singleton commits, the patch ID effectively acts
much like the tranditonal Change-ID.  For multi-commit patch series,
all of the commits will have the same patch set ID.

       	   	   	     	      - Ted
