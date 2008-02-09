From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Minor annoyance with git push
Date: Sat, 9 Feb 2008 13:04:10 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802091302550.11591@racer.site>
References: <46a038f90802072044u3329fd33w575c689cba2917ee@mail.gmail.com> <alpine.LSU.1.00.0802081142060.11591@racer.site> <46a038f90802081427k6ee94cfagbc02533538e75b49@mail.gmail.com> <20080209024636.GE2572@coredump.intra.peff.net>
 <20080209025431.GF2572@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 09 14:04:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNpO3-0008OK-Aj
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 14:04:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754480AbYBINEJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 08:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754444AbYBINEI
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 08:04:08 -0500
Received: from mail.gmx.net ([213.165.64.20]:54054 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754390AbYBINEH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 08:04:07 -0500
Received: (qmail invoked by alias); 09 Feb 2008 13:04:05 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp006) with SMTP; 09 Feb 2008 14:04:05 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/7dRcoKFP7zbeemXbeXMIPZ6bsN7H5r9+Te6cKch
	Sk3eW2REKl5d3P
X-X-Sender: gene099@racer.site
In-Reply-To: <20080209025431.GF2572@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73216>

Hi,

On Fri, 8 Feb 2008, Jeff King wrote:

> On Fri, Feb 08, 2008 at 09:46:36PM -0500, Jeff King wrote:
> 
> > > The local side has the remote refs if the client has fetched recently,
> > > so it might be able to tell in some cases. Not with authority (things
> > > may have changed on the server side...) but the client might be able
> > > to say something less alarming.
> > 
> > This is actually not that hard to do in the case that we can. Patch will
> > follow in a second, though I am not sure it is a good idea (because it
> > silently ignores pushing rewinds).
> 
> And here it is. Again, I don't think this is the right default behavior.
> I'm not even sure it is a good idea as configurable behavior. But it's
> here for comment and for playing with, nonetheless.

I was already trying to make a patch on top of yours which says "[stale]" 
instead of "[rejected]" for those cases, but then I realised that 2 tests 
in t5400 fail.

> @@ -463,8 +467,12 @@ static int do_send_pack(int in, int out, struct remote *remote, const char *dest
>  		    (!has_sha1_file(ref->old_sha1)
>  		      || !ref_newer(new_sha1, ref->old_sha1));
>  
> +
>  		if (ref->nonfastforward && !ref->force && !args.force_update) {
> -			ref->status = REF_STATUS_REJECT_NONFASTFORWARD;
> +			if (ref_newer(ref->old_sha1, new_sha1))
> +				ref->status = REF_STATUS_REJECT_REWIND;
> +			else
> +				ref->status = REF_STATUS_REJECT_NONFASTFORWARD;

Indeed.  I did not think it was that easy, but apparently it is.

Thanks,
Dscho
