From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn: File was not found in commit
Date: Sun, 11 Jan 2009 18:32:11 -0800
Message-ID: <20090112023211.GA21462@dcvr.yhbt.net>
References: <49678705.4040506@mog.se> <20090111215526.GA15533@atjola.homenet> <496A890C.8080208@mog.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Morgan Christiansson <git@mog.se>
X-From: git-owner@vger.kernel.org Mon Jan 12 03:33:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMCcd-0001fm-W2
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 03:33:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752188AbZALCcO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 21:32:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751645AbZALCcN
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 21:32:13 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:48665 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752006AbZALCcM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 21:32:12 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E9121FE52;
	Mon, 12 Jan 2009 02:32:11 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <496A890C.8080208@mog.se>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105280>

Morgan Christiansson <git@mog.se> wrote:
> The "Ignoring path" message appears to be coming from git which is  
> refusing to commit the .git directory. Which leads to git-svn being  
> unaware of the files being ignored and giving an error when it can't  
> find them.

> I'm personally fine with these files being ignored by git, but git-svn  
> needs to be aware that they are not added to the repository.

Hi Morgan,
Can you try the following rough patch and see it it fixes things
for you?  Thanks!

>From 559f4b673592f364e9773f2ba65caf09b138521b Mon Sep 17 00:00:00 2001
From: Eric Wong <normalperson@yhbt.net>
Date: Sun, 11 Jan 2009 18:23:38 -0800
Subject: [PATCH/RFC] git-svn: avoid importing nested repos

Some SVN repositories contain .git repositories within them
(hopefully accidentally checked in).  Since git refuses to
check in ".git" repositories, this can be a problem when
fetching updates from SVN.

This seems to repull the entire blob from SVN everytime a user
changes something inside the ".git" directory on the SVN side,
but hopefully this will be a rare case and the SVN users will
correct the error quickly.

The test could probably be expanded to be more thorough...

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl                       |    8 +++++
 t/t9133-git-svn-nested-git-repo.sh |   61 ++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+), 0 deletions(-)
 create mode 100755 t/t9133-git-svn-nested-git-repo.sh

diff --git a/git-svn.perl b/git-svn.perl
index b0e3d7c..d34d967 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3379,6 +3379,13 @@ sub apply_textdelta {
 	# (but $base does not,) so dup() it for reading in close_file
 	open my $dup, '<&', $fh or croak $!;
 	my $base = $::_repository->temp_acquire('git_blob');
+
+	# skip any .git directories that may have gone into SVN
+	# since update-index refuses to add anything under ".git"
+	if ($fb->{path} =~ m{(?:^|/)\.git(?:/|$)}) {
+		goto apply;
+	}
+
 	if ($fb->{blob}) {
 		my ($base_is_link, $size);
 
@@ -3412,6 +3419,7 @@ sub apply_textdelta {
 		}
 	}
 	seek $base, 0, 0 or croak $!;
+apply:
 	$fb->{fh} = $fh;
 	$fb->{base} = $base;
 	[ SVN::TxDelta::apply($base, $dup, undef, $fb->{path}, $fb->{pool}) ];
diff --git a/t/t9133-git-svn-nested-git-repo.sh b/t/t9133-git-svn-nested-git-repo.sh
new file mode 100755
index 0000000..85402f4
--- /dev/null
+++ b/t/t9133-git-svn-nested-git-repo.sh
@@ -0,0 +1,61 @@
+#!/bin/sh
+#
+# Copyright (c) 2009 Eric Wong
+#
+
+test_description='git svn property tests'
+. ./lib-git-svn.sh
+
+test_expect_success 'setup repo with a git repo inside it' '
+	svn co "$svnrepo" s &&
+	(
+		cd s &&
+		git init &&
+		test -f .git/HEAD &&
+		echo a > a &&
+		svn add .git a &&
+		test a = "`sed -ne 1p < a`" &&
+		svn commit -m "create a nested git repo"
+	)
+'
+
+test_expect_success 'clone an SVN repo containing a git repo' '
+	git svn clone "$svnrepo" g
+'
+
+test_expect_success 'SVN-side change outside of .git' '
+	(
+		cd s &&
+		echo b >> a &&
+		svn commit -m "SVN-side change outside of .git"
+	)
+'
+
+test_expect_success 'update git svn-cloned repo' '
+	(
+		cd g &&
+		git svn rebase &&
+		test a = "`sed -ne 1p < a`" &&
+		test b = "`sed -ne 2p < a`"
+	)
+'
+test_expect_success 'SVN-side change inside of .git' '
+	(
+		cd s &&
+		git add a &&
+		git commit -m "add a inside an SVN repo" &&
+		svn add .git &&
+		svn commit -m "SVN-side change inside of .git"
+	)
+'
+
+test_expect_success 'update git svn-cloned repo' '
+	(
+		cd g &&
+		git svn rebase &&
+		grep ^b a &&
+		git log --raw -r
+	)
+'
+
+test_done
-- 
Eric Wong
