From: Jeff King <peff@peff.net>
Subject: Re: How to stop sharing objects between repositories
Date: Mon, 17 Aug 2009 02:19:17 -0400
Message-ID: <20090817061916.GA27530@coredump.intra.peff.net>
References: <alpine.DEB.2.00.0908151756150.29215@nhtr.ovalna.fjrygre.arg>
 <alpine.DEB.1.00.0908161042210.8306@pacific.mpi-cbg.de>
 <20090816122842.GA942@sigill.intra.peff.net>
 <alpine.DEB.1.00.0908161429590.8306@pacific.mpi-cbg.de>
 <20090816135703.GA31638@coredump.intra.peff.net>
 <7vmy5z603d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jon Jensen <jon@endpoint.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 08:19:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McvYz-0004OD-MA
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 08:19:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756820AbZHQGTR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 02:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756816AbZHQGTR
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 02:19:17 -0400
Received: from peff.net ([208.65.91.99]:53177 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756815AbZHQGTR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 02:19:17 -0400
Received: (qmail 28668 invoked by uid 107); 17 Aug 2009 06:19:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 17 Aug 2009 02:19:21 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 17 Aug 2009 02:19:17 -0400
Content-Disposition: inline
In-Reply-To: <7vmy5z603d.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126125>

On Sun, Aug 16, 2009 at 12:16:22PM -0700, Junio C Hamano wrote:

> After reading this, two points come to my mind.  They may or may not be
> issues.
> 
>  (1) Such a user does not necessarily know a casual "git repack -a" breaks
>      the dependency, defeating the -s option s/he deliberately used in
>      order to save disk space in the first place.  Perhaps we can reword
>      this further to kill two penguins with a single stone?
> 
> 	Note that the pack resulting from running `git repack -a` in the
> 	repository cloned with the `-s` option will include objects that
> 	are borrowed from the source repository.  It essentially breaks
> 	the dependency created by cloning with the `-s` option by copying
> 	the objects from the source repository.  To keep borrowing from
> 	the source repository to save disk space, do not use `repack -a`.

Good point, but I don't think this wording is quite right. You can also
cause such an inefficiency by simply running "git repack", if the source
has loose objects. In other words:

  1. "git repack -a" is sufficient to break dependency, as it copies
     both packed and loose objects

  2. "git repack" _may_ break the dependency, if there are no packs, as
     it copies only loose objects. It _may_ introduce inefficiency, but
     only if there are loose objects.

  3. "git repack -l" always keeps the dependency and current efficiency.

     As an aside, making this list makes me realize there is no easy
     "keep the dependency and increase efficiency". In other words, pack
     everything that is not available otherwise, and then prune the
     remaining packs.

Modified patch is below.

>      We should suggest an alternative immediately after this sentence,
>      e.g. "Instead, use `repack -l`" or something, but somebody should
>      check if it is a valid/viable alternative.

It does work. From a user's perspective, I think "-l" would probably be
a more sane default. But I think it is off for historical reasons, and
these days we try to steer users towards "git gc", anyway, which does
use "-l" by default.

-- >8 --
Subject: [PATCH] docs: describe impact of repack on "clone -s"

The effects of repacking on a repository with alternates are
a bit subtle. The two main things users will want are:

  1. Not to waste disk space by accidentally copying objects
     which could be shared.

  2. Copying all objects explicitly to break the dependency
     on the source repo.

This patch describes both under the "clone -s"
documentation. It makes sense to put it there rather than in
git-repack.txt for both cases. For (1), we are warning the
user who is using "clone -s" about what _not_ to do, so we
need to get their attention when reading about "clone -s".
For (2), we are telling them how git-repack can be used to
accomplish a task, but until they know that git-repack is
the right tool, they have no reason to look at the repack
documentation.

Signed-off-by: Jeff King <peff@peff.net>
---

The extra deleted lines in the patch below are just cleaning up some
excess whitespace.

 Documentation/git-clone.txt |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index b14de6c..b25944f 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -72,8 +72,16 @@ These objects may be removed by normal git operations (such as 'git-commit')
 which automatically call `git gc --auto`. (See linkgit:git-gc[1].)
 If these objects are removed and were referenced by the cloned repository,
 then the cloned repository will become corrupt.
-
-
++
+Note that running `git repack` without the `-l` option in a repository
+cloned with `-s` will copy objects from the source repository into a
+pack in the cloned repository, removing the disk space savings of `clone
+-s`. It is safe, however, to run `git gc`, which uses the `-l` option by
+default.
++
+If you want to break the dependency of a repository cloned with `-s` on
+its source repository, you can simply run `git repack -a` to copy all
+objects from the source repository into a pack in the cloned repository.
 
 --reference <repository>::
 	If the reference repository is on the local machine
-- 
1.6.4.283.gec993
