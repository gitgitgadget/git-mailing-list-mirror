Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011F533C5
	for <git@vger.kernel.org>; Fri, 29 Nov 2024 03:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732851084; cv=none; b=hCzpFk4daLEZ8DsBikhN79+XQQ254mjJPdYwZsB3OjYm96rm0+/eV+GGgaNGAZlt0mGCE5omog3S76j1PfP0btvglzUw39aMBNT7ifjx6LwmEI9qCRlmtcHmrB+ceIOH14eZQya9VOMHWQdVkp4OBfspq2IBt+kI3as+XNqJgt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732851084; c=relaxed/simple;
	bh=dzcPk7dbKpeL46mW5t9+V2lxoynyqD06DAeiEbwcN1o=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u12RI6RXmg7GAl/9+noQiLbrO8UTiAgz7bz0gzyrYc+EF0PizhdB6P52RfOVSkwhlBvUNZXpvsBaAjrbrT2fcm2ZJ/7vQ1Nd53TnEiPwazdSX0fjWO89xVPnBS421cY2SQOSs8NgsUJXlP8JvPTlVWDWwiIPmuz8dQcSNmebldc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=fQ9go/RG; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="fQ9go/RG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1732851073; x=1733110273;
	bh=Wsnhvk8OYnaMV4ebnm03mmUapTDzK1IfbxCyPgRz0HM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=fQ9go/RGsc/D78Dfk9REQWuMNpRblJOW3RIIBVHjm2ZmoUqvAWIzWndfLB+KpOFph
	 jAhOAjRschXlgdhJo40UM6wzr+qDqynyv3f5Dha6wUs/MJXnZSqqiQXNi8uIR1lAxF
	 u3GapddFsT3Atms7Ee4KZVda/OfUYBcOgbG2Iq1U9X1EeCWLlLTwRdrK6OvTyKYbQn
	 X3ULeaBrm8U7YySHghhDe0aRUFnnaPEciByInZHk/iTOGG0ayv+Wm7PRYhnOeG0e29
	 w2/F2pLRKMG7ymkdayCYqCJE+gyo9wnHa8FXRrOS5JSIzTWA6b1lQf8hlHT9nCvvrE
	 DDqK+GLFitE9A==
Date: Fri, 29 Nov 2024 03:31:09 +0000
To: Junio C Hamano <gitster@pobox.com>
From: Caleb White <cdwhite3@pm.me>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/2] Ensure unique worktree ids across repositories
Message-ID: <D5YCFP1AV64F.36B116IUDDEE2@pm.me>
In-Reply-To: <xmqqr06un33g.fsf@gitster.g>
References: <20241128-wt_unique_ids-v1-0-30345d010e43@pm.me> <xmqqr06un33g.fsf@gitster.g>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: 0b37a41c29e1ef06b3137f62390120eb6ce24366
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu Nov 28, 2024 at 9:14 PM CST, Junio C Hamano wrote:
> Caleb White <cdwhite3@pm.me> writes:
>
>> The `es/worktree-repair-copied` topic added support for repairing a
>> worktree from a copy scenario. I noted[1,2] that the topic added the
>> ability for a repository to "take over" a worktree from another
>> repository if the worktree_id matched a worktree inside the current
>> repository which can happen if two repositories use the same worktree na=
me.
>
> Problem worth solving.  Another would be to fail if the worktree ID
> proposed to be used is already in use, but the ID is supposed to be
> almost invisible (unless the user is doing some adiministrative work
> on the repository), generating a unique ID is a good approach.

There's already a `while` loop that tries incrementing the proposed id
(e.g., `develop1` if `develop` is taken). However, this is on
a per-repository basis, so there's no way to know what's already in use
in another repository. The problem arises when trying to run `worktree
repair` on a worktree that has a matching id (like `develop`) from
another repository. The goal here is that the same worktree name can be
created in different repositories and the id will be (effectively)
unique.

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
> I do not think it matters much what hash/rand algorithm is chosen.
> What is important is what you do when the suffix suggested by that
> chosen algorithm collides with an existing worktree ID.  IOW, there
> is no way a "random" can guarantee uniqueness.  Attempt to create and
> if you find a collision, retry from the generation of another suffix,
> or something like that, is necessary.
>
> And as long as that "make sure it is unique" part is done right, it
> does not even have to be random.  Just generating a sequence number
> and using the first one that is available would work as well.

The `while` loop mentioned earlier still exists, so in the (unlikely)
event that the suffix collides with an existing worktree_id, it will
increment the suffix and try again.

Best,

Caleb

