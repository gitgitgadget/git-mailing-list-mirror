From: Jeff King <peff@peff.net>
Subject: Re: git log --merges doesn't show commits as expected
Date: Fri, 13 Nov 2015 17:35:23 -0500
Message-ID: <20151113223523.GB14830@sigill.intra.peff.net>
References: <AMSPR02MB168531F809E1625FACEB25283110@AMSPR02MB168.eurprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Dominik Rauch <dominik.rauch@gmx.at>
X-From: git-owner@vger.kernel.org Fri Nov 13 23:35:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZxMwM-0002nR-D5
	for gcvg-git-2@plane.gmane.org; Fri, 13 Nov 2015 23:35:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752191AbbKMWf0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2015 17:35:26 -0500
Received: from cloud.peff.net ([50.56.180.127]:57291 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750873AbbKMWfZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2015 17:35:25 -0500
Received: (qmail 13567 invoked by uid 102); 13 Nov 2015 22:35:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 Nov 2015 16:35:25 -0600
Received: (qmail 29210 invoked by uid 107); 13 Nov 2015 22:35:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 Nov 2015 17:35:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Nov 2015 17:35:23 -0500
Content-Disposition: inline
In-Reply-To: <AMSPR02MB168531F809E1625FACEB25283110@AMSPR02MB168.eurprd02.prod.outlook.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281267>

On Fri, Nov 13, 2015 at 04:21:36PM +0000, Dominik Rauch wrote:

> (This is my first post to this mailing list and I couldn't find a FAQ
> section - please excuse me, if I haven't followed all the established
> posting guidelines yet.)

This is the right place. Welcome. :)

> I have the following repository tree:
> 
> C
> |\
> | B
> | /
> A
> 
> Commit A: Parents=(). Initial commit. Contains file foo with content "ABC".
> Commit B: Parents=(A). Represents a commit on some feature branch. Contains file foo with content "XYZ".
> Commit C: Parents=(A, B). Represents a merge commit of a feature branch back to the main branch. Contains file foo with content "XYZ".
> 
> I expected "git log --merges foo" to show C, however, the log is
> empty! Specifying "--full-history" results in the correct history,
> therefore I assume, I misunderstand Git's default history
> simplification algorithm. Unfortunately, the example in the Git docs
> at [1] does not contain the very same situation (although it is
> probably one of the most common situations...).

I don't think "--merges" is relevant to the simplification here. By
asking for "foo", that turns on history simplification. Since the merge
at C took one side directly, that means we can cull the parent link that
leads to A (its foo=ABC did not contribute to the final outcome). And
then C is TREESAME to its only remaining parent (they both have
foo=XYZ), so it can be removed, leaving only commit B to be passed to
the next stage.

And then we apply "--merges", and see that B is not a merge, and so
do not show it (but we still traverse it, of course).

In theory we could apply "--merges" first (by simplifying history to
shrink any chains of non-merges to a single point). But I don't think
there's any way to do that currently with git.

-Peff
