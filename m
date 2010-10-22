From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] make pack-objects a bit more resilient to repo
 corruption
Date: Fri, 22 Oct 2010 10:46:01 -0400
Message-ID: <20101022144600.GA5554@sigill.intra.peff.net>
References: <alpine.LFD.2.00.1010220037250.2764@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri Oct 22 16:45:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9Is2-0004CF-0P
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 16:45:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756842Ab0JVOpT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 10:45:19 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:53855 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754850Ab0JVOpS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 10:45:18 -0400
Received: (qmail 18561 invoked by uid 111); 22 Oct 2010 14:45:17 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 22 Oct 2010 14:45:17 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Oct 2010 10:46:01 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1010220037250.2764@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159692>

On Fri, Oct 22, 2010 at 12:53:32AM -0400, Nicolas Pitre wrote:

> -		if (!src->data)
> +		if (!src->data) {
> +			if (src_entry->preferred_base) {
> +				/* 
> +				 * Those objects are not included in the
> +				 * resulting pack.  Be resilient and ignore
> +				 * them if they can't be read, in case the
> +				 * pack could be created nevertheless.
> +				 */
> +				return 0;
> +			}
>  			die("object %s cannot be read",
>  			    sha1_to_hex(src_entry->idx.sha1));
> +		}

By converting this die() into a silent return, are we losing a place
where git might previously have alerted a user to corruption? In this
case, we can continue the operation without the object, but if we have
detected corruption, letting the user know as soon as possible is
probably a good idea.

In other words, should this instead be:

  warning("unable to read preferred base object: %s", ...);
  return 0;

Or will some other part of the code already complained to stderr?

-Peff
