From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] log: do not shorten decoration names too early
Date: Thu, 14 May 2015 18:33:13 -0400
Message-ID: <20150514223313.GA21149@peff.net>
References: <55534D95.60609@alum.mit.edu>
 <xmqqwq0c9zc1.fsf@gitster.dls.corp.google.com>
 <xmqqsib09z8y.fsf@gitster.dls.corp.google.com>
 <xmqqoalo9sgc.fsf_-_@gitster.dls.corp.google.com>
 <20150514063317.GA22509@peff.net>
 <xmqq8ucr83h8.fsf@gitster.dls.corp.google.com>
 <xmqqfv6yj0dl.fsf@gitster.dls.corp.google.com>
 <20150514215453.GA16897@peff.net>
 <xmqq7fsaiyoy.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Thomas Rast <tr@thomasrast.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 15 00:33:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yt1gw-0001iO-2N
	for gcvg-git-2@plane.gmane.org; Fri, 15 May 2015 00:33:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933511AbbENWdR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2015 18:33:17 -0400
Received: from cloud.peff.net ([50.56.180.127]:58941 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933019AbbENWdQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 18:33:16 -0400
Received: (qmail 30984 invoked by uid 102); 14 May 2015 22:33:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 May 2015 17:33:16 -0500
Received: (qmail 29199 invoked by uid 107); 14 May 2015 22:33:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 May 2015 18:33:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 May 2015 18:33:13 -0400
Content-Disposition: inline
In-Reply-To: <xmqq7fsaiyoy.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269116>

On Thu, May 14, 2015 at 03:25:33PM -0700, Junio C Hamano wrote:

> @@ -90,6 +97,8 @@ static MAYBE_UNUSED elemtype *slabname## _at(struct slabname *s,	\
>  									\
>  	if (s->slab_count <= nth_slab) {				\
>  		int i;							\
> +		if (!add_if_missing)					\
> +			return NULL;					\
>  		s->slab = xrealloc(s->slab,				\
>  				   (nth_slab + 1) * sizeof(*s->slab));	\
>  		stat_ ##slabname## realloc++;				\

This skips extending the list of slabs if we would go past the nth slab.
But we don't fill in each slab in the first place. I.e., we may have 10
slabs, but only s->slab[10] is non-NULL.

A few lines below this, we xcalloc() it if necessary. I think that needs
to respect add_if_missing, as well.

>  void unuse_commit_buffer(const struct commit *commit, const void *buffer)
>  {
> -	struct commit_buffer *v = buffer_slab_at(&buffer_slab, commit);
> -	if (v->buffer != buffer)
> +	struct commit_buffer *v = buffer_slab_peek(&buffer_slab, commit);
> +	if (v && v->buffer != buffer)
>  		free((void *)buffer);
>  }

I think you want:

  if (!v || v->buffer != buffer)

here. IOW, we free it only if it is not our cached buffer, and it cannot
be if we do not have a cached buffer. It may be easier to read by
flipping the logic:

  if (v && v->buffer == buffer)
	return; /* it is saved in the cache */
  free((void *)buffer);

Or some variation on that.

-Peff
