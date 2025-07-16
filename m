Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E37C2E36F7
	for <git@vger.kernel.org>; Wed, 16 Jul 2025 05:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752642937; cv=none; b=Dpm5r4rihG/RDFOeA0JFxWfuI4n2zNbw/QotUs6geWzqiaVZmeHPEGN5pGMlIj77Uc7+GlB9VAue2tSKgfQzzPjQyc6yJuG1NBes3TjhQ6z0J7nd45R4qLXSEk6MBaAv1ubGv21gH0jOVYIBSs3fRWLHaPnufRa1YLc6gpx7F20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752642937; c=relaxed/simple;
	bh=XLMUjKKlB91KyCwODnLhkA2BDHvDRM4V0avEQpiR4L4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p2Burpm74PBpMizMAxpPJadIqd3hpY82rl/xnAftiwolcJCUV0vwpuDRvTgyZuPR2fwfGrX+NtM5jfCIaULciH0U9RWhpyKR6rOsoj/dgeQgHsyPa8XcMsj8wGCed+N5jLuQymnFsHOQwqvYlJu9cp8JvApHgqpxc5RGyDtKDvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=cSGNen+o; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="cSGNen+o"
Received: (qmail 589 invoked by uid 109); 16 Jul 2025 05:15:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=XLMUjKKlB91KyCwODnLhkA2BDHvDRM4V0avEQpiR4L4=; b=cSGNen+oLzDlhBu4Z9BULACvxpG02Vs4P4ONcOQB/l9tZa4ed0ZI1LKjju9DqLy6KwHPeBEaHCWNzeFLLwNJaLXGNqhLa+eRD9eaJa+ddv5WK0z2+lHo2XMOaQifBQkC8/8oRXDM2fsn3mFIC48G46PG4nyYpxWU+02ck5I/eI11xKT+juyHlmriAScuN855s67HsB0OjXbbCztL3HQQ5C1Tj/HrfzqyPzJBGTp8bHDfBXnvCfxcm9UxKB/j1bxwLVJQUKhPRhjl+aaUMvIH4N6XAd+6ijsP8R7lmBNOtjpQYboa1g2MYAzs3ZArbVuTzaeDHTgwvgVw8k5GNSaWQA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 16 Jul 2025 05:15:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9803 invoked by uid 111); 16 Jul 2025 05:15:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 16 Jul 2025 01:15:38 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 16 Jul 2025 01:15:33 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Git List <git@vger.kernel.org>
Subject: Re: [PATCH 0/3] commit: convert pop_most_recent_commit() to
 prio_queue
Message-ID: <20250716051533.GD1396022@coredump.intra.peff.net>
References: <bc079b3c-a472-4f5d-95ca-390f9de25196@web.de>
 <xmqqv7ntdmlx.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqv7ntdmlx.fsf@gitster.g>

On Tue, Jul 15, 2025 at 05:07:38PM -0700, Junio C Hamano wrote:

> René Scharfe <l.s.r@web.de> writes:
> 
> > Use prio_queue to improve worst-case performance at the cost of slightly
> > worse best-case performance.  Then add and use prio_queue_replace() to
> > recover that loss.
> 
> Would change in the tiebreaking behaviour (aka sort stability) also
> a cost of this change, as this swaps use of sorted linearly linked
> list with priority queue?

The prio_queue uses insertion order as a tie-breaker for stability (with
earlier entries coming first). For building the initial queue from the
list, I think that is obviously fine (we feed them in sorted order,
which the prio queue will retain). For inserting while we walk the list,
we'll produce the same results as long as the original code always
inserted new entries after existing ones (in the case of a tie on commit
date, that is).

And I think that is the case, since commit_list_insert_by_date() does
this:

          while ((p = *pp) != NULL) {
                  if (p->item->date < item->date) {
                          break;
                  }
                  pp = &p->next;
          }
          return commit_list_insert(item, pp);

So we only insert once we have found an item in the list _after_ us,
retaining the same order.

But hopefully somebody can double check my logic, as it is quite
possible I got something reversed above. ;)

-Peff
