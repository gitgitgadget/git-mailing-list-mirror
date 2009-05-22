From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-diff: must --exit-code work with --ignore* options?
Date: Fri, 22 May 2009 09:14:00 -0700
Message-ID: <7vvdnt869j.fsf@alter.siamese.dyndns.org>
References: <87k549dyne.fsf@meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Fri May 22 18:14:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7XNq-000847-BB
	for gcvg-git-2@gmane.org; Fri, 22 May 2009 18:14:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755052AbZEVQOB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2009 12:14:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753699AbZEVQOA
	(ORCPT <rfc822;git-outgoing>); Fri, 22 May 2009 12:14:00 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:50447 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751535AbZEVQN7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2009 12:13:59 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090522161400.YSIX18948.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Fri, 22 May 2009 12:14:00 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id ugE01b00J4aMwMQ03gE0NH; Fri, 22 May 2009 12:14:00 -0400
X-Authority-Analysis: v=1.0 c=1 a=tgU2TYdJe80A:10 a=Tph-e6BAsvEA:10
 a=O0v0mdFJAAAA:8 a=ddgFDvcoovtOYtg3hKQA:9 a=_h05pEILQk16JDvwSfy9GyF_yowA:4
 a=VvQ7Xpx9qTgA:10
X-CM-Score: 0.00
In-Reply-To: <87k549dyne.fsf@meyering.net> (Jim Meyering's message of "Fri\, 22 May 2009 16\:01\:57 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119739>

Jim Meyering <jim@meyering.net> writes:

> git-diff's --quiet option works how I'd expect with --ignore-space-at-eol
> as long as I'm also using --no-index:
>
>     $ echo>b; echo \ >c; git diff --no-index --quiet --ignore-space-at-eol b c \
>       && echo good
>     good
>
> But in what I think of as normal operation (i.e., without --no-index),
> --exit-code (or --quiet) makes git-diff say there were differences,
> even when they have been ignored:
>
>     # do this in an empty directory
>     $ git init -q; echo>k; git add .; git commit -q -m. .; echo \ >k
>     $ git diff --ignore-space-at-eol --quiet || echo bad
>     bad

I am slightly torn about this, in that I can picture myself saying that
this is unintuitive on some different days, but not today ;-)

If you look at the output (i.e. no --quiet), you would see that the blob
changes are still reported for the path.  E.g.  you would see something
like...

	$ git diff --ignore-space-at-eol
        diff --git a/k b/k
        index 8b13789..8d1c8b6 100644

The "index" line is still showing that there _is_ a difference.

The --ignore-* options are there merely to tell git what changes are not
worth _showing_ in the textual part of the patch, in order to cut down the
amount of the output.  It never affects the outcome.

So if anything, I think --no-index codepath is what's buggy; if it does
not report the blob difference that is a different matter, though.
