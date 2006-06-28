From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 1/5] git-svn: SVN 1.1.x library compatibility
Date: Tue, 27 Jun 2006 19:39:10 -0700
Message-ID: <11514623563534-git-send-email-normalperson@yhbt.net>
References: <11514623542848-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Jun 28 04:39:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvPxZ-0007bM-IK
	for gcvg-git@gmane.org; Wed, 28 Jun 2006 04:39:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422927AbWF1CjT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Jun 2006 22:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422925AbWF1CjS
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jun 2006 22:39:18 -0400
Received: from hand.yhbt.net ([66.150.188.102]:25047 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1422924AbWF1CjR (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jun 2006 22:39:17 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 5E0C27DC024;
	Tue, 27 Jun 2006 19:39:16 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue, 27 Jun 2006 19:39:16 -0700
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.4.1.rc1.g3cc8
In-Reply-To: <11514623542848-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22768>

Tested on a plain Ubuntu Hoary installation
using subversion 1.1.1-2ubuntu3

1.1.x issues I had to deal with:

* Avoid the noisy command-line client compatibility check if we
  use the libraries.

* get_log() arguments differ.

* get_file() is picky about what kind of file handles it gets,
  so I ended up redirecting STDOUT.  I'm probably overflushing
  my file handles, but that's the safest thing to do...

* BDB kept segfaulting on me during tests, so svnadmin will use FSFS
  whenever we can.

* If somebody used an expanded CVS $Id$ line inside a file, then
  propsetting it to use svn:keywords will cause the original CVS
  $Id$ to be retained when asked for the original file.  As far as
  I can see, this is a server-side issue.  We won't care in the
  test anymore, as long as it's not expanded by SVN, a static
  CVS $Id$ line is fine.

While we're at making ourselves more compatible, avoid using the
-q flag in grep, which is GNU-specific.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 contrib/git-svn/git-svn.perl                     |   26 ++++++++++++++++------
 contrib/git-svn/t/lib-git-svn.sh                 |    8 ++++++-
 contrib/git-svn/t/t0000-contrib-git-svn.sh       |    4 ++-
 contrib/git-svn/t/t0001-contrib-git-svn-props.sh |    4 ++-
 4 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/contrib/git-svn/git-svn.perl b/contrib/git-svn/git-svn.perl
index 08c3010..711b558 100755
--- a/contrib/git-svn/git-svn.perl
+++ b/contrib/git-svn/git-svn.perl
@@ -134,7 +134,7 @@ usage(1) unless defined $cmd;
 init_vars();
 load_authors() if $_authors;
 load_all_refs() if $_branch_all_refs;
-svn_compat_check();
+svn_compat_check() unless $_use_lib;
 migration_check() unless $cmd =~ /^(?:init|rebuild|multi-init)$/;
 $cmd{$cmd}->[0]->(@ARGV);
 exit 0;
@@ -379,7 +379,9 @@ sub fetch_lib {
 			# performance sucks with it enabled, so it's much
 			# faster to fetch revision ranges instead of relying
 			# on the limiter.
-			$SVN_LOG->get_log( '/'.$SVN_PATH, $min, $max, 0, 1, 1,
+			$SVN_LOG->get_log( '/'.$SVN_PATH, $min, $max,
+				($SVN::Core::VERSION ge '1.2.0') ? (0) : (),
+				1, 1,
 				sub {
 					my $log_msg;
 					if ($last_commit) {
@@ -924,7 +926,9 @@ sub graft_file_copy_lib {
 	$SVN::Error::handler = \&libsvn_skip_unknown_revs;
 	while (1) {
 		my $pool = SVN::Pool->new;
-		$SVN_LOG->get_log( "/$path", $min, $max, 0, 1, 1,
+		$SVN_LOG->get_log( "/$path", $min, $max,
+				($SVN::Core::VERSION ge '1.2.0') ? (0) : (),
+				1, 1,
 			sub {
 				libsvn_graft_file_copies($grafts, $tree_paths,
 							$path, @_);
@@ -2358,8 +2362,8 @@ sub libsvn_load {
 	return unless $_use_lib;
 	$_use_lib = eval {
 		require SVN::Core;
-		if ($SVN::Core::VERSION lt '1.2.1') {
-			die "Need SVN::Core 1.2.1 or better ",
+		if ($SVN::Core::VERSION lt '1.1.0') {
+			die "Need SVN::Core 1.1.0 or better ",
 					"(got $SVN::Core::VERSION) ",
 					"Falling back to command-line svn\n";
 		}
@@ -2392,9 +2396,15 @@ sub libsvn_get_file {
 	my $pool = SVN::Pool->new;
 	defined($pid = open3($in, $out, '>&STDERR',
 				qw/git-hash-object -w --stdin/)) or croak $!;
-	my ($r, $props) = $SVN->get_file($f, $rev, $in, $pool);
+	# redirect STDOUT for SVN 1.1.x compatibility
+	open my $stdout, '>&', \*STDOUT or croak $!;
+	open STDOUT, '>&', $in or croak $!;
+	$| = 1; # not sure if this is necessary, better safe than sorry...
+	my ($r, $props) = $SVN->get_file($f, $rev, \*STDOUT, $pool);
 	$in->flush == 0 or croak $!;
+	open STDOUT, '>&', $stdout or croak $!;
 	close $in or croak $!;
+	close $stdout or croak $!;
 	$pool->clear;
 	chomp($hash = do { local $/; <$out> });
 	close $out or croak $!;
@@ -2566,7 +2576,9 @@ sub revisions_eq {
 	if ($_use_lib) {
 		# should be OK to use Pool here (r1 - r0) should be small
 		my $pool = SVN::Pool->new;
-		$SVN->get_log("/$path", $r0, $r1, 0, 1, 1, sub {$nr++},$pool);
+		$SVN->get_log("/$path", $r0, $r1,
+				($SVN::Core::VERSION ge '1.2.0') ? (0) : (),
+				1, 1, sub {$nr++});#, $pool);
 		$pool->clear;
 	} else {
 		my ($url, undef) = repo_path_split($SVN_URL);
diff --git a/contrib/git-svn/t/lib-git-svn.sh b/contrib/git-svn/t/lib-git-svn.sh
index 2843258..d7f972a 100644
--- a/contrib/git-svn/t/lib-git-svn.sh
+++ b/contrib/git-svn/t/lib-git-svn.sh
@@ -33,7 +33,13 @@ svnrepo=$PWD/svnrepo
 
 set -e
 
-svnadmin create $svnrepo
+if svnadmin create --help | grep fs-type >/dev/null
+then
+	svnadmin create --fs-type fsfs "$svnrepo"
+else
+	svnadmin create "$svnrepo"
+fi
+
 svnrepo="file://$svnrepo/test-git-svn"
 
 
diff --git a/contrib/git-svn/t/t0000-contrib-git-svn.sh b/contrib/git-svn/t/t0000-contrib-git-svn.sh
index 443d518..3c14ad8 100644
--- a/contrib/git-svn/t/t0000-contrib-git-svn.sh
+++ b/contrib/git-svn/t/t0000-contrib-git-svn.sh
@@ -173,7 +173,7 @@ then
 fi
 
 
-if test -n "$GIT_SVN_LC_ALL" && echo $GIT_SVN_LC_ALL | grep -q '\.UTF-8$'
+if test -n "$GIT_SVN_LC_ALL" && echo $GIT_SVN_LC_ALL |grep '\.UTF-8$' >/dev/null
 then
 	name="commit with UTF-8 message: locale: $GIT_SVN_LC_ALL"
 	echo '# hello' >> exec-2.sh
@@ -203,7 +203,7 @@ fi
 
 name='check imported tree checksums expected tree checksums'
 rm -f expected
-if test -n "$GIT_SVN_LC_ALL" && echo $GIT_SVN_LC_ALL | grep -q '\.UTF-8$'
+if test -n "$GIT_SVN_LC_ALL" && echo $GIT_SVN_LC_ALL |grep '\.UTF-8$' >/dev/null
 then
 	echo tree f735671b89a7eb30cab1d8597de35bd4271ab813 > expected
 fi
diff --git a/contrib/git-svn/t/t0001-contrib-git-svn-props.sh b/contrib/git-svn/t/t0001-contrib-git-svn-props.sh
index 54e0ed7..a5a235f 100644
--- a/contrib/git-svn/t/t0001-contrib-git-svn-props.sh
+++ b/contrib/git-svn/t/t0001-contrib-git-svn-props.sh
@@ -21,8 +21,8 @@ a_empty_crlf=
 
 cd import
 	cat >> kw.c <<\EOF
-/* Make it look like somebody copied a file from CVS into SVN: */
-/* $Id: kw.c,v 1.1.1.1 1994/03/06 00:00:00 eric Exp $ */
+/* Somebody prematurely put a keyword into this file */
+/* $Id$ */
 EOF
 
 	printf "Hello\r\nWorld\r\n" > crlf
-- 
1.4.1.rc1.g3cc8
