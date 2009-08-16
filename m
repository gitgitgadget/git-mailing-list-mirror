From: Jeff King <peff@peff.net>
Subject: Re: How to stop sharing objects between repositories
Date: Sun, 16 Aug 2009 09:57:03 -0400
Message-ID: <20090816135703.GA31638@coredump.intra.peff.net>
References: <alpine.DEB.2.00.0908151756150.29215@nhtr.ovalna.fjrygre.arg>
 <alpine.DEB.1.00.0908161042210.8306@pacific.mpi-cbg.de>
 <20090816122842.GA942@sigill.intra.peff.net>
 <alpine.DEB.1.00.0908161429590.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Jon Jensen <jon@endpoint.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Aug 16 15:57:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McgEi-00056t-T7
	for gcvg-git-2@gmane.org; Sun, 16 Aug 2009 15:57:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752628AbZHPN5E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Aug 2009 09:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751737AbZHPN5D
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Aug 2009 09:57:03 -0400
Received: from peff.net ([208.65.91.99]:35985 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752187AbZHPN5C (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Aug 2009 09:57:02 -0400
Received: (qmail 24986 invoked by uid 107); 16 Aug 2009 13:57:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 16 Aug 2009 09:57:06 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 16 Aug 2009 09:57:03 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0908161429590.8306@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126060>

On Sun, Aug 16, 2009 at 02:30:15PM +0200, Johannes Schindelin wrote:

> > I think it is the opposite; packing _without_ "-l" will create a pack
> > with objects from the alternate; using "-l" suppresses them. Running
> > "git repack -a" should do the trick, I believe (and you need the "-a" to
> > ensure that objects already packed in the repo are re-packed).
> 
> Hmm.  I really would like a documentation patch, then.

To what? From git-repack(1):

  -l
     Pass the --local option to git-pack-objects. See git-pack-objects(1).

>From git-pack-objects(1):

  --local
      This flag is similar to --incremental; instead of ignoring all
      packed objects, it only ignores objects that are packed and/or not
      in the local object store (i.e. borrowed from an alternate).

So I think the documentation is correct, but for the original poster, it
suffers from two problems:

  1. The impact of "-l" in this case is a bit subtle and confusing.
     I.e., it is not an obvious "use this flag to break the dependency
     on an alternate", but rather "don't use this flag so that you won't
     ignore non-local objects when packing". In fact, you don't need to
     know about it at all

  2. He has to know that "git repack" is the right place to look in the
     first place (_and_ he has to figure out that "-l" is what he cares
     about and follow the docs to git-pack-objects to find out what it
     does).

So I think the best thing is a "by the way, here is how you break this
dependency" closer to where the concept of alternates is defined. I
guess the best part would be under the "-s" flag of git-clone, since
that is presumably how such a situation was created (unless the user is
savvy enough to edit .git/objects/info/alternates themselves, in which
case I think we have to assume they know what they are doing).

So maybe something like this would be enough:

-- >8 --
Subject: [PATCH] docs: mention how to break alternates dependency

A user who has created a repository dependency by using "git
clone -s" does not necessarily know where to look to find
out how to break that dependency. Let's mention it right
under "-s", where they are most likely to find it.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-clone.txt |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index b14de6c..87fa687 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -72,6 +72,11 @@ These objects may be removed by normal git operations (such as 'git-commit')
 which automatically call `git gc --auto`. (See linkgit:git-gc[1].)
 If these objects are removed and were referenced by the cloned repository,
 then the cloned repository will become corrupt.
++
+To break the dependency of the cloned repository to the source
+repository, run `git repack -a` in the cloned repository, which will
+create a new pack in that repository with all referenced objects,
+including those in the source repository.
 
 
 
-- 
1.6.4.257.gb8ef
