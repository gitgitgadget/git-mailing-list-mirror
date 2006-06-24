From: Martin Langhoff <martin@catalyst.net.nz>
Subject: [PATCH] cvsimport - streamline temp index file creation and avoid
 creating empty tmpfiles
Date: Sat, 24 Jun 2006 17:09:10 +1200
Message-ID: <11511257501323-git-send-email-martin@catalyst.net.nz>
References: <Pine.LNX.4.63.0606231811200.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Reply-To: Martin Langhoff <martin@catalyst.net.nz>
Cc: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Sat Jun 24 07:09:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fu0OR-0007Fl-Uo
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 07:09:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932554AbWFXFJK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 01:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932570AbWFXFJK
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 01:09:10 -0400
Received: from bm-3a.paradise.net.nz ([203.96.152.182]:63406 "EHLO
	linda-3.paradise.net.nz") by vger.kernel.org with ESMTP
	id S932554AbWFXFJI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jun 2006 01:09:08 -0400
Received: from smtp-2.paradise.net.nz
 (tclsnelb1-src-1.paradise.net.nz [203.96.152.172]) by linda-3.paradise.net.nz
 (Paradise.net.nz) with ESMTP id <0J1C00CS4MB63P@linda-3.paradise.net.nz> for
 git@vger.kernel.org; Sat, 24 Jun 2006 17:09:07 +1200 (NZST)
Received: from localhost.localdomain
 (203-79-116-174.cable.paradise.net.nz [203.79.116.174])
	by smtp-2.paradise.net.nz (Postfix) with ESMTP id 431C1D24FCA; Sat,
 24 Jun 2006 17:09:06 +1200 (NZST)
In-reply-to: <Pine.LNX.4.63.0606231811200.29667@wbgn013.biozentrum.uni-wuerzburg.de>
To: git@vger.kernel.org, junkio@cox.net, Johannes.Schindelin@gmx.de
X-Mailer: git-send-email 1.4.0.gcda2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22484>

On 6/24/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> It seems that git-cvsimport makes a temporary file of size 0, which cannot
> get mmap()ed, because it has size 0.

This switch to tmpnam() avoids creating the tmpfile in the first place and
streamlines the code. This handling of tmpfiles is slightly safer, but there
is an inherent race condition.

---
NOTE: (a) I cannot reproduce the problem and (b) this is only lightly tested,
if trivial.

However, this switch to tmpnam() avoids creating the tmpfile in the first place
and streamlines the code. This usage of tempfiles is open to a race condition
if someone could guess the name returned by tmpnam, but even this is safer than
what we did before, which was creating a file, closing the fh and then
clobbering it from git-read-tree.

And if someone can guess the name that tmpnam() returns their magic is strong
enough that they'll go for more interesting targets.
Signed-off-by: Martin Langhoff <martin@catalyst.net.nz>
---
 git-cvsimport.perl |   20 +++++---------------
 1 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index f3daa6c..d961b7b 100644
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -17,7 +17,7 @@ use strict;
 use warnings;
 use Getopt::Std;
 use File::Spec;
-use File::Temp qw(tempfile);
+use File::Temp qw(tempfile tmpnam);
 use File::Path qw(mkpath);
 use File::Basename qw(basename dirname);
 use Time::Local;
@@ -467,12 +467,8 @@ my $orig_git_index;
 $orig_git_index = $ENV{GIT_INDEX_FILE} if exists $ENV{GIT_INDEX_FILE};
 
 my %index; # holds filenames of one index per branch
-{   # init with an index for origin
-    my ($fh, $fn) = tempfile('gitXXXXXX', SUFFIX => '.idx',
-			     DIR => File::Spec->tmpdir());
-    close ($fh);
-    $index{$opt_o} = $fn;
-}
+$index{$opt_o} = tmpnam();
+
 $ENV{GIT_INDEX_FILE} = $index{$opt_o};
 unless(-d $git_dir) {
 	system("git-init-db");
@@ -502,10 +498,7 @@ unless(-d $git_dir) {
 
 	# populate index
 	unless ($index{$last_branch}) {
-	    my ($fh, $fn) = tempfile('gitXXXXXX', SUFFIX => '.idx',
-				     DIR => File::Spec->tmpdir());
-	    close ($fh);
-	    $index{$last_branch} = $fn;
+	    $index{$last_branch} = tmpnam();
 	}
 	$ENV{GIT_INDEX_FILE} = $index{$last_branch};
 	system('git-read-tree', $last_branch);
@@ -818,10 +811,7 @@ while(<CVS>) {
 		if(($ancestor || $branch) ne $last_branch) {
 			print "Switching from $last_branch to $branch\n" if $opt_v;
 			unless ($index{$branch}) {
-			    my ($fh, $fn) = tempfile('gitXXXXXX', SUFFIX => '.idx',
-						     DIR => File::Spec->tmpdir());
-			    close ($fh);
-			    $index{$branch} = $fn;
+			    $index{$branch} = tmpnam();
 			    $ENV{GIT_INDEX_FILE} = $index{$branch};
 			    system("git-read-tree", $branch);
 			    die "read-tree failed: $?\n" if $?;
-- 
1.4.0.gcda2
