From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] grep Added --blame so that grep can show result
 tagged with blame entries
Date: Tue, 10 Mar 2009 02:46:54 -0700
Message-ID: <7v7i2xaewh.fsf@gitster.siamese.dyndns.org>
References: <49B51791.4030801@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: pi song <pi.songs@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 10 10:48:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgyZk-0001Qw-8h
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 10:48:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753999AbZCJJrB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2009 05:47:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752996AbZCJJrB
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 05:47:01 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34302 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752798AbZCJJrB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2009 05:47:01 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 1CDEF4AE2;
	Tue, 10 Mar 2009 05:46:59 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 5709D4AE1; Tue,
 10 Mar 2009 05:46:56 -0400 (EDT)
In-Reply-To: <49B51791.4030801@gmail.com> (pi song's message of "Tue, 10 Mar
 2009 00:20:17 +1100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 663A8602-0D58-11DE-8492-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112797>

pi song <pi.songs@gmail.com> writes:

> This part:-
> 1) Move reusable bits from builtin-blame.c into blame.c, blame.h
> 2) Replace static variables with context struct
>
> Signed-off-by: Pi Song <pi.songs@gmail.com>
> ---
> Makefile        |    2 +
> blame.c         | 1919 +++++++++++++++++++++++++++++++++++++++++++++++++++
> blame.h         |  222 ++++++
> builtin-blame.c | 2072
> +++----------------------------------------------------
> 4 files changed, 2245 insertions(+), 1970 deletions(-)
> create mode 100644 blame.c
> create mode 100644 blame.h

This is simply too big to ask anybody sane to review (besides as we can
clearly see in the above the patch is severely whitespace damaged to be
usable nor mechanically reviewable). 

I suspect that most of the file-scope static variables can be moved to the
scoreboard, and when the reusable parts are made public, some structure
and function names may need to become a bit more blame specific to avoid
namespace contamination.

Perhaps the first two patches in an equivalent series that is rerolled to
be reviewable would look like:

 (1) move file-scope static variables to the scoreboard, and necessary
     code changes associated with it;

     renaming of some structures and functions (if needed---I didn't
     check);

 (2) create blame.c and blame.h, and move lines from builtin-blame.c *and*
     do NOTHING OTHER THAN

     - adding #include "blame.h" to builtin-blame.c,

     - adding necessary #include at the top of blame.c,

     - surrounding blame.h with necessary

         #ifndef BLAME_H
         #define BLAME_H
	 ...
         #endif

       and finally         

     - updating Makefile to add blame.c and blame.h

     This step will make a HUGE patch, and it is crucial for reviewability
     for it not to do anything other than line movement.  Ideally, the
     patch shouldn't even reorder the structures and function definitions
     during this step.

     Then we can use "git blame" itself to make sure that no other changes
     were sneaked in by mistake.  "git blame -C blame.h" and "git blame -C
     blame.c" would show everything came from builtin-blame.c.

At this point, there shouldn't still be any behaviour change nor new
feature.  And the titles of these preparatory step will never say anything
about "grep".  They are only refactoring "blame".

Once this becomes solid, you can start adding features to blame.c to
support your new caller, and we can be reasonably sure that such patches
can be reviewed to decide if its change breaks the existing (and so far
the only) caller builtin_blame() or not.
