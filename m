Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5215339B
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 10:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708941614; cv=none; b=kjbmXnh5f5TgwFUBxaSdPyZHlFBglQEs70Bd0oSJgdyJkTadd+fX+Y4dwGXW3HW7wi6OHTN1iSFFGZl4yK5+wjpbG7bLcB0bfWQnxtNrXH40+Uj8K8C3Ne4GJvpgHIEp3qCDlhTqiVgn09V9/PxcEEFMsKEdBJdneymvOGuaE2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708941614; c=relaxed/simple;
	bh=m1Ly8jkmhCkTA1TfqR6t6IYeotphnzpEw7FUTR6lvzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qtjqRe5W+d4WoKq68QDwhh/yos9c0gLocTa3lKkJJCT5ESc+VU8cnC+2Vhx6DngtNHEWLSJm9XQHKkXV4D+aNTVFbbi4Bchx/dlglDIITZH0ag+VMMdAsJcWbZnqzFxk11uCdMjrUOXkOxbeb9JQ/TC0OGetBqPEsYK07GH0U74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 21847 invoked by uid 109); 26 Feb 2024 10:00:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 26 Feb 2024 10:00:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13720 invoked by uid 111); 26 Feb 2024 10:00:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 26 Feb 2024 05:00:15 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 26 Feb 2024 05:00:10 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, Yasushi SHOJI <yasushi.shoji@gmail.com>,
	Denton Liu <liu.denton@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 0/3] show-branch --reflog fixes
Message-ID: <20240226100010.GA1214708@coredump.intra.peff.net>
References: <CAELBRWK-bZTV0qx6_34HAgpmYwy+5Zo2E0M+4B6yZJJ3CqweTw@mail.gmail.com>
 <20240221084250.GA25385@coredump.intra.peff.net>
 <xmqqv86hogpi.fsf@gitster.g>
 <ZdcNtxw04MtybTWZ@tanuki>
 <xmqq34tkiho9.fsf@gitster.g>
 <20240222172252.GA3535450@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240222172252.GA3535450@coredump.intra.peff.net>

On Thu, Feb 22, 2024 at 12:22:52PM -0500, Jeff King wrote:

> If none of this makes sense, it is because I am only now untangling what
> is going on with 6436a20284. ;) I will try to polish my proposed patches
> and hopefully that will explain it a bit more clearly (I may not get to
> it until tomorrow though).

OK, so here's what I came up with. One thing I did not realize, as I
was writing my patches directly atop 6436a20284, is that we actually
fixed the reflog message bug back in f2463490c4 (show-branch: show
reflog message, 2021-12-02). And several tests have been added since
then.

So I gave up on trying to build on top of the source of the bug, and
just rebased onto the tip of master. It should apply to recent "maint"
as well, I'd think.

  [1/3]: Revert "refs: allow @{n} to work with n-sized reflog"
  [2/3]: get_oid_basic(): special-case ref@{n} for oldest reflog entry
  [3/3]: read_ref_at(): special-case ref@{0} for an empty reflog

 object-name.c          |  9 ++++++
 refs.c                 | 65 +++++++++++++++++++-----------------------
 refs.h                 | 15 +++++++++-
 t/t3202-show-branch.sh | 49 +++++++++++++++++++++----------
 4 files changed, 87 insertions(+), 51 deletions(-)
