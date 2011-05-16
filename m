From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv3 2/9] send-pack: Attempt to retrieve remote status even
 if pack-objects fails
Date: Mon, 16 May 2011 02:39:44 -0400
Message-ID: <20110516063944.GB25731@sigill.intra.peff.net>
References: <201105151942.29219.johan@herland.net>
 <1305495440-30836-1-git-send-email-johan@herland.net>
 <1305495440-30836-3-git-send-email-johan@herland.net>
 <20110516040745.GA23583@sigill.intra.peff.net>
 <20110516061354.GA25731@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon May 16 08:39:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLrT8-0007Nt-7b
	for gcvg-git-2@lo.gmane.org; Mon, 16 May 2011 08:39:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751584Ab1EPGjt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2011 02:39:49 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:34161
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751546Ab1EPGjs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2011 02:39:48 -0400
Received: (qmail 11064 invoked by uid 107); 16 May 2011 06:41:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 16 May 2011 02:41:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 May 2011 02:39:44 -0400
Content-Disposition: inline
In-Reply-To: <20110516061354.GA25731@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173708>

On Mon, May 16, 2011 at 02:13:54AM -0400, Jeff King wrote:

> and this patch fixes it:
> 
> diff --git a/builtin/send-pack.c b/builtin/send-pack.c
> index e2f4e21..b9da044 100644
> --- a/builtin/send-pack.c
> +++ b/builtin/send-pack.c
> @@ -345,6 +345,13 @@ int send_pack(struct send_pack_args *args,
>  				ref->status = REF_STATUS_NONE;
>  			if (args->stateless_rpc)
>  				close(out);
> +			/* in case we actually have a full-duplex socket
> +			 * and not two pipes; we can't use "out" because
> +			 * it has been closed already, but in the full-duplex
> +			 * case, "in" and "out" are merely dups of each other.
> +			 * We can't directly use "in" because it may be
> +			 * pointing to the sideband demuxer now */
> +			shutdown(fd[0], SHUT_WR);
>  			if (use_sideband)
>  				finish_async(&demux);
>  			return -1;
> 
> It does call shutdown() on a non-socket in the pipe case. That should be
> a harmless noop, AFAIK.

If we do care (or if we just want to be cleaner), this patch series also
works (and goes on top of the same deadlock topic, i.e., e07fd15):

  [1/3]: connect: treat generic proxy processes like ssh processes
  [2/3]: connect: let callers know if connection is a socket
  [3/3]: send-pack: avoid deadlock on git:// push with failed pack-objects

Another approach would be to actually spawn a pipe-based helper for tcp
connections (sort of a "git netcat"). That would mean all git-protocol
connections would get the same descriptor semantics, in case any other
bugs are lurking. I'm not sure if the ugliness (extra process to manage)
and decreased efficiency (pointlessly proxying data through an extra set
of pipes) are worth it. The only thing which makes me not reject it out
of hand is that it is already how git-over-ssh works (and not unlike
git-over-http), so the extra process and inefficiency are probably not
_that_ big a deal. It just feels ugly. I wish there were a portable way
to split a full-duplex socket into two half-duplex halves, but AFAIK,
that is not possible.

-Peff
