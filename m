From: Jim Meyering <jim@meyering.net>
Subject: git-cvsimport doesn't quite work, wrt branches
Date: Tue, 13 Jun 2006 18:41:49 +0200
Message-ID: <87irn5ovn6.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthias Urlichs <smurf@smurf.noris.de>
X-From: git-owner@vger.kernel.org Tue Jun 13 18:41:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqBxi-0004bH-5f
	for gcvg-git@gmane.org; Tue, 13 Jun 2006 18:41:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbWFMQlv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Jun 2006 12:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932191AbWFMQlv
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jun 2006 12:41:51 -0400
Received: from mx.meyering.net ([82.230.74.64]:38050 "EHLO mx.meyering.net")
	by vger.kernel.org with ESMTP id S932188AbWFMQlu (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Jun 2006 12:41:50 -0400
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 4EB10270F2; Tue, 13 Jun 2006 18:41:49 +0200 (CEST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21783>

Here's a test case that shows how git-cvsimport is misbehaving.
The script below demonstrates the problem with git-1.3.3 as
well as with 1.4.0.rc2.g5e3a6.  As for cvsps, I'm using version 2.1.

The script creates a simple cvs module, with one file on the trunk,
and one file on a branch, then runs git-cvsimport on that.  The error
is that the resulting git repository has both files on the branch.

FYI, this started when I tried to convert the GNU coreutils repository
(which takes barely an hour with git-cvsimport -- very quick, for 45K
revisions and 90MB of ,v files), but found that with a git-based working
directory, not all files on the b5_9x branch showed up after `git checkout
b5_9x' -- plus, there were some files there that didn't belong.

-----------------------------
#!/bin/sh
# Show that git-cvsimport doesn't quite work when
# there is one file on a branch, and another on the trunk.
# The resulting git repository has both files on the branch.

export PATH=/p/p/git/bin:$PATH

cvs='cvs -f -Q'

t=/tmp/.k
rm -rf $t
mkdir -p $t/git $t/cvs
R=$t/repo
$cvs -d $R init
mkdir -p $R/m

cd $t/cvs
$cvs -d $R co m
cd m
# Add a file on the trunk.
touch on-trunk
$cvs add on-trunk
$cvs ci -m. on-trunk

# Add another file, but destined for a branch.
touch on-br
$cvs add on-br
$cvs ci -m. on-br
$cvs tag -b B on-br
$cvs up -r B
echo x > on-br
$cvs ci -m. on-br
# Back to trunk.
$cvs up -A
# Remove our only-on-branch file from the trunk.
$cvs rm -f on-br
$cvs ci -m. on-br

$cvs up -r B

cd $t/git && git-cvsimport -p -x -v -d $R m >& $t/import-log
cd $t/git && git checkout B

cd $t

(cd cvs/m; ls -1 on-*)        > cvs-files
(cd git;   git-ls-files|sort) > git-files

diff -u1 cvs-files git-files

# The problem: diff reports the following differences.
# It should find none.
# --- cvs-files   2006-06-13 17:48:47.000000000 +0200
# +++ git-files   2006-06-13 17:48:47.000000000 +0200
# @@ -1 +1,2 @@
#  ./on-br
# +./on-trunk
