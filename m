From: Jeff King <peff@peff.net>
Subject: Re: Editing the root commit
Date: Wed, 20 Jun 2012 15:48:24 -0400
Message-ID: <20120620194824.GA32228@sigill.intra.peff.net>
References: <20120619091657.GA28005@arachsys.com>
 <7vy5nj1uld.fsf@alter.siamese.dyndns.org>
 <20120619111709.GC10692@arachsys.com>
 <20120620093205.GB10579@arachsys.com>
 <7vy5nhvo0z.fsf@alter.siamese.dyndns.org>
 <20120620192938.GC31520@sigill.intra.peff.net>
 <20120620193922.GB3192@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Chris Webb <chris@arachsys.com>
X-From: git-owner@vger.kernel.org Wed Jun 20 21:48:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShQtD-00043O-SI
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 21:48:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757928Ab2FTTs2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jun 2012 15:48:28 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:39172
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757901Ab2FTTs1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2012 15:48:27 -0400
Received: (qmail 28663 invoked by uid 107); 20 Jun 2012 19:48:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 20 Jun 2012 15:48:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Jun 2012 15:48:24 -0400
Content-Disposition: inline
In-Reply-To: <20120620193922.GB3192@arachsys.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200347>

On Wed, Jun 20, 2012 at 08:39:23PM +0100, Chris Webb wrote:

> Jeff King <peff@peff.net> writes:
> 
> > But if the first commit is deleted (or reordered), then it is not
> > appropriate to detach to the root; we must detach to the first picked
> > commit, which we can only do after we see the final instruction sheet.
> 
> It's worse than that isn't it? If you have
> 
>   A -- B -- C
> 
> and the sheet says drop A, pick B, pick C, you can't detach to B. You want
> the commit B as a root (i.e. with no parent), not the commit B with parent
> A. You need to have the patch from A to B replayed as the first commit on an
> empty branch (only without the branch).

Oh, you're right. I think you would have to do some custom magic to make
the first commit without looking at HEAD, like:

  1. Erase the index and working tree.

  2. Apply the patch from B^ to B (where B is the first picked commit).

  3. git-commit-tree manually with no parents.

  4. Point HEAD to the newly made commit.

But there is a very good chance of step (2) causing conflicts, at which
point you would have to give control back to the user. And what is in
HEAD at that point that would give them a meaningful answer to "git diff
--cached" or similar?

I think the only thing you can do is make a fake sentinel commit (with
an empty tree) to put in HEAD, and then remove the sentinel immediately
after the first commit is put in place (making sure not to include it in
the first commit's parent list). Yuck.

-Peff
