From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] clone: check if server supports shallow clones
Date: Wed, 10 Jun 2015 15:05:14 -0400
Message-ID: <20150610190512.GB22800@peff.net>
References: <1433961320-1366-1-git-send-email-adgar@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, pclouds@gmail.com
To: Mike Edgar <adgar@google.com>
X-From: git-owner@vger.kernel.org Wed Jun 10 21:05:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2lJU-0005Cq-46
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 21:05:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752551AbbFJTFU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 15:05:20 -0400
Received: from cloud.peff.net ([50.56.180.127]:44353 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752623AbbFJTFS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 15:05:18 -0400
Received: (qmail 18413 invoked by uid 102); 10 Jun 2015 19:05:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Jun 2015 14:05:18 -0500
Received: (qmail 30622 invoked by uid 107); 10 Jun 2015 19:05:21 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Jun 2015 15:05:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Jun 2015 15:05:14 -0400
Content-Disposition: inline
In-Reply-To: <1433961320-1366-1-git-send-email-adgar@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271346>

On Wed, Jun 10, 2015 at 02:35:20PM -0400, Mike Edgar wrote:

> When the user passes --depth to git-clone the server's capabilities are
> not currently consulted. The client will send shallow requests even if
> the server does not understand them, and the resulting error may be
> unhelpful to the user. This change pre-emptively checks so git-clone can
> exit with a helpful error if necessary.

This sounds like a good thing to do, but...

> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -944,6 +944,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  
>  	refs = transport_get_remote_refs(transport);
>  
> +	if (option_depth && !is_local && !server_supports("shallow"))
> +		die(_("Server does not support shallow clients"));
> +

It feels a little weird to be checking the option here in cmd_clone.
The transport layer knows we have specified a depth, so it seems like a
more natural place for it (or possibly even lower, in the actual
git-protocol code).

That being said, I think the current capabilities handling is a bit
messy and crosses module boundaries freely. So I would not be surprised
if this is the most reasonable place to put it. But it does make me
wonder whether "git fetch --depth=..." needs the same treatment.

I see that do_fetch_pack checks server_supports("shallow"). Is that
enough to cover all fetch cases? And if it is, why does it not cover the
matching clone cases?

-Peff
