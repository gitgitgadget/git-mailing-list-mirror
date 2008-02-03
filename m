From: Jeff King <peff@peff.net>
Subject: Re: [RFH] revision limiting sometimes ignored
Date: Sun, 3 Feb 2008 02:13:18 -0500
Message-ID: <20080203071318.GA13849@coredump.intra.peff.net>
References: <20080202122135.GA5783@code-monkey.de> <20080203030054.GA18654@coredump.intra.peff.net> <20080203043310.GA5984@coredump.intra.peff.net> <7vr6fuzgq1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 03 08:14:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLZ3D-00061a-G0
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 08:14:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758180AbYBCHN1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 02:13:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbYBCHN1
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 02:13:27 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3083 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936002AbYBCHNV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 02:13:21 -0500
Received: (qmail 17673 invoked by uid 111); 3 Feb 2008 07:13:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 03 Feb 2008 02:13:19 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 03 Feb 2008 02:13:18 -0500
Content-Disposition: inline
In-Reply-To: <7vr6fuzgq1.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72332>

On Sat, Feb 02, 2008 at 10:39:18PM -0800, Junio C Hamano wrote:

> It is not so simple, it appears.  If I add for reproducibility
> "test_tick" like this:
> 
>         commit () {
>                 test_tick &&
>                 echo $1 >file &&
>                 git commit -a -m $1 &&
>                 git tag $1
>         }

Ah. I think what is happening is something like this:

  - when we add 'four' as uninteresting, we mark its parents as
    uninteresting in handle_commit
  - we don't recursively follow all of its parents because we haven't
    parsed them yet
  - when we get to limit_list, we call mark_parents_uninteresting again.
    But we have already marked four^ as uninteresting, and therefore we
    do not recurse in marking
  - we add the parents to the list, but they are not interesting, and
    therefore we quit

The reason it works with test_tick is that it changes the order we deal
with the commits in limit_list. We deal with 'one' _after_ dealing with
the uninteresting parents, so we never bail with
everybody_uninteresting.

> +test_expect_failure 'one is ancestor of others and should not be shown' '
> +
> +	git rev-list one --not four >result &&
> +	>expect &&
> +	diff -u expect result 
> +
> +'

Hooray, test_expect_failure is used properly. But you are still
missing a test_done. :)

-Peff
