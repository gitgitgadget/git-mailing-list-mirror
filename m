Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1BA1C02
	for <git@vger.kernel.org>; Sun,  2 Jun 2024 01:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717290218; cv=none; b=K1nunCMGM+E306q7Uc74+IYzLH23NWzU/teSVHK8X6UyBxcq7LaaNv9p4SsZf1FubP2aR1GSCk9+tnH7ohfg645MSawtBKWLD7jUOg1rqH9Nz2fTYj80ncm4xPgrPpGdtumakZYc4RVVUKcYa1OWC9fqV9+MaZvBMaM6I+tzFlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717290218; c=relaxed/simple;
	bh=sGjkWD15+ulEtiEuS5o9giJNs4kbMZpaXfg797OAcUk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JB6nZkPo7qIv8fAet/7gPNKN+j3fRgyBbVLs9MOD4+aX4arlHA+wSzoHzkdXo9g116J23v8kPNLAzyRmKpUnOvRIaK7p1UsCcVjNN1dyXrLZprcw5qUs4B+qY+49zyq8WkRWkDro0/AQ6szy8ToWxRG9f89ie3s07dF/zD9gLpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=QWLKvnaJ; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QWLKvnaJ"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 850D81ED1E;
	Sat,  1 Jun 2024 21:03:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=sGjkWD15+ulEtiEuS5o9giJNs4kbMZpaXfg797
	OAcUk=; b=QWLKvnaJo+Ct4LmiYlyDc0duo/Z/NFVdcrYc3pGf1ZIIe8gNCsgjOz
	xKquBKzHHXLxFggWi8Jw1VHj5S6eZ6t5bputTqUFAPoC1pxoJO3qsT9SlY9OP76H
	6serhQvgkWeikFGO6nBA/cqrZCrVlIez06//y1tWC8jWrSJ8GE3RM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 7E78C1ED1D;
	Sat,  1 Jun 2024 21:03:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 994F61ED1A;
	Sat,  1 Jun 2024 21:03:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Eric Sunshine <sunshine@sunshineco.com>,  Ramsay
 Jones <ramsay@ramsayjones.plus.com>,  Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v3 12/12] builtin/refs: new command to migrate ref
 storage formats
In-Reply-To: <xmqqjzj9czop.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	31 May 2024 16:46:30 -0700")
References: <cover.1716451672.git.ps@pks.im> <cover.1716877224.git.ps@pks.im>
	<d832414d1f8a7c8d9ec3ade13e11dd509c0ab641.1716877224.git.ps@pks.im>
	<xmqqjzj9czop.fsf@gitster.g>
Date: Sat, 01 Jun 2024 18:03:27 -0700
Message-ID: <xmqq7cf8b1gg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 EC2144BC-207B-11EF-8F9F-ACC938F0AE34-77302942!pb-smtp20.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> One thing missing is an entry in command-list.
>
> If you ran "make check-docs", you would have seen
>
>     $ make check-docs
>     no link: git-refs
>
> The Documentation/MyFirstContribution.txt file does mention
> command-list, but it is rather messy and unorganized.  I think the
> checklist at the top of <builtin.h> would be the best source of
> information at this moment.
>
> Thanks.

You'd need something like this.  

With the command missing from command-list.txt, git.1 (which has the
list of commands) will fail to mention the command, of course.

The fix to the documentation file itself is also crucial, as the
name section is where we grab the list of command descriptions used
in "git help -a", and with the extra blank line, git.1 will fail to
build.

--- >8 ---
Subject: SQUASH???

diff --git a/Documentation/git-refs.txt b/Documentation/git-refs.txt
index 3e9c05185a..5b99e04385 100644
--- a/Documentation/git-refs.txt
+++ b/Documentation/git-refs.txt
@@ -3,12 +3,11 @@ git-refs(1)
 
 NAME
 ----
-
 git-refs - Low-level access to refs
 
+
 SYNOPSIS
 --------
-
 [verse]
 'git refs migrate' --ref-format=<format> [--dry-run]
 
diff --git a/command-list.txt b/command-list.txt
index c4cd0f352b..e0bb87b3b5 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -157,6 +157,7 @@ git-read-tree                           plumbingmanipulators
 git-rebase                              mainporcelain           history
 git-receive-pack                        synchelpers
 git-reflog                              ancillarymanipulators           complete
+git-refs                                ancillarymanipulators           complete
 git-remote                              ancillarymanipulators           complete
 git-repack                              ancillarymanipulators           complete
 git-replace                             ancillarymanipulators           complete
