From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "git reflog expire --all" very slow
Date: Wed, 01 Apr 2009 23:46:07 -0700
Message-ID: <7vmyazimds.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.2.00.0903301803190.4093@localhost.localdomain>
 <7vk5668g55.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.2.00.0903302154000.4093@localhost.localdomain>
 <alpine.LFD.2.00.0903302231370.4093@localhost.localdomain>
 <alpine.LFD.2.00.0903302244580.4093@localhost.localdomain>
 <alpine.LFD.2.00.0903302250500.4093@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Apr 02 08:47:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpGiL-0000Um-B2
	for gcvg-git-2@gmane.org; Thu, 02 Apr 2009 08:47:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752545AbZDBGqR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2009 02:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751553AbZDBGqR
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Apr 2009 02:46:17 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61439 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751885AbZDBGqQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2009 02:46:16 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 3EAF4B9F2;
	Thu,  2 Apr 2009 02:46:14 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 4C2DBB9ED; Thu, 
 2 Apr 2009 02:46:09 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.00.0903302250500.4093@localhost.localdomain>
 (Linus Torvalds's message of "Mon, 30 Mar 2009 22:51:34 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F5B02796-1F51-11DE-B87E-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115446>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> That made no sense. It should have been:
>
> On Mon, 30 Mar 2009, Linus Torvalds wrote:
>> 
>> but we care about the commits that are younger than 'expire_total' (older 
>> than that, and they are pruned unconditionally), but older than 
>> 'expire_unreachable' (younger than that and the date doesn't matter).
>                                                   ^^^^
>                                                  reachability
>
> but other than that the commentary stands.

Correct.  But after thinking about this a bit more, I am starting to suspect
the "of course" in your earlier

    If I do

            mark_reachable(cb.ref_commit, 0);

    instead (to traverse the _whole_ tree, with no regards to date), the time 
    shrinks to 1.7s. But of course, that's also wrong.

may not be such a clearly obvious thing.

Suppose you do not do "mark_reachable(cb.ref_commit, 0)" but use the
expire_total as the cut-off value (which is what I've queued).  If you
have one unreachable entry that you end up running in_merge_bases() for,
you will traverse all the history down _anyway_, and at that point, you
would be better off if you actually marked everything upfront, and
discarded anything unmarked as unreachable without falling back to
in_merge_bases() at all.

The above reasoning of course assumes that "keep reflog entries if they
are reachable from the tip, otherwise drop them if they are more than 30
days old" is a good medium level semantics to cull what the other rule
"drop any reflog entry older than 90 days" may not.

A hacky alternative would be to use total_expire as the cut-off and do not
fall back on in_merge_bases().  We might incorrectly prune away an entry
that records that you pulled a commit that is still reachable from the tip
last week, if that commit happens to be 4 months old if we did so, so I am
not convinced myself it is a reasonable hack, though.
