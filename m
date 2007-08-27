From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Keep last used delta base in the delta window
Date: Mon, 27 Aug 2007 12:07:58 +0200
Message-ID: <86veb1thmp.fsf@lola.quinscape.zz>
References: <11881617934179-git-send-email-mkoegler@auto.tuwien.ac.at>
	<7v3ay5l5wq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 27 12:08:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPbW4-0008Np-TO
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 12:08:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751391AbXH0KIO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 06:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbXH0KIO
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 06:08:14 -0400
Received: from main.gmane.org ([80.91.229.2]:41807 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751333AbXH0KIN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 06:08:13 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IPbVz-0001FL-Il
	for git@vger.kernel.org; Mon, 27 Aug 2007 12:08:11 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 27 Aug 2007 12:08:11 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 27 Aug 2007 12:08:11 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:Wi01MsxaC5zxZPAcT9yoXRQDzZE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56804>

Junio C Hamano <gitster@pobox.com> writes:

> Martin Koegler <mkoegler@auto.tuwien.ac.at> writes:
>
>> Keeping the last used delta base object, if it would be dropped,
>> supports creating smaller packs with shorter delta chains.
>
> Instead of treating the "the last used one happened to be on the
> horizon -- try not to drop it" special case, I wonder if it
> makes sense to float the last used delta base object early in
> the window _after_ it is used.  Wouldn't we keep more than one
> very recently used delta base objects in the window that way?

Well, given the little amount of spare time I have for personal
projects, I should not go flaunting them too much, but anyway...

I am just drafting implementing a delta-diff size estimator: for every
hash value it does not store hash chains or pointers to memory images,
but just a bit map of at most 32 (possibly 64 where ulong delivers it,
possibly even just 16 bits when one restricts oneself to 16 element
windows in order to save memory) delta window files, telling which of
the files show such a hash value anywhere.  When a file is considered
for deltaing, it is run once against this delta-diff estimator which
does not even look at the files again.  This delivers a lower bound
for the size a delta towards each of the delta candidates can take.
The candidates are then sorted in increasing size of expected delta
size and are considered in turn.  Once a delta has a lower size than
the lowest bound for further delta candidates, no further candidates
need to get considered.

Also the calculation of a delta can get aborted once it exceeds the
size of a previous delta.  Somewhat more complex and error-prone would
be to abort based on continually correcting the estimated lower bound
from the estimator while one is creating a delta and dropping out as
soon as it becomes impossible to beat a previous delta.

The nice thing about this is that one can start out with a simplistic
estimator as long as it is guaranteed never to deliver an estimate
that is too high.  As long as that is the case, the packs will never
get worse than they are now: a bad estimator will just mean that more
elements of the window need to be considered before the conclusion is
reached.

Since the estimator data structure does not point into any
memory-mapped files or hash chains scattered through memory, it should
be comparatively light (in comparison to an actual delta) on page
thrashing which appears to me one of the main performance problems,
while delivering a reasonably useful lower bound for all deltas in the
window at once.

Its size needs to be large enough so that the bit maps will be
dominated by zeros: hash collisions not actually corresponding to
matching data lead to underestimates.  If those become too many, the
pruning of comparisons will become ineffective:

A match implies that the next 2*RABIN_SIZE-1 (31) bytes at least could
possibly be expressed as a delta, and every match after another
RABIN_SIZE implies another RABIN_SIZE bytes might get folded into the
previous delta.

So false positives seriously distort the estimate.  There is still a
good chance that a good candidate will land early in the sort order
due to such an estimate and thus other candidates will have their
deltaing cut off early, but of course it is quite more effective if
their deltaing does not even have to start.

-- 
David Kastrup
