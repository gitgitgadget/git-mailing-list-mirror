From: Paul Mackerras <paulus@samba.org>
Subject: Re: Suggestion: make --left-right work with --merge
Date: Sat, 1 Mar 2008 18:39:16 +1100
Message-ID: <18377.2084.30531.202087@cargo.ozlabs.ibm.com>
References: <18372.53155.854763.12637@cargo.ozlabs.ibm.com>
	<7v7igqyii9.fsf@gitster.siamese.dyndns.org>
	<18373.58839.636432.448970@cargo.ozlabs.ibm.com>
	<7v1w6yqaim.fsf@gitster.siamese.dyndns.org>
	<18374.39253.408961.634788@cargo.ozlabs.ibm.com>
	<7vprugdxpj.fsf@gitster.siamese.dyndns.org>
	<18375.58359.687664.855599@cargo.ozlabs.ibm.com>
	<7vfxvbd0nu.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 01 08:40:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVMKb-0004zQ-Um
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 08:40:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754192AbYCAHjx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 02:39:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753933AbYCAHjx
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 02:39:53 -0500
Received: from ozlabs.org ([203.10.76.45]:37151 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753840AbYCAHjw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 02:39:52 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 234F5DDE20; Sat,  1 Mar 2008 18:39:51 +1100 (EST)
In-Reply-To: <7vfxvbd0nu.fsf@gitster.siamese.dyndns.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75633>

Junio C Hamano writes:

> Try it on user inputs like "master..next", "next...master".  You
> wanted to grab only the positive ones, no?

No... gitk passes the IDs it gets from git rev-parse (both positive
and negative) to git log, rather than the original arguments.  This is
to avoid gitk having an incorrect idea about what commits git log has
started from, in the situation where somebody changes some head or tag
between when gitk does the git rev-parse and when it does the git log.

That unfortunately means --left-right doesn't work however, because
git log doesn't recognize "a b ^merge_base(a,b)" as being equivalent
to "a...b".

> And in order to handle them sanely without worrying about
> revision machinery and rev-parse going out-of-sync, I would
> almost suggest doing something like the attached patch and say:
> 
> 	$ git rev-list --no-walk "$@"
> 
> The user options can contain --left-right and --boundary, so the
> output from this could begin with ">", "<" and "-".  If you
> discard the ones that are prefixed with "-" (i.e. the user had
> the --boundary option in "$@"), grab the ones that are not
> prefixed (i.e. the user did not have the --left-right option in
> "$@"), and the ones prefixed with ">" and "<" (i.e. the user did
> have --left-right, and you would strip the prefix from such a
> line), you would find all positive ones the user specified, I
> think.

Yes, that would be useful.  Now, if I can just think of a way to avoid
the race, or work around it, the problem will be solved. :)  I can
probably do that by checking whether I see all the (positive) commits
from git rev-list --no-walk in the git log output.

Thanks,
Paul.
