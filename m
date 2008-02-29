From: Paul Mackerras <paulus@samba.org>
Subject: Re: Suggestion: make --left-right work with --merge
Date: Fri, 29 Feb 2008 21:52:39 +1100
Message-ID: <18375.58359.687664.855599@cargo.ozlabs.ibm.com>
References: <18372.53155.854763.12637@cargo.ozlabs.ibm.com>
	<7v7igqyii9.fsf@gitster.siamese.dyndns.org>
	<18373.58839.636432.448970@cargo.ozlabs.ibm.com>
	<7v1w6yqaim.fsf@gitster.siamese.dyndns.org>
	<18374.39253.408961.634788@cargo.ozlabs.ibm.com>
	<7vprugdxpj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 29 11:53:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JV2rm-0000sE-0L
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 11:53:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755590AbYB2Kwt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 05:52:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755574AbYB2Kwt
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 05:52:49 -0500
Received: from ozlabs.org ([203.10.76.45]:56237 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755391AbYB2Kws (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Feb 2008 05:52:48 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 24509DDE07; Fri, 29 Feb 2008 21:52:47 +1100 (EST)
In-Reply-To: <7vprugdxpj.fsf@gitster.siamese.dyndns.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75521>

Junio C Hamano writes:

> Doesn't
> 
> 	git rev-parse --revs-only --no-flags "$@" | grep '^[0-9a-f]'
> 
> give you what you want?

Well, it does, except for --merge, which is perhaps a special case.

(Actually, what would git rev-parse --revs-only --no-flags output that
isn't a SHA1 ID?  Why do you have the grep command there?)

Also, --left-right with symmetric difference is an interesting case,
because git rev-parse will turn a symmetric difference into three SHA1
IDs, with the 3rd one negated.  If I pass what I get from git
rev-parse to git log --left-right, then git log doesn't recognize that
as a symmetric difference and shows all commits with the ">" marker.

> Interesting.
> 
>  * gitk has already done what the user asked once.  E.g. "git
>    log next..master" to find out new trivially correct fixes
>    that are already applied to 'master' and will be brought to
>    'next' when I merge 'master' to 'next' next time;
> 
>  * The user does "git merge master" while on 'next', and tell
>    gitk to "Update".
> 
>  * gitk is expected to re-run "git log next..master" (textually
>    the same command line), but most part of the graph it already
>    knows about.  You need a way to omit what you already know,
>    so when you run the query for the first time you would want
>    to remember the actual object names, so that you use them to
>    tweak the query to "git log next..master --not <positive ones
>    in the first round>" for the second query.
> 
> In the above example, the set of commits actually will shrink
> ('next' moves and you will exclude more than before upon
> "Update").

"Update" adds new commits and moves the head/tag markers as necessary,
but doesn't remove commits from the graph, because that's a bit hard.
There is also a "Reload" function that restarts from scratch and so
will not show the newly-removed commits (i.e., the same as "Update"
does now in current gitk master), but it is a lot slower than
"Update".  In the common case (a few commits added), "Update" takes
less than a second.

> If you are only interested in cases that the only positive end
> grows (in the above example, the user adds commit to 'master'
> instead of merging it into 'next'), then grabbing only the
> positive ends (e.g. 'master' in 'next..master'), negate them and
> append them to the original query would speed things up, but
> obviously that would not work in the above example.

That's essentially what I do.  I think I'll just have to do special
cases for --merge and --left-right.

Paul.
