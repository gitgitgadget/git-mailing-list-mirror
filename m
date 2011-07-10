From: John Nowak <john@johnnowak.com>
Subject: reproducible unexpected behavior for 'git reset'
Date: Sun, 10 Jul 2011 18:02:48 -0400
Message-ID: <F5C3C2A9-1A77-4E28-B4B2-508A7F8ACB7E@johnnowak.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 11 01:16:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qg3Ef-0004y1-0m
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jul 2011 01:16:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756832Ab1GJXQU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jul 2011 19:16:20 -0400
Received: from birch.site5.com ([174.132.116.226]:51094 "EHLO birch.site5.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751806Ab1GJXQU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Jul 2011 19:16:20 -0400
Received: from user-387hdgh.cable.mindspring.com ([208.120.182.17] helo=[192.168.1.200])
	by birch.site5.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.69)
	(envelope-from <john@johnnowak.com>)
	id 1Qg25T-0007oT-V1
	for git@vger.kernel.org; Sun, 10 Jul 2011 17:02:52 -0500
X-Mailer: Apple Mail (2.1084)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - birch.site5.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - johnnowak.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176830>

I am able to reproduce a scenario where, after a 'commit' and a 'stash pop' that results in a merge conflict, I need to 'reset' a file twice in order to get the index back to HEAD. It appears that the first 'reset' sets the index to the merge base version instead of HEAD which was, for me, rather unexpected. I encountered this on 1.7.4 but others have reproduced it on the latest master. If this behavior is documented, I cannot find it.

A transcript to reproduce this oddity is below; note how the file is partially staged after the first 'reset' and unstaged after the second:

---

$ git init
Initialized empty Git repository in /Users/jn/test/.git/

$ echo "a" > foo

$ git add foo

$ git commit -a -m "Initial"
[master (root-commit) 5214837] Initial
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 foo

$ echo "b" >> foo

$ git stash
Saved working directory and index state WIP on master: 5214837 Initial
HEAD is now at 5214837 Initial

$ echo "c" >> foo

$ git add foo

$ git commit -a -m "Added c"
[master 69eef48] Added c
 1 files changed, 1 insertions(+), 0 deletions(-)

$ git stash pop
Auto-merging foo
CONFLICT (content): Merge conflict in foo

$ git status
# On branch master
# Unmerged paths:
#   (use "git reset HEAD <file>..." to unstage)
#   (use "git add/rm <file>..." as appropriate to mark resolution)
#
#	both modified:      foo
#
no changes added to commit (use "git add" and/or "git commit -a")

$ git reset foo
Unstaged changes after reset:
M	foo

$ git status
# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#	modified:   foo
#
# Changes not staged for commit:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#
#	modified:   foo
#

$ git reset foo
Unstaged changes after reset:
M	foo

$ git status
# On branch master
# Changes not staged for commit:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#
#	modified:   foo
#
no changes added to commit (use "git add" and/or "git commit -a")
