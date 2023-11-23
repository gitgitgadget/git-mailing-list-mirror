Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="f0AuEc1n"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA0711F
	for <git@vger.kernel.org>; Wed, 22 Nov 2023 17:28:23 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 299671C30FC;
	Wed, 22 Nov 2023 20:28:21 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=WIIhDBuA8stf4wYZRXacPXdcyr5ujnkS2P1Her
	4nloY=; b=f0AuEc1nBxaOTKrPGudwMGII0WdV8Fcnu0n0brA78qomGqLttuZu7Z
	5WrTPWm4Yl4N1dlK+Jhd67fCumfUrRfEkeN6BEWtg13lzxA+H2zbHmVvplCt7nXs
	j3Dr95H2vSUUMfB6bfK3Mr98+8wWF/lGyloBFInzpjMXuz7cKGDrg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 211A81C30FB;
	Wed, 22 Nov 2023 20:28:21 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 84AD51C30FA;
	Wed, 22 Nov 2023 20:28:20 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Willem Verstraeten <willem.verstraeten@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: git checkout -B <branch> lets you checkout a branch that is
 already checked out in another worktree Inbox
In-Reply-To: <CAGX9RpFMCVLQV7RbK2u9AabusvkZD+RZNv_UD=R00cSUrjutBg@mail.gmail.com>
	(Willem Verstraeten's message of "Wed, 22 Nov 2023 20:08:36 +0100")
References: <CAGX9RpFMCVLQV7RbK2u9AabusvkZD+RZNv_UD=R00cSUrjutBg@mail.gmail.com>
Date: Thu, 23 Nov 2023 10:28:19 +0900
Message-ID: <xmqqjzq9cl70.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 96124364-899F-11EE-A35B-25B3960A682E-77302942!pb-smtp2.pobox.com

Willem Verstraeten <willem.verstraeten@gmail.com> writes:

>     git checkout -b main #reports a fatal error, as expected

This is expected because "main" already exists, not because "main"
is checked out elsewhere.

>     git checkout -f main origin/main #also reports a fatal error, as expected

This is expected because origin/main is taken as pathspec, and it is
a request to checkout the paths that match the pathspec out of the
named tree-ish (i.e., "main"), even when these paths have local
changes, but you do not have paths that match "origin/main".  The
failure is not because "main" is checked out elsewhere.

A slight variant of the command

    git checkout -f -b main origin/main

still fails for the same reason as the first of your examples above.

It is a tangent, but I suspect this failure may be a bit unexpected.
In this example, "-f"orce could be overriding the usual failure from
"-b" to switch to a branch that already exists, but that is what
"-B" does, and "-f -b" does not work as a synonym for "-B".

In any case, these example you marked "fail as expected" do fail as
expected, but they fail for reasons that have nothing to do with the
protection of branches that are used in other worktrees.

>     git checkout -B main origin/main # ----> this succeeds, which is
> unexpected <----

I agree this may be undesirable.

But it makes sort of sense, because "-B" is a forced form of "-b"
(i.e., it tells git: even when "-b" would fail, take necessary
measures to make it work), and we can view that it is part of
"forcing" to override the protection over branches that are used
elsewhere.

I guess we could change the behaviour so that

    git checkout -B <branch> [<start-point>]

fails when <branch> is an existing branch that is in use in another
worktree, and allow "-f" to be used to override the safety, i.e.,

    git checkout -f -B <branch> [<start-point>]

would allow the <branch> to be repointed to <start-point> (or HEAD)
even when it is used elsewhere.

Thoughts, whether they agree or disagree with what I just said, by
other experienced contributors are very much welcome, before I can
say "patches welcome" ;-).

Willem, thanks for raising the issue.



