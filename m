From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: SVN 1.1.x library compatibility
Date: Wed, 28 Jun 2006 03:07:14 -0700
Message-ID: <20060628100714.GB23948@soma>
References: <11514623542848-git-send-email-normalperson@yhbt.net> <11514623563534-git-send-email-normalperson@yhbt.net> <7virml4pqg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 28 12:07:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvWx7-0000dn-OE
	for gcvg-git@gmane.org; Wed, 28 Jun 2006 12:07:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423253AbWF1KHS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Jun 2006 06:07:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423255AbWF1KHS
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jun 2006 06:07:18 -0400
Received: from hand.yhbt.net ([66.150.188.102]:54745 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1423253AbWF1KHQ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Jun 2006 06:07:16 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 948977DC022;
	Wed, 28 Jun 2006 03:07:14 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Wed, 28 Jun 2006 03:07:14 -0700
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7virml4pqg.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22798>

Tested on a plain Ubuntu Hoary installation
using subversion 1.1.1-2ubuntu3

1.1.x issues I had to deal with:

* Avoid the noisy command-line client compatibility check if we
  use the libraries.

* get_log() arguments differ (now using a nice wrapper from
  Junio's suggestion)

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

While we're at making ourselves more compatible, avoid grep
along with the -q flag, which is GNU-specific. (grep avoidance
tip from Junio, too)

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 Junio C Hamano <junkio@cox.net> wrote:
 > Eric Wong <normalperson@yhbt.net> writes:
 > > * get_log() arguments differ.
 > 
 > Maybe you would want to have a single wrapper sub {} for this,
 > instead of repeating it all over, perhaps like this:
 > 
 > 	sub log_get {
 >         	my ($SVN_LOG, @args) = @_;
 >         	if ($SVN::CORE::VERSION ge '1.2.0') {
 >                 	splice(@args, 3, 0, 0);
 >                 }
 >                 $SVN_LOG->get_log(@args);
 > 	}

 I actually did it backwards (le) in case I want create something that
 could take advantage of the limit arg for newer versions but degrade
 gracefully for 1.1.x

 contrib/git-svn/git-svn.perl                     |   30 +++++++++++++++++-----
 contrib/git-svn/t/lib-git-svn.sh                 |    8 +++++-
 contrib/git-svn/t/t0000-contrib-git-svn.sh       |   14 +++++++++-
 contrib/git-svn/t/t0001-contrib-git-svn-props.sh |    4 +--
 4 files changed, 44 insertions(+), 12 deletions(-)

diff --git a/contrib/git-svn/git-svn.perl b/contrib/git-svn/git-svn.perl
index 08c3010..f026b24 100755
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
@@ -379,7 +379,8 @@ sub fetch_lib {
 			# performance sucks with it enabled, so it's much
 			# faster to fetch revision ranges instead of relying
 			# on the limiter.
-			$SVN_LOG->get_log( '/'.$SVN_PATH, $min, $max, 0, 1, 1,
+			libsvn_get_log($SVN_LOG, '/'.$SVN_PATH,
+					$min, $max, 0, 1, 1,
 				sub {
 					my $log_msg;
 					if ($last_commit) {
@@ -924,7 +925,7 @@ sub graft_file_copy_lib {
 	$SVN::Error::handler = \&libsvn_skip_unknown_revs;
 	while (1) {
 		my $pool = SVN::Pool->new;
-		$SVN_LOG->get_log( "/$path", $min, $max, 0, 1, 1,
+		libsvn_get_log($SVN_LOG, "/$path", $min, $max, 0, 1, 1,
 			sub {
 				libsvn_graft_file_copies($grafts, $tree_paths,
 							$path, @_);
@@ -2358,8 +2359,8 @@ sub libsvn_load {
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
@@ -2392,9 +2393,15 @@ sub libsvn_get_file {
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
@@ -2566,7 +2573,8 @@ sub revisions_eq {
 	if ($_use_lib) {
 		# should be OK to use Pool here (r1 - r0) should be small
 		my $pool = SVN::Pool->new;
-		$SVN->get_log("/$path", $r0, $r1, 0, 1, 1, sub {$nr++},$pool);
+		libsvn_get_log($SVN, "/$path", $r0, $r1,
+				0, 1, 1, sub {$nr++}, $pool);
 		$pool->clear;
 	} else {
 		my ($url, undef) = repo_path_split($SVN_URL);
@@ -2606,6 +2614,14 @@ sub libsvn_find_parent_branch {
 	return undef;
 }
 
+sub libsvn_get_log {
+	my ($ra, @args) = @_;
+	if ($SVN::Core::VERSION le '1.2.0') {
+		splice(@args, 3, 1);
+	}
+	$ra->get_log(@args);
+}
+
 sub libsvn_new_tree {
 	if (my $log_entry = libsvn_find_parent_branch(@_)) {
 		return $log_entry;
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
index 443d518..b482bb6 100644
--- a/contrib/git-svn/t/t0000-contrib-git-svn.sh
+++ b/contrib/git-svn/t/t0000-contrib-git-svn.sh
@@ -5,6 +5,16 @@ #
 
 test_description='git-svn tests'
 GIT_SVN_LC_ALL=$LC_ALL
+
+case "$LC_ALL" in
+*.UTF-8)
+	have_utf8=t
+	;;
+*)
+	have_utf8=
+	;;
+esac
+
 . ./lib-git-svn.sh
 
 mkdir import
@@ -173,7 +183,7 @@ then
 fi
 
 
-if test -n "$GIT_SVN_LC_ALL" && echo $GIT_SVN_LC_ALL | grep -q '\.UTF-8$'
+if test "$have_utf8" = t
 then
 	name="commit with UTF-8 message: locale: $GIT_SVN_LC_ALL"
 	echo '# hello' >> exec-2.sh
@@ -203,7 +213,7 @@ fi
 
 name='check imported tree checksums expected tree checksums'
 rm -f expected
-if test -n "$GIT_SVN_LC_ALL" && echo $GIT_SVN_LC_ALL | grep -q '\.UTF-8$'
+if test "$have_utf8" = t
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
1.4.1.rc1.gc7c5
