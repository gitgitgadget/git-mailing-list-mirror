Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C74179659
	for <git@vger.kernel.org>; Wed, 10 Apr 2024 16:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712767681; cv=none; b=NBW9SnTH/RkboxUl6D5GIWW5LQTkSBc+DW6yTdKttOfOW8RzMHg76u3BAJLgMMlmS3bhgXE3BwVGHVibYXH4cyU8KVv0AoqWrg7/cLkcIvMjhp5XzcFdtk85gJs5WblZaCrnBOeCOQeONWtM3Xw1Ne+oWS8QOejNYYJWf4rvdhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712767681; c=relaxed/simple;
	bh=2evuMjjfGQ/TjRVUOJXMzWG4RtufvDUJTSpWFhraDaw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Qr8eauEuO8v9d07DUGkTtpWkiR2mf9rPgucEfJnZjopE5ZcY4zhKbs19yO2aVgu9NME7Ac7IcYy4972t79ALbImwJb1YT5cfWEgumsKfniCJRd9nZchyTR0g2CAidHqgzke61T0+WIlX7zZDS737FFWhMD2mWpBL687dH6YmfcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=aLp3ZU/e; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="aLp3ZU/e"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id F15E82F894;
	Wed, 10 Apr 2024 12:47:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=2evuMjjfGQ/TjRVUOJXMzWG4RtufvDUJTSpWFh
	raDaw=; b=aLp3ZU/eCTzCUk20qVrNT8XM2WEH+L3+dZrTzetBdL11xs9WND/K3v
	miwHb6MpR02X5vu129aBF//RKz43s1hgSTvM3zo6+ZurETOZC7c2lkJiqxmjZx1S
	bKcK6pHxjCz+Rnyirqspf7Ctf7MXgdA3QlpAQi6EBoNJvjfEM+TXI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id E8F172F893;
	Wed, 10 Apr 2024 12:47:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 46A1E2F886;
	Wed, 10 Apr 2024 12:47:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Olliver Schinagl <oliver@schinagl.nl>
Cc: phillip.wood123@gmail.com,  phillip.wood@dunelm.org.uk,
  git@vger.kernel.org,  Christian Couder <christian.couder@gmail.com>,
  Stefan Haller <lists@haller-berlin.de>
Subject: Re: [RFC] bisect: Introduce skip-when to automatically skip commits
In-Reply-To: <116dd27e-2e30-4915-a131-6c71c999fccd@schinagl.nl> (Olliver
	Schinagl's message of "Wed, 10 Apr 2024 12:39:03 +0200")
References: <20240330081026.362962-2-oliver@schinagl.nl>
	<864b0f22-b07b-469b-8fc2-56940fd89a8b@schinagl.nl>
	<xmqqcyr3s3gj.fsf@gitster.g>
	<b194ba7c-454b-494f-bef2-e9eac7ca87f1@schinagl.nl>
	<4bedcad2-218a-4b16-88a7-cc70cc126af3@gmail.com>
	<6dd4a5a4-9999-4c04-a854-09fc238c91bb@schinagl.nl>
	<d10bd772-2cf1-4838-bec2-ea2a639cabab@gmail.com>
	<2542ebd6-11ce-496b-b10b-b55c3a211705@schinagl.nl>
	<c4ed3e05-ae9f-42dd-835e-a52e710e70fd@gmail.com>
	<xmqqzfu3dcl1.fsf@gitster.g>
	<116dd27e-2e30-4915-a131-6c71c999fccd@schinagl.nl>
Date: Wed, 10 Apr 2024 09:47:53 -0700
Message-ID: <xmqqzfu1upty.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1432E01E-F75A-11EE-93F5-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Olliver Schinagl <oliver@schinagl.nl> writes:

> While completly orthonogal, I agree; it would be nice to have and
> 'abuse' for the bisect-skip usecase. So if we ignore the fact that it
> can be abused for this (which I don't think is a bad thing, it just
> risks the recursive issue Phillip mentioned.

I do not see the "recursive" issue here, though.  If we had such a
mechansim, those whose test cannot be driven by "bisect run" can
still use the "--post-checkout" and "--pre-resume" options, where
the post-checkout option names a file that has:

	#!/bin/sh
        if git merge-base --is-ancestor $the_other_bug HEAD
        then
          # we need the fix
          git cherry-pick --no-commit $fix_for_the_other_bug ||
          exit 125
        fi

in it.  There is no "recursive"-ness here.  And then after manually
testing the checked out stuff (with tweak, thanks to the post-checkout
script), they can now say "git bisect good/bad/skip" and that is
when their --pre-resume script kicks in, which may do

	#!/bin/sh
	git reset --hard ;# undo the damage done by post-checkout

before the bisect machinery goes and picks the next commit to test.

Notice that I still kept the "exit 125" in the above post-checkout
example?  That is where the "bisect next" that picked the commit to
test, checked out that commit and updated the working tree, and run
your post-checkout script, can be told that the version checked out
is untestable and to be skipped.  So such a post-checkout script can
be treated as a strict superset of --skip-when script we have been
discussing.

Needless to say, if we were to do this, we probably should let
"bisect run" also pay attention to these two scripts.  They are most
likely to become new parameters specified when "bisect start" is run
to be recorded as one of the many states "git bisect" creates.
