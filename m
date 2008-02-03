From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFH] revision limiting sometimes ignored
Date: Sat, 02 Feb 2008 23:40:40 -0800
Message-ID: <7vbq6yzdvr.fsf@gitster.siamese.dyndns.org>
References: <20080202122135.GA5783@code-monkey.de>
	<20080203030054.GA18654@coredump.intra.peff.net>
	<20080203043310.GA5984@coredump.intra.peff.net>
	<7vr6fuzgq1.fsf@gitster.siamese.dyndns.org>
	<20080203071318.GA13849@coredump.intra.peff.net>
	<20080203071833.GA16273@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 03 08:41:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLZTf-0001dx-3m
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 08:41:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758932AbYBCHku (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 02:40:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758880AbYBCHku
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 02:40:50 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64492 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758576AbYBCHku (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 02:40:50 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 4AD604B6C;
	Sun,  3 Feb 2008 02:40:47 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 44731470F;
	Sun,  3 Feb 2008 02:40:42 -0500 (EST)
In-Reply-To: <20080203071833.GA16273@coredump.intra.peff.net> (Jeff King's
	message of "Sun, 3 Feb 2008 02:18:33 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72335>

Jeff King <peff@peff.net> writes:

> We could topologically order the commits going into limit_list (it just
> works most of the time because the date ordering is _mostly_ right).
> This guarantees that we deal with 'four' before 'one'. But topo sorting
> is expensive.

I recall we did a rather clever optimization in merge-base.  I
am starting to suspect that we would need a similar trick there.

The issue is:

 * We have pushed "one" out already to "newlist", but we haven't
   given UNINTERESTING bit to it yet.

 * We are responsible to mark "one" UNINTERESTING, if it can be
   reached from a commit that is UNINTERESTING.  We expect
   further looping of the "while (list)" and
   mark_parents_uninteresting() in that loop will eventually
   smudge it.

 * We can obviously prove that we marked all UNINTERESTING
   commits that matters by traversing _all_ history (i.e. make
   sure mark_parents_uninteresting() recurses, and wait until
   "list" truly becomes empty), but we would want to somehow
   optimize it.  The everybody_uninteresting() check was
   introduced for that purpose, but that is not a right
   optimization if commit timestamps are skewed like this.

The right optimization is probably:

 * Wait until everybody on "list" is UNINTERESTING.  IOW, keep
   the "everybody_uninteresting()" check with break as is.

   At that point "newlist" will contain all the commits that we
   might be interested in (e.g. "one").  The issue is reduced
   from "mark _all_ commits that can be reached from known
   UNINTERESTING ones" to "make sure the commits on the newlist
   that are reachable from UNINTERESTING ones in the "list" are
   marked as UNINTERESTING (e.g. "one" should be checked for
   reachability from the remaining UNINTERESTING commits in
   "list", we do not have to check for anything else).

 * After the loop exits, traverse from all non UNINTERESTING
   commits on the "newlist" and all remaining commits on the
   "list" (by definition, the latter are UNINTERESTING) down to
   their common merge base, propagating UNINTERESTING bit down.

   Once we do that, we have proven that "one" is reachable from
   any of the UNINTERESTING commit.
