From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] commit-slab: introduce a macro to define a slab for
 new type
Date: Sun, 14 Apr 2013 14:41:21 -0400
Message-ID: <20130414184121.GA1621@sigill.intra.peff.net>
References: <1365919489-17553-1-git-send-email-gitster@pobox.com>
 <1365919489-17553-4-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 14 20:41:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URRro-0007l7-VI
	for gcvg-git-2@plane.gmane.org; Sun, 14 Apr 2013 20:41:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753468Ab3DNSl1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 14:41:27 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:45486 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752208Ab3DNSl1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Apr 2013 14:41:27 -0400
Received: (qmail 15567 invoked by uid 107); 14 Apr 2013 18:43:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 14 Apr 2013 14:43:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 14 Apr 2013 14:41:21 -0400
Content-Disposition: inline
In-Reply-To: <1365919489-17553-4-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221146>

On Sat, Apr 13, 2013 at 11:04:49PM -0700, Junio C Hamano wrote:

> Suppose you want to give one bit per existing ref and paint commits
> down to find which refs are descendants of each commit. You find
> that you have 320 refs only at runtime.
> 
> The code can declare a commit slab "struct flagbits"
> 
> 	define_commit_slab(flagbits, unsigned char);
> 	struct flagbits flags;
> 
> and initialize it by:
> 
> 	nrefs = ... count number of refs that returns say 320 ...
> 	init_flagbits_with_stride(&flags, (nrefs + 7) / 8);
> 
> so that
> 
> 	unsigned char *fp = flagbits_at(&flags, commit);
> 
> will return a pointer pointing at an array of 40 "unsigned char"s
> associated with the commit.

Thanks, I was thinking originally that we would want to break it down
into "unsigned long" or something, but there is probably no real
performance advantage to doing that over bytes.

I'd probably further wrap it with a flagbit_set and flagbit_tst to wrap
the "figure out which byte, then which bit of that byte" logic, but that
would be a wrapper around flagbits_at, anyway. It can come later.

> +static elemtype *slabname## _at(struct slabname *s,			\
> +				const struct commit *c)			\
> +{									\
> +	int nth_slab, nth_slot, ix;					\
> +									\
> +	ix = c->index * s->stride;					\
> +	nth_slab = ix / s->slab_size;					\
> +	nth_slot = ix % s->slab_size;					\
> +									\
> +	if (s->slab_count <= nth_slab) {				\
> +		int i;							\
> +		s->slab = xrealloc(s->slab,				\
> +				   (nth_slab + 1) * sizeof(s->slab));	\
> +		stat_ ##slabname## realloc++;				\
> +		for (i = s->slab_count; i <= nth_slab; i++)		\
> +			s->slab[i] = NULL;				\
> +		s->slab_count = nth_slab + 1;				\
> +	}								\
> +	if (!s->slab[nth_slab])						\
> +		s->slab[nth_slab] = xcalloc(s->slab_size,		\
> +					    sizeof(**s->slab));		\
> +	return &s->slab[nth_slab][nth_slot];				\
> +}									\

We'd probably want the hot path of this (returning the actual pointer)
to be inline, but not necessarily the parts about growing, which should
trigger a lot less. It may make sense to split the conditional bodies
out into a sub-function. And do we want to mark it with "inline"?

-Peff
