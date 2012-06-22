From: Chris Webb <chris@arachsys.com>
Subject: Re: Editing the root commit
Date: Fri, 22 Jun 2012 21:50:27 +0100
Message-ID: <20120622205026.GI32205@arachsys.com>
References: <20120619091657.GA28005@arachsys.com>
 <7vy5nj1uld.fsf@alter.siamese.dyndns.org>
 <20120619111709.GC10692@arachsys.com>
 <20120620093205.GB10579@arachsys.com>
 <7vy5nhvo0z.fsf@alter.siamese.dyndns.org>
 <20120620192938.GC31520@sigill.intra.peff.net>
 <20120620193922.GB3192@arachsys.com>
 <20120620194824.GA32228@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 22 22:50:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SiAof-0002do-5r
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jun 2012 22:50:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755692Ab2FVUug (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jun 2012 16:50:36 -0400
Received: from alpha.arachsys.com ([91.203.57.7]:56046 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754538Ab2FVUuf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2012 16:50:35 -0400
Received: from [81.2.114.212] (helo=arachsys.com)
	by alpha.arachsys.com with esmtpa (Exim 4.72)
	(envelope-from <chris@arachsys.com>)
	id 1SiAoJ-00043r-VY; Fri, 22 Jun 2012 21:50:32 +0100
Content-Disposition: inline
In-Reply-To: <20120620194824.GA32228@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200469>

Jeff King <peff@peff.net> writes:

> I think the only thing you can do is make a fake sentinel commit (with
> an empty tree) to put in HEAD, and then remove the sentinel immediately
> after the first commit is put in place (making sure not to include it in
> the first commit's parent list). Yuck.

If I do this:

diff --git a/path.c b/path.c
index 6f2aa69..1b3b6f3 100644
--- a/path.c
+++ b/path.c
@@ -169,8 +169,9 @@ int validate_headref(const char *path)
 	int fd;
 	ssize_t len;
 
+	/* Allow HEAD to be entirely missing for detached orphan state */
 	if (lstat(path, &st) < 0)
-		return -1;
+		return errno == ENOENT ? 0 : -1;
 
 	/* Make sure it is a "refs/.." symlink */
 	if (S_ISLNK(st.st_mode)) {


to thwart the sanity check, I can do 'rm $GIT_DIR/HEAD' to put my HEAD into a
state where it is both detached and unborn, i.e. so that my next commit will
result in a detached HEAD pointing at a root commit.

Surprisingly, this check appears to be the only thing disallowing such a state,
and the result behaves as sanely as a normal git-checkout --orphan <branch>
does! Using a detached unborn HEAD like this would avoid any need for sentinel
commits or the like in generalising rebase: we'd just do

  git rm -rf .
  rm -f $GIT_DIR/index $GIT_DIR/HEAD

instead of git checkout $onto, and be away replaying the commits or executing
the instruction sheet as normal.

If I prepared a proper patch series with docs and tests, would allowing this be
acceptable? I don't want to work on it if there's an intentional design
decision to explicitly disallow it. However, apart from just rebase and
rebase--interactive, I suspect other scripts which operate on history will be
more easily generalised to work on history right up to the root commit if such
a state were allowed.

PS Whilst experimenting, I also noticed a (presumably unintentional) behaviour:

  $ git init .
  Initialized empty Git repository in /tmp/foo/.git/
  $ git checkout --detach
  $ touch bar
  $ git add bar
  $ git commit -m test
  [(null) (root-commit) 17b5bf9] test
   0 files changed
   create mode 100644 bar
  $ ls .git/refs/heads/
  (null)
  $

Here we've created a branch with the strange name '(null)' instead of actually
detaching, or refusing to detach because we're on an unborn branch.

Assuming this is a bug, I'll cook up a patch to fix it either way, either by
entering a detached unborn state if we're allowing that, or to refuse to detach
if we're not allowing that state.

Best wishes,

Chris.
