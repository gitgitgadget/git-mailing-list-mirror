Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB1429CA
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 16:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721840018; cv=none; b=aKWOD//FG56mw8ZnFXCXT2E+hOOqjPRXD0UmkHalMkX2ZNDV4UcUEWAL6JLLyDCs4LtYuZmVrHsSG5EIb6dTq/2rbeAyxLxG0eW/Ns9w758RPTdMr+xNu7xEOxkVuR6JPF0PCsZ5cOJCMswEjtZqr3xAs5suwYAU6BYrwS6M3o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721840018; c=relaxed/simple;
	bh=Il4mr588asYsMHxXk1GAK26Iay2S+ubmX3bs8PJLmXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BUDfOEdY/R9kXsnwjs1XNAxqFL5hJ0Uq1eCa3niOwV9jpQ5cEc/PcnqqrJjfxfrdDDwgz9BedaH0llwiLIEo5fi6UQm6MSNFMfohHin5V6fNcH2fs8RwH7/DmDJoALb7uzYock46q/RVAgalFNXhXNQxzSQGGHg6g6voe1k40uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zB3O+cjF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zB3O+cjF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC1B6C32781;
	Wed, 24 Jul 2024 16:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721840017;
	bh=Il4mr588asYsMHxXk1GAK26Iay2S+ubmX3bs8PJLmXA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zB3O+cjFWxJAhhL/cpxm8M9dJep0hLIa52WjDeqxlZjbDW9jZG+GbRL6jEsDPRhdO
	 hhrMcrlKOwXbb2XXsxjb418cqH6oaDki/cjpwU283VkL4abVnl/l4TSTKLvQgFqY+c
	 CnQg9i476uTy/L7G5F1lPF+FrXc2/3mjsaxG6nDQ=
Date: Wed, 24 Jul 2024 12:53:36 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Robert Coup <robert.coup@koordinates.com>, git <git@vger.kernel.org>
Subject: Re: bug/defaults: COMMIT_EDITMSG not reused after a failed commit
Message-ID: <20240724-cryptic-private-mustang-3f50aa@meerkat>
References: <CAFLLRpJgpjJpNRC_UpZmUXF2626e0BiH8CkOkoMrX3zcrOp7YA@mail.gmail.com>
 <xmqq1q3iyceq.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1q3iyceq.fsf@gitster.g>

On Wed, Jul 24, 2024 at 09:37:01AM GMT, Junio C Hamano wrote:
> > 1. delete COMMIT_EDITMSG on success
> >
> > 2. reopen COMMIT_EDITMSG on commit if it exists. Maybe logging something like
> >    "Restoring previous in-progress commit message..." might explain what's
> >    happening.
> > 3. if COMMIT_EDITMSG doesn't exist, re-populate from the template before opening
> >    the editor. We could also do this for "parsed-as-empty" commit messages.
> 
> Unconditionally doing this change would be disruptive to workflows
> of existing users.  To them, Git left COMMIT_EDITMSG available even
> after the commit to them almost forever, but suddenly it stops doing
> so.  Like "git cherry-pick|rebase|revert" that got stopped can be
> restarted _with_ some state information with "--continue", offering
> this as an optional feature might be a possibility, but I haven't
> thought things through.
> 
> An obvious and a lot more lightweight first step is to make it clear
> (perhaps in the error message after a failed commit---after all,
> such a failure from "git commit" should be a rare event) where you
> can resurrect the draft commit message from.  That is independent
> and orthogonal to the "let's reuse COMMIT_EDITMSG file" change.

Yes, I would say even doing the following would result in a better experience
for users who don't know about .git/COMMIT_EDITMSG:

1. when git-commit fails, save the message as .git/FAILED_COMMIT_MSG
2. output "Commit message saved as .git/FAILED_COMMIT_MSG"

(exact wording/naming up for debate)

-K
