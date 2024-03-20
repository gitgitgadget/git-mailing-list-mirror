Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B87384
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 00:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710894359; cv=none; b=fhN74/cScqzNzq2ZWqoacM5hgnJZWYGTtQpskNC7ASaEqtXDur5cYVCq92hfrZZYwS+FrdAJI+YrYwOA4QfpVx22Ecu+batxQhdUgrcbozLKPYnErEvr0UYCYfOqPGzQoM7QtkflRYf/eb74+w73F4r7DHvJBPlhUWZhUgBAaPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710894359; c=relaxed/simple;
	bh=HRaqBnxen2qWFAK6ejnSL84TuxJ782rBCAL8W6DZI3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CWtOA8FaUmAllpb7mm45FHiUvaxYSKRzGYdxiM/NaJfvvsSSGlVWNqfbq/WONTzNDVW8HAY6no63E6k3r43rk7Dir5RQbpmN34A0/FZRUU3FRO7uDdjj9z2Jm+8ts3EHpA5bq7yGhCvmzxTSV1ATB/Nb9BZ6vNwf/bG3E7Hw55w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 5621 invoked by uid 109); 20 Mar 2024 00:25:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 20 Mar 2024 00:25:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13317 invoked by uid 111); 20 Mar 2024 00:25:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 19 Mar 2024 20:25:58 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 19 Mar 2024 20:25:55 -0400
From: Jeff King <peff@peff.net>
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 1/3] revision: add a per-email field to rev-info
Message-ID: <20240320002555.GB903718@coredump.intra.peff.net>
References: <cover.1709841147.git.code@khaugsbakk.name>
 <cover.1710873210.git.code@khaugsbakk.name>
 <9a7102b708e4afe78447e48e4baf5b6d66ca50d1.1710873210.git.code@khaugsbakk.name>
 <20240319212940.GE1159535@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240319212940.GE1159535@coredump.intra.peff.net>

On Tue, Mar 19, 2024 at 05:29:40PM -0400, Jeff King wrote:

> There are three pointers at play here:
> 
>   - ctx.after_subject has its const removed, since it will now always be
>     allocated by log_write_email_headers(), and then freed by the
>     caller. Makes sense Though it looks like we only free in show_log(),
>     and the free in make_cover_letter() is not added until patch 2?
> 
>   - rev_info.extra_headers has its const removed here, but I don't think
>     that is helping anything. We only use it to write into the "headers"
>     strbuf in log_write_email_headers(), which always returns
>     headers.buf (or NULL).
> 
>   - rev.pe_headers is introduced as non-const because it is allocated
>     and freed for each email. That makes some sense, though if we
>     followed the pattern of rev.extra_headers, then the pointer is
>     conceptually "const" within the rev_info struct, and it is the
>     caller who keeps track of the allocation (using a to_free variable).
>     Possibly we should do the same here?
> 
> I do still think this could be split in a more obvious way, leaving the
> pe_headers bits until they are actually needed. Let me see if I can
> sketch it up.

OK, this rabbit hole went much deeper than I expected. ;)

I see why you wanted to drop the const from rev_info.extra_headers here.
We need the local extra_headers variable in show_log() to be non-const
(since it receives the output of log_write_email_headers). But we also
assign rev_info.extra_headers to that variable, and if it is const, the
compiler will complain.

But as it turns out, that assignment is not really necessary at all! It
is only used when you have extra headers along with a non-email format.
In most cases we simply ignore the headers for those formats, and in the
one case where we do respect them, I think it is doing the wrong thing.

So here are some patches which clean things up. They would make a
suitable base for your changes, I think, but IMHO they also stand on
their own as cleanups.

Having now stared at this code for a bit, I do think there's another,
much simpler option for your series: keep the same ugly static-strbuf
allocation pattern in log_write_email_headers(), but extend it further.
I'll show that in a moment, too.

  [1/6]: shortlog: stop setting pp.print_email_subject
  [2/6]: pretty: split oneline and email subject printing
  [3/6]: pretty: drop print_email_subject flag
  [4/6]: log: do not set up extra_headers for non-email formats
  [5/6]: format-patch: return an allocated string from log_write_email_headers()
  [6/6]: format-patch: simplify after-subject MIME header handling

 builtin/log.c      |  4 ++--
 builtin/rev-list.c |  1 +
 builtin/shortlog.c |  1 -
 log-tree.c         | 22 +++++++++-------------
 log-tree.h         |  2 +-
 pretty.c           | 43 ++++++++++++++++++++-----------------------
 pretty.h           | 11 +++++------
 7 files changed, 38 insertions(+), 46 deletions(-)

-Peff
