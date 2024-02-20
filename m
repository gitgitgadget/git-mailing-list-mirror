Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248C736113
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 01:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708394372; cv=none; b=Qtca5T7+uLdvRvcQyzsiDuKbDjvYa4krPGai97VW0jqgpBf25UY5p5gFVbbNLieumkoTkWyXVCvLqGmWz8ADD4INmGW2pq4s9luANXZUg/Q38kSkqrpwgfPmH7p/mOpnb/rA/mCS/lBbh0iY4fx+W8L1SDgYNL50EdlzF9gh7Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708394372; c=relaxed/simple;
	bh=SgwUqxoZHL/Yqx7bEiymH0KZbEaZkeQDHstiNhGqD9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ew0UKCf9ob1LC6iJC77Oo2HYaZkwAXVgFBqtXIq+Iwzu74BFBXqULCfsI9MTcXgSS7lD5K64ZERzDI5e4y/7xVpmDA7WLh27jiEwRDb+3NygIXh5tu+7AhGshTeEEQZjSjkNbHwXbyRlryig415EEGhly6JG0TTTZt55/B+70Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 23384 invoked by uid 109); 20 Feb 2024 01:59:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 20 Feb 2024 01:59:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18572 invoked by uid 111); 20 Feb 2024 01:59:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 19 Feb 2024 20:59:32 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 19 Feb 2024 20:59:28 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Maarten Bosmans <mkbosmans@gmail.com>, git@vger.kernel.org,
	Maarten Bosmans <maarten.bosmans@vortech.nl>
Subject: Re: [PATCH v2 1/5] log: Move show_blob_object() to log.c
Message-ID: <20240220015928.GB2713741@coredump.intra.peff.net>
References: <20240205204932.16653-1-maarten.bosmans@vortech.nl>
 <20240218195938.6253-1-maarten.bosmans@vortech.nl>
 <20240218195938.6253-2-maarten.bosmans@vortech.nl>
 <xmqqjzn0x72z.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqjzn0x72z.fsf@gitster.g>

On Mon, Feb 19, 2024 at 05:22:44PM -0800, Junio C Hamano wrote:

> > This way it can be used outside of builtin/log.c.
> > The next commit will make builtin/notes.c use it.
> 
> The resulting file is only about a small part of the implementation
> detail of "show", and has very little to do with "log".
> 
> "show.c" that happens to house show_blob_object(), a "canonical" way
> to display a blob object, with an anticipation that somebody may
> want to expand it in the future to house the "canonical" way to
> display a tag, a tree or a commit object, would be OK, though.

I'm not sure this function (or its siblings in builtin/log.c) counts as
"canonical", since it is deeply connected to "struct rev_info". So it is
appropriate for log, show, etc, but not for other commands.

It felt a little funny to me to make a new file just for this one
function. The related functions are all in log-tree.c. And as a bonus,
the name is _already_ horribly confusing because it says "tree" but the
functions are really about showing commits. ;)

All that said, I'm not sure based on our previous discussion why we
can't just call stream_blob_to_fd(). Looking at show_blob_object(), most
of the logic is about recording the tree-context of the given name and
using it for textconv. But since we know we are feeding a bare oid,
that would never kick in. So I don't know if there's any value in
sharing this function more widely in the first place.

-Peff
