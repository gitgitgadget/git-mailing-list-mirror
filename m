From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/11] Fix warnings in nedmalloc when compiling with GCC 4.4.0
Date: Tue, 02 Jun 2009 08:50:56 -0700
Message-ID: <7viqjefxcv.fsf@alter.siamese.dyndns.org>
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
	<7vhbz0mmai.fsf@alter.siamese.dyndns.org>
	<alpine.DEB.1.00.0906011054410.26154@pacific.mpi-cbg.de>
	<7vr5y3lxrj.fsf@alter.siamese.dyndns.org>
	<alpine.DEB.1.00.0906021448300.4440@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jun 02 17:51:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBWGc-0002NU-J5
	for gcvg-git-2@gmane.org; Tue, 02 Jun 2009 17:51:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754940AbZFBPu5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2009 11:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753864AbZFBPu4
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jun 2009 11:50:56 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:47769 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753224AbZFBPuz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2009 11:50:55 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090602155055.ICPP17670.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Tue, 2 Jun 2009 11:50:55 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id z3qw1b00E4aMwMQ043qwUx; Tue, 02 Jun 2009 11:50:56 -0400
X-Authority-Analysis: v=1.0 c=1 a=pJQHuwW63eoA:10 a=O6WTdPAIJOYA:10
 a=bxSzPNJltzt9sQU1jfYA:9 a=G73Hrd-R1NQumLY2OmsA:7
 a=5t67n3nuygHyAP4FDkVt2Z3V5AAA:4 a=_RhRFcbxBZMA:10
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120524>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Okay, how about this in the commit body in addition?
>
> -- snip --
> Nedmalloc's source code has a cute #define construct to avoid inserting
> an if() statement, because that might interact badly with enclosing if()
> statements.  However, there is no danger of that now, but GCC > 4
> complains "warning: value computed is not used".
>
> Also, with the version of MinGW's headers in msysGit, we need to include 
> malloc.h lest the compiler complain about an "incompatible implicit 
> declaration of built-in function 'alloca'".
> -- snap --
>
> Hmm?

As to the first one, I think your problem description is clear (the
problem is clear without being explained to begin with) but "there is no
danger of that now" is somewhere between a lame excuse for not doing it
the right way and a bug waiting to happen.  If "value computed is not
used" is the issue, why doesn't this work?

    #define ensure_initialization() (void)(mparams.magic != 0 || init_mparams())

or at least wrap your fragile "if" in a bog-standard do {} while(0), like...

    #define ensure_initialization() \
    	do { if (mparams.magic == 0) init_mparams(); } while (0)

Then you do not have to make excuses, and instead can just say

	Squelch GCC > 4's "value computed not used" warnings from
	ensure_initialization() macro definition.

As to the second one, I think you lost "even if we happen to" part (that
logically corresponds to "... that is why we do not want to limit the
inclusion to !__MINGW32__ case") from the description, making it less
readable...
