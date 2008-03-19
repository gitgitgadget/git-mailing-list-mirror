From: "Bryan Donlan" <bdonlan@gmail.com>
Subject: [SoC RFC] libsvn-fs-git: A git backend for the subversion filesystem
Date: Wed, 19 Mar 2008 00:08:25 -0400
Message-ID: <3e8340490803182108y40a9aec2q8e5bcb78b907bbb5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 19 23:36:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc6tr-0008OO-Ft
	for gcvg-git-2@gmane.org; Wed, 19 Mar 2008 23:36:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936039AbYCSWgF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 18:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S939480AbYCSWgC
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 18:36:02 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:47598 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936357AbYCSWf7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 18:35:59 -0400
Received: by py-out-1112.google.com with SMTP id u52so833101pyb.10
        for <git@vger.kernel.org>; Wed, 19 Mar 2008 15:35:57 -0700 (PDT)
Received: by 10.65.252.13 with SMTP id e13mr5437609qbs.26.1205899705552;
        Tue, 18 Mar 2008 21:08:25 -0700 (PDT)
Received: by 10.64.195.14 with HTTP; Tue, 18 Mar 2008 21:08:25 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77577>

Hello,

I'm planning to apply for the git summer of code project. My proposal
is based on the project idea of a subversion gateway for git,
implemented with a new subversion filesystem layer. A draft of my
proposal follows; I'd appreciate any comments/questions on it before
the application period proper begins.

Thanks,

Bryan Donlan

=== Project Goals ===

I propose to implement a subversion filesystem driver (libsvn-fs-git) that
uses a git repository as its backing store. Commits will be supported either
directly in the git repository, or in the corresponding subversion repository,
and automatically mirrored to the other side as appropriate.

I intend to support the following:
* Full or near full (possibly forbidding modification of the toplevel
trunk/ branches/ tags/ structure) read/write access from subversion
* svnadmin create/dump/load to convert existing subversion repositories
* Support for wrapping a pre-existing git repository and presenting it
as a subversion repository
* Support for mapping git branches and tags onto subversion branches
and tags (and vice versa)
* Support for syncing svn:executable with git file mode information
* Representation of git merge data using svk:merge and/or svn:mergeinfo
* Syncing .gitignore and svn:ignore data

As both subversion and git are written in C, this driver will also be in C.

Here are some tentative milestones:
* Read-only access from SVN to the master branch (no trunk/ etc layout)
  = Conversion of git commit information into svn revprops
  = git mode/.gitignore -> svn property conversion here?
* Read-write access from SVN to the master branch
  = Map svn usernames to git full name/email according to a configuration map
    - how should git commits with names unknown to svn be handled? Just pass
      them through, spaces and <@> as well?
  = Bidirectional svn:execute and svn:ignore conversion.
  = Copyfrom and file property information needs to be recorded
  = Test importing a largish repository (without converting merge information)
    to git (the svn toplevel stuff would be left as-is in the git tree)
  = Consider developing git-svn-fs on a git-svn-fs repository itself for
    testing purposes
* Standard toplevel SVN layout (trunk/ tags/ branches/)
  = SVN branch creation might come a bit later
  = Test importing a largish repository with tags and branches carried across
    (might not efficiently support copy-from information)
* Merge information annotation (git->svn)
  = Try to guess the copy source for a new tag or branch - and for merges
* Merge information annotation (svn->git)
* Import of a largish repository with svk or similar merge information into git,
  and vice versa (eg, exporting git.git with merge tracking as a subversion
  repo)

=== Interfaces ===

As mentioned before, this driver will plug into the existing subversion stack
as a filesystem driver. This immediately allows access using any of subversion's
access methods (direct filesystem access, mod_dav_svn, svnserve).

On the git side I intend to use libgit for all git repository access. If I find
it lacking a necessary feature, I will attempt to add the missing interfaces
to libgit if at all feasable.

I anticipate svn-git-fs to live either in git.git's contrib or an outside
repository. There should be little if any changes to git itself.

=== About me ===
I am a sophomore computer science student at the University of Maine at Orono.
I have been programming since well before I entered college, and am experienced
in C, although I have not done much work in large (in terms of number of
developers) projects. I have experience in using Subversion, including doing
merges with svk, but I am somewhat less experienced with git. I hope to become
more familiar with git prior to, and as I progress in this project. I also have
some ability with Japanese... but possibly not enough yet to translate the
strings and documentation in this project :)

This particular project idea caught my eye partially because I have been hoping
to convert another open-source project that I hack on [1] to git, but as one
of the other developers is testing it primarily on windows, we've been reluctant
to move there. A git<->svn gateway would be ideal to help ease the transition.
(We haven't yet tried the cygwin port, so admittedly this may be moot already)

I have submitted a small documentation patch to git.git recently[2], and lurked
on the mailing lists for a while during its early days, but I have not yet
become actively involved in development.

[1] - http://openc2e.ccdevnet.org
[2] - commit 81fa145917c40b68a5e2cca6afc6a10cdfdbd25b

=== (Tentative) design notes ===

My current plan for storing the additional information the subversion side will
need (fileprops, revprops, copyfrom information...) is to create an additional
branch on the git repository (possibly .git-svn or similar) to hold the
necessary metadata. Configuration, including author maps, branch/tag maps,
etc, would be on another branch (git-svn-config or similar).

The layout might look like this:

/tree/{trunk/,branches/,tags/} - the tree as svn currently sees it
/props/{trunk/,branches/,tags/} - file properties; props on directories will be
  represented with a reserved filename (._GIT-SVN-DIRPROPS perhaps)
  copyfrom information might be in /props, or in a seperate tree
/revprops/NNN - revision properties for the given revision number
/revmap/NNN - a reference to the commit hash in the .git-svn branch
  corresponding to the given subversion revision number

Each subversion commit corresponds to two .git-svn commits; one to
update tree, props, and revprops, and one to update revmap. The first
commit will
additionally have the following metadata in its commit:
git-svn-revno NNN
git-svn-parent (commit hash of corresponding git-side commit)

If the commit was initiated from the svn side, the git-side commit will be
committed first, and will contain a git-svn-revno field as well. The overall
commit will be performed while holding a git-svn-fs-specific lock (also held
when replicating new git commits to the svn side).

If a commit is performed on the subversion side, the next query to the
subversion layer which checks the current youngest revision number will also
scan for updated git heads, assign revision numbers, and create the necessary
subversion metadata in the .git-svn branch.
