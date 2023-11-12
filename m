Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3801A70A
	for <git@vger.kernel.org>; Sun, 12 Nov 2023 23:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wxL7IocI"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0BE1FFB
	for <git@vger.kernel.org>; Sun, 12 Nov 2023 15:52:40 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 2B95F375BC;
	Sun, 12 Nov 2023 18:52:40 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=6Tp7V64ZavfHYqq22oI/LW7/U018mdaEeOx9Ix
	hNP5A=; b=wxL7IocIMDxnArmSfIHnEHnAkuhf3lTwf58dQ+Dct4j4wcCo92AI2T
	Yd9c2vuBerT+ThPTbZbj+cDRQ9rNdy+HmpQnCvX12TSSAvohs0jmKr4bEzp9/sQk
	sPabr5toZa9cSZCgiSDQhWv9+MSY7VZZ+c1sb9JpLiLolJ21aN+rU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 18379375BB;
	Sun, 12 Nov 2023 18:52:40 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A5FE1375B1;
	Sun, 12 Nov 2023 18:52:35 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Edmundo Carmona Antoranz <eantoranz@gmail.com>,  git@vger.kernel.org
Subject: Re: [RFC PATCH] status: avoid reporting worktrees as "Untracked files"
In-Reply-To: <CAPig+cQbwcJOQiYyb7bma3pH1hxjE_X_yeAp3JeHWVCeJtySfQ@mail.gmail.com>
	(Eric Sunshine's message of "Sun, 12 Nov 2023 12:13:59 -0500")
References: <20231104000209.916189-1-eantoranz@gmail.com>
	<xmqqjzqygg3i.fsf@gitster.g>
	<CAOc6etbowajhHsctFJN4ZQ0gND0jzZUrhEkep_pLYtE9y9RBCQ@mail.gmail.com>
	<CAPig+cQbwcJOQiYyb7bma3pH1hxjE_X_yeAp3JeHWVCeJtySfQ@mail.gmail.com>
Date: Mon, 13 Nov 2023 08:52:34 +0900
Message-ID: <xmqqjzqmmsvx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8E53FB04-81B6-11EE-A26F-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Eric Sunshine <sunshine@sunshineco.com> writes:

> I doubt you're the only one, but, based upon, list emails over the
> years, it seems that both in-main-tree and outside-main-tree (often
> sibling) worktrees are common. More recently, we've also heard from
> people who don't even have a main-worktree; instead, they hang their
> multiple worktrees off of a bare repository (which is an
> explicitly-supported use-case); i.e.:
>
>     git clone --bare https://.../foobar.git
>     git -C foobar.git worktree add worktree1
>     git -C foobar.git worktree add worktree2
>     ...

I am not sure why you brought in that layout in this discussion,
because it places worktree1 and worktree2 next to each other, just
like placing worktree1 and worktree2 next to the non-bare repository.

    git clone https://.../foobar.git foobar
    git -C foobar worktree add worktree1
    git -C foobar worktree add worktree2

The layout to create worktrees attached to a bare repository and add
them next to each other, and the same starting from a non-bare
repository, share an important trait.  They do not have an untracked
and untrackable "cruft" in their working tree, unlike the crazy
layout that places worktrees of the repository inside the working
tree of the primary worktree as untracked subdirectories.

Really, what is the advantage of doing so?  It is not like the build
recipe recorded in the primary worktree can work recursively on
different branches that are checked out---worktree names and paths
at which they are checked out are totally local matter, and the
upstream project that supplies the build recipe would not know or
care.

Even worse, when the project wants to add a new subdirectory or a
file, the name chosen for the subdirectory may happen to collide
with the name of an untracked subdirectory you happened to have used
(again, because the worktree names and locations are totally local
matter, the upstream project are unaware of them and cannot avoid
such name clashes even if they cared).  You can imagine the
confusion that happens to your next "git pull".

Compared to such an insanity, attaching worktrees to a bare
repository, so that all worktrees are equals and there is no
"primary" worktree that you cannot remove, behave just as normal as
a set of worktrees attached to a non-bare repository and sit outside
the primary worktree, often as immediate siblings.



