From: Matt McCutchen <matt@mattmccutchen.net>
Subject: How to structure a project distributed with varyingly
	interdependent feature branches?
Date: Mon, 31 Dec 2007 17:20:13 -0500
Message-ID: <1199139613.2360.83.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Dec 31 23:22:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J9T1w-00061O-Kx
	for gcvg-git-2@gmane.org; Mon, 31 Dec 2007 23:22:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbXLaWWS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 Dec 2007 17:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbXLaWWS
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Dec 2007 17:22:18 -0500
Received: from hapkido.dreamhost.com ([66.33.216.122]:41770 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751150AbXLaWWR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Dec 2007 17:22:17 -0500
Received: from jankymail-a1.g.dreamhost.com (sd-green-bigip-177.dreamhost.com [208.97.132.177])
	by hapkido.dreamhost.com (Postfix) with ESMTP id A83B017959B
	for <git@vger.kernel.org>; Mon, 31 Dec 2007 14:22:16 -0800 (PST)
Received: from [192.168.1.45] (pool-71-163-64-35.washdc.east.verizon.net [71.163.64.35])
	by jankymail-a1.g.dreamhost.com (Postfix) with ESMTP id 0ED21986C4
	for <git@vger.kernel.org>; Mon, 31 Dec 2007 14:20:14 -0800 (PST)
X-Mailer: Evolution 2.21.3 (2.21.3-4.fc8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69420>

Dear git people,

The rsync source repository has recently been migrated from CVS to git
at my encouragement ( http://git.samba.org/rsync.git/ ), and I am tryin=
g
to figure out a better way to structure the repository (to propose to
the maintainer, Wayne Davison, or to use myself).

Rsync presents a unique challenge because it has a number of long-term
feature patches that are maintained and distributed with the main sourc=
e
code.  Furthermore, some of the patches depend on other patches.  With
CVS, the patch files were just stored in the repository; this worked,
but browsing and developing the branched versions represented by the
patches required a lot of extra work.  My hope now is to represent thes=
e
branches and their dependencies properly in git so that the git tools
handle them with the same elegance with which they handle everything
else.

The feature branches seem to present two fundamental problems:

1. How to properly represent the history of an individual branch and
update it when the trunk (or the branch on which it depends) changes.
Right now, Wayne updates the branch by rebasing; unfortunately, if the
trunk changes in such a way that one of the intermediate commits no
longer makes sense, it is impossible to update the branch while
preserving a record that the intermediate commit once existed.  Merging
gives the right history and is very well-supported by the git tools, bu=
t
it has one fatal flaw: when a dependency on another branch is removed,
there is no way to undo the merge of the other branch.  One can revert
the tree changes, but the other branch is still present in the ancestry=
,
which causes problems if the dependency is added again.  It seems to me
that overcoming this flaw would require significant changes to git.  Is
there some other workflow that does what is needed?  Ideally "git blame=
"
would work correctly.

2. How to manage the large number of branches in a practical way.  The
branch dependency information should be pullable from the main
repository to minimize the need for each developer to configure his/her
repository manually on initial cloning and when dependencies change.
Also, for an rsync release, it should be possible to tag the trunk and
all branches as a unit so that developers can ask questions like "which
branches changed between these two pre-releases?".  My feeling is that
the solution will involve a taggable, pullable master tree object that
contains the trunk and branches as submodules and also some
metainformation (including the dependencies).  However, special scripts
will then be needed to conveniently check out and update the submodules
using a single rsync source/build tree.

I'm sure the rsync project could make do without a fully general
solution for the feature branches, but it would be awesome (and a
testament to git's flexibility) if one existed.  Also, Linux
distributions maintain packages with evolving and potentially
interdependent packages, and a good solution would make it possible for
them to do all their package maintenance and patching with git.  Ubuntu
[1] and Fedora [2] are thinking about this.  From my perspective, such =
a
setup would make modifying distribution packages much less painful.

[1] =EF=BB=BFhttps://wiki.ubuntu.com/NoMoreSourcePackages/GitImpl
[2] http://fcp.surfsite.org/modules/newbb/viewtopic.php?topic_id=3D3871=
6&start=3D0#forumpost175743

I would appreciate any ideas toward a solution.

I am not subscribed to the list (I once was but the traffic overwhelmed
me), so please be sure to CC me in replies.

Matt
