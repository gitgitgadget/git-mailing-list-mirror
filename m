Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2184B64CF1
	for <git@vger.kernel.org>; Tue, 23 Jan 2024 00:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705971556; cv=none; b=sPcHwUqqLmopnFZ5bVFIGMak1CvHBlelcLIxmmwdfZ8jY4FaKju1uTI1V46/Cws0iFsLoZAXDDdsv8AwzIQmO4QUc9stNIgX38suDQviyP1Y1hj9qL05888rKLGwuXJppUgCWn19abzseyF6xWTwM+996szZmVZj5mOhdivUStQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705971556; c=relaxed/simple;
	bh=OiuzKpYudc2SvnT2hITUGZ6EgmSGXieCi5xXqyL7vBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YP2P5Bhx+ZHlBhzkFo4ywfVdYrOse6ivqtHAO+wV2bt81pXEmUhHoR30zDjy/t6ZeFm+ZkUsKdrrOCibMPoyCkupOuFdVn+sTMcGz7tLKILd2O7bPyr+YwpDYYZF6lNp8rMYWgWfEcPOl6v4jMOmHvqPM/Vw2kPzCSmT0XyFdeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 12705 invoked by uid 109); 23 Jan 2024 00:59:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 23 Jan 2024 00:59:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11120 invoked by uid 111); 23 Jan 2024 00:59:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 22 Jan 2024 19:59:15 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 22 Jan 2024 19:59:13 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
	johannes.schindelin@gmx.de, phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH 2/4] test-tool run-command testsuite: support unit
 tests
Message-ID: <20240123005913.GB835964@coredump.intra.peff.net>
References: <cover.1705443632.git.steadmon@google.com>
 <5ecbc976e6216b941e760e096e166ab432ee7784.1705443632.git.steadmon@google.com>
 <xmqqv87sx3y2.fsf@gitster.g>
 <xmqqil3sx2y6.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqil3sx2y6.fsf@gitster.g>

On Tue, Jan 16, 2024 at 03:40:01PM -0800, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Josh Steadmon <steadmon@google.com> writes:
> >
> >> Teach the testsuite runner in `test-tool run-command testsuite` how to
> >> run unit tests, by adding two new flags:
> >>
> >> First, "--(no-)run-in-shell" allows the test-tool to exec the unit-test
> >> binaries directly, rather than trying to interpret them as shell
> >> scripts.
> >
> > Makes perfect sense.
> 
> This may be a stupid question, but do we even need the current "push
> 'sh' to the strvec"?  If our executable shell scripts run just fine
> without, then this may not have to be conditional.

It is necessary for the same reason that the indirection provided by
patch 4 is necessary: the test scripts are supposed to be run by
TEST_SHELL_PATH, even if they may say "#!/bin/sh" in their header.

But the "testsuite" helper just hard-codes "sh", which is wrong. It's
somewhat academic for Windows where "sh" is already bash, and that's the
only reasonable thing anybody would set TEST_SHELL_PATH to anyway. But
if the point is to be a drop-in replacement for the existing flow, it
should be checking getenv("TEST_SHELL_PATH"). And perhaps the Makefile
might need to correctly export the variable.

-Peff
