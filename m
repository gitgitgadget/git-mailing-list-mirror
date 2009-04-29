From: Jeff King <peff@peff.net>
Subject: Re: Project Setup Problem
Date: Tue, 28 Apr 2009 23:21:01 -0400
Message-ID: <20090429032101.GA8826@coredump.intra.peff.net>
References: <loom.20090429T001456-24@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jason Brice <jason@sbh.co.nz>
X-From: git-owner@vger.kernel.org Wed Apr 29 05:21:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lz0MG-00070z-GV
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 05:21:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753698AbZD2DVH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2009 23:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753317AbZD2DVG
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 23:21:06 -0400
Received: from peff.net ([208.65.91.99]:47691 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753181AbZD2DVF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2009 23:21:05 -0400
Received: (qmail 2466 invoked by uid 107); 29 Apr 2009 03:21:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 28 Apr 2009 23:21:16 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Apr 2009 23:21:01 -0400
Content-Disposition: inline
In-Reply-To: <loom.20090429T001456-24@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117842>

On Wed, Apr 29, 2009 at 12:22:56AM +0000, Jason Brice wrote:

> I am very new to git and I am trying to create my first project. After running:
> "git init", I ran "git add ." but I get the following error message:
> fatal: pathspec '' did not match any files

Probably because you don't have any files, thus there was nothing to
match. You can't add or commit in git until there is something to add or
commit.

If you do have files and you got that message, then that is a problem
(and let us know).

All that being said, the error message is not especially helpful. In
particular, showing '' when the user asked for '.' can look like a bug
(when in fact it is an artifact of how git translates the pathspecs
internally).

The point of that message is to warn the user of typos or other
mistakes (see f259339). But pointing to an existing but empty directory
probably shouldn't generate a warning. And in fact, neither "mkdir foo
&& cd foo && git add ." nor "mkdir foo && git add foo" generates a
warning. It is really just that the empty pathspec for the root doesn't
work (because it fools our lstat() call).

I suspect, but didn't carefully investigate, that this is actually a
regression introduced by my ancient e96980e (builtin-add: simplify (and
increase accuracy of) exclude handling, 2007-06-12) which reorganized
that section of code a bit. I did a quick check, which contains f259339
but not e96980e, and it treats "git add ." in an empty project root as a
no-op.

Junio, I think we should apply the patch below. It is a bugfix, but
obviously this is not a critical bug (the impact is small, and it has
been around for 2 years already), and given that we are so late in the
release cycle, it is probably fine to wait for post-1.6.3.

-- >8 --
Subject: [PATCH] add: don't complain when adding empty project root

We try to warn the user if one of their pathspecs caused no
matches, as it may have been a typo. However, we disable the
warning if the pathspec points to an existing file, since
that means it is not a typo but simply an empty directory.

Unfortunately, the file_exists() test was broken for one
special case: the pathspec of the project root is just "".
This patch detects this special case and acts as if the file
exists (which it must, since it is the project root).

The user-visible effect is that this:

  $ mkdir repo && cd repo && git init && git add .

used to complain like:

  fatal: pathspec '' did not match any files

but now is a silent no-op.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin-add.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index 314380e..bee45f0 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -63,7 +63,7 @@ static void prune_directory(struct dir_struct *dir, const char **pathspec, int p
 	fill_pathspec_matches(pathspec, seen, specs);
 
 	for (i = 0; i < specs; i++) {
-		if (!seen[i] && !file_exists(pathspec[i]))
+		if (!seen[i] && pathspec[i][0] && !file_exists(pathspec[i]))
 			die("pathspec '%s' did not match any files",
 					pathspec[i]);
 	}
-- 
1.6.3.rc3.188.g92147.dirty
