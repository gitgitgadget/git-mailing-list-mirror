From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: git-clone --quiet broken?
Date: Sat, 5 Jul 2008 21:22:18 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0807052102180.19665@iabervon.org>
References: <20080705211616.GA3874@codemonkey.org.uk> <7vmykvrfta.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Dave Jones <davej@codemonkey.org.uk>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 06 03:23:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFIyG-000136-9a
	for gcvg-git-2@gmane.org; Sun, 06 Jul 2008 03:23:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753255AbYGFBWU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jul 2008 21:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753195AbYGFBWT
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jul 2008 21:22:19 -0400
Received: from iabervon.org ([66.92.72.58]:39810 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753174AbYGFBWT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jul 2008 21:22:19 -0400
Received: (qmail 8176 invoked by uid 1000); 6 Jul 2008 01:22:18 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 6 Jul 2008 01:22:18 -0000
In-Reply-To: <7vmykvrfta.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87481>

On Sat, 5 Jul 2008, Junio C Hamano wrote:

> Dave Jones <davej@codemonkey.org.uk> writes:
> 
> > The server I run various git snapshots on recently got upgraded to git 1.5.6,
> > ...
> > I could run the clone with 2>/dev/null, but I'd really like to get
> > mail when something breaks instead of it being totally silent.
> >
> > I'm assuming this was an unintentional side-effect of some other recent change?
> 
> Yeah, I would assume so, too ;-)
> 
> Daniel, is this enough?  From re-reading the scripted version of
> git-clone, it appears that we *might* need to squelch no-progress if the
> stdout is not tty;  I do not offhand if you got that right when you
> rewrote this in C.

This is probably enough for what people actually care about (when stdout 
isn't a tty and isn't /dev/null, people are likely to ask for "quiet" 
anyway, because this command's output isn't interesting after the fact). 
But no-progress is probably a good idea anyway.

Oh, and you're fixing the corresponding regressions in fetch, which nobody 
seems to have mentioned previously.

Acked-by: Daniel Barkalow <barkalow@iabervon.org>

>  transport.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/transport.c b/transport.c
> index 3ff8519..b2f0d8a 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -645,7 +645,8 @@ static int fetch_refs_via_pack(struct transport *transport,
>  	args.lock_pack = 1;
>  	args.use_thin_pack = data->thin;
>  	args.include_tag = data->followtags;
> -	args.verbose = transport->verbose > 0;
> +	args.verbose = (transport->verbose > 0);
> +	args.quiet = (transport->verbose < 0);

And:
+	args.no_progress = !isatty(1);

>  	args.depth = data->depth;
>  
>  	for (i = 0; i < nr_heads; i++)
