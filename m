From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] clone: make sure we support the transport type
Date: Tue, 27 May 2008 14:05:37 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0805271352070.19665@iabervon.org>
References: <200805271124.50172.trast@student.ethz.ch> <20080527142842.GA7651@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 27 20:06:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K13Z8-0004Nf-Ul
	for gcvg-git-2@gmane.org; Tue, 27 May 2008 20:06:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756958AbYE0SFj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2008 14:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756926AbYE0SFj
	(ORCPT <rfc822;git-outgoing>); Tue, 27 May 2008 14:05:39 -0400
Received: from iabervon.org ([66.92.72.58]:40286 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756895AbYE0SFi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2008 14:05:38 -0400
Received: (qmail 31718 invoked by uid 1000); 27 May 2008 18:05:37 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 27 May 2008 18:05:37 -0000
In-Reply-To: <20080527142842.GA7651@sigill.intra.peff.net>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83034>

On Tue, 27 May 2008, Jeff King wrote:

> If we use an unsupported transport (e.g., http when curl
> support is not compiled in), transport_get reports an error
> to the user, but we still get a transport object. We need to
> manually check and abort the clone process at that point, or
> we end up with a segfault.
> 
> Noticed by Thomas Rast.

Good catch. I think it might be better to have the transport functions 
report failure when the method requested is NULL, but it's also worthwhile 
to notice this in advance and give the user a comprehensive message in 
advance.

Acked-by: Daniel Barkalow <barkalow@iabervon.org>

> Signed-off-by: Jeff King <peff@peff.net>
> ---
> There are a few other calls to transport_get in builtin-clone, for
> setting up references and doing local cloning. I didn't check, but
> assumed it was impossible for http:// remotes to make it to that code
> path.
> 
>  builtin-clone.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/builtin-clone.c b/builtin-clone.c
> index 4740b13..f4accbe 100644
> --- a/builtin-clone.c
> +++ b/builtin-clone.c
> @@ -449,6 +449,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  		struct remote *remote = remote_get(argv[0]);
>  		struct transport *transport = transport_get(remote, argv[0]);
>  
> +		if (!transport->get_refs_list || !transport->fetch)
> +			die("Don't know how to clone %s", transport->url);
> +
>  		transport_set_option(transport, TRANS_OPT_KEEP, "yes");
>  
>  		if (option_depth)
> -- 
> 1.5.6.rc0.128.g5fd3b9.dirty
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
