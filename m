Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B8B7A706
	for <git@vger.kernel.org>; Sun,  3 Mar 2024 23:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709508292; cv=none; b=a94ML6kFU21RwEoO0TgxNh1546T1Ol+VwzbYiv8gNKEt/nfOZtEu1EpxG6IsiROzEAGfvqc3elviwuczqN4adiy0sz9LgmAruD80C77NV+kTV61ke4FVzOF4w0+TtMpJqFZnyCH54NwjNBJgAxv4Ve7xejT49XIEhUs5CmVOuXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709508292; c=relaxed/simple;
	bh=AzvATSKlPJIvUvAH+191dxpMx0YzlJb3FnJZDEiQKG4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s4R4NhmyawQiUUWdB3yf68Nl+dceNUgWHjf02wwAphUuwIQgKeLaoKAN0S5lFUWZOKDlPoCTst8FLRYwNkgqKyc7JWlP7D2PwOo0YDIeCiKuwT/4OwVEQvoAyNYLHhK2eWa4GMAJrNcP/An4FH+qmdu5jq1Fnj7qpkkahLHHVqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=V5sYWVZY; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="V5sYWVZY"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0052C1EEBA6;
	Sun,  3 Mar 2024 18:24:50 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=AzvATSKlPJIvUvAH+191dxpMx0YzlJb3FnJZDE
	iQKG4=; b=V5sYWVZYZzJOB4/O/6gkASfXpJcs4ROalBbA14wanNx5zZWGKpl9NC
	/v3ISppL1S0DAoiQQWFE3hYC0aQO+M0yndM+0W7pKejdc4dUboLI0G3dxD06RyyU
	Buhp2h8wtJ+UCq2wshmz7LhcGpKdA6b24fZ8vSKg3uHQnxXCLoQbw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DEB341EEBA5;
	Sun,  3 Mar 2024 18:24:49 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 407161EEBA4;
	Sun,  3 Mar 2024 18:24:49 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/1] rebase: teach `--exec` about `GIT_REBASE_BRANCH`
In-Reply-To: <4140fca4f454310d215df8bdac237caeb5c38521.1709495964.git.code@khaugsbakk.name>
	(Kristoffer Haugsbakk's message of "Sun, 3 Mar 2024 21:03:37 +0100")
References: <cover.1709495964.git.code@khaugsbakk.name>
	<4140fca4f454310d215df8bdac237caeb5c38521.1709495964.git.code@khaugsbakk.name>
Date: Sun, 03 Mar 2024 15:24:48 -0800
Message-ID: <xmqqo7buuce7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3ABCB9C0-D9B5-11EE-94E7-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Kristoffer Haugsbakk <code@khaugsbakk.name> writes:

> The command fed to `--exec` might need some contextual information from
> the branch name. But there is no convenient access to the branch name
> that we were on before starting the rebase; rebase operates in detached
> HEAD mode so we cannot ask for it directly. This means that we need to
> parse something like this from the first line of `git branch --list`:
>
>     (no branch, rebasing <branch>)
>
> This is a moderate amount of effort for something that git-rebase(1) can
> store for us.
>
> To that end, teach `--exec` about an env. variable which stores the
> branch name for the rebase-in-progress, if applicable.

You seem to be saying that `git branch --list` output already
contains the necessary information but it is shown in a hard to use
format.  Is the information given at least always accurate and
reliable?

Assuming it is, do you know where "git branch --list" gets that
information when it says "(no branch, rebasing <branch>)"?

git-rebase(1) is already storing information sufficient to let "git
branch --list" to produce that information, and there are other ways
to inspect that state ("git status" gives the same information but
it also is in a "meant for humans" format).

So, isn't it just the matter of surfacing the information that we
are already recording and is already available in a fashion that is
easier to use?  For example, if "git status --porcelain=[version]"
does not give the information, perhaps you can add a line or two to
it, instead of duplicating the same information in two places?

It comes from wt-status.c:wt_status_check_rebase() where state->branch
is assigned to, by reading "$GIT_DIR/rebase-{apply,merge}/head-name".


