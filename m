From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: lazy load some modules
Date: Thu, 15 Jan 2015 10:14:34 +0000
Message-ID: <20150115101434.GA15361@dcvr.yhbt.net>
References: <CAKdxknyCQf6HpnTZ8BMVVpEX3vcVEoTo5BmpqrkgFuxV+k7wmw@mail.gmail.com>
 <20150114203012.GA26023@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Niluge kiwi <kiwiiii@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 15 11:14:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBhRw-0006TJ-RK
	for gcvg-git-2@plane.gmane.org; Thu, 15 Jan 2015 11:14:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753380AbbAOKOh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2015 05:14:37 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:39727 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752143AbbAOKOf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2015 05:14:35 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A8631F453;
	Thu, 15 Jan 2015 10:14:34 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20150114203012.GA26023@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262472>

Baby steps, pushed to my master on git://bogomips.org/git-svn

--------------------------8<----------------------------
Subject: [PATCH] git-svn: lazy load some modules

We can delay loading some modules until we need them for uncommon
code paths.  For example, persistent memoization is not often
needed, so we can avoid loading the modules for it until we
encounter svn::mergeinfo during fetch.

This gives a tiny reduction in syscalls (from 15641 to 15305) when
running "git svn info" and counting via "strace -fc".  Further,
more invasive work will be needed to noticeably improve performance.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl            | 13 +++++++------
 perl/Git/SVN.pm         | 22 +++++++++++++---------
 perl/Git/SVN/Editor.pm  |  3 +--
 perl/Git/SVN/Fetcher.pm |  3 +--
 perl/Git/SVN/Ra.pm      |  5 ++++-
 5 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 32d109e..36f7240 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -11,14 +11,10 @@ $AUTHOR = 'Eric Wong <normalperson@yhbt.net>';
 $VERSION = '@@GIT_VERSION@@';
 
 use Carp qw/croak/;
-use Digest::MD5;
-use IO::File qw//;
 use File::Basename qw/dirname basename/;
 use File::Path qw/mkpath/;
 use File::Spec;
-use File::Find;
 use Getopt::Long qw/:config gnu_getopt no_ignore_case auto_abbrev/;
-use IPC::Open3;
 use Memoize;
 
 use Git::SVN;
@@ -298,7 +294,6 @@ my %cmd = (
 		{} ],
 );
 
-use Term::ReadLine;
 package FakeTerm;
 sub new {
 	my ($class, $reason) = @_;
@@ -313,6 +308,7 @@ package main;
 my $term;
 sub term_init {
 	$term = eval {
+		require Term::ReadLine;
 		$ENV{"GIT_SVN_NOTTY"}
 			? new Term::ReadLine 'git-svn', \*STDIN, \*STDOUT
 			: new Term::ReadLine 'git-svn';
@@ -1173,6 +1169,7 @@ sub cmd_branch {
 	}
 
 	::_req_svn();
+	require SVN::Client;
 
 	my $ctx = SVN::Client->new(
 		config => SVN::Core::config_get_config(
@@ -1693,11 +1690,13 @@ sub cmd_reset {
 }
 
 sub cmd_gc {
+	require File::Find;
 	if (!can_compress()) {
 		warn "Compress::Zlib could not be found; unhandled.log " .
 		     "files will not be compressed.\n";
 	}
-	find({ wanted => \&gc_directory, no_chdir => 1}, "$ENV{GIT_DIR}/svn");
+	File::Find::find({ wanted => \&gc_directory, no_chdir => 1},
+			 "$ENV{GIT_DIR}/svn");
 }
 
 ########################### utility functions #########################
@@ -2122,6 +2121,7 @@ sub find_file_type_and_diff_status {
 sub md5sum {
 	my $arg = shift;
 	my $ref = ref $arg;
+	require Digest::MD5;
 	my $md5 = Digest::MD5->new();
         if ($ref eq 'GLOB' || $ref eq 'IO::File' || $ref eq 'File::Temp') {
 		$md5->addfile($arg) or croak $!;
@@ -2148,6 +2148,7 @@ sub gc_directory {
 			$gz->gzwrite($str) or
 				die "Unable to write: ".$gz->gzerror()."!\n";
 		}
+		no warnings 'once'; # $File::Find::name would warn
 		unlink $_ or die "unlink $File::Find::name: $!\n";
 	} elsif (-f $_ && basename($_) eq "index") {
 		unlink $_ or die "unlink $_: $!\n";
diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index 8e4af71..afa562c 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -9,10 +9,8 @@ use vars qw/$_no_metadata
 	    $_use_log_author $_add_author_from $_localtime/;
 use Carp qw/croak/;
 use File::Path qw/mkpath/;
-use File::Copy qw/copy/;
 use IPC::Open3;
 use Memoize;  # core since 5.8.0, Jul 2002
-use Memoize::Storable;
 use POSIX qw(:signal_h);
 
 use Git qw(
@@ -32,11 +30,7 @@ use Git::SVN::Utils qw(
 	add_path_to_url
 );
 
-my $can_use_yaml;
-BEGIN {
-	$can_use_yaml = eval { require Git::SVN::Memoize::YAML; 1};
-}
-
+my $memo_backend;
 our $_follow_parent  = 1;
 our $_minimize_url   = 'unset';
 our $default_repo_id = 'svn';
@@ -1578,7 +1572,16 @@ sub tie_for_persistent_memoization {
 	my $hash = shift;
 	my $path = shift;
 
-	if ($can_use_yaml) {
+	unless ($memo_backend) {
+		if (eval { require Git::SVN::Memoize::YAML; 1}) {
+			$memo_backend = 1;
+		} else {
+			require Memoize::Storable;
+			$memo_backend = -1;
+		}
+	}
+
+	if ($memo_backend > 0) {
 		tie %$hash => 'Git::SVN::Memoize::YAML', "$path.yaml";
 	} else {
 		tie %$hash => 'Memoize::Storable', "$path.db", 'nstore';
@@ -2188,8 +2191,9 @@ sub rev_map_set {
 	# both of these options make our .rev_db file very, very important
 	# and we can't afford to lose it because rebuild() won't work
 	if ($self->use_svm_props || $self->no_metadata) {
+		require File::Copy;
 		$sync = 1;
-		copy($db, $db_lock) or die "rev_map_set(@_): ",
+		File::Copy::copy($db, $db_lock) or die "rev_map_set(@_): ",
 					   "Failed to copy: ",
 					   "$db => $db_lock ($!)\n";
 	} else {
diff --git a/perl/Git/SVN/Editor.pm b/perl/Git/SVN/Editor.pm
index 4088f13..c50176e 100644
--- a/perl/Git/SVN/Editor.pm
+++ b/perl/Git/SVN/Editor.pm
@@ -5,7 +5,6 @@ use warnings;
 use SVN::Core;
 use SVN::Delta;
 use Carp qw/croak/;
-use IO::File;
 use Git qw/command command_oneline command_noisy command_output_pipe
            command_input_pipe command_close_pipe
            command_bidi_pipe command_close_bidi_pipe/;
@@ -586,7 +585,7 @@ The interface will change as git-svn evolves.
 =head1 DEPENDENCIES
 
 Subversion perl bindings,
-the core L<Carp> and L<IO::File> modules,
+the core L<Carp> module,
 and git's L<Git> helper module.
 
 C<Git::SVN::Editor> has not been tested using callers other than
diff --git a/perl/Git/SVN/Fetcher.pm b/perl/Git/SVN/Fetcher.pm
index 10edb27..6b9c6e0 100644
--- a/perl/Git/SVN/Fetcher.pm
+++ b/perl/Git/SVN/Fetcher.pm
@@ -7,7 +7,6 @@ use warnings;
 use SVN::Delta;
 use Carp qw/croak/;
 use File::Basename qw/dirname/;
-use IO::File qw//;
 use Git qw/command command_oneline command_noisy command_output_pipe
            command_input_pipe command_close_pipe
            command_bidi_pipe command_close_bidi_pipe/;
@@ -600,7 +599,7 @@ developing git-svn.
 =head1 DEPENDENCIES
 
 L<SVN::Delta> from the Subversion perl bindings,
-the core L<Carp>, L<File::Basename>, and L<IO::File> modules,
+the core L<Carp> and L<File::Basename> modules,
 and git's L<Git> helper module.
 
 C<Git::SVN::Fetcher> has not been tested using callers other than
diff --git a/perl/Git/SVN/Ra.pm b/perl/Git/SVN/Ra.pm
index 622535e..cf36b9d 100644
--- a/perl/Git/SVN/Ra.pm
+++ b/perl/Git/SVN/Ra.pm
@@ -3,7 +3,6 @@ use vars qw/@ISA $config_dir $_ignore_refs_regex $_log_window_size/;
 use strict;
 use warnings;
 use Memoize;
-use SVN::Client;
 use Git::SVN::Utils qw(
 	canonicalize_url
 	canonicalize_path
@@ -42,6 +41,7 @@ END {
 }
 
 sub _auth_providers () {
+	require SVN::Client;
 	my @rv = (
 	  SVN::Client::get_simple_provider(),
 	  SVN::Client::get_ssl_server_trust_file_provider(),
@@ -247,7 +247,10 @@ sub get_log {
 	$ret;
 }
 
+# uncommon, only for ancient SVN (<= 1.4.2)
 sub trees_match {
+	require IO::File;
+	require SVN::Client;
 	my ($self, $url1, $rev1, $url2, $rev2) = @_;
 	my $ctx = SVN::Client->new(auth => _auth_providers);
 	my $out = IO::File->new_tmpfile;
-- 
EW
