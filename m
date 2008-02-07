From: Adam Roben <aroben@apple.com>
Subject: Bug in git rebase -i where <upstream> is "HEAD" in 1.5.4?
Date: Thu, 07 Feb 2008 16:47:27 -0500
Message-ID: <D94A5309-3EB0-46FA-9114-D11376585DBB@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 07 22:58:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNEks-0001Fa-0c
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 22:58:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755248AbYBGV52 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 16:57:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754475AbYBGV52
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 16:57:28 -0500
Received: from mail-out4.apple.com ([17.254.13.23]:57059 "EHLO
	mail-out4.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754204AbYBGV51 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 16:57:27 -0500
X-Greylist: delayed 597 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Feb 2008 16:57:27 EST
Received: from relay13.apple.com (relay13.apple.com [17.128.113.29])
	by mail-out4.apple.com (Postfix) with ESMTP id D09A321719D0
	for <git@vger.kernel.org>; Thu,  7 Feb 2008 13:47:29 -0800 (PST)
Received: from relay13.apple.com (unknown [127.0.0.1])
	by relay13.apple.com (Symantec Mail Security) with ESMTP id B9C9528083
	for <git@vger.kernel.org>; Thu,  7 Feb 2008 13:47:29 -0800 (PST)
X-AuditID: 1180711d-99be6bb000001e9b-b7-47ab7c714718
Received: from gertie.apple.com (gertie.apple.com [17.151.62.15])
	by relay13.apple.com (Apple SCV relay) with ESMTP id A0A752808C
	for <git@vger.kernel.org>; Thu,  7 Feb 2008 13:47:29 -0800 (PST)
Received: from [17.151.80.128] by ifon.apple.com
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPSA id <0JVW0072T1V4EB00@ifon.apple.com> for git@vger.kernel.org;
 Thu, 07 Feb 2008 13:47:29 -0800 (PST)
X-Mailer: Apple Mail (2.915)
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73009>

Hi all-
    I've discovered a difference in behavior between `git rebase` and  
`git rebase -i`, and I believe the behavior exhibited by `git rebase - 
i` is incorrect and should be changed to match `git rebase`. The  
behavior difference occurs when running the command in the form:

git rebase [-i] <upstream> <branch>

    If <upstream> is "HEAD", `git rebase` seems to perform these  
(correct) steps:

A=$(git rev-parse HEAD)
git checkout <branch>
git rebase $A

    However, `git rebase -i` seems to perform these (incorrect) steps:

git checkout <branch>
git rebase -i HEAD

    The problem is that `git checkout` changes the meaning of HEAD  
(naturally), and so these steps are not equivalent. The end result is  
that `git rebase -i HEAD <branch>` just checks out <branch> and prints  
"Nothing to do", while when -i is omitted the rebase occurs as  
expected. Below is a transcript that shows exactly what I mean.

-Adam


% git init
Initialized empty Git repository in .git/
% touch onmaster
% git add onmaster
% git commit -m "Added onmaster"
Created initial commit 7c3e0f1: Added onmaster
  0 files changed, 0 insertions(+), 0 deletions(-)
  create mode 100644 onmaster
% touch onmaster2
% git add onmaster2
% git commit -m "Added onmaster2"
Created commit c19019b: Added onmaster2
  0 files changed, 0 insertions(+), 0 deletions(-)
  create mode 100644 onmaster2
% git checkout -b work HEAD^
Switched to a new branch "work"
% touch onwork
% git add onwork
% git commit -m "Added onwork"
Created commit ae14495: Added onwork
  0 files changed, 0 insertions(+), 0 deletions(-)
  create mode 100644 onwork
% touch onwork2
% git add onwork2
% git commit -m "Added onwork2"
Created commit 64b3dc0: Added onwork2
  0 files changed, 0 insertions(+), 0 deletions(-)
  create mode 100644 onwork2
% ls
onmaster onwork   onwork2
% git checkout master
Switched to branch "master"
% ls
onmaster  onmaster2
% git rebase -i HEAD work
Nothing to do
% ls
onmaster onwork   onwork2
