From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 10/11] Fix warnings in nedmalloc when compiling with GCC
 4.4.0
Date: Mon, 1 Jun 2009 10:57:49 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0906011054410.26154@pacific.mpi-cbg.de>
References: <1243786525-4493-1-git-send-email-prohaska@zib.de> <1243786525-4493-2-git-send-email-prohaska@zib.de> <1243786525-4493-3-git-send-email-prohaska@zib.de> <1243786525-4493-4-git-send-email-prohaska@zib.de> <1243786525-4493-5-git-send-email-prohaska@zib.de>
 <1243786525-4493-6-git-send-email-prohaska@zib.de> <1243786525-4493-7-git-send-email-prohaska@zib.de> <1243786525-4493-8-git-send-email-prohaska@zib.de> <1243786525-4493-9-git-send-email-prohaska@zib.de> <1243786525-4493-10-git-send-email-prohaska@zib.de>
 <1243786525-4493-11-git-send-email-prohaska@zib.de> <7vhbz0mmai.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 01 10:57:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MB3Kg-0004AR-FK
	for gcvg-git-2@gmane.org; Mon, 01 Jun 2009 10:57:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754061AbZFAI5H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2009 04:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753588AbZFAI5G
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jun 2009 04:57:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:36382 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751540AbZFAI5F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2009 04:57:05 -0400
Received: (qmail invoked by alias); 01 Jun 2009 08:57:06 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp028) with SMTP; 01 Jun 2009 10:57:06 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18SX6tDqYISXx/tt3iGxUulizPdX0wmN0B99ka5kM
	nj35aTCpSQMGzE
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vhbz0mmai.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.46
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120451>

Hi,

On Mon, 1 Jun 2009, Junio C Hamano wrote:

> Steffen Prohaska <prohaska@zib.de> writes:
> 
> > @@ -2541,7 +2543,7 @@ struct malloc_params {
> >  static struct malloc_params mparams;
> >  
> >  /* Ensure mparams initialized */
> > -#define ensure_initialization() (mparams.magic != 0 || init_mparams())
> > +#define ensure_initialization() if (mparams.magic == 0) init_mparams()
> >  
> >  #if !ONLY_MSPACES
> 
> The code after the patch looks more fragile than the original.  I know
> there currently is no code like:
> 
> 	if (foo())
>         	ensure_initialization();
> 	else
>         	warn("oops");
> 
> but this change still feels wrong.

I know, but the whole use of ensure_initialization() feels wrong to me, 
and I did _not_ want to change the code too much, lest we end up 
maintaining a proper fork as has happened with libxdiff.

> What issue is this patch trying to work around?  Returned value not 
> being used?

I forgot what the GCC warning looked like, and have only text-mode access 
to the web right now, so I cannot access any Windows machine and try 
again.

It was a warning, though, that much I remember.

> > diff --git a/compat/nedmalloc/nedmalloc.c b/compat/nedmalloc/nedmalloc.c
> > index a381a7d..60a4093 100644
> > --- a/compat/nedmalloc/nedmalloc.c
> > +++ b/compat/nedmalloc/nedmalloc.c
> > @@ -34,7 +34,7 @@ DEALINGS IN THE SOFTWARE.
> >  /*#define FULLSANITYCHECKS*/
> >  
> >  #include "nedmalloc.h"
> > -#if defined(WIN32) && !defined(__MINGW32__)
> > +#if defined(WIN32)
> >   #include <malloc.h>
> >  #endif
> 
> Can somebody enlighten me what this hunk is about, and how it helps GCC
> 4.4?

It helps in that malloc.h is included even if we happen to compile the 
stuff as a MinGW program.  Otherwise necessary function declarations are 
missing.

> There are many "#if[n]def __MINGW32__" remaining in the codebase both
> inside and outside compat/ area, so it is not that that symbol is somehow
> special.  I cannot even tell which one of the following is closer to the
> reason behind this change:
> 
>  (1) "Because tacking '&& !defined(__MINGW32__)' after defined(WIN32) is
>      unnecessary for such and such reasons, it is removed"; or
> 
>  (2) "Because tacking '&& !defined(__MINGW32__)' after defined(WIN32) is
>      harmful for such and such reasons, it is removed".

The latter.

> Puzzled.

Hopefully less so, now.

Ciao,
Dscho
