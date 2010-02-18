From: Sebastian Thiel <byronimo@gmail.com>
Subject: Re: Bug Report ( including test script ): Non-Fastforward merges misses directory deletion
Date: Thu, 18 Feb 2010 11:43:23 +0000 (UTC)
Message-ID: <loom.20100218T113103-602@post.gmane.org>
References: <loom.20100218T104300-858@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 18 12:44:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ni4nY-000233-Pt
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 12:44:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757611Ab0BRLnu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2010 06:43:50 -0500
Received: from lo.gmane.org ([80.91.229.12]:40706 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757733Ab0BRLnt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2010 06:43:49 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Ni4nL-0001uB-HP
	for git@vger.kernel.org; Thu, 18 Feb 2010 12:43:47 +0100
Received: from 91-64-162-37-dynip.superkabel.de ([91.64.162.37])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 18 Feb 2010 12:43:47 +0100
Received: from byronimo by 91-64-162-37-dynip.superkabel.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 18 Feb 2010 12:43:47 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 91.64.162.37 (Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.2pre) Gecko/20100218 Ubuntu/8.10 (intrepid) Namoroka/3.6.2pre)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140322>

I did some additional testing and now this issue makes more sense to me. 

To me it appears as if merge, once it detects a file deletion, 
internally uses git-rm to delete the affected files from the working tree. 
Git-rm will only delete the file's immediate parent directory, but does not 
consider other empty parent directories. 
Given the working tree ...

dir/subdir/subsubdir/file

... if git-rm receives only one file for deletion, i.e. 

git rm dir/subdir/subsubdir/file

it will also delete subsubdir if it turns out to be empty after the deletion of
file. This might already be too much as the user might have had a reason not to
specify dir/subdir/subsubdir ( perhaps he wants to copy another file into it
which sadly doesn't exist anymore ).


Conversely, if the user wants to delete a whole directory tree recursively, rm
seems to resolve commands like  ...

git rm -r dir

... to a list of file paths in the index, and applies the same logic as
previously mentioned. This results in unexpected behaviour regarding the working
tree state, as it will leave 'dir/subdir' untouched although it was supposed to
be deleted recursively ( /bin/rm -R would have done it )

To my mind, this behaviour of git-rm is incorrect, when reading the docs I would
come to the conclusion that it will in fact delete subdirectories recursively,
although I could expect that 'dir' should stay as it only cares about
subdirectories:

"A leading directory name (e.g. dir to remove dir/file1 and dir/file2) can be
given to remove all files in the directory, and recursively all sub-directories,
but this requires the -r option to be explicitly given."

Perhaps this behaviour is desired here, but it might be good to update the
git-rm docs to clearly reflect that.

Considering my previous findings about git-rm, the behaviour of git-merge is
understandable. As git only tracks files, it would even be okay to keep possibly
empty directories after a merge. The problem here is that git-merge in fact
deletes empty parent directories after file deletions which implies it cares,
but it does not do so recursively.
I would suggest that it either does not touch the empty parent directories of
deleted files at all or that it removes empty parent directories to more closely
match the actual index.

To increase the understanding for the severity of the working tree
inconsistency, let me present the case I am working on. There is a file server
with a git repository. It keeps its working tree up-to-date with the tree of the
head commit at all times, hence empty folders may not exist as there are no
empty trees. Clients push their changes into separate branches. A git-update
hook checks it and will at some point allow the change to be merged into the
checked-out main branch. If this merge involves a deletion that effectively
removes directories, these would remain in the working tree if the merge ends up
not to be fast-forwarded. This confuses the users as they see the server's
working tree.

I can workaround this issue by verifying that the merge was a fast-forward one.
If this was not the case, I use git-clean to remove everything not in the index.

To illustrate the git-rm recursive deletion issue, I appended the
'test_git_rm_recursive' script.

Please see this post as an amendment to my previous post.

Thank you, 
Sebastian

This test exits with 3 and a comment.
--------------- test_git_rm -------------------
#!/bin/bash
reponame=testrepo_rm
basedir=dir
subdir=$basedir/subdir
fileparentdir=$subdir/subsubdir
filepath=$fileparentdir/file

# setup git repo
mkdir $reponame
cd $reponame
git init

# make dir and file
mkdir -p $fileparentdir
echo data > $filepath

# initial commit
git add $filepath
git commit -m "initial commit" 

# delete the top-level dir - we expect recursive deletion as stated in the docs
git rm -r $basedir

# assertion - basedir must not exist, but even if it does,subdir must definitely 
# not exist
[[ ! -d $fileparentdir ]] || exit 2
[[ ! -d $subdir ]] || echo "git-rm didn't delete subdirectories recursively" \
&& exit 3
[[ ! -d $basedir ]] || echo "Merge may suffer from this git-rm behaviour" \
&& exit 4
