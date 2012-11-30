From: Sebastian Leske <Sebastian.Leske@sleske.name>
Subject: [PATCH v2 1/4] git-svn: Document branches with at-sign(@).
Date: Fri, 30 Nov 2012 08:16:30 +0100
Message-ID: <67e9db6f948315f3c733dda0ad970e6257c075af.1354324110.git.Sebastian.Leske@sleske.name>
References: <cover.1354324110.git.Sebastian.Leske@sleske.name>
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 01 12:00:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Teko4-0008E1-Ju
	for gcvg-git-2@plane.gmane.org; Sat, 01 Dec 2012 12:00:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416Ab2LALAH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Dec 2012 06:00:07 -0500
Received: from serv28.loswebos.de ([213.187.93.221]:54851 "EHLO
	serv28.loswebos.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709Ab2LALAG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Dec 2012 06:00:06 -0500
Received: from iota.localnet (p4FD44AFD.dip.t-dialin.net [79.212.74.253])
	(using SSLv3 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by serv28.loswebos.de (Postfix) with ESMTPSA id EA6191F54A34;
	Sat,  1 Dec 2012 11:59:32 +0100 (CET)
Received: from sleske by iota.localnet with local (Exim 4.69)
	(envelope-from <sebastian.leske@sleske.name>)
	id 1Tekn9-00040D-3Z; Sat, 01 Dec 2012 11:59:27 +0100
In-Reply-To: <cover.1354324110.git.Sebastian.Leske@sleske.name>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210959>

git svn will sometimes create branches with an at-sign in the name
(branchname@revision). These branches confuse many users and it is a FAQ
why they are created. Document when git svn will create them.

Signed-off-by: Sebastian Leske <sebastian.leske@sleske.name>
---
 Documentation/git-svn.txt |   38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 8b0d3ad..824bf82 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -881,6 +881,44 @@ different name spaces.  For example:
 	branches = stable/*:refs/remotes/svn/stable/*
 	branches = debug/*:refs/remotes/svn/debug/*
 
+If 'git svn' is configured to fetch branches (and --follow-branches
+is in effect), it will sometimes create multiple branches for one SVN
+branch, where the addtional branches have names of the form
+'branchname@nnn' (with nnn an SVN revision number).  These additional
+branches are created if 'git svn' cannot find a parent commit for the
+first commit in an SVN branch, to connect the branch to the history of
+the other branches. Normally, the first commit in an SVN branch consists
+of a copy operation. 'git svn' will read this commit to get the SVN
+revision the branch was created (copied) from. It will then try to find the
+git commit that corresponds to this SVN revision, and use that as the
+parent of the branch. However, it is possible that there is no suitable
+git commit to serve as parent.  This will happen, among other reasons,
+if the SVN branch is a copy of a revision that was not fetched by 'git
+svn' (e.g. because it is an old revision that was skipped with
+'--revision'), or if in SVN a directory was copied that is not tracked
+by 'git svn' (such as a branch that is not tracked at all, or a
+subdirectory of a tracked branch). In these cases, 'git svn' will still
+create a git branch, but instead of using an existing git commit as the
+parent of the branch, it will read the SVN history of the directory the
+branch was copied from and create appropriate git commits (this is
+indicated by the message "Initializing parent: <branchname>").
+Additionally, it will create a special branch named
+'<branchname>@<SVN-Revision>', where <SVN-Revision> is the SVN revision
+number the branch was copied from.  This branch will point to the newly 
+created parent commit of the branch.  If in SVN the branch was deleted
+and later recreated from a different version, there will be multiple
+such branches with an '@'.
+Note that this may mean that multiple git commits are created for a
+single SVN revision. An example: In an SVN repository with a standard 
+trunk/tags/branches layout, a directory trunk/sub is created in r.100.
+In r.200, trunk/sub is branched by copying it to branches/. 'git svn
+clone -s' will then create a branch 'sub'. It will also create new git
+commits for r.100 through r.199 and use these as the history of branch
+'sub'. Thus there will be two git commits for each revision from r.100
+to r.199 (one containing trunk/, one containing trunk/sub/). Finally,
+it will create a branch 'sub@200' pointing to the new parent commit of
+branch 'sub' (i.e. the commit for r.200 and trunk/sub/).
+
 BUGS
 ----
 
-- 
1.7.10.4
