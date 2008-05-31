From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/git-filter-branch.txt: Fix description of
 --commit-filter
Date: Sat, 31 May 2008 15:33:15 -0700
Message-ID: <7vskvydrys.fsf@gitster.siamese.dyndns.org>
References: <1212183820-40712-1-git-send-email-kevin@sb.org>
 <7vlk1rh0av.fsf@gitster.siamese.dyndns.org>
 <98EEBDF4-9964-4CA6-ABBD-DB72C4F6CAD3@sb.org>
 <7v63svgy0q.fsf@gitster.siamese.dyndns.org>
 <AF9CB160-FFC9-4372-BE86-5FAC6B59A050@sb.org>
 <7v1w3jgs51.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Petr Baudis <pasky@suse.cz>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Sun Jun 01 00:34:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2Zee-0001t2-5I
	for gcvg-git-2@gmane.org; Sun, 01 Jun 2008 00:34:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754411AbYEaWd3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 May 2008 18:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754443AbYEaWd2
	(ORCPT <rfc822;git-outgoing>); Sat, 31 May 2008 18:33:28 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35459 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754311AbYEaWd1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 May 2008 18:33:27 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 064933927;
	Sat, 31 May 2008 18:33:24 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id F13A03926; Sat, 31 May 2008 18:33:17 -0400 (EDT)
In-Reply-To: <7v1w3jgs51.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 30 May 2008 18:48:58 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9476DA28-2F61-11DD-BBBF-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83410>

Junio C Hamano <gitster@pobox.com> writes:

> Kevin Ballard <kevin@sb.org> writes:
>
>> You're still talking about the parent-filter here. I think you're
>> quite confused.
>
> Blush.  I should go to bed.

Now after following the codepath, your original

    diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
    index 506c37a..541bf23 100644
    --- a/Documentation/git-filter-branch.txt
    +++ b/Documentation/git-filter-branch.txt
    @@ -113,8 +113,8 @@ OPTIONS
            stdin.  The commit id is expected on stdout.
     +
     As a special extension, the commit filter may emit multiple
    -commit ids; in that case, ancestors of the original commit will
    -have all of them as parents.
    +commit ids; in that case, the rewritten children of the original commit will
    +have all of them as parents. You probably don't want to do this.
     +
     You can use the 'map' convenience function in this filter, and other
     convenience functions, too.  For example, calling 'skip_commit "$@"'

does make sense to me.  Except for "You probably don't want to do this."
part.  It is just "the utility of this feature is unknown to us" ;-)

I dug the code with "git blame" and the basic logic has been the same
since its introduction to git with 6f6826c (Add git-filter-branch,
2007-06-03).  The commit-filter itself appeared first in Cogito as d690516
(cg-admin-rewritehist --commit-filter for omitting commits, 2006-03-26),
and the commit log message claims that it was primarily meant to _omit_
unwanted commits from the history, but at the same time it advertises the
multiple commits case as a "feature" without telling why somebody wants to
do so.

Except for this gem, which may have been lost in our copy:

    # ... Note that this handles merges properly! In case Darl
    # committed a merge between P1 and P2, it will be propagated properly
    # and all children of the merge will become merge commits with P1,P2
    # as their parents instead of the merge commit.

IOW, to rewrite this history:

        ---A---C---D---E
              /
             B 

to pretend C never happened, you would give A' and B' back when you
rewrite C, to end up with this history:

        ---A'--D'--E'
              /
             B' 

I'd agree with "You probably don't want to do this", but perhaps it needs
a bit of clarification as to _why_ you would not:

 - If the history is being rewritten for the whole tree, this will
   make D' an evil merge that contains difference between C to D.

 - If the filtering of the history is done to ignore parts of the tree
   that is touched between C and D (iow, history simplification would
   leave trees C and D the same), you would want to simplify away D' not
   C'.  IOW, you would want the resulting history to look like:

        ---A'--C'--E'
              /
             B' 

   and for that you do not need to use this "feature".
