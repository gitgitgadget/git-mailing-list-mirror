From: Sebastian Leske <Sebastian.Leske@sleske.name>
Subject: [PATCH v3 1/4] git-svn: Document branches with at-sign(@).
Date: Fri, 30 Nov 2012 08:16:30 +0100
Message-ID: <ae56cb0c64972d2caa35743485f251f9d1652a61.1354693001.git.Sebastian.Leske@sleske.name>
References: <cover.1354693001.git.Sebastian.Leske@sleske.name>
Cc: Eric Wong <normalperson@yhbt.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 05 13:51:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TgERO-0000Fg-HG
	for gcvg-git-2@plane.gmane.org; Wed, 05 Dec 2012 13:51:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753143Ab2LEMuv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2012 07:50:51 -0500
Received: from serv28.loswebos.de ([213.187.93.221]:42919 "EHLO
	serv28.loswebos.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752641Ab2LEMuu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2012 07:50:50 -0500
Received: from iota.localnet (unknown [46.115.102.110])
	(using SSLv3 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by serv28.loswebos.de (Postfix) with ESMTPSA id 8059D1F5459D;
	Wed,  5 Dec 2012 13:50:14 +0100 (CET)
Received: from sleske by iota.localnet with local (Exim 4.69)
	(envelope-from <sebastian.leske@sleske.name>)
	id 1Tg9Yo-0001A9-S4; Wed, 05 Dec 2012 08:38:26 +0100
In-Reply-To: <cover.1354693001.git.Sebastian.Leske@sleske.name>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211118>

git svn sometimes creates branches with an at-sign in the name
(branchname@revision). These branches confuse many users and it is a FAQ
why they are created. Document when git svn creates them.

Signed-off-by: Sebastian Leske <sebastian.leske@sleske.name>
---
 Documentation/git-svn.txt |   47 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 8b0d3ad..55bed53 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -830,6 +830,53 @@ inside git back upstream to SVN users.  Therefore it is advised that
 users keep history as linear as possible inside git to ease
 compatibility with SVN (see the CAVEATS section below).
 
+HANDLING OF SVN BRANCHES
+------------------------
+If 'git svn' is configured to fetch branches (and --follow-branches
+is in effect), it will sometimes create multiple git branches for one
+SVN branch, where the addtional branches have names of the form
+'branchname@nnn' (with nnn an SVN revision number).  These additional
+branches are created if 'git svn' cannot find a parent commit for the
+first commit in an SVN branch, to connect the branch to the history of
+the other branches.
+
+Normally, the first commit in an SVN branch consists
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
+
+Additionally, it will create a special branch named
+'<branchname>@<SVN-Revision>', where <SVN-Revision> is the SVN revision
+number the branch was copied from.  This branch will point to the newly
+created parent commit of the branch.  If in SVN the branch was deleted
+and later recreated from a different version, there will be multiple
+such branches with an '@'.
+
+Note that this may mean that multiple git commits are created for a
+single SVN revision.
+
+An example: In an SVN repository with a standard
+trunk/tags/branches layout, a directory trunk/sub is created in r.100.
+In r.200, trunk/sub is branched by copying it to branches/. 'git svn
+clone -s' will then create a branch 'sub'. It will also create new git
+commits for r.100 through r.199 and use these as the history of branch
+'sub'. Thus there will be two git commits for each revision from r.100
+to r.199 (one containing trunk/, one containing trunk/sub/). Finally,
+it will create a branch 'sub@200' pointing to the new parent commit of
+branch 'sub' (i.e. the commit for r.200 and trunk/sub/).
+
 CAVEATS
 -------
 
-- 
1.7.10.4
