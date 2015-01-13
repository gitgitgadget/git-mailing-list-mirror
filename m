From: "Henning Moll" <newsScott@gmx.de>
Subject: sporadic git failures on interactive rebase
Date: Tue, 13 Jan 2015 11:54:32 +0100
Message-ID: <trinity-5098e61e-b59a-4225-9d4c-8879dc78bb53-1421146472532@3capp-gmx-bs08>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 13 11:54:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YAz7P-0004MG-Tn
	for gcvg-git-2@plane.gmane.org; Tue, 13 Jan 2015 11:54:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752164AbbAMKyf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2015 05:54:35 -0500
Received: from mout.gmx.net ([212.227.15.19]:57496 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752094AbbAMKye (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2015 05:54:34 -0500
Received: from [195.49.159.90] by 3capp-gmx-bs08.server.lan (via HTTP); Tue,
 13 Jan 2015 11:54:32 +0100
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K0:fzKbV5jFqLYHIeFmkY5ZhX+gL+K5gNkpM9iHGCV4npZ
 OEXj5qh8ZmjKGhFPQ8ZJMVPqMo2k+wkSpjRu+EDc2EzgC35+MX
 uvKwQCXBqEhPBcckm8S3xOftqIw2EGyuV0mDg1sJ8VYWlndWgw
 e2Q6PFWAX1e+/6ghV8wlhyJBNPFnV7aM6tsgCnhjsQ0589TKb2
 O7+Vcx5Lwn8VZx1AlzODNqeZneQ+Fd/yHqZWSAnxlz1tL2qIxW
 dy6r9dXkCki28Yb+YAWCnTP+7FzvdTTL5PcKuyb7VkXVrpmsln 1l5LNY=
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262334>


Hi,

(git version 2.2.0)

I am currently developing/testing a script for a "history surgery" on a quite big repository (~30000 commits). The script always runs against exactly the same copy of a git repository. So things should be reproducable, but sometimes i get failures for the following sequence of commands:  

$ git checkout some_branch
$ GIT_SEQUENCE_EDITOR="sed -i '1s/^pick /edit /'" git rebase -i $MERGETARGET~1
$ git rm -rf some_files
$ git commit --amend --no-edit -c $MERGETARGET
$ git rebase --continue

(where MERGETARGET is a valid commit id in the history of some_branch)

Here is an example output where things went wrong (MERGETARGET is 6185ac39299a740dc9bc6c5906dd1f229b3f046b). The interesting parts are the messages "c4095c1: not a commit that can be picked" and "error: short SHA1 c4095c1 is ambiguous.":

. Switched to branch 'master-flat'
. c4095c1: not a commit that can be picked
. 80f99bd: not a commit that can be picked
. Stopped at 6185ac39299a740dc9bc6c5906dd1f229b3f046b... some_comment
. You can amend the commit now, with
. 
.         git commit --amend
. 
. Once you are satisfied with your changes, run
. 
.         git rebase --continue
. rm 'some_files'
. [detached HEAD 56675a06316345ac121997dde2b9eddb649d0539] some_comment
.  Author: user <foo.bar@com.com>
.  Date: Wed Sep 26 09:11:17 2012 +0000
. [more info about that commit]
. error: short SHA1 c4095c1 is ambiguous.
. fatal: Needed a single revision
. Invalid commit name: c4095c1

Now that the command failed, i checked for ambigous c4095c1. But there is only one:
$ git log -1 c4095c1
. commit c4095c1f5e7c126accf93ba68e2fa72bb055f567
. ...

Just as a test:
$ git log -1 c409
. error: short SHA1 c409 is ambiguous.
. error: short SHA1 c409 is ambiguous.

As i said above this issue is not strictly reproducable. I have a full backup of the working dir including the .git folder from just before the command sequence above. If i rollback and execute the commands again, everything works fine. Up to now i didn't had the situation the the sequence failed twice two in a row.

I also have the backup of the directory from directly after the sequence failure. So i can still test some commands if you need more information.

Does anybody have an idea of what's going on here?

Best regards
Henning
