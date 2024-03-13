Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09B65D461
	for <git@vger.kernel.org>; Wed, 13 Mar 2024 22:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710370745; cv=none; b=QOoSVJHB/QvtlLBcPXonVBXC/ng7rz1E/5LV9CCpPnmcZH66SABOQ+T+7qH7jxPbENukcOThiCNmzRjZwV7Iqhz2PRMdrpg7PmpZVH1LA+oAtiJ8+wpSYj96XIx0tbm9dBLfOCcAWXJ9ix4p0srNiueH6iWKE8tyNRMinzx1tZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710370745; c=relaxed/simple;
	bh=f6SBv2A2KOciWjo9JFsvxHWE7RIwFdGkvFx4nPIG9qs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=L6jyNDadTA2+0N4L9c5ZKx3DLUWJMZ5kv0MOBPm3ndkzelJJX56CKH389zKwe3//5+qgFhXFc9hfkO4BU+Ppb2i3HbmYfUHiwpFOKZ9wrMKsUvdKjhUxPlh0oXwresVINUQN/97R6EP4zSxo1bRb6QLXEY4asaZ/HxZEMBDXNUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=q2H3A6HB; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="q2H3A6HB"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 380731C64F;
	Wed, 13 Mar 2024 18:59:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=f6SBv2A2KOciWjo9JFsvxHWE7RIwFdGkvFx4nP
	IG9qs=; b=q2H3A6HBL60cejkdIVchYBoPebAB64J/ACz3v3d7iIHro0N2fuwfU/
	gMkH7HKKxmPYE13lGzW2AsEzGYDQas71NUhT3pQGaovXMn2vscmuxLuf2oimO8dd
	TqKfvd55ymwnOqnaJod6O0adnXVvsiPCDGv9+oG5Be1qAJ3QM0RKw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 314B71C64E;
	Wed, 13 Mar 2024 18:59:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B8DE21C649;
	Wed, 13 Mar 2024 18:58:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Christopher Lindee <christopher.lindee@webpros.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 0/2] Optionally support push options on up-to-date branches
In-Reply-To: <SA1PR14MB4691B63C740F95D7D8A495628D2B2@SA1PR14MB4691.namprd14.prod.outlook.com>
	(Christopher Lindee's message of "Tue, 12 Mar 2024 21:55:08 +0000")
References: <SA1PR14MB4691B63C740F95D7D8A495628D2B2@SA1PR14MB4691.namprd14.prod.outlook.com>
Date: Wed, 13 Mar 2024 15:58:58 -0700
Message-ID: <xmqqa5n168nh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4749E7D2-E18D-11EE-B98A-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Christopher Lindee <christopher.lindee@webpros.com> writes:

> Some Git servers can take actions on a branch using push options; to do this,
> the branch ref must be passed along with the push options.  However, if the
> branch is up-to-date, then Git submits push options without any refs, so the
> server is not given a branch to act upon and the push options become no-ops.

Yeah, the send-pack/receive-pack were written in the simpler days
back when "pushing the same object again to the ref was an absolute
no-op", and push options that breaks the expectation did not exist.

It makes sense to allow a (seemingly no-op) push to go through with
an option.

And even without custom push option, recording this seemingly no-op
push as a ref "update" does make sense--push certificate records
what object the pusher wanted each target ref to have, and omitting
a ref from the record only because the ref was already pointing at
the desired object is losing information.

So I doubly agree with the reasoning beind this change.

> This changeset proposes to address this issue by adding an option to `push` and
> `send-pack` that, when specified, will send refs where the old-oid and new-oid

"where" -> "even if"

> are identical - instead of silently skipping these refs.  The first commit
> introduces the `--send-up-to-date` option to toggle this behavior, while the
> second commit updates the commands to output an `(up-to-date)` notice for each
> branch with an identical old-oid and new-oid.
>
> Notably, the `--force` option will not send a ref when the remote is up-to-date.

And it makes sense *not* to update `--force` to do the no-op push,
becaues you may not want to (accidentally) force push a ref that
does not fast-forward.  As I already said, tying this with use of
the "-o" option is not sufficient.  So I agree we may want a new
option to trigger this behaviour.

A radical counter-proposal for the design is to update the client
side to do this unconditionally, without needing any new option.
For an already up-to-date ref, its only contribution to the cost of
"git push" is from its "Finally, tell the other end!" instruction,
which is in the order of 100 bytes per ref, and it should not add to
the pack generation cost at all [*].

    Side note: But we have to be careful---if the receiving end is
    totally up-to-date and there is absolutely no ref, I think the
    current code will not even call pack_objects(), and you'd
    probably want a similar optimization to avoid the cost to spawn
    pack_objects().

I do not know if "send-up-to-date" is a great name for the option,
though.

>
> Chris Lindee (2):
>   Teach send-pack & push to --send-up-to-date refs
>   Add transport message for up-to-date references
>
>  Documentation/git-push.txt      | 8 +++++++-
>  Documentation/git-send-pack.txt | 7 +++++++
>  builtin/push.c                  | 1 +
>  builtin/send-pack.c             | 4 ++++
>  send-pack.c                     | 2 +-
>  send-pack.h                     | 3 ++-
>  transport-helper.c              | 7 ++++++-
>  transport.c                     | 3 +++
>  transport.h                     | 1 +
>  9 files changed, 32 insertions(+), 4 deletions(-)
>         
>
> base-commit: 3c2a3fdc388747b9eaf4a4a4f2035c1c9ddb26d0
