From: Zbyszek Szmek <zbyszek@in.waw.pl>
Subject: rebase -i segmentation fault and another problem
Date: Mon, 27 Sep 2010 16:23:27 +0200
Message-ID: <20100927142327.GW6756@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: python-faculty@g-node.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 27 16:37:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with smtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0EpS-0000Uz-DE
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 16:37:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756145Ab0I0OhJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Sep 2010 10:37:09 -0400
Received: from cwm83.internetdsl.tpnet.pl ([83.19.120.83]:1676 "EHLO
	cwm83.internetdsl.tpnet.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755783Ab0I0OhI (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Sep 2010 10:37:08 -0400
X-Greylist: delayed 820 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 Sep 2010 10:37:08 EDT
Received: from zbyszek by cwm83.internetdsl.tpnet.pl with local (Exim 4.69)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1P0Ec3-00023t-J6; Mon, 27 Sep 2010 16:23:27 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157335>

Hi,
I get a core dump when trying to remove a commit from the tip
of a branch which was merged with a branch with a different
root. Sorry if this is unclear - picture might help:

 *-*-m-r
    /
 z-*

(m is merge point, and r is the commit to be removed,
 z is initial commit on the other branch).

A simple 'git reset --hard HEAD^' works, I know. But:

$ git rebase --interactive HEAD~2
Segmentation fault (core dumped)

Could not apply 532e7e0... z

The core files comes from 'git cherry-pick ...',
and indeed it's enough to run this command directly:

$ git-cherry-pick --ff 532e7e0
[2]    9582 segmentation fault (core dumped)  git-cherry-pick --ff 532e7e0

gdb:
Program terminated with signal 11, Segmentation fault.
#0  do_pick_commit (argc=3, argv=<value optimized out>) at builtin/revert.c:445
445 		   if (allow_ff && !hashcmp(parent->object.sha1, head))

(gdb) bt
#0  do_pick_commit (argc=3, argv=<value optimized out>) at builtin/revert.c:445
#1  revert_or_cherry_pick (argc=3, argv=<value optimized out>) at builtin/revert.c:576
#2  0x000000000040499a in run_builtin (argc=3, argv=0x7fff86b20ba8) at git.c:275
#3  handle_internal_command (argc=3, argv=0x7fff86b20ba8) at git.c:431
#4  0x0000000000404f9f in main (argc=3, argv=0x7fff86b20ba8) at git.c:516

Repo which shows this behaviour can be created with:
git init repo1; cd repo1
touch a; git add a; git commit -m a
cd ..
git init repo2; cd repo2
touch b; git add b; git commit -m b
cd ../repo1
git pull ../repo2
touch c; git add c; git commit -m c
git rebase --interactive HEAD~2
 (just save without doing anything -> segmentation fault)


$ git --version
git version 1.7.3 (compiled from git/master) 

--------------------------------------------------------

Another small problem with git rebase --interactive: in the same repo,
running git rebase HEAD~1 and removing the only commit on the list
doesn't do anything (repo is unchanged). The expected behaviour
would be to remove the tip of branch...

Best,
Zbyszek
