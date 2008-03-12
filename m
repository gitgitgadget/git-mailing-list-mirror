From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-filter-branch.txt: Add picture to explain the
 graft-id
Date: Tue, 11 Mar 2008 19:51:08 -0700
Message-ID: <7vzlt48xk3.fsf@gitster.siamese.dyndns.org>
References: <7igcz2xx.fsf@blue.sea.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Wed Mar 12 03:52:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZH4S-0001Gx-I4
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 03:52:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751859AbYCLCvV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 22:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751853AbYCLCvV
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 22:51:21 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55109 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751385AbYCLCvV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 22:51:21 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4C6B23958;
	Tue, 11 Mar 2008 22:51:18 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 598443956; Tue, 11 Mar 2008 22:51:13 -0400 (EDT)
In-Reply-To: <7igcz2xx.fsf@blue.sea.net> (Jari Aalto's message of "Sun, 09
 Mar 2008 11:01:14 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76915>

Jari Aalto <jari.aalto@cante.net> writes:

> diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
> index 543a1cf..73939e2 100644
> --- a/Documentation/git-filter-branch.txt
> +++ b/Documentation/git-filter-branch.txt
> @@ -186,7 +186,7 @@ Now, you will get the rewritten history saved in HEAD.
>  
>  To set a commit (which typically is at the tip of another
>  history) to be the parent of the current initial commit, in
> -order to paste the other history behind the current history:
> +order to paste the other history behind the current history.
>  
>  -------------------------------------------------------------------
>  git filter-branch --parent-filter 'sed "s/^\$/-p <graft-id>/"' HEAD

Why?  I think ":" in the original is correct here, just like what you can
see in the pre-context in the next hunk.

> @@ -198,6 +198,12 @@ history with a single root (that is, no merge without common ancestors
>  happened).  If this is not the case, use:
>  
>  --------------------------------------------------------------------------
> +
> +    The plan: supposing we're merging A with B
> +    commit sequence A: a-b-c			graft-id  = b
> +    commit sequence B: c'-d'-e'			commit-id = c'
> +    Result	     : a-b-c'-d'-e'
> +
>  git filter-branch --parent-filter \
>  	'test $GIT_COMMIT = <commit-id> && echo "-p <graft-id>" || cat' HEAD
>  --------------------------------------------------------------------------

It is not "merging".  As seen in the first hunk you are "pasting" (or
grafting).

Also I think it would be easier to read without made-up words like
"xxx-id", if you are illustrating.

The example is unclear what HEAD is.  If you are clarifying the example,
it is better to state that we are filtering starting at the tip of the
second sequence.

Perhaps...

    Suppose we have these two unrelated histories:

	---A---B---C (tip of the branch "one")

	---D---E---F (tip of the branch "two")

    and the commits C and D have the same trees and are logically at the
    corresponding places in the global history.  You want to rewrite these
    histories by pasting them together at C/D, so that the result looks
    like this:

        ---A---B---D---E---F (rewritten branch "two")

    You can use --parent-filter to rewrite the parent of D to be B by
    telling it to say "the parent is B" when (and only when) filter-branch
    reaches D and processes it (for other commits, you just say "whatever
    parents the original commit had is just fine" by running "cat" to emit
    what you get from your standard input).  Hence, the command line to
    filter the history, starting at F, becomes:

	git filter-branch --parent-filter '
		if test $GIT_COMMIT = D
                then
                	echo "-p B
		else
                	cat
		fi
        ' two

    After filter-branch finishes, the branch "two" would have the desired
    history.
