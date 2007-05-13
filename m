From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: don't attempt to minimize URLs by default
Date: Sun, 13 May 2007 09:58:14 -0700
Message-ID: <20070513165814.GA11732@muzzle>
References: <C05C5EF4-EC68-490B-946E-630117393F4E@drhanson.net> <463F6A95.30207@midwinter.com> <9fb1551c0705072048u3ff85ea7n5166596855b8f322@mail.gmail.com> <464023D4.5060101@midwinter.com> <7v4pmn4oxj.fsf_-_@assigned-by-dhcp.cox.net> <20070508193455.GA14602@muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 13 18:58:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnHP3-0001xM-Nk
	for gcvg-git@gmane.org; Sun, 13 May 2007 18:58:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755415AbXEMQ6R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 May 2007 12:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755962AbXEMQ6R
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 12:58:17 -0400
Received: from hand.yhbt.net ([66.150.188.102]:53426 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755415AbXEMQ6Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 May 2007 12:58:16 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id DE3AE7DC0A3;
	Sun, 13 May 2007 09:58:14 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sun, 13 May 2007 09:58:14 -0700
Content-Disposition: inline
In-Reply-To: <20070508193455.GA14602@muzzle>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47151>

For tracking branches and tags, git-svn prefers to connect
to the root of the repository or at least the level that
houses branches and tags as well as trunk.  However, users
that are accustomed to tracking a single directory have
no use for this feature.

As pointed out by Junio, users may not have permissions to
connect to connect to a higher-level path in the repository.

While the current minimize_url() function detects lack of
permissions to certain paths _after_ successful logins, it
cannot effectively determine if it is trying to access a
login-only portion of a repo when the user expects to
connect to a part where anonymous access is allowed.

For people used to the git-svnimport switches of
--trunk, --tags, --branches, they'll already pass the
repository root (or root+subdirectory), so minimize URL
isn't of too much use to them, either.

For people *not* used to git-svnimport, git-svn also
supports:

 git svn init --minimize-url \
  --trunk http://repository-root/foo/trunk \
  --branches http://repository-root/foo/branches \
  --tags http://repository-root/foo/tags

And this is where the new --minimize-url command-line switch
comes in to allow for this behavior to continue working.
---
 git-svn.perl                         |    5 +++--
 t/t9100-git-svn-basic.sh             |    2 +-
 t/t9104-git-svn-follow-parent.sh     |   13 +++++++------
 t/t9105-git-svn-commit-diff.sh       |    2 +-
 t/t9110-git-svn-use-svm-props.sh     |    7 ++++---
 t/t9111-git-svn-use-svnsync-props.sh |    6 +++---
 6 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 5352470..e38811a 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -80,6 +80,7 @@ my %icv;
 my %init_opts = ( 'template=s' => \$_template, 'shared:s' => \$_shared,
                   'trunk|T=s' => \$_trunk, 'tags|t=s' => \$_tags,
                   'branches|b=s' => \$_branches, 'prefix=s' => \$_prefix,
+                  'minimize-url|m' => \$Git::SVN::_minimize_url,
 		  'no-metadata' => sub { $icv{noMetadata} = 1 },
 		  'use-svm-props' => sub { $icv{useSvmProps} = 1 },
 		  'use-svnsync-props' => sub { $icv{useSvnsyncProps} = 1 },
@@ -820,7 +821,7 @@ use strict;
 use warnings;
 use vars qw/$default_repo_id $default_ref_id $_no_metadata $_follow_parent
             $_repack $_repack_flags $_use_svm_props $_head
-            $_use_svnsync_props $no_reuse_existing/;
+            $_use_svnsync_props $no_reuse_existing $_minimize_url/;
 use Carp qw/croak/;
 use File::Path qw/mkpath/;
 use File::Copy qw/copy/;
@@ -1037,7 +1038,7 @@ sub init_remote_config {
 				     "[svn-remote \"$existing\"]\n";
 		}
 		$self->{repo_id} = $existing;
-	} else {
+	} elsif ($_minimize_url) {
 		my $min_url = Git::SVN::Ra->new($url)->minimize_url;
 		$existing = find_existing_remote($min_url, $r);
 		if ($existing) {
diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
index eb628fe..70c3669 100755
--- a/t/t9100-git-svn-basic.sh
+++ b/t/t9100-git-svn-basic.sh
@@ -229,7 +229,7 @@ test_expect_failure 'exit if init-ing a would clobber a URL' "
 
 test_expect_success \
   'init allows us to connect to another directory in the same repo' "
-        git-svn init -i bar $svnrepo/bar &&
+        git-svn init --minimize-url -i bar $svnrepo/bar &&
         git config --get svn-remote.svn.fetch \
                               '^bar:refs/remotes/bar$' &&
         git config --get svn-remote.svn.fetch \
diff --git a/t/t9104-git-svn-follow-parent.sh b/t/t9104-git-svn-follow-parent.sh
index bd4f366..35aa45c 100755
--- a/t/t9104-git-svn-follow-parent.sh
+++ b/t/t9104-git-svn-follow-parent.sh
@@ -28,7 +28,7 @@ test_expect_success 'initialize repo' "
 	"
 
 test_expect_success 'init and fetch a moved directory' "
-	git-svn init -i thunk $svnrepo/thunk &&
+	git-svn init --minimize-url -i thunk $svnrepo/thunk &&
 	git-svn fetch -i thunk &&
 	test \"\`git-rev-parse --verify refs/remotes/thunk@2\`\" \
            = \"\`git-rev-parse --verify refs/remotes/thunk~1\`\" &&
@@ -68,7 +68,8 @@ test_expect_success 'follow larger parent' "
         echo hi > import/trunk/thunk/bump/thud/file &&
         svn import -m 'import a larger parent' import $svnrepo/larger-parent &&
         svn cp -m 'hi' $svnrepo/larger-parent $svnrepo/another-larger &&
-        git-svn init -i larger $svnrepo/another-larger/trunk/thunk/bump/thud &&
+        git-svn init --minimize-url -i larger \
+          $svnrepo/another-larger/trunk/thunk/bump/thud &&
         git-svn fetch -i larger &&
         git-rev-parse --verify refs/remotes/larger &&
         git-rev-parse --verify \
@@ -90,14 +91,14 @@ test_expect_success 'follow higher-level parent' "
                 cd ..
         svn mkdir -m 'new glob at top level' $svnrepo/glob &&
         svn mv -m 'move blob down a level' $svnrepo/blob $svnrepo/glob/blob &&
-        git-svn init -i blob $svnrepo/glob/blob &&
+        git-svn init --minimize-url -i blob $svnrepo/glob/blob &&
         git-svn fetch -i blob
         "
 
 test_expect_success 'follow deleted directory' "
 	svn mv -m 'bye!' $svnrepo/glob/blob/hi $svnrepo/glob/blob/bye &&
 	svn rm -m 'remove glob' $svnrepo/glob &&
-	git-svn init -i glob $svnrepo/glob &&
+	git-svn init --minimize-url -i glob $svnrepo/glob &&
 	git-svn fetch -i glob &&
 	test \"\`git cat-file blob refs/remotes/glob:blob/bye\`\" = hi &&
 	test \"\`git ls-tree refs/remotes/glob | wc -l \`\" -eq 1
@@ -127,7 +128,7 @@ test_expect_success 'follow-parent avoids deleting relevant info' "
 	  poke native/t/c.t &&
 	  svn commit -m 'reorg test' &&
 	cd .. &&
-	git-svn init -i r9270-t \
+	git-svn init --minimize-url -i r9270-t \
 	  $svnrepo/r9270/trunk/subversion/bindings/swig/perl/native/t &&
 	git-svn fetch -i r9270-t &&
 	test \`git rev-list r9270-t | wc -l\` -eq 2 &&
@@ -137,7 +138,7 @@ test_expect_success 'follow-parent avoids deleting relevant info' "
 
 test_expect_success "track initial change if it was only made to parent" "
 	svn cp -m 'wheee!' $svnrepo/r9270/trunk $svnrepo/r9270/drunk &&
-	git-svn init -i r9270-d \
+	git-svn init --minimize-url -i r9270-d \
 	  $svnrepo/r9270/drunk/subversion/bindings/swig/perl/native/t &&
 	git-svn fetch -i r9270-d &&
 	test \`git rev-list r9270-d | wc -l\` -eq 3 &&
diff --git a/t/t9105-git-svn-commit-diff.sh b/t/t9105-git-svn-commit-diff.sh
index c668dd1..318e172 100755
--- a/t/t9105-git-svn-commit-diff.sh
+++ b/t/t9105-git-svn-commit-diff.sh
@@ -33,7 +33,7 @@ test_expect_success 'test the commit-diff command' "
 
 test_expect_success 'commit-diff to a sub-directory (with git-svn config)' "
 	svn import -m 'sub-directory' import $svnrepo/subdir &&
-	git-svn init $svnrepo/subdir &&
+	git-svn init --minimize-url $svnrepo/subdir &&
 	git-svn fetch &&
 	git-svn commit-diff -r3 '$prev' '$head' &&
 	svn cat $svnrepo/subdir/readme > readme.2 &&
diff --git a/t/t9110-git-svn-use-svm-props.sh b/t/t9110-git-svn-use-svm-props.sh
index 9db0d8f..59e17f2 100755
--- a/t/t9110-git-svn-use-svm-props.sh
+++ b/t/t9110-git-svn-use-svm-props.sh
@@ -9,9 +9,10 @@ test_description='git-svn useSvmProps test'
 
 test_expect_success 'load svm repo' "
 	svnadmin load -q $rawsvnrepo < ../t9110/svm.dump &&
-	git-svn init -R arr -i bar $svnrepo/mirror/arr &&
-	git-svn init -R argh -i dir $svnrepo/mirror/argh &&
-	git-svn init -R argh -i e $svnrepo/mirror/argh/a/b/c/d/e &&
+	git-svn init --minimize-url -R arr -i bar $svnrepo/mirror/arr &&
+	git-svn init --minimize-url -R argh -i dir $svnrepo/mirror/argh &&
+	git-svn init --minimize-url -R argh -i e \
+	  $svnrepo/mirror/argh/a/b/c/d/e &&
 	git-config svn.useSvmProps true &&
 	git-svn fetch --all
 	"
diff --git a/t/t9111-git-svn-use-svnsync-props.sh b/t/t9111-git-svn-use-svnsync-props.sh
index 483d7f8..e523214 100755
--- a/t/t9111-git-svn-use-svnsync-props.sh
+++ b/t/t9111-git-svn-use-svnsync-props.sh
@@ -9,9 +9,9 @@ test_description='git-svn useSvnsyncProps test'
 
 test_expect_success 'load svnsync repo' "
 	svnadmin load -q $rawsvnrepo < ../t9111/svnsync.dump &&
-	git-svn init -R arr -i bar $svnrepo/bar &&
-	git-svn init -R argh -i dir $svnrepo/dir &&
-	git-svn init -R argh -i e $svnrepo/dir/a/b/c/d/e &&
+	git-svn init --minimize-url -R arr -i bar $svnrepo/bar &&
+	git-svn init --minimize-url -R argh -i dir $svnrepo/dir &&
+	git-svn init --minimize-url -R argh -i e $svnrepo/dir/a/b/c/d/e &&
 	git-config svn.useSvnsyncProps true &&
 	git-svn fetch --all
 	"
-- 
Eric Wong
