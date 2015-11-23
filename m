From: Marc Strapetz <marc.strapetz@syntevo.com>
Subject: branch --set-upstream-to unexpectedly fails with "starting point ...
 is no branch"
Date: Mon, 23 Nov 2015 12:04:50 +0100
Message-ID: <5652F2D2.3050902@syntevo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 23 12:14:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a0p4h-000618-52
	for gcvg-git-2@plane.gmane.org; Mon, 23 Nov 2015 12:14:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753030AbbKWLOR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Nov 2015 06:14:17 -0500
Received: from smtprelay03.ispgateway.de ([80.67.31.30]:51689 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752983AbbKWLOO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Nov 2015 06:14:14 -0500
X-Greylist: delayed 569 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 Nov 2015 06:14:14 EST
Received: from [91.113.179.170] (helo=[192.168.92.20])
	by smtprelay03.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES128-SHA:128)
	(Exim 4.84)
	(envelope-from <marc.strapetz@syntevo.com>)
	id 1a0ou2-0005QA-0G
	for git@vger.kernel.org; Mon, 23 Nov 2015 12:03:22 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
X-Df-Sender: bWFyYy5zdHJhcGV0ekBzeW50ZXZvLmNvbQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281578>

There is a strange "branch --set-upstream-to" failure for "clones" which 
haven't been created using "git clone" but constructed using "git init", 
"git remote add" and "git fetch".

Following script first creates a "main" repository and then constructs 
the clone. Finally, in the clone branches origin/1 and origin/2 will be 
present, however it's not possible to invoke "git branch 
--set-upstream-to" for origin/2 (it works fine for origin/1).

I guess the behavior is related to following line in .git/config:

fetch = refs/heads/1:refs/remotes/origin/1

However, I don't understand what's the problem for Git here? Definitely 
the error "starting point 'origin/2' is not a branch" is wrong.



$ git --version
git version 2.5.0.windows.1

$ cd /tmp/gittest
$ mkdir main
$ cd main
$ git init
$ touch file
$ git add file
$ git commit -m "import"
$ git branch 1
$ git branch 2
$ git branch
   1
   2
* master

$ cd /tmp/gittest
$ mkdir clone
$ cd clone
$ git init
Initialized empty Git repository in /tmp/gittest/clone/.git/
$ git remote add origin /tmp/gittest/main
$ git config remote.origin.fetch refs/heads/1:refs/remotes/origin/1
$ git fetch origin
remote: Counting objects: 3, done.
remote: Total 3 (delta 0), reused 0 (delta 0)
Unpacking objects: 100% (3/3), done.
 From /tmp/gittest/main
  * [new branch]      1          -> origin/1

$ git fetch origin refs/heads/2:refs/remotes/origin/2
 From /tmp/gittest/main
  * [new branch]      2          -> origin/2

$ git branch --no-track 2 refs/remotes/origin/2
$ git branch
   2

# HERE COMES THE STRANGE FAILURE:
$ git branch --set-upstream-to=origin/2 2
fatal: Cannot setup tracking information; starting point 'origin/2' is 
not a branch.

# THIS WORKS AS EXPECTED:
$ git branch --set-upstream-to=origin/1 2
Branch 2 set up to track remote branch 1 from origin by rebasing.

-Marc
