From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Newbie] How to *actually* get rid of remote tracking branch?
Date: Tue, 13 Nov 2007 15:56:54 -0800
Message-ID: <7vr6itr96h.fsf@gitster.siamese.dyndns.org>
References: <874pfq9q8s.fsf@osv.gnss.ru> <fhcdpv$9u3$1@ger.gmane.org>
	<87ve86889o.fsf@osv.gnss.ru> <200711131703.16357.jnareb@gmail.com>
	<A919E788-C5D0-4404-95D4-869BAFE868AC@zib.de>
	<473A027E.5000107@op5.se> <473A262B.4010205@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steffen Prohaska <prohaska@zib.de>,
	Jakub Narebski <jnareb@gmail.com>,
	Sergei Organov <osv@javad.com>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed Nov 14 00:57:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is5dN-000058-4i
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 00:57:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758423AbXKMX5H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 18:57:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757912AbXKMX5G
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 18:57:06 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:38604 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756739AbXKMX5F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 18:57:05 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 064382FB;
	Tue, 13 Nov 2007 18:57:24 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 35E9B957AD;
	Tue, 13 Nov 2007 18:57:18 -0500 (EST)
In-Reply-To: <473A262B.4010205@op5.se> (Andreas Ericsson's message of "Tue, 13
	Nov 2007 23:33:15 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64916>

Andreas Ericsson <ae@op5.se> writes:

> I've got half a patch ready to change all occurrences of anything but
> "remote-tracking branch" to that self-same description. This is what
> I've got in Documentation/glossary.txt so far:
>
> [[def_remote_tracking_branch]]remote-tracking branch:
>    A "remote-tracking branch" is a branch set up to track the
>    state of a branch in a remote repository which the user has named.
> These branches follow exactly the same rules as the branches which
>    reside in the remote repository, except that they are manipulated
>    by `git fetch` instead of `git push`. That is, they can only be
>    updated if the update would result in a  <<def_fastforward,fast
> forward>>, or if the user supplies the  '--force' option.  They cannot
> be checked out or committed to by users, but serve
>    solely as local reference-pointers to their corresponding branches
>    in the remote repository.
>    The most common example of a remote-tracking branch is origin/master.

Please try to read it as if it were an entry in a glossary.
The sentence "... follow exactly the same rules as ..." was
"Huh?" to me.  "rules?  what rules?  the set of valid characters
in their names?"

When branch 'foo' from remote is tracked with the standard layout
(post 1.3.0) it is copied to refs/remotes/origin/foo and people
often fork their local branch refs/heads/foo to build on top.
The use of the word "corresonding" feels a bit confusing,
because you can arguably say refs/heads/foo at remote
corresopnds to refs/heads/foo in your repository.

I'd drop "These branches follow ... the '--force' option.  "
from the above.  The rules on how they are updated are
irrelevant, before the reader understands what they are for.
How about this?

    A "remote tracking branch" remembers which commit a branch
    in the remote repository was pointing at last time you
    checked.  It cannot be checked out or committed because its
    purpose is to serve as a local reference point after you
    built your own changes on top of it in your local branch
    forked from it.  The most common example of a remote
    tracking branch is "origin/master", which tracks the
    "master" branch of the "origin" remote.

BTW, when you have this data-flow (probably typical in a shared
repository workflow):

    Remote repository               Your repository

    refs/heads/foo -------(A)------> refs/remotes/origin/foo
         ^                                |
         |                               (B)
         |                                |
         |                                V
         `-------------(C)---------- refs/heads/foo

         (A) "git fetch" with remote.origin.fetch configuration
             set to +refs/heads/*:refs/remotes/origin/* keeps
             your refs/remotes/origin/foo up-to-date with their
             refs/heads/foo

         (B) "git merge origin/foo" while on "foo" branch (there
             are few shorthands like "git pull origin foo" while
             on "foo" branch.  If you say "git branch --track
             foo origin/foo", then running "git pull" without
             parameter while on "foo" branch).

         (C) "git push origin foo".

 * Everybody seems to agree that "refs/remotes/origin/foo" is
   called a "remote tracking branch";

 * Your refs/heads/foo follows and builds on top of 'foo' branch
   at the remote.  Some people errorneously call it "tracking"
   but that is because we do not have a good term for it;

 * There is no good name for "refs/heads/foo at the remote".  We
   always say "the remote branch you follow" (or "track"). 

   
