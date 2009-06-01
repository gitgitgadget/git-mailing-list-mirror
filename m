From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/11] Fix warnings in nedmalloc when compiling with GCC 4.4.0
Date: Mon, 01 Jun 2009 00:43:33 -0700
Message-ID: <7vhbz0mmai.fsf@alter.siamese.dyndns.org>
References: <1243786525-4493-1-git-send-email-prohaska@zib.de>
	<1243786525-4493-2-git-send-email-prohaska@zib.de>
	<1243786525-4493-3-git-send-email-prohaska@zib.de>
	<1243786525-4493-4-git-send-email-prohaska@zib.de>
	<1243786525-4493-5-git-send-email-prohaska@zib.de>
	<1243786525-4493-6-git-send-email-prohaska@zib.de>
	<1243786525-4493-7-git-send-email-prohaska@zib.de>
	<1243786525-4493-8-git-send-email-prohaska@zib.de>
	<1243786525-4493-9-git-send-email-prohaska@zib.de>
	<1243786525-4493-10-git-send-email-prohaska@zib.de>
	<1243786525-4493-11-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j6t@kdbg.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Mon Jun 01 09:43:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MB2BK-0002xQ-2b
	for gcvg-git-2@gmane.org; Mon, 01 Jun 2009 09:43:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751953AbZFAHne (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2009 03:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751718AbZFAHnd
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jun 2009 03:43:33 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:36975 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751615AbZFAHnc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2009 03:43:32 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090601074333.OPUY25927.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Mon, 1 Jun 2009 03:43:33 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id yXjZ1b0094aMwMQ03Xjaxx; Mon, 01 Jun 2009 03:43:34 -0400
X-Authority-Analysis: v=1.0 c=1 a=pJQHuwW63eoA:10 a=O6WTdPAIJOYA:10
 a=ME9Ak6LYAnvvTAQxS0QA:9 a=Q6ouoQgpHHIF_kVqS_gA:7
 a=TXEsli7VPE2tRSaX4bqOdOywPb4A:4 a=JO-CUkcG2iAA:10
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120448>

Steffen Prohaska <prohaska@zib.de> writes:

> @@ -2541,7 +2543,7 @@ struct malloc_params {
>  static struct malloc_params mparams;
>  
>  /* Ensure mparams initialized */
> -#define ensure_initialization() (mparams.magic != 0 || init_mparams())
> +#define ensure_initialization() if (mparams.magic == 0) init_mparams()
>  
>  #if !ONLY_MSPACES

The code after the patch looks more fragile than the original.  I know
there currently is no code like:

	if (foo())
        	ensure_initialization();
	else
        	warn("oops");

but this change still feels wrong.

What issue is this patch trying to work around?  Returned value not being
used?

> diff --git a/compat/nedmalloc/nedmalloc.c b/compat/nedmalloc/nedmalloc.c
> index a381a7d..60a4093 100644
> --- a/compat/nedmalloc/nedmalloc.c
> +++ b/compat/nedmalloc/nedmalloc.c
> @@ -34,7 +34,7 @@ DEALINGS IN THE SOFTWARE.
>  /*#define FULLSANITYCHECKS*/
>  
>  #include "nedmalloc.h"
> -#if defined(WIN32) && !defined(__MINGW32__)
> +#if defined(WIN32)
>   #include <malloc.h>
>  #endif

Can somebody enlighten me what this hunk is about, and how it helps GCC
4.4?

There are many "#if[n]def __MINGW32__" remaining in the codebase both
inside and outside compat/ area, so it is not that that symbol is somehow
special.  I cannot even tell which one of the following is closer to the
reason behind this change:

 (1) "Because tacking '&& !defined(__MINGW32__)' after defined(WIN32) is
     unnecessary for such and such reasons, it is removed"; or

 (2) "Because tacking '&& !defined(__MINGW32__)' after defined(WIN32) is
     harmful for such and such reasons, it is removed".

Puzzled.
