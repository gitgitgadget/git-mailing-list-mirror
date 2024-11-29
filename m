Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D3113D619
	for <git@vger.kernel.org>; Fri, 29 Nov 2024 15:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.79.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732895917; cv=none; b=FsoQP21FIXck4z4TAjwLHLfPwWNbwxDxp1TUxyMI1bGbv/3iuYDTZ09LhxKyAVOsSDBWI1wBYFYTmSCXKOFyPuPFcsI6gCIMJQ3z0+UgCc21ZihseRW/+1CJLYcwjBZr+dgZ9LwvSmtb1PeFyNngh2ao9hkY6x6T29qAKtJ4so0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732895917; c=relaxed/simple;
	bh=V7aHFMIPu2cajvMP4k+L3mDLHlAYavzBf3fiMtYXa1g=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CzvZRmPh9FLKdASTtzpkyZRVVvfC9VkyAdByxwUESlMtTYAy6mIadYkh5hq13x5+2GdWTG6THScyLtUR/Rhrx4MMgFd6z+ihc2gMRGEQVCDSKzXR6ZShoEALykBizjVHrTfgsGr43Rt55luqzrqUmbBVllMLNyYAUOIGsGYuusI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=DKYuexDk; arc=none smtp.client-ip=51.77.79.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="DKYuexDk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1732895900; x=1733155100;
	bh=Xio3eQ38qUmBy+VxrinGC3aXM7NU5HSz+Goxjm1wUwM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=DKYuexDkyRBhCTGrPj+0bjyXQNdIBqmqQpOS4+nmj1YtxLqnd6USiuIE7AkhRb9L+
	 AyfxlMahO3HTEx8ASvkSkJ1JAgMY+AQl8fHyZN4hMzvJRDi0Sv15cmeAB8vsBG/Qk8
	 vfoQ789KP83TQ3E9kVPryzsihbBxMZ68D+pSB19AqEER7Egq1i6Lu4LC2MuoQO8PtN
	 ma+CzQ7IsYujcf8jq6n55r1R2wb/VbO7IPz/d13YGh+zTvQYkPMIqFXUNGa7fV3Po3
	 7Ww1mAebdG6cBv8a+B5D1EkufeYG1qDeXS4bq5O21tGZRTV79Ty8CGYy14YYM0vnLD
	 KhtuRGSYKwizw==
Date: Fri, 29 Nov 2024 15:58:16 +0000
To: shejialuo <shejialuo@gmail.com>
From: Caleb White <cdwhite3@pm.me>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/2] Ensure unique worktree ids across repositories
Message-ID: <D5YSBQXU7FYD.25KOIM1N3US88@pm.me>
In-Reply-To: <Z0mgAt9ssu_32tTQ@ArchLinux>
References: <20241128-wt_unique_ids-v1-0-30345d010e43@pm.me> <Z0mgAt9ssu_32tTQ@ArchLinux>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: 52dd15b4244e0f281d74c8115c0ad217a0be8b3e
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri Nov 29, 2024 at 5:05 AM CST, shejialuo wrote:
> On Fri, Nov 29, 2024 at 02:44:24AM +0000, Caleb White wrote:
>> The `es/worktree-repair-copied` topic added support for repairing a
>> worktree from a copy scenario. I noted[1,2] that the topic added the
>> ability for a repository to "take over" a worktree from another
>> repository if the worktree_id matched a worktree inside the current
>> repository which can happen if two repositories use the same worktree na=
me.
>
> I somehow understand why we need to append a hash or a random number
> into the current "id" field of the "struct worktree *". But I don't see
> a _strong_ reason.
>
> I think we need to figure out the following things:
>
>     1. In what situation, there is a possibility that the user will
>     repair the worktree from another repository.

This can happen if a user accidentally mistypes a directory name when
executing `git worktree repair`. Or if a user copies a worktree from one
repository and the executes `git worktree repair` in a different repository=
.

The point is to prevent this from happening before it becomes a problem.

>     2. Why we need to hash to make sure the worktree is unique? From the
>     expression, my intuitive way is that we need to distinguish whether
>     the repository is the same.

During `worktree repair`, an "inferred backlink" is established by
parsing the worktree id from the `.git` file and checking if that
matches an existing worktree id in the current repository. If so, then
the link is established even if that worktree belonged to another
repository. The easiest way I thought to prevent this from happening is
to ensure that no "inferred backlink" can be established by using an
effectively unique worktree_id. So two repositories can have the same
worktree name (e.g., `develop`) but the actual ids would be different.
Additionally, if the ids **do match**, then this would be indicative of
a copy situation like the original topic addressed.

How do you propose to distinguish whether the repository is the same?

>> This series teaches Git to create worktrees with a unique suffix so
>> that the worktree_id is unique across all repositories even if they have
>> the same name. For example creating a worktree `develop` would look like=
:
>>
>>     foo/
>>     =E2=94=9C=E2=94=80=E2=94=80 .git/worktrees/develop-5445874156/
>>     =E2=94=94=E2=94=80=E2=94=80 develop/
>>     bar/
>>     =E2=94=9C=E2=94=80=E2=94=80 .git/worktrees/develop-1549518426/
>>     =E2=94=94=E2=94=80=E2=94=80 develop/
>>
>> The actual worktree directory name is still `develop`, but the
>> worktree_id is unique and prevents the "take over" scenario. The suffix
>> is given by the `git_rand()` function, but I'm open to suggestions if
>> there's a better random or hashing function to use.
>
> The actual worktree directory name is unchanged. But we have changed the
> "worktree->id" and the git filesystem. Now, we will encounter much
> trouble. The main reason is that we make the worktree name and worktree
> id inconsistent. There are many tools which assume that worktree id is
> the worktree name.

Do you have any sources for these tools? Because I'm not aware of any.
Any tool that needs the actual worktree id should be extracting the id
from the `.git` file and not using the worktree directory name.

> In other words, there is no difference between the worktree id and
> worktree name at current.

This is NOT true, there are several scenarios where they can currently diff=
er:

1. git currently will append a number to the worktree name if it already
   exists in the repository. This means that you can create a `develop`
   worktree and wind up with an id of `develop2`.
2. git does not currently rename the id during a `worktree move`. This
   means that I can create a worktree with a name of `develop` and then
   execute `git worktree move develop master` and the id will still be
   `develop` while the directory is now `master`.
3. a user can manually move/rename the directory and then repair the
   worktree and wind up in the same situation as 2).

The suffix is not a new concept, I've just changed it from occasionally
adding a suffix to always adding a (unique) suffix. The worktree id has
never been guaranteed to be the same as the worktree name, and as
mentioned above, any tools/scripts/intelligence that need the id should
always be extracting it from the `.git` file.

One thing we can do is to add the worktree id to the `git worktree list`
output so that users can see the id and the name together. This would
make it easier for users/tools obtain the id if they need it without
having to parse the `.git` file.

> Let me give you an example.
>
> So, with this patch, we make worktree-id not the same as worktree name.
> If we do this. "git update-ref" cannot find the
> ".git/worktrees/worktree-1/refs/worktree/branch-2". This is because the
> filesystem is changed to ".git/worktrees/worktree-1-<hash>/...".

Yes this is expected because the worktree id is not the same as the
name.

> If we use hash / random number to distinguish. We also need to change
> the ref-related code to ignore the "-<hash>". It's impossible to let the
> user type the extra hash / random number. However, this requires a lot
> of effort.

This would be possible as long as the given worktree slug is unambiguous.
However, I think this is more trouble than it's worth.

> So, I think we need a _strong_ reason to indicate that we must append
> some chars into worktree id to do this.

As stated above, git already appends a number to the worktree name if it
collides with an existing directory. Always appending a unique suffix
should actually make things simpler / more consistent in the long run
because the worktree id will always be different from the name instead
of occasionally being different.

Best,

Caleb

