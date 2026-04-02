Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B725D372B28
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 09:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775120939; cv=none; b=bMYxP/jQmqY/ultjiRnGG87yCdQdAfCLV+tXCVgU3K2yVLv3ryvH6AczGFQ9tG6viUy91o1kjeOtwmY9VIHKPREibAJf5VqmzZ4dV/eERuidCqllNwfNe4P20KsIW3MwJLH0TnRwqbRVT/NOBfb4dPbB+9U4dZhxMCnmEPS/Pk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775120939; c=relaxed/simple;
	bh=pfyNX7dojSGRPBU4GwMwyU9sh8rdj8WE790tla7q0CI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gZvukL7Ie6A/bRw0D4zS1lszsAQUiAxeTo00PgRyCURpV9jkF6H5UJCT+6b3iTZSl6UqYRNm/bZ2pqpNI5sfUddlVLkbuvXcjdtkqekoAfNh6nl44fTu31dV/hGuOiwnF52NbNIL/vfZHUikM9KVfMq4dU+jbNEkXGA3DI01LgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=vnrRQ/oB; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="vnrRQ/oB"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1775120933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1Y23adB0hVqA8IXqPEm7J/omjiu3FtU8mPnF6ICphNg=;
	b=vnrRQ/oBjQDuIyeDnu0uBeuJF8Df370RrRi4g2qyioc/iOyXjtvfVneynL9TPqbFM1Crl/
	/Ro13OnyNNFQE/4pb1v2FBaZXxtk5b70CbUNc0WQiiD8nJvJxPWNxdqvywcQfUkYc4ldly
	T7Eynr8+1iOSsxcKS5ugxeBxIG0+SkA=
From: Toon Claes <toon@iotcl.com>
To: Junio C Hamano <gitster@pobox.com>, Christian Couder
 <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>, Ben Knoble
 <ben.knoble@gmail.com>
Subject: Re: [PATCH v2] replay: support replaying down from root commit
In-Reply-To: <xmqq4ilw2cnw.fsf@gitster.g>
References: <20260317-toon-replay-down-to-root-v1-1-cb5c249e15fd@iotcl.com>
 <20260324-toon-replay-down-to-root-v2-1-34e723489f6e@iotcl.com>
 <xmqqtsu5xaw0.fsf@gitster.g>
 <CAP8UFD1zJXnsm7POK32GqEu4xSC+VO5mfzUpM-jn+Nr1qvzEFQ@mail.gmail.com>
 <87a4vv2ada.fsf@iotcl.com> <xmqqfr5lkyq8.fsf@gitster.g>
 <CAP8UFD3P2Gs0J1FNyKW2URwSEW4ZaTrVO7cM1V8sG+zzXctbhg@mail.gmail.com>
 <xmqq4ilw2cnw.fsf@gitster.g>
Date: Thu, 02 Apr 2026 11:08:43 +0200
Message-ID: <87zf3ld90k.fsf@toon--20250203-5JQV3.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT


Junio C Hamano <gitster@pobox.com> writes:

> Toon Claes <toon@iotcl.com> writes:
>
>>> Maybe something like the following could help:
>>>
>>> --- a/Documentation/git-replay.adoc
>>> +++ b/Documentation/git-replay.adoc
>>> @@ -23,6 +23,10 @@ instead get update commands that can be piped to
>>> `git update-ref --stdin`
>>>
>>>  THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
>>>
>>> +Note that `git replay --onto main topic` replays the topic branch starting
>>> +from the root commit, not from main. What you might want instead is
>>> +`git replay --onto main main..topic`.
>>> +
>>
>> Definitely would help, not sure it needs to be part of this series.
>
> Where else should the patch to add such a note to the documentation
> go, though?

First let me clarify, I'm sorry but I posted that message because I was
messing up two of my patch series. Yes, that change (if made) should
belong to this series.

> Where else should the patch to add such a note to the documentation
> go, though?  Without this patch, we do not is because the command
> will not take such a command line.  With this patch that adds the
> "now we allow replay to take a single tip commit and replay the
> history leading to the tip all the way down to root" feature, the
> note may become relevant.
>
> So to me, it looks like it is either we will never add such a note
> because it is irrelevant and everybody should know the consequence
> of passing "topic", not "main..topic", or we will have to add such a
> note as part of the series (if the note would help the readers).
>
> Even though I am on the fence about the need for this specific note
> in the documentation, it does not make sense to me to say "this will
> help but we are not doing so here".

The git-replay(1) docs refer to "Specifying Ranges" in
git-rev-parse(1). The section itself is included from
Documentation/revisions.adoc. If I look at "Revision Range Summary":

    Revision Range Summary
    ----------------------
    '<rev>'::
    	Include commits that are reachable from <rev> (i.e. <rev> and
    	its ancestors).

Personally I would say that's clear enough, and it feels a redundant to
repeat ourselves in the git-replay(1) docs. It's basically the same as
for every other command (git-log(1) for example).

Now I can understand it can be confusing when you compare this to how
git-rebase(1) works. But if you ask me, using git-rebase(1) with
'--onto' is a bit awkward anyway.

Nevertheless, looking at what the git-replay(1) docs now say about the
'<revision-range>':

    <revision-range>::
    	Range of commits to replay; see "Specifying Ranges" in
    	linkgit:git-rev-parse[1]. In `--advance <branch>` mode, the
    	range should have a single tip, so that it's clear to which tip the
    	advanced <branch> should point. Any commits in the range whose
    	changes are already present in the branch the commits are being
    	replayed onto will be dropped.

The phrasing around dropping commits can cause confusion. We should say
instead empty commits are dropped.

One other thing to note though, in my other patch series I'm changing
the docs to use stuck form. I think that also helps to clarify the
argument to '--onto' isn't part of the revision range.

But to summarize: I'm not sure a documentation change is needed, but if
you insist, I'm attaching a fixup patch (it's based on
sa/replay-revert). I'm leaving it to Christian an Junio to decide
whether it should be included. I'm happy to take it to a separate series
if you consider that a better idea.

> Christian Couder <christian.couder@gmail.com> writes:
>
>> So if we are about to fix that main issue in a separate patch or
>> series, and if we plan to emit something like the following in the
>> regular case:
>>
>> "fatal: replaying failed due to conflict"
>>
>> and something like the following when replaying from a root commit:
>>
>> "fatal: replaying from root commit XXX failed due to conflict"
>>
>> then I think it would alleviate the need for a doc update.
>
> Hmph, what would you do to the other side (i.e., replay from some
> specified boundary) of the message?  When the version of "git
> replay" command a user who sees for the first time comes with the
> ability to replay from a root on day one, "from root commit" is not
> so special from "from these boundary commits", so I am not sure if
> it makes sense to have such a message that treats the down-to-root
> case any specially.

I agree, making a separate error message for when replaying down to root
seems a bit of an overkill.


Cheers, Toon

---

From: Toon Claes <toon@iotcl.com>
Date: Thu, 2 Apr 2026 10:52:59 +0200
Subject: [PATCH] fixup! Add support to git-replay down from root commit

---
 Documentation/git-replay.adoc | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-replay.adoc b/Documentation/git-replay.adoc
index 997097e420..fb73a57444 100644
--- a/Documentation/git-replay.adoc
+++ b/Documentation/git-replay.adoc
@@ -78,13 +78,15 @@ incompatible with `--contained` (which is a modifier for `--onto` only).
 The default mode can be configured via the `replay.refAction` configuration variable.
 
 <revision-range>::
-	Range of commits to replay; see "Specifying Ranges" in
-	linkgit:git-rev-parse[1]. In `--advance <branch>` or
-	`--revert <branch>` mode, the range should have a single tip,
-	so that it's clear to which tip the advanced or reverted
-	<branch> should point. Any commits in the range whose changes
-	are already present in the branch the commits are being
-	replayed onto will be dropped.
+	Each ref specified in the `<revision-range>` is replayed and updated
+	separately. All commits reachable from those refs are replayed and thus
+	if no dotted range notation is used or excluded revision is given, each
+	ref is replayed down to root.
+	Commits that end up being empty are dropped.
+	Only one positive ref is allowed when using `--advance <branch>` or
+	`--revert <branch>`.
+	Consult "Specifying Ranges" in linkgit:git-rev-parse[1] for more
+	information.
 
 :git-replay: 1
 include::rev-list-options.adoc[]
-- 
2.53.0.310.g728cabbaf7

