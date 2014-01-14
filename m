From: Keith Derrick <keith.derrick@lge.com>
Subject: BUG: check-ref-format and rev-parse can not handle branches with an
 @ in their name combined with @{u}
Date: Tue, 14 Jan 2014 18:04:54 -0500
Message-ID: <52D5C296.7050906@lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 15 00:06:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3D3W-00084F-TC
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jan 2014 00:05:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751609AbaANXFz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jan 2014 18:05:55 -0500
Received: from LGEMRELSE6Q.lge.com ([156.147.1.121]:43667 "EHLO
	LGEMRELSE6Q.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750906AbaANXFy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Jan 2014 18:05:54 -0500
X-AuditID: 9c930179-b7c84ae000000e38-11-52d5c2cfb082
Received: from aicexhub01.lge.net ( [204.79.148.74])
	by LGEMRELSE6Q.lge.com (Symantec Brightmail Gateway) with SMTP id 21.D6.03640.FC2C5D25; Wed, 15 Jan 2014 08:05:51 +0900 (KST)
Received: from AICEXMBXCL02.LGE.NET ([136.166.10.230]) by AICEXHUB04
 ([204.79.148.64]) with mapi; Tue, 14 Jan 2014 18:05:48 -0500
Thread-Topic: check-ref-format and rev-parse can not handle branches with an
 @ in their name combined with @{u}
Thread-Index: Ac8RfSl0JkM9BJ37S7u2gkylWnsnqg==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101
 Thunderbird/24.2.0
acceptlanguage: en-US
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240421>

I couldn't find a duplicate in the JIRA instance.

According to the documentation of check-ref-format, a branch name such 
as @mybranch is valid. Yet 'git check-ref-format --branch @mybranch@{u}' 
claims @mybranch is an invalid branch name. yet I am able to create the 
branch (which would seem the obvious place to check for an invalid 
branch name)

Pick any repository with an upstream remote (I cloned git itself from 
github). The following will reproduce the bug
> $cd ~/play/gitsrc/
> $
> $git status
> On branch master
> Your branch is up-to-date with 'origin/master'.
>
> nothing to commit, working directory clean
> $git checkout -t -b @mybranch origin/master
> Branch @mybranch set up to track remote branch master from origin.
> Switched to a new branch '@mybranch'
> $git branch -av
> * @mybranch             14598b9 Sync with 1.8.5.3
>   master                14598b9 Sync with 1.8.5.3
>   remotes/origin/HEAD   -> origin/master
>   remotes/origin/maint  4224916 Git 1.8.5.3
>   remotes/origin/master 14598b9 Sync with 1.8.5.3
>   remotes/origin/next   b139ac2 Sync with master
>   remotes/origin/pu     3d58c42 Merge branch 'ab/subtree-doc' into pu
>   remotes/origin/todo   1066e10 What's cooking (2014/01 #02)
> $git check-ref-format --branch @mybranch
> @mybranch
> $git check-ref-format --branch @mybranch@{u}
> fatal: '@mybranch@{u}' is not a valid branch name
> $git rev-parse --abbrev-ref @mybranch
> @mybranch
> $git rev-parse --abbrev-ref @mybranch@{u}
> @mybranch@{u}
> fatal: ambiguous argument '@mybranch@{u}': unknown revision or path 
> not in the working tree.
> Use '--' to separate paths from revisions, like this:
> 'git <command> [<revision>...] -- [<file>...]'
> $

The same problem appears if the single '@' is anywhere in the branch name.

I *think* the problem lies in 'interpret_empty_at' in sha1_name.c with 
these statements

>     if (next != name + 1)
>         return -1;
Which is trying to allow the sequence '@@' but I'm not certain enough of 
unintended consequences to suggest a patch.

In our real-world example, we wanted to use a naming convention where a 
branch name beginning with @ was intended to be a long-lived branch (for 
example, a support branch for an official release). Thus, our sequence 
above actually begins with something like 'git checkout -t 
origin/@release1'.

We hit this problem some considerable time after initiating the naming 
convention, so it's too late to turn back for us.

As a work around, if you have the branch checked out, then using HEAD 
instead of the branch name works
> $git checkout @mybranch
> Switched to branch '@mybranch'
> Your branch is up-to-date with 'origin/master'.
> $git check-ref-format --branch HEAD@{u}
> origin/master
> $git rev-parse --abbrev-ref HEAD@{u}
> origin/master
> $

Envronment:

> $git version
> git version 1.8.5.2
> $lsb_release -a
> No LSB modules are available.
> Distributor ID:    Ubuntu
> Description:    Ubuntu 12.04.3 LTS
> Release:    12.04
> Codename:    precise

Keith Derrick
