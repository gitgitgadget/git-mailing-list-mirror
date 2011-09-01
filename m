From: Jeff King <peff@peff.net>
Subject: Re: Cannot rewrite branch(es) with a dirty working directory
Date: Thu, 1 Sep 2011 17:53:07 -0400
Message-ID: <20110901215306.GD16308@sigill.intra.peff.net>
References: <CACyv8dfL-G0Px0aFe3VFNHP-1xRUDLsFxgUu3amPGzO7qKp7jQ@mail.gmail.com>
 <vpqmxeoqj61.fsf@bauges.imag.fr>
 <20110901215003.GC16308@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	James Blackburn <jamesblackburn@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Sep 01 23:53:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzFCF-0006st-NH
	for gcvg-git-2@lo.gmane.org; Thu, 01 Sep 2011 23:53:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758090Ab1IAVxK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Sep 2011 17:53:10 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:35289
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758088Ab1IAVxJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Sep 2011 17:53:09 -0400
Received: (qmail 24775 invoked by uid 107); 1 Sep 2011 21:53:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 01 Sep 2011 17:53:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Sep 2011 17:53:07 -0400
Content-Disposition: inline
In-Reply-To: <20110901215003.GC16308@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180575>

On Thu, Sep 01, 2011 at 05:50:03PM -0400, Jeff King wrote:

> > No idea. It comes after a "git reset --hard", so it's supposed to be
> > clean.
> 
> I wonder if there are racily clean entries[1] in the index, and
> diff-index reports them as potential changes.
> 
> At any rate, filter-branch should probably be refreshing the index
> before checking for dirtiness, which would give the correct answer
> either way.

Actually, we've already factored this logic out, so let's use it.

-- >8 --
Subject: filter-branch: use require_clean_work_tree

Filter-branch already requires that we have a clean work
tree before starting. However, it failed to refresh the
index before checking, which means it could be wrong in the
case of stat-dirtiness.

Instead of simply adding a call to refresh the index, let's
switch to using the require_clean_work_tree function
provided by git-sh-setup. It does exactly what we want, and
with fewer lines of code and more specific output messages.

Signed-off-by: Jeff King <peff@peff.net>
---
 git-filter-branch.sh |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 804a7f4..add2c02 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -108,9 +108,7 @@ OPTIONS_SPEC=
 . git-sh-setup
 
 if [ "$(is_bare_repository)" = false ]; then
-	git diff-files --ignore-submodules --quiet &&
-	git diff-index --cached --quiet HEAD -- ||
-	die "Cannot rewrite branch(es) with a dirty working directory."
+	require_clean_work_tree 'rewrite branches'
 fi
 
 tempdir=.git-rewrite
-- 
1.7.6.10.g62f04
