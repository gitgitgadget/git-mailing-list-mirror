From: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
Subject: [PATCH] Improve description of git filter-branch.
Date: Sat, 15 Mar 2008 11:39:00 +0100
Organization: Department of Numerical Simulation, University of Bonn
Message-ID: <20080315103900.GC14769@ins.uni-bonn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 15 11:39:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaTnu-0007l7-Cb
	for gcvg-git-2@gmane.org; Sat, 15 Mar 2008 11:39:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751592AbYCOKjQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Mar 2008 06:39:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751595AbYCOKjQ
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Mar 2008 06:39:16 -0400
Received: from merkur.ins.uni-bonn.de ([131.220.223.13]:52823 "EHLO
	merkur.ins.uni-bonn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751590AbYCOKjH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Mar 2008 06:39:07 -0400
Received: from localhost.localdomain (xdsl-87-78-111-54.netcologne.de [87.78.111.54])
	by merkur.ins.uni-bonn.de (Postfix) with ESMTP id CEC4640002E14
	for <git@vger.kernel.org>; Sat, 15 Mar 2008 11:39:04 +0100 (CET)
Received: from ralf by localhost.localdomain with local (Exim 4.63)
	(envelope-from <Ralf.Wildenhues@gmx.de>)
	id 1JaTn2-0004Og-Tt
	for git@vger.kernel.org; Sat, 15 Mar 2008 11:39:00 +0100
Mail-Followup-To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77318>

Signed-off-by: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
---

Now that I learned about filter-branch, here's my share of nits with its
documentation, a couple of language nits and inaccuracies.

One problem was that I originally understood the manual in the way that
only --env-filter may be used to modify GIT_AUTHOR_NAME etc., and thus
I failed to see how with the fixed order I could change that with data
taken from the tree.  

Also, I think it is quite helpful to state that all filters operate in
the shell environment of the script (this may be an issue for a later
conversion to a builtin).

Cheers,
Ralf

 Documentation/git-filter-branch.txt |   25 +++++++++++++------------
 1 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index 543a1cf..3f7df04 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -20,12 +20,12 @@ DESCRIPTION
 Lets you rewrite git revision history by rewriting the branches mentioned
 in the <rev-list options>, applying custom filters on each revision.
 Those filters can modify each tree (e.g. removing a file or running
-a perl rewrite on all files) or information about each commit.
+a perl script on all files) or information about each commit.
 Otherwise, all information (including original commit times or merge
 information) will be preserved.
 
 The command will only rewrite the _positive_ refs mentioned in the
-command line (i.e. if you pass 'a..b', only 'b' will be rewritten).
+command line (i.e. if you pass 'a..b', 'a' will not be rewritten).
 If you specify no filters, the commits will be recommitted without any
 changes, which would normally have no effect.  Nevertheless, this may be
 useful in the future for compensating for some git bugs or such,
@@ -42,7 +42,7 @@ Always verify that the rewritten version is correct: The original refs,
 if different from the rewritten ones, will be stored in the namespace
 'refs/original/'.
 
-Note that since this operation is extensively I/O expensive, it might
+Note that since this operation is extremely I/O expensive, it might
 be a good idea to redirect the temporary directory off-disk with the
 '-d' option, e.g. on tmpfs.  Reportedly the speedup is very noticeable.
 
@@ -51,14 +51,15 @@ Filters
 ~~~~~~~
 
 The filters are applied in the order as listed below.  The <command>
-argument is always evaluated in shell using the 'eval' command (with the
-notable exception of the commit filter, for technical reasons).
+argument is always evaluated in the shell context using the 'eval' command
+(with the notable exception of the commit filter, for technical reasons).
 Prior to that, the $GIT_COMMIT environment variable will be set to contain
 the id of the commit being rewritten.  Also, GIT_AUTHOR_NAME,
 GIT_AUTHOR_EMAIL, GIT_AUTHOR_DATE, GIT_COMMITTER_NAME, GIT_COMMITTER_EMAIL,
-and GIT_COMMITTER_DATE are set according to the current commit. If any
-evaluation of <command> returns a non-zero exit status, the whole operation
-will be aborted.
+and GIT_COMMITTER_DATE are set according to the current commit.  The values
+of these variables after the filters have run, are used for the new commit.
+If any evaluation of <command> returns a non-zero exit status, the whole
+operation will be aborted.
 
 A 'map' function is available that takes an "original sha1 id" argument
 and outputs a "rewritten sha1 id" if the commit has been already
@@ -71,9 +72,9 @@ OPTIONS
 -------
 
 --env-filter <command>::
-	This is the filter for modifying the environment in which
-	the commit will be performed.  Specifically, you might want
-	to rewrite the author/committer name/email/time environment
+	This filter may be used if you only need to modify the environment
+	in which the commit will be performed.  Specifically, you might
+	want to rewrite the author/committer name/email/time environment
 	variables (see linkgit:git-commit[1] for details).  Do not forget
 	to re-export the variables.
 
@@ -149,7 +150,7 @@ definition impossible to preserve signatures at any rate.)
 -d <directory>::
 	Use this option to set the path to the temporary directory used for
 	rewriting.  When applying a tree filter, the command needs to
-	temporary checkout the tree to some directory, which may consume
+	temporarily checkout the tree to some directory, which may consume
 	considerable space in case of large projects.  By default it
 	does this in the '.git-rewrite/' directory but you can override
 	that choice by this parameter.
-- 
1.5.4.4.603.g1f9f
