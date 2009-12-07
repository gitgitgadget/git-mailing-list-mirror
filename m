From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: core.worktree bug
Date: Mon, 7 Dec 2009 11:15:47 +0100
Message-ID: <200912071115.48085.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 07 11:16:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHadJ-0004Kb-Ss
	for gcvg-git-2@lo.gmane.org; Mon, 07 Dec 2009 11:15:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934988AbZLGKPq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2009 05:15:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934964AbZLGKPq
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Dec 2009 05:15:46 -0500
Received: from mail.dewire.com ([83.140.172.130]:23278 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934916AbZLGKPp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2009 05:15:45 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id A9556146FF6E
	for <git@vger.kernel.org>; Mon,  7 Dec 2009 11:15:50 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ewKGm1tbcD3f for <git@vger.kernel.org>;
	Mon,  7 Dec 2009 11:15:49 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id 7BC4B80039F
	for <git@vger.kernel.org>; Mon,  7 Dec 2009 11:15:49 +0100 (CET)
User-Agent: KMail/1.11.4 (Linux/2.6.28-11-generic; KDE/4.2.4; i686; ; )
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134733>


According to git-config(1) 

       core.worktree
           Set the path to the working tree. The value will not be used in combination with repositories found automatically in a
           .git directory (i.e. $GIT_DIR is not set). This can be overridden by the GIT_WORK_TREE environment variable and the
           --work-tree command line option. It can be a absolute path or relative path to the directory specified by --git-dir or
           GIT_DIR. Note: If --git-dir or GIT_DIR are specified but none of --work-tree, GIT_WORK_TREE and core.worktree is
           specified, the current working directory is regarded as the top directory of your working tree.

this setting is not used if GIT_DIR is set. But when I try it out 

$ mkdir r1
$ mkdir r2
$ cd r2
$ git init
Initialized empty Git repository in /home/me/tmp/r2/.git/
$ date >f
$ git add f
$ git commit -m "f"
 f
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 f
$ git status
# On branch master
nothing to commit (working directory clean)

=> Nothing interesting here. It comes here:

$ git config core.worktree $(cd ../r1;pwd)
$ git status
# On branch master
# Changed but not updated:
#   (use "git add/rm <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#
#       deleted:    f
#
no changes added to commit (use "git add" and/or "git commit -a")

=> Seems the config is actually honored even though GIT_DIR is not set.

Bisect tells me 4f38f6b5bafb1f7f85c7b54d0bb0a0e977cd947c broke it. My main point is that I am
implementing this in JGit so I want the same behaviour. Question: Should we try to fix this
in git so it matches the documentation or fix the documentation to match behaviour.

The breakage appeared over a year ago and no one has complained.

-- robin

My bisection script:

#!/bin/bash

test_description="CEILING"

. ./test-lib.sh

test_expect_success \
    "ceiling" \
    "
     rm -rf r1 r2 &&
     mkdir r1 r2 &&
     (cd r2 &&
     git init &&
     date >f &&
     git add f &&
echo ADD &&
     git commit -m f &&
echo COMMIT &&
     git diff --exit-code f && 
echo DIFF &&
     git config core.worktree \$(cd ../r1/..;pwd) &&
echo CONFIG &&
     (unset GIT_DIR;git diff --exit-code -- f) &&
echo DIFF
     )
     "

test_don
