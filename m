From: Jeff King <peff@peff.net>
Subject: Re: [RFH] revision limiting sometimes ignored
Date: Sun, 3 Feb 2008 02:18:33 -0500
Message-ID: <20080203071833.GA16273@coredump.intra.peff.net>
References: <20080202122135.GA5783@code-monkey.de> <20080203030054.GA18654@coredump.intra.peff.net> <20080203043310.GA5984@coredump.intra.peff.net> <7vr6fuzgq1.fsf@gitster.siamese.dyndns.org> <20080203071318.GA13849@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 03 08:19:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLZ8c-0006zf-Rg
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 08:19:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936057AbYBCHSh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 02:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935875AbYBCHSg
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 02:18:36 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3861 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756747AbYBCHSf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 02:18:35 -0500
Received: (qmail 17702 invoked by uid 111); 3 Feb 2008 07:18:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 03 Feb 2008 02:18:34 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 03 Feb 2008 02:18:33 -0500
Content-Disposition: inline
In-Reply-To: <20080203071318.GA13849@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72333>

On Sun, Feb 03, 2008 at 02:13:18AM -0500, Jeff King wrote:

> Ah. I think what is happening is something like this:
> 
>   - when we add 'four' as uninteresting, we mark its parents as
>     uninteresting in handle_commit
>   - we don't recursively follow all of its parents because we haven't
>     parsed them yet
>   - when we get to limit_list, we call mark_parents_uninteresting again.
>     But we have already marked four^ as uninteresting, and therefore we
>     do not recurse in marking
>   - we add the parents to the list, but they are not interesting, and
>     therefore we quit

So the "fix" I posted before was to stop bailing on
everybody_uninteresting; clearly it is possible that although those
commits are uninteresting, we still have work to do on their ancestors.
There is probably a performance impact since we will end up traversing
the whole commit chain just to mark them all uninteresting.

We could also always recurse in make_parents_uninteresting; I think this
has the same performance problem, since we have to parse the parents for
each commit.

We could topologically order the commits going into limit_list (it just
works most of the time because the date ordering is _mostly_ right).
This guarantees that we deal with 'four' before 'one'. But topo sorting
is expensive.

-Peff
