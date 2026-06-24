Received: from bsmtp.bon.at (bsmtp.bon.at [213.33.87.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DAC31197C
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 07:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782287379; cv=none; b=UC+rMhSBbX+sADRg3mg+FEElwXPHt7X8HUy0Dov3Eshpnstqq9pYjV5Hs1jvI7UOoqKkcz09cHhL8qWM8XgqZk/T3zOgFKSEu5ncGQN7d1dSjyipX+lcVEIQcm6vVfWdpCHPrCh8zzXWwDQsLokl+Cn+iLrEBucJivSf9h+ROLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782287379; c=relaxed/simple;
	bh=PdcggeB/SDk/9JY5O5OvNronLnSHbzjhTfrWl+BRraM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r7HAjpZZvluvk2E9JY/BDxxxOj++359sFwaaMFKW2ck9LN3owOWFa5kvU5Vc6NUd/b45yzIe9YSa6n6mOqLOww0zwYvLNj4a2feqb5QM7qLqXcNILjJtWwWC6ENVptYoga6TjFDv+3/MPz1xmDDMjP2h2ZqJuVdrDbfPMNTNKVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4glYx33YwpzRnmS;
	Wed, 24 Jun 2026 09:49:26 +0200 (CEST)
Message-ID: <3a2ba6c0-4ced-4d2c-820e-401c2dff1dd1@kdbg.org>
Date: Wed, 24 Jun 2026 09:49:26 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] notes: support an external command to display
 notes
To: Siddh Raman Pant <siddh.raman.pant@oracle.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
 Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
 Elijah Newren <newren@gmail.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>, Jeff King
 <peff@peff.net>, Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
 git@vger.kernel.org
References: <cover.1779532562.git.siddh.raman.pant@oracle.com>
 <7284a8bccb6bfb5734adb09f05ae4b61a63da2df.1779532562.git.siddh.raman.pant@oracle.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <7284a8bccb6bfb5734adb09f05ae4b61a63da2df.1779532562.git.siddh.raman.pant@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 23.05.26 um 12:38 schrieb Siddh Raman Pant:
> git notes is a very very helpful feature to show user-supplied
> information about a commit alongside its message transparently.
> 
> For distributed teams working on large git repos (huge number of
> branches/refs, files, etc.) and using the notes feature to mark
> information on git commits, the problem is often not that two users
> update the same note object at the same time. It is that the local
> notes state used while reading history can be stale.
> 
> In kernel work, the same logical upstream fix can appear as different
> commit objects across many downstream branches, such as the stable
> branches and vendor-specific branches (based on which the released
> kernel is actually built). Different developers may be working on those
> branches in parallel, and a review decision recorded for one backport
> is useful context for the others.
> 
> Today, seeing that decision in ordinary history output requires first
> synchronizing the local notes ref, and then interpreting those notes
> for the branch being inspected. The latter step is workflow-specific
> and can be cheap, but keeping the local notes state fresh enough can be
> expensive in a large kernel repository with a large shared notes
> history (and if we are to extrapolate, a slow git server conn/ops can
> be a factor too).
> 
> This TOCTOU problem exacerbates on scale (rapid updates, more devs,
> larger repos, more git server traffic, etc).
> 
> One solution to this is to move the freshness policy out of git so that
> it is someone else's problem. We can have a realtime fetch or faster
> updation via external helper means. But unfortunately we lose the
> coherence in the display of information, and so the user would end up
> reinventing git log in his quest to have same workflow.

You are presenting one solution here. But a more obvious solution would
have been to make Git's notes implementation capable enough to keep up
with the volume of notes that are produced by your team.

Another solution would be to track the information outside of Git notes
entirely, similar to how pull requests, issues, reviews, and
conversations are tracked by Git hosters in databases outside of Git.

> Let's add support for notes.externalCommand, a protected-configuration
> command that git runs as a long-lived helper when displaying notes. git
> sends commit IDs to the helper and displays any returned text through
> the existing notes formatting path. This keeps presentation in git
> while letting the helper decide how fresh note text is obtained.

To my eyes, this looks like an overengineered solution that helps one
user of a niche feature of Git.

-- Hannes

