From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] log: do not shorten decoration names too early
Date: Thu, 14 May 2015 17:54:53 -0400
Message-ID: <20150514215453.GA16897@peff.net>
References: <55534D95.60609@alum.mit.edu>
 <xmqqwq0c9zc1.fsf@gitster.dls.corp.google.com>
 <xmqqsib09z8y.fsf@gitster.dls.corp.google.com>
 <xmqqoalo9sgc.fsf_-_@gitster.dls.corp.google.com>
 <20150514063317.GA22509@peff.net>
 <xmqq8ucr83h8.fsf@gitster.dls.corp.google.com>
 <xmqqfv6yj0dl.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	git discussion list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 14 23:55:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yt15p-0000ov-L4
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 23:55:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933763AbbENVy5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2015 17:54:57 -0400
Received: from cloud.peff.net ([50.56.180.127]:58902 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933547AbbENVy4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 17:54:56 -0400
Received: (qmail 29049 invoked by uid 102); 14 May 2015 21:54:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 May 2015 16:54:56 -0500
Received: (qmail 28612 invoked by uid 107); 14 May 2015 21:54:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 May 2015 17:54:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 May 2015 17:54:53 -0400
Content-Disposition: inline
In-Reply-To: <xmqqfv6yj0dl.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269107>

On Thu, May 14, 2015 at 02:49:10PM -0700, Junio C Hamano wrote:

> > But if we do not have the "buffer" data cached for that commit (via
> > an earlier call to set_commit_buffer()), we don't have to enlarge
> > the slab, as we are not adding anything to the slab system with this
> > call.
> 
> The change may look something like this.  I do not think it would
> make a difference to the get_cached_commit_buffer() codepath (when
> we use the commit->buffer, we pretty much know we use that for all
> commits), though.

I'm not sure that's true. Most of the _users_ of the commit buffer will
try to look in the cache, and if it's not there, do a one-off read.  But
they don't attach the result to the commit; they throw it away. The
reasoning is that we don't have a cached buffer because we are going to
look at a lot of commits (i.e., save_commit_buffer is off).

So basically anytime save_commit_buffer is off (e.g., in rev-list) we
are expanding the slab unnecessarily, even though literally nobody will
write to it.

> diff --git a/commit.c b/commit.c
> index 65179f9..2d1901f 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -244,7 +244,12 @@ void set_commit_buffer(struct commit *commit, void *buffer, unsigned long size)
>  
>  const void *get_cached_commit_buffer(const struct commit *commit, unsigned long *sizep)
>  {
> -	struct commit_buffer *v = buffer_slab_at(&buffer_slab, commit);
> +	struct commit_buffer *v = buffer_slab_peek(&buffer_slab, commit);
> +	if (!v) {
> +		if (sizep)
> +			*sizep = 0;
> +		return NULL;
> +	}
>  	if (sizep)
>  		*sizep = v->size;
>  	return v->buffer;

I think you need matching changes in unused_commit_buffer and
free_commit_buffer. And detach_commit_buffer, too, I guess. Basically
everywhere except set_commit_buffer would want to use the peek version.

-Peff
