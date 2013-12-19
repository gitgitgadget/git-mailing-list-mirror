From: Jeff King <peff@peff.net>
Subject: Re: RLIMIT_NOFILE fallback
Date: Wed, 18 Dec 2013 19:15:19 -0500
Message-ID: <20131219001519.GB17420@sigill.intra.peff.net>
References: <20131218171446.GA19657@kitenet.net>
 <xmqqy53ihwe4.fsf@gitster.dls.corp.google.com>
 <20131218191702.GA9083@sigill.intra.peff.net>
 <xmqq61qmhrb3.fsf@gitster.dls.corp.google.com>
 <20131218212847.GA13685@sigill.intra.peff.net>
 <xmqqd2kthmcr.fsf@gitster.dls.corp.google.com>
 <20131218214001.GA14354@sigill.intra.peff.net>
 <xmqqzjnxg3zz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Joey Hess <joey@kitenet.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 19 01:15:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtRGx-0007gF-Hg
	for gcvg-git-2@plane.gmane.org; Thu, 19 Dec 2013 01:15:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751842Ab3LSAPW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Dec 2013 19:15:22 -0500
Received: from cloud.peff.net ([50.56.180.127]:47021 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751367Ab3LSAPV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Dec 2013 19:15:21 -0500
Received: (qmail 16922 invoked by uid 102); 19 Dec 2013 00:15:21 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 18 Dec 2013 18:15:21 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Dec 2013 19:15:19 -0500
Content-Disposition: inline
In-Reply-To: <xmqqzjnxg3zz.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239502>

On Wed, Dec 18, 2013 at 02:59:12PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
>
> >> Yes, that is locally OK, but depending on how the caller behaves, we
> >> might need to have an extra saved_errno dance here, which I didn't
> >> want to get into...
> >
> > I think we are fine. The only caller is about to clobber errno by
> > closing packs anyway.

Also, I do not think we would be any worse off than the current code.
getrlimit almost certainly just clobbered errno anyway. Either it is
worth saving for the whole function, or not at all (and I think not at
all).

> diff --git a/sha1_file.c b/sha1_file.c
> index 760dd60..288badd 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -807,15 +807,38 @@ void free_pack_by_name(const char *pack_name)
>  static unsigned int get_max_fd_limit(void)
>  {
>  #ifdef RLIMIT_NOFILE
> -	struct rlimit lim;
> +	{
> +		struct rlimit lim;
>  
> -	if (getrlimit(RLIMIT_NOFILE, &lim))
> -		die_errno("cannot get RLIMIT_NOFILE");
> +		if (!getrlimit(RLIMIT_NOFILE, &lim))
> +			return lim.rlim_cur;
> +	}
> +#endif

Yeah, I think pulling the variable into its own block makes this more
readable.

> +#ifdef _SC_OPEN_MAX
> +	{
> +		long open_max = sysconf(_SC_OPEN_MAX);
> +		if (0 < open_max)
> +			return open_max;
> +		/*
> +		 * Otherwise, we got -1 for one of the two
> +		 * reasons:
> +		 *
> +		 * (1) sysconf() did not understand _SC_OPEN_MAX
> +		 *     and signaled an error with -1; or
> +		 * (2) sysconf() said there is no limit.
> +		 *
> +		 * We _could_ clear errno before calling sysconf() to
> +		 * tell these two cases apart and return a huge number
> +		 * in the latter case to let the caller cap it to a
> +		 * value that is not so selfish, but letting the
> +		 * fallback OPEN_MAX codepath take care of these cases
> +		 * is a lot simpler.
> +		 */
> +	}
> +#endif

This is probably OK. I assume sane systems actually provide OPEN_MAX,
and/or have a working getrlimit in the first place.

The fallback of "1" is actually quite low and can have an impact. Both
for performance, but also for concurrent use. We used to run into a
problem at GitHub where pack-objects serving a clone would have its
packfile removed from under it (by a concurrent repack), and then would
die. The normal code paths are able to just retry the object lookup and
find the new pack, but the pack-objects code is a bit more intimate with
the particular packfile and cannot (currently) do so. With a large
enough mmap window and descriptor limit, we just keep the packfiles
open. But if we have to close them for resource limits (like a too-low
descriptor limit), then we can end up in the die() situation above.

-Peff
