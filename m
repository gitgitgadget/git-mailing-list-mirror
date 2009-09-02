From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] clone: disconnect transport after fetching
Date: Wed, 2 Sep 2009 12:38:35 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0909021228570.28290@iabervon.org>
References: <alpine.LNX.2.00.0909020159080.28290@iabervon.org> <20090902063647.GA29559@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	=?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Sitaram Chamarty <sitaramc@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 02 18:38:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Misr9-0004YX-0u
	for gcvg-git-2@lo.gmane.org; Wed, 02 Sep 2009 18:38:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752441AbZIBQie (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2009 12:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752407AbZIBQie
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Sep 2009 12:38:34 -0400
Received: from iabervon.org ([66.92.72.58]:33793 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752342AbZIBQid (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2009 12:38:33 -0400
Received: (qmail 23075 invoked by uid 1000); 2 Sep 2009 16:38:35 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 2 Sep 2009 16:38:35 -0000
In-Reply-To: <20090902063647.GA29559@coredump.intra.peff.net>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127609>

On Wed, 2 Sep 2009, Jeff King wrote:

> The current code just leaves the transport in whatever state
> it was in after performing the fetch.  For a non-empty clone
> over the git protocol, the transport code already
> disconnects at the end of the fetch.
> 
> But for an empty clone, we leave the connection hanging, and
> eventually close the socket when clone exits. This causes
> the remote upload-pack to complain "the remote end hung up
> unexpectedly". While this message is harmless to the clone
> itself, it is unnecessarily scary for a user to see and may
> pollute git-daemon logs.
> 
> This patch just explicitly calls disconnect after we are
> done with the remote end, which sends a flush packet to
> upload-pack and cleanly disconnects, avoiding the error
> message.
> 
> Other transports are unaffected or slightly improved:
> 
>  - for a non-empty repo over the git protocol, the second
>    disconnect is a no-op (since we are no longer connected)
> 
>  - for "walker" transports (like HTTP or FTP), we actually
>    free some used memory (which previously just sat until
>    the clone process exits)
> 
>  - for "rsync", disconnect is always a no-op anyway
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> This was suggested by Daniel, so theoretically
> 
>   Acked-by: Daniel Barkalow <barkalow@iabervon.org>
> 
> :)

This is what I intended, so:

Acked-by: Daniel Barkalow <barkalow@iabervon.org>

> As you can see from the commit message, I did a little extra hunting to
> make sure we are not going to impact any other code paths, and I am
> pretty sure we are fine.

Also, builtin-fetch already does the explicit disconnect, and commonly 
exercises both the "we want something" and "we don't want anything" cases, 
so any problems would have to be surprisingly clone-specific.

>  builtin-clone.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/builtin-clone.c b/builtin-clone.c
> index 991a7ae..0f231d8 100644
> --- a/builtin-clone.c
> +++ b/builtin-clone.c
> @@ -580,8 +580,10 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  		option_no_checkout = 1;
>  	}
>  
> -	if (transport)
> +	if (transport) {
>  		transport_unlock_pack(transport);
> +		transport_disconnect(transport);
> +	}
>  
>  	if (!option_no_checkout) {
>  		struct lock_file *lock_file = xcalloc(1, sizeof(struct lock_file));
> -- 
> 1.6.4.2.401.ga275f.dirty
> 
