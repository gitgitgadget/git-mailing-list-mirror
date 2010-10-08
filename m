From: Jeff King <peff@peff.net>
Subject: Re: Efficiently detecting paths that differ from each other only
 in case
Date: Fri, 8 Oct 2010 16:06:57 -0400
Message-ID: <20101008200657.GA10954@sigill.intra.peff.net>
References: <AANLkTimGAbosbD0pprROu_g-UW38faotYA2dTxj9scsP@mail.gmail.com>
 <20101008135034.GC5163@sigill.intra.peff.net>
 <AANLkTik6pSJFUkY9sooSH7iANaKLhxdN+ouKRXJn1B9G@mail.gmail.com>
 <20101008195120.GA10810@sigill.intra.peff.net>
 <AANLkTimAhjHm5Z4ekTOBaxwzyw2YD6MrRnB1O8E6nAtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Dun Peal <dunpealer@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 08 22:07:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4JDi-0006pE-9e
	for gcvg-git-2@lo.gmane.org; Fri, 08 Oct 2010 22:07:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932918Ab0JHUGy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Oct 2010 16:06:54 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:41291 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932453Ab0JHUGx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Oct 2010 16:06:53 -0400
Received: (qmail 30454 invoked by uid 111); 8 Oct 2010 20:06:53 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 08 Oct 2010 20:06:53 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Oct 2010 16:06:57 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTimAhjHm5Z4ekTOBaxwzyw2YD6MrRnB1O8E6nAtw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158533>

On Fri, Oct 08, 2010 at 02:57:49PM -0500, Dun Peal wrote:

> On Fri, Oct 8, 2010 at 2:51 PM, Jeff King <peff@peff.net> wrote:
> > One thing to consider, though, is if this is a hook running on the
> > server, you probably don't want to look at the index. You probably want
> > to look for duplicates in one tree entry (fed to the hook). So you would
> > be using git ls-tree, which probably is a bit slower.
> 
> Thanks, but why is that?  Why can't I use ls-files, and must use use
> ls-tree, which you say would be slower?

For two reasons:

  1. Bare repos generally don't _have_ an index, as it is about
     maintaining the state of the working tree.

  2. Even if you did have an index, it would presumably represent the
     contents of HEAD. But if you are feeding a commit to a hook, then
     that hook will get some sha1 of the to-be-pushed commit. So you
     need to look at the paths that are in that hook.

Re-reading your original message, I have a few more thoughts.

One is that you don't need to do this per-commit. You probably want to
do it per-updated-ref, each of which may be pushing many commits. And
then you either reject the new ref value or not.

Also, you could try not looking at the whole tree by doing something
like:

  git diff-tree --diff-filter=A --name-only $old $new

and then only considering duplicates for newly introduced files. But
that means for each introduced file, you need to enumerate the tree to
find case-sensitive matches. You can avoid looking at the whole tree
only be manually expanding each level (e.g., you see that foo/bar is
new. So you look at the root tree, looking for "foo" or case-insensitive
equivalents. For each one you find, you look further down for "bar" or a
case-insensitive equivalent). But that means many git ls-tree calls. So
I don't think it buys you anything in practice.

-Peff
