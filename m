From: Jeff King <peff@peff.net>
Subject: Re: Merging split files
Date: Tue, 29 Mar 2011 11:16:23 -0400
Message-ID: <20110329151623.GD10771@sigill.intra.peff.net>
References: <31155742.183989.1300374518689.JavaMail.root@mail.hq.genarts.com>
 <2495196.195017.1300454556155.JavaMail.root@mail.hq.genarts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Stephen Bash <bash@genarts.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 17:16:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4aeo-00038p-1c
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 17:16:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751651Ab1C2PQ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 11:16:29 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39031
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750991Ab1C2PQ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 11:16:28 -0400
Received: (qmail 29048 invoked by uid 107); 29 Mar 2011 15:17:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 29 Mar 2011 11:17:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Mar 2011 11:16:23 -0400
Content-Disposition: inline
In-Reply-To: <2495196.195017.1300454556155.JavaMail.root@mail.hq.genarts.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170275>

On Fri, Mar 18, 2011 at 09:22:36AM -0400, Stephen Bash wrote:

> In our previous release foo.cxx contained both the base class and a
> few subclasses.  Since then the number of subclasses has grown, and
> we've split foo.cxx (base and sub-classes) into foo-base.cxx (base
> class) and foo-defs.cxx (sub-classes).  Since the release, we've had a
> few bug fixes in foo.cxx on the maintenance branch, and need to merge
> those back to development.  When I did the merge Git identified
> foo.cxx as moved to foo-defs.cxx, which worked for most changes, but a
> few needed to be in foo-base.cxx.  In this case it was a pretty
> trivial manual resolution, but is there a method for handling merges
> of split files?

I don't think there is currently a good way to do this automatically.

The problem is that the closest merge-recursive gets to understanding
content movement is that it considers whole file renames. So it sees
"foo.cxx became foo-defs.cxx", and applies changes to foo.cxx to
foo-defs.cxx, but it has no clue that foo-base.cxx. So at the very
least, it would need to represent "foo.cxx has split into foo-base.cxx
and foo-defs.cxx", which is not something it can currently handle. But
more than that, you want to know _which_ parts moved to each file.

So I think the most flexible thing is to forget file renames at all.
They are just a rough version of the general idea of content movement.
In theory, we should be able to see that the content we changed in
foo.cxx no longer exists, and then start looking for similar content
elsewhere. Not similar _files_, but for the chunk of content that is
changed between the merge base and the maintenance (and some surrounding
context), find where that bit of content went. And then try to merge our
changes into that new bit of content.

One problem is that when it fails, it fails pretty hard. With file
renames, your changes at least usually ends up in the right file (your
present problem excluded), and you get some textual mess to clean up.
But with content-level renaming, I suspect in conflict cases we would
end up with no clue where the result goes (because the conflict means we
can't easily match up the content for similarity), and have to stick it
in the deleted file. On the other hand, it might simply work to keep
expanding the amount of context we consider for content similarity until
we find a match, which eventually would end up considering the whole
file, and generalize to a file rename.

Implementing that inside of merge-recursive is likely to be pretty nasty
(even the current file-rename code is already pretty nasty). But it may
be possible to prototype something that runs after we hit the conflicted
state, like mergetool.

I definitely think it's an interesting area to work in, but I would have
to give it a lot of thought.

-Peff
