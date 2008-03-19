From: John Goerzen <jgoerzen@complete.org>
Subject: Two bugs with renaming
Date: Wed, 19 Mar 2008 18:21:27 -0500
Message-ID: <slrnfu37vn.d2i.jgoerzen@katherina.lan.complete.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 20 00:30:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc7js-0003cp-48
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 00:30:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759636AbYCSX32 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 19:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933286AbYCSX31
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 19:29:27 -0400
Received: from main.gmane.org ([80.91.229.2]:51924 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932704AbYCSX3Y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 19:29:24 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Jc7if-0003K8-EB
	for git@vger.kernel.org; Wed, 19 Mar 2008 23:29:17 +0000
Received: from 63-245-179-205.kitusa.com ([63.245.179.205])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 19 Mar 2008 23:29:17 +0000
Received: from jgoerzen by 63-245-179-205.kitusa.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 19 Mar 2008 23:29:17 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 63-245-179-205.kitusa.com
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77588>

Hi folks,

I have a transcript of a Git session that illustrates two odd bugs
with Git renaming.  Command output is truncated except where
interesting.

Bug #1 causes git to refuse to change to a different branch, claiming
that uncommitted changes exist, even when git status says there are none.
Bug #2 causes git to refuse to merge unrelated changes.

Tested with Git 1.5.4.4.

jgoerzen@katherina:/tmp$ mkdir testrepo
jgoerzen@katherina:/tmp$ cd testrepo
jgoerzen@katherina:/tmp/testrepo$ git init
jgoerzen@katherina:/tmp/testrepo$ mkdir files
jgoerzen@katherina:/tmp/testrepo$ echo hi > files/delete.me
jgoerzen@katherina:/tmp/testrepo$ git add .
jgoerzen@katherina:/tmp/testrepo$ git commit -m 'Added files/delete.me'
jgoerzen@katherina:/tmp/testrepo$ git checkout -b testbranch
Switched to a new branch "testbranch"
jgoerzen@katherina:/tmp/testrepo$ git mv files files.upstream
jgoerzen@katherina:/tmp/testrepo$ git commit -m 'Renamed files to files.upstream'
Created commit 7b6e9c5: Renamed files to files.upstream
 1 files changed, 0 insertions(+), 0 deletions(-)
 rename {files => files.upstream}/delete.me (100%)
jgoerzen@katherina:/tmp/testrepo$ git status
# On branch testbranch
nothing to commit (working directory clean)

#######
# We can still change branches here...

jgoerzen@katherina:/tmp/testrepo$ git co master
Switched to branch "master"
jgoerzen@katherina:/tmp/testrepo$ git co testbranch
Switched to branch "testbranch"

#######
# Now here comes bug #1...

jgoerzen@katherina:/tmp/testrepo$ ln -s /tmp/nonexistant files
jgoerzen@katherina:/tmp/testrepo$ git add files
jgoerzen@katherina:/tmp/testrepo$ git commit -m 'Added files as symlink'
jgoerzen@katherina:/tmp/testrepo$ git status
# On branch testbranch
nothing to commit (working directory clean)
jgoerzen@katherina:/tmp/testrepo$ git checkout master
fatal: Untracked working tree file 'files.upstream/delete.me' would be removed by merge.

#######
# Hrm, but that file really is tracked, AND it didn't show up in git status!

$ git log files.upstream/delete.me | cat
commit 7b6e9c5d0fb268b5bca4985b407fe35aa2a7bd6d
Author: John Goerzen <jgoerzen@complete.org>
Date:   Wed Mar 19 18:12:12 2008 -0500

    Renamed files to files.upstream

#######
# Well, let's work around this and check out master anyhow.

jgoerzen@katherina:/tmp/testrepo$ git checkout -f master
Switched to branch "master"
jgoerzen@katherina:/tmp/testrepo$ ls -l
total 0
drwxr-xr-x 2 jgoerzen jgoerzen 22 Mar 19 18:13 files
drwxr-xr-x 2 jgoerzen jgoerzen 22 Mar 19 18:12 files.upstream

#######
# Yeow!  What's files.upstream doing here?  It wasn't on this branch, and
# we had no uncommitted changes on the other branch.

jgoerzen@katherina:/tmp/testrepo$ rm -r files.upstream
jgoerzen@katherina:/tmp/testrepo$ git rm files.upstream/delete.me
rm 'files.upstream/delete.me'
jgoerzen@katherina:/tmp/testrepo$ git status
# On branch master
nothing to commit (working directory clean)

#######
# Set up bug #2

jgoerzen@katherina:/tmp/testrepo$ echo foo > foo
jgoerzen@katherina:/tmp/testrepo$ git add foo
jgoerzen@katherina:/tmp/testrepo$ git commit -m 'Added foo'
jgoerzen@katherina:/tmp/testrepo$ git checkout testbranch
Switched to branch "testbranch"
jgoerzen@katherina:/tmp/testrepo$ ls -l
total 0
lrwxrwxrwx 1 jgoerzen jgoerzen 16 Mar 19 18:14 files -> /tmp/nonexistant
drwxr-xr-x 2 jgoerzen jgoerzen 22 Mar 19 18:14 files.upstream
jgoerzen@katherina:/tmp/testrepo$ git merge master
fatal: Entry 'files/delete.me' would be overwritten by merge. Cannot merge.
Merge with strategy recursive failed.

########
# And there's bug #2
#
# Note that it doesn't matter what strategy is attempted.

Thanks for any insight.

-- John
