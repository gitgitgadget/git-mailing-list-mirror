From: "Vitaly \"_Vi\" Shukela" <public_vi@tut.by>
Subject: [PATCH 1/3] git-svn: add --ignore-paths option for fetching
Date: Sun, 25 Jan 2009 21:49:02 +0200
Message-ID: <1232912944-27076-1-git-send-email-public_vi@tut.by>
Cc: git@vger.kernel.org, "Vitaly \"_Vi\" Shukela" <public_vi@tut.by>
To: trast@student.ethz.ch
X-From: git-owner@vger.kernel.org Sun Jan 25 20:51:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRB0r-0008Lv-Dg
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 20:51:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751017AbZAYTtu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 14:49:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750954AbZAYTtt
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 14:49:49 -0500
Received: from mail.tut.by ([195.137.160.40]:48493 "EHLO speedy.tutby.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750872AbZAYTts (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 14:49:48 -0500
Received: from [93.125.21.130] (account public_vi@tut.by HELO localhost.localdomain)
  by speedy.tutby.com (CommuniGate Pro SMTP 5.1.12)
  with ESMTPSA id 136551189; Sun, 25 Jan 2009 21:49:36 +0200
X-Mailer: git-send-email 1.6.1.288.gff3b4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107088>


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
1.6.1.288.gff3b4
