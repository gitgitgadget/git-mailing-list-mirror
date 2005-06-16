From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Stacked GIT 0.1 (a.k.a. quilt for git)
Date: Thu, 16 Jun 2005 23:44:32 +0100
Message-ID: <tnxy899zzu7.fsf@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Jun 17 00:51:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dj3CU-0004Z1-JK
	for gcvg-git@gmane.org; Fri, 17 Jun 2005 00:51:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261883AbVFPWzV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Jun 2005 18:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261853AbVFPWxS
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jun 2005 18:53:18 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:45039 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S261877AbVFPWtP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2005 18:49:15 -0400
Received: from cam-mail2.cambridge.arm.com (cam-mail2.cambridge.arm.com [10.1.127.39])
	by cam-admin0.cambridge.arm.com (8.12.10/8.12.10) with ESMTP id j5GMmo6i008215
	for <git@vger.kernel.org>; Thu, 16 Jun 2005 23:48:50 +0100 (BST)
Received: from ZIPPY.Emea.Arm.com (cam-exch2.emea.arm.com [10.1.255.58])
	by cam-mail2.cambridge.arm.com (8.9.3/8.9.3) with ESMTP id XAA11164
	for <git@vger.kernel.org>; Thu, 16 Jun 2005 23:49:13 +0100 (BST)
Received: from localhost.localdomain ([10.1.69.144]) by ZIPPY.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.211);
	 Thu, 16 Jun 2005 23:44:46 +0100
To: git@vger.kernel.org
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 16 Jun 2005 22:44:46.0497 (UTC) FILETIME=[FEDCD910:01C572C4]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

StGIT is a Python application providing similar functionality to quilt
(i.e. pushing/poping patches to a stack) on top of git. These
operations are performed using the git merge algorithms. StGIT also
allows working with the standard repository commands without having
any patch on the stack (though not all the expected functionality is
implemented yet - see the TODO file in the archive).

The project page is at http://www.procode.org/stgit/

Below is a cut&paste of the README file in the archive.

Catalin



Basic Operations
----------------

For a full list of commands:

	stg help

For help on individual commands:

	stg <cmd> (-h | --help)

To initialise a tree:

	stg init

If there already is a .git directory, it only creates the
.git/patches/ infrastructure. Otherwise, it creates the whole .git
directory structure and imports the existing files.

To commit changes:

	stg commit

To add/delete files:

	stg add [<file>*]
	stg rm [<file>*]

To inspect the tree status:

	stg status

To get a diff between 2 revisions:

	stg diff [-r rev1[:[rev2]]]

A revision name can be of the form '([patch]/[bottom | top]) | <tree-ish>'
If the patch name is not specified but '/' is passed, the topmost
patch is considered. If neither 'bottom' or 'top' follows the '/', the
whole patch diff is displayed (this does not include the local
changes).

Note than when the first patch is pushed to the stack, the current
HEAD is saved in the .git/refs/heads/base file for easy reference.

To create/delete a patch:

	stg new <name>
	stg delete [<name or topmost>]

The 'new' command also sets the topmost patch to the newly created
one.

To push/pop a patch to/from the stack:

	stg push [<name or first unapplied>]
	stg pop [<name or topmost>]

Note that the 'push' command can apply any patch un the unapplied
list. This is useful if you want to reorder the patches.

To inspect the patches applied:

	stg series
	stg applied
	stg unapplied
	stg top

To export a patch series:

	stg export [<dir-name or 'patches'>]

The 'export' command supports options to automatically number the
patches (-n) or add the '.diff' extension (-d).

StGIT does not yet provide support for cloning or pulling changes from
a different repository. Until this becomes available, run the
following commands:

	stg pop -a
	your-git-script-for-pulling-and-committing
	stg push -a

If you forget to pop the patches, the changes will be included in the
topmost patch. StGIT gives a warning on the first commit or patch
operation and you can revert the changes. If this was the intended
behaviour, you either commit the changes with 'stg commit' or do a
'stg refresh' command to synchronise the top of the patch with the
current HEAD.

You can also look in the TODO file for what's planned to be
impelmented in the future.


Directory Structure
-------------------

.git/
  objects/
    ??/

refs/
  heads/
    master		- the master commit id
    base		- the bottom id of the stack (to get a big diff)
    ...
  tags/
    ...
  branches/
    ...
  patches/
    applied		- list of applied patches
    unapplied		- list of not-yet applied patches
    current		- name of the topmost patch
    patch1/
      first		- the initial id of the patch (used for log)
      bottom		- the bottom id of the patch
      top		- the top id of the patch
    patch2/
    ...

HEAD			-> refs/heads/<something>


A Bit of StGIT Patch Theory
---------------------------

We assume that a patch is a diff between two nodes - bottom and top. A
node is a commit SHA1 id or tree SHA1 id in the GIT terminology:

P - patch
N - node

P = diff(Nt, Nb)

	Nb - bottom (start) node
	Nt - top (end) node
	Nf - first node (for log generation)

For an ordered stack of patches:

P1 = diff(N1, N0)
P2 = diff(N2, N1)
...

Ps = P1 + P2 + P3 + ... = diff(Nst, Nsb)

	Ps  - the big patch of the whole stack
	Nsb - bottom stack node (= N0)
	Nst - top stack node (= Nn)

Applying (pushing) a patch on the stack (Nst can differ from Nb) is
done by diff3 merging. The new patch becomes:

P' = diff(Nt', Nb')
Nb' = Nst
Nt' = diff3(Nst, Nb, Nt)

(note that the diff3 parameters order is: branch1, ancestor, branch2)

The above operation allows easy patch re-ordering.

Removing (popping) a patch from the stack is done by simply setting
the Nst to Nb.

