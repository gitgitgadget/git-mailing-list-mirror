From: "Vitaly \"_Vi\" Shukela" <public_vi@tut.by>
Subject: [PATCH] git-svn: add --ignore-paths option for fetching
Date: Mon, 26 Jan 2009 00:21:40 +0200
Message-ID: <1232922102-6144-1-git-send-email-public_vi@tut.by>
Cc: "Vitaly \"_Vi\" Shukela" <public_vi@tut.by>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 25 23:26:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRDR4-0003cx-5S
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 23:26:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbZAYWZE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 17:25:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750775AbZAYWZD
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 17:25:03 -0500
Received: from mail.tut.by ([195.137.160.40]:53381 "EHLO speedy.tutby.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750747AbZAYWZB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 17:25:01 -0500
Received: from [91.149.148.191] (account public_vi@tut.by HELO localhost.localdomain)
  by speedy.tutby.com (CommuniGate Pro SMTP 5.1.12)
  with ESMTPSA id 136627218; Mon, 26 Jan 2009 00:22:15 +0200
X-Mailer: git-send-email 1.6.1.288.gff3b4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107113>

This will be useful when somebody want to checkout something partially from
repository with some non-standart layout or exclude some files from it.
Example: repository has structure /module-{a,b,c}/{trunk,branches,tags}/...
Modules are interdependent, and you want it to be single repostory (to commit
to all modules simultaneously and view complete history), but do not want
branches and tags be checked out into working copy.
Other use case is excluding some large blobs.

The quirk for now is that user must specify this option every fetch/rebase;
in other case he may get extra files or "file not found" errors. It may be
will be resolved by adding regular expression to .git/config into
[svn-remote ...] to make it persistent.

Signed-off-by: Vitaly "_Vi" Shukela <public_vi@tut.by>
---
 git-svn.perl |   43 +++++++++++++++++++++++++++----------------
 1 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index d4cb538..40b0e9e 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -70,7 +70,8 @@ my ($_stdin, $_help, $_edit,
 $Git::SVN::_follow_parent = 1;
 my %remote_opts = ( 'username=s' => \$Git::SVN::Prompt::_username,
                     'config-dir=s' => \$Git::SVN::Ra::config_dir,
-                    'no-auth-cache' => \$Git::SVN::Prompt::_no_auth_cache );
+                    'no-auth-cache' => \$Git::SVN::Prompt::_no_auth_cache,
+                    'ignore-paths=s' => \$SVN::Git::Fetcher::ignore_regex );
 my %fc_opts = ( 'follow-parent|follow!' => \$Git::SVN::_follow_parent,
 		'authors-file|A=s' => \$_authors,
 		'repack:i' => \$Git::SVN::_repack,
@@ -3245,6 +3246,21 @@ use warnings;
 use Carp qw/croak/;
 use File::Temp qw/tempfile/;
 use IO::File qw//;
+use vars qw/ $ignore_regex/;
+
+# returns true if a given path is inside a ".git" directory
+sub in_dot_git($) {
+	$_[0] =~ m{(?:^|/)\.git(?:/|$)};
+}
+
+# 0 -- don't ignore, 1 -- ignore
+sub is_path_ignored($) {
+    my ($path) = @_;
+    return 1 if in_dot_git($path);
+    return 0 unless defined($ignore_regex);
+    return 1 if $path =~ m!$ignore_regex!o;
+    return 0;
+}
 
 # file baton members: path, mode_a, mode_b, pool, fh, blob, base
 sub new {
@@ -3292,11 +3308,6 @@ sub _mark_empty_symlinks {
 	\%ret;
 }
 
-# returns true if a given path is inside a ".git" directory
-sub in_dot_git {
-	$_[0] =~ m{(?:^|/)\.git(?:/|$)};
-}
-
 sub set_path_strip {
 	my ($self, $path) = @_;
 	$self->{path_strip} = qr/^\Q$path\E(\/|$)/ if length $path;
@@ -3322,7 +3333,7 @@ sub git_path {
 
 sub delete_entry {
 	my ($self, $path, $rev, $pb) = @_;
-	return undef if in_dot_git($path);
+	return undef if is_path_ignored($path);
 
 	my $gpath = $self->git_path($path);
 	return undef if ($gpath eq '');
@@ -3352,7 +3363,7 @@ sub open_file {
 	my ($self, $path, $pb, $rev) = @_;
 	my ($mode, $blob);
 
-	goto out if in_dot_git($path);
+	goto out if is_path_ignored($path);
 
 	my $gpath = $self->git_path($path);
 	($mode, $blob) = (command('ls-tree', $self->{c}, '--', $gpath)
@@ -3372,7 +3383,7 @@ sub add_file {
 	my ($self, $path, $pb, $cp_path, $cp_rev) = @_;
 	my $mode;
 
-	if (!in_dot_git($path)) {
+	if (!is_path_ignored($path)) {
 		my ($dir, $file) = ($path =~ m#^(.*?)/?([^/]+)$#);
 		delete $self->{empty}->{$dir};
 		$mode = '100644';
@@ -3383,7 +3394,7 @@ sub add_file {
 
 sub add_directory {
 	my ($self, $path, $cp_path, $cp_rev) = @_;
-	goto out if in_dot_git($path);
+	goto out if is_path_ignored($path);
 	my $gpath = $self->git_path($path);
 	if ($gpath eq '') {
 		my ($ls, $ctx) = command_output_pipe(qw/ls-tree
@@ -3407,7 +3418,7 @@ out:
 
 sub change_dir_prop {
 	my ($self, $db, $prop, $value) = @_;
-	return undef if in_dot_git($db->{path});
+	return undef if is_path_ignored($db->{path});
 	$self->{dir_prop}->{$db->{path}} ||= {};
 	$self->{dir_prop}->{$db->{path}}->{$prop} = $value;
 	undef;
@@ -3415,7 +3426,7 @@ sub change_dir_prop {
 
 sub absent_directory {
 	my ($self, $path, $pb) = @_;
-	return undef if in_dot_git($pb->{path});
+	return undef if is_path_ignored($path);
 	$self->{absent_dir}->{$pb->{path}} ||= [];
 	push @{$self->{absent_dir}->{$pb->{path}}}, $path;
 	undef;
@@ -3423,7 +3434,7 @@ sub absent_directory {
 
 sub absent_file {
 	my ($self, $path, $pb) = @_;
-	return undef if in_dot_git($pb->{path});
+	return undef if is_path_ignored($path);
 	$self->{absent_file}->{$pb->{path}} ||= [];
 	push @{$self->{absent_file}->{$pb->{path}}}, $path;
 	undef;
@@ -3431,7 +3442,7 @@ sub absent_file {
 
 sub change_file_prop {
 	my ($self, $fb, $prop, $value) = @_;
-	return undef if in_dot_git($fb->{path});
+	return undef if is_path_ignored($fb->{path});
 	if ($prop eq 'svn:executable') {
 		if ($fb->{mode_b} != 120000) {
 			$fb->{mode_b} = defined $value ? 100755 : 100644;
@@ -3447,7 +3458,7 @@ sub change_file_prop {
 
 sub apply_textdelta {
 	my ($self, $fb, $exp) = @_;
-	return undef if (in_dot_git($fb->{path}));
+	return undef if is_path_ignored($fb->{path});
 	my $fh = $::_repository->temp_acquire('svn_delta');
 	# $fh gets auto-closed() by SVN::TxDelta::apply(),
 	# (but $base does not,) so dup() it for reading in close_file
@@ -3494,7 +3505,7 @@ sub apply_textdelta {
 
 sub close_file {
 	my ($self, $fb, $exp) = @_;
-	return undef if (in_dot_git($fb->{path}));
+	return undef if is_path_ignored($fb->{path});
 
 	my $hash;
 	my $path = $self->git_path($fb->{path});
-- 
1.5.6.5
