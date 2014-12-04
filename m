From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] remote: add --fetch and --both options to set-url
Date: Thu, 4 Dec 2014 04:37:50 -0500
Message-ID: <20141204093750.GD27455@peff.net>
References: <1416916106-19892-1-git-send-email-peter@lekensteyn.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Peter Wu <peter@lekensteyn.nl>
X-From: git-owner@vger.kernel.org Thu Dec 04 10:38:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwSrH-0005Z2-4F
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 10:37:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752922AbaLDJhx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 04:37:53 -0500
Received: from cloud.peff.net ([50.56.180.127]:48260 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751147AbaLDJhw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 04:37:52 -0500
Received: (qmail 23985 invoked by uid 102); 4 Dec 2014 09:37:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Dec 2014 03:37:52 -0600
Received: (qmail 4921 invoked by uid 107); 4 Dec 2014 09:37:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Dec 2014 04:37:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Dec 2014 04:37:50 -0500
Content-Disposition: inline
In-Reply-To: <1416916106-19892-1-git-send-email-peter@lekensteyn.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260751>

On Tue, Nov 25, 2014 at 12:48:26PM +0100, Peter Wu wrote:

> git remote set-url knew about the '--push' option to update just the
> pushurl, but it does not have a similar option for "update fetch URL and
> leave whatever was in place for the push URL".
> 
> This patch adds support for a '--fetch' option which implements that use
> case in a backwards compatible way: if no --both, --push or --fetch
> options are given, then the push URL is modified too if it was not set
> before. This is the case since the push URL is implicitly based on the
> fetch URL.
> 
> A '--both' option is added to make the command independent of previous
> pushurl settings. For the --add and --delete set operations, it will
> always set the push and/ or the fetch URLs. For the primary mode of
> operation (without --add or --delete), it will drop pushurl as the
> implicit push URL is the (fetch) URL.
> 
> The documentation has also been updated and a missing '--push' option
> is added to the 'git remote -h' command.
> 
> Tests are also added to verify the documented behavior.
> 
> Signed-off-by: Peter Wu <peter@lekensteyn.nl>
> ---

Sorry for the slowness in reviewing. The design of this version makes
sense to me (not surprising, I guess, since it was in direct response to
my comments).

I didn't see anything glaringly wrong in the implementation, though I
did find it a little hard to follow, because of this:

> +#define MODIFY_TYPE_FETCH       (1 << 0)
> +#define MODIFY_TYPE_PUSH        (1 << 1)
> +#define MODIFY_TYPE_BOTH        (MODIFY_TYPE_FETCH | MODIFY_TYPE_PUSH)
> +#define MODIFY_TYPE_HISTORIC    (MODIFY_TYPE_FETCH | (1 << 2))

When reading through the code, the distinction between

  modify_type & MODIFY_TYPE_FETCH

and

  modify_type == MODIFY_TYPE_FETCH

is significant, because the former matches HISTORIC, while the latter
does not. I imagine that a distinct bit value for HISTORIC would make
things a bit more verbose (you would have to add an extra OR in many
places), but I wonder if it would make the code easier to follow (one of
the things I wanted to check was that HISTORIC does the same thing that
it always did, and it is very hard to follow the HISTORIC behavior
reading the code linearly).

I dunno. I don't insist; just noting a difficulty I had while reading
it.  Maybe you went down that route already during development and found
it more painful.

-Peff
