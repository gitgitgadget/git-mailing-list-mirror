From: Sebastian Thiel <byronimo@gmail.com>
Subject: Bug Report ( including test script ): Non-Fastforward merges misses directory deletion
Date: Thu, 18 Feb 2010 10:00:35 +0000 (UTC)
Message-ID: <loom.20100218T104300-858@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 18 11:01:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ni3C3-0000ia-2O
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 11:01:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756049Ab0BRKBF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2010 05:01:05 -0500
Received: from lo.gmane.org ([80.91.229.12]:49323 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755829Ab0BRKBD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2010 05:01:03 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Ni3Br-0000a5-Rq
	for git@vger.kernel.org; Thu, 18 Feb 2010 11:00:59 +0100
Received: from 91-64-162-37-dynip.superkabel.de ([91.64.162.37])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 18 Feb 2010 11:00:59 +0100
Received: from byronimo by 91-64-162-37-dynip.superkabel.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 18 Feb 2010 11:00:59 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 91.64.162.37 (Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.2pre) Gecko/20100218 Ubuntu/8.10 (intrepid) Namoroka/3.6.2pre)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140312>

Hello, 

I recently recognized a bug that is related to the merge of deletions. 
If there is a single file at path 'dir/subdir/file', and the file is deleted in
one branch called 'del', git merge fails to delete 'dir' if 'del' is merged into
another branch where the path still existed if --no-ff is given ( or if a
fast-forward is not possible ). Apparently, it will only delete the immediate
parent directory, but cannot work its way up to the remaining empty directories.
If a fast-forward is possible, 'dir' will be deleted as one would expect it -
perhaps git will internally just do a checkout which is implemented differently.

The issue could be reproduced on git 1.7.0 and 1.6.5, I have not tested other
versions though.

To reproduce the issue, execute the following script. It will exit with status 5
to indicate the base top-level directory still exists.

Regards, 
Sebastian

--------------------------------------------------------------------------

#!/bin/bash
reponame=testrepo
basedir=dir
dirpath=$basedir/subdir
filepath=$dirpath/file

# setup git repo
mkdir $reponame
cd $reponame
git init

# make dir and file
mkdir -p $dirpath
echo data > $filepath

# initial commit
git add $dirpath
git commit -m "initial commit"

# create branch with deletion
git co -b del
git rm -r $dirpath
git commit -m "deleted folder"

# merge fast forward - it works
git co master
git merge del

# assertion - directory must not exist
[[ ! -d $dirpath ]] || exit 1
[[ ! -d $basedir ]] || exit 2

# undo merge, again with non-fastforward
git reset --hard master~1

# as a test, one can make a fast-forward impossible - the issue still shows up
#echo "some data" > new_file
#git add new_file
#git commit -m "new file"
#git merge del

git merge --no-ff del

# the directory should be gone, but effectively only the file is AND the files
# empty parent directory
[[ ! -f $filepath ]] || exit 3
[[ ! -d $dirpath ]] || exit 4
[[ ! -d $basedir ]] || exit 5

echo "It worked actually !"
