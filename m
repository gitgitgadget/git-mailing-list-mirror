Received: from mail.normalmode.org (h01.normalmode.org [157.230.60.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD77C2E22BD
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 04:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.230.60.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784004307; cv=none; b=Mn9DQwWJMCrmGmVt6QTNSvHGAeGl7cv2zr6FUz0u6bbH5/jlNL+20NspGvCseAkPx83WyYeRUwI/jLt/lyQlKuWQFp5f+bms/OeCf+bEdU+gWgQvYYfP7WYBrQzR9NucN64j6oaldFaJoO7WjUCMjad4bvsYTGu6Sgyrao8/nV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784004307; c=relaxed/simple;
	bh=8/Li1pd1HHWsyzKeM255anIcsKIP+QjvVdA9np1m8bA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=ntcM1YbRw4ECsKg3zUZywkK4eDygsNGmARhhcM0fgGyTqKQQfTH6wF708P5k8f+sz+ALRRHDRqyeXtl/pJ9reYQl0/gI0TwR4ZhfE1YQ66x2v4dAp9aofRpIkHlnUP8dJH8CB814MjkCcvfEAie6LBioMVVknAkJJVt6AMQSMKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us; spf=pass smtp.mailfrom=lfurio.us; dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b=nJjxKd+g; arc=none smtp.client-ip=157.230.60.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lfurio.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b="nJjxKd+g"
Received: by mail.normalmode.org (Postfix) with ESMTPSA id 3273E60006;
	Tue, 14 Jul 2026 04:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lfurio.us; s=default;
	t=1784004299; bh=8/Li1pd1HHWsyzKeM255anIcsKIP+QjvVdA9np1m8bA=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=nJjxKd+gX786ZccfMq8viIUD2Uim04StiYaF+MlMbx33A7TMlEDuMs/uVORZWAujg
	 SJPfM64mpr/2sEkApAl/FevqqC5/USPoSkeMlaVKMNDrmO5wYKWDx/hY5qP/qd8/lq
	 zuJioG9cnuUxsnsVNXLiJz7FEySmJqlYvsrGraNc=
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 14 Jul 2026 00:44:58 -0400
Message-Id: <DJY0QSJYNG0J.210HZQH198Y1N@lfurio.us>
Subject: Re: [PATCH v8 0/5] history: add squash subcommand to fold a range
Cc: "Phillip Wood" <phillip.wood123@gmail.com>, "D. Ben Knoble"
 <ben.knoble@gmail.com>, "Patrick Steinhardt" <ps@pks.im>, "Harald Nordgren"
 <haraldnordgren@gmail.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>,
 <git@vger.kernel.org>
From: "Matt Hunter" <m@lfurio.us>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <pull.2337.v7.git.git.1783327849.gitgitgadget@gmail.com>
 <pull.2337.v8.git.git.1783674396.gitgitgadget@gmail.com>
In-Reply-To: <pull.2337.v8.git.git.1783674396.gitgitgadget@gmail.com>

On Fri Jul 10, 2026 at 5:06 AM EDT, Harald Nordgren via GitGitGadget wrote:
> Adds git history squash <revision-range> to fold a range of commits.
>
> Changes in v8:
>
>  * --reedit-message now builds the same editor template as git rebase -i
>    --autosquash: fixup!, squash! and amend! commits are grouped under the
>    commit they target instead of shown in commit order, and an amend!
>    replaces its target's message.
>  * A fixup!, squash! or amend! is refused only when its target is outside
>    the range, so several fixups for an in-range commit fold together. A
>    range that is entirely markers for one below-range target is combined
>    into a single commit, keeping the last amend! message.
>  * Merges inside the range are folded when the range has a single base, w=
ith
>    no dedicated opt-in flag, --ancestry-path ensures only commits descend=
ed
>    from the base are folded, and a range reaching more than one base is
>    rejected.
>  * Rev-list options are accepted and sanitized the way git replay does,
>    forcing the walk order back with a warning, which also fixes git histo=
ry
>    squash -- --reverse slipping past the previous option check.
>  * Kept this as an explicit squash subcommand rather than making
>    --reedit-message the default or renaming the command.

This feature looks like it's coming together pretty well imo.  I just have
one observation I want to comment on:

I noticed that 'git history squash <range>', when --reedit-message is
omitted, will ignore any amend! message in the range that targets the
first folded commit.

On the surface, this makes sense.  The feature is pretty explicit that
it will faithfully stick with the first commit's message, unless
modified by use of --reedit-message.

However, this edge case is a little surprising, given that
'git history squash' seems to be aware of the semantics of fixup!, amend!,
and squash! messages whether --reedit-message was given or not.  For instan=
ce,
the default command notices when the range contains a squash! commit whose
target is elsewhere (a useful feature).  It seems consistent then, that the
default command would incorporate an amend! it is aware of when placing the
"first commit's" message in the resulting squash.  This seems useful to me
as well.

At the same time, I can understand why the current implementation does
what it does.  So I'm not entirely sure what the correct answer is here.

I'll mention as well that I really like the decisions made for how this
command handles squashing a bunch of related fixups.  This "fixup
consolidation" is a use-case that this command may steal away from rebase
for me.  And the way a final amend! is handled in this case is what got me
thinking about it in the general case.

Thanks for the work on this topic!
