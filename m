From: Salikh Zakirov <salikh@gmail.com>
Subject: git-commit goes awry after git-add -u
Date: Wed, 15 Aug 2007 23:16:59 +0900
Message-ID: <f9v1t6$uph$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 15 16:18:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILJhV-0003Jo-Ee
	for gcvg-git@gmane.org; Wed, 15 Aug 2007 16:18:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759020AbXHOORZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Aug 2007 10:17:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757631AbXHOORZ
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 10:17:25 -0400
Received: from main.gmane.org ([80.91.229.2]:60150 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756806AbXHOORW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2007 10:17:22 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1ILJgW-0007hK-CJ
	for git@vger.kernel.org; Wed, 15 Aug 2007 16:17:20 +0200
Received: from cerberus.is.titech.ac.jp ([131.112.51.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 15 Aug 2007 16:17:20 +0200
Received: from salikh by cerberus.is.titech.ac.jp with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 15 Aug 2007 16:17:20 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cerberus.is.titech.ac.jp
User-Agent: Thunderbird 2.0.0.4 (X11/20070708)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55906>

Hi,

I have observed incorret behaviour of git-commit after git-add -u, where
it records deletions of files not related to the files touched by commit.

Unfortunately, I was not able to create a small reproducer, and so
describing the reproducer with the codebase I've encountered this.
Fortunately, it's an open-source project, so I've uploaded the tree
to repo.or.cz.

I've reproduced the problem with both 1.5.3-rc5 and 1.5.2.4

The problematic commit is the topmost one, so it is needed to reset it
to reproduce the bug. The commit moves files:

  vm/em/src/ia32 => vm/em/src/arch/ia32
  vm/vmcore/src/util/em64t => vm/em/src/arch/em64t
  vm/vmcore/src/util/ipf => vm/em/src/arch/ipf

Problem description (short):

Sequence of commands
 git-add -u
 git-commit
produces severely damaged commit. If 'git-add -u' is changed
to using git-add and git-rm, the commit is correct.

How to reproduce (long):

$ git clone git://repo.or.cz/drlvm.git
$ cd drlvm
$ git reset HEAD^   	# undo the problematic commit
$ git status		# all is good now
...
# Changed but not updated:
...
#       deleted:    vm/em/src/ia32/...
...
#       deleted:    vm/vmcore/src/util/em64t/...
...
#       deleted:    vm/vmcore/src/util/ipf/...
...
# Untracked files:
...
#       vm/em/src/arch/

$ git add vm/em/src/arch/	# inform git about added files
$ git status		# still good...
...
# Changes to be committed:
...
#       new file:   vm/em/src/arch/...
...
# Changed but not updated:
...
#       deleted:    vm/em/src/ia32/...
...
#       deleted:    vm/vmcore/src/util/em64t/...
...
#       deleted:    vm/vmcore/src/util/ipf/...
...
$ git add -u		# inform git about deleted files as well
$ git status		# output is okay, it looks like git picked up all of the
moves, but ...
...
# Changed but not updated:
#       renamed:    vm/vmcore/src/util/em64t/... -> vm/em/src/arch/em64t/...
...
$ git diff		# is empty as expected
$ git diff -M --cached  # shows a bunch of renames as expected
$ git commit -m "move"  # BANG! something gone wrong:
Created commit 64aed27: move
 53 files changed, 23168 insertions(+), 5414 deletions(-)
 create mode 100644 vm/em/src/arch/...
 ...					# file creations are okay
 delete mode 100644 vm/vmi/Makefile	# these deletions are incorrect
 delete mode 100644 vm/vmi/src/j9vmls.cpp
 delete mode 100644 vm/vmi/src/vm_trace.h
 delete mode 100644 vm/vmi/src/vmi.cpp
 delete mode 100644 vm/vmi/src/vmi.exp
 delete mode 100644 vm/vmstart/src/compmgr/component_manager_impl.cpp
 delete mode 100644 vm/vmstart/src/compmgr/component_manager_impl.h

$ git status		# work dir is expected to be clean, but it is not
# Changes to be committed:
...
#       deleted:    vm/vmcore/src/util/em64t/...	
...
#       new file:   vm/vmi/Makefile
#       new file:   vm/vmi/src/j9vmls.cpp
#       renamed:
vm/vmcore/src/util/em64t/base_natives/java_lang_thread_em64t.cpp ->
vm/vmi/src/vm_trace.h
#       new file:   vm/vmi/src/vmi.cpp
#       new file:   vm/vmi/src/vmi.exp
#       new file:   vm/vmstart/src/compmgr/component_manager_impl.cpp
#       new file:   vm/vmstart/src/compmgr/component_manager_impl.h

So it does not committed deletion of moved files, but instead recorded
deletions of some other arbitrary files, which in fact are still intact
in the tree, and now are reported as new.

Alternative sequence of commands, not involving 'git-add -u' produces
correct results (without output for compactness)
$ git add vm/em
$ git rm -r vm/vmcore/src/util/ipf
$ git rm -r vm/vmcore/src/util/em64t
$ git rm -r vm/em/src/ia32
$ git status
# On branch master
nothing to commit (working directory clean)
