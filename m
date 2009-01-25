From: "Vitaly \"_Vi\" Shukela" <public_vi@tut.by>
Subject: [PATCH] git-svn: add --ignore-paths option for fetching
Date: Sun, 25 Jan 2009 08:27:22 +0200
Message-ID: <1232864842-8841-1-git-send-email-public_vi@tut.by>
Cc: "Vitaly \"_Vi\" Shukela" <public_vi@tut.by>
To: git@vger.kernel.org, normalperson@yhbt.net
X-From: git-owner@vger.kernel.org Sun Jan 25 07:44:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQyjb-0004ld-W0
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 07:44:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbZAYGnQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 01:43:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbZAYGnQ
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 01:43:16 -0500
Received: from mail.tut.by ([195.137.160.40]:45328 "EHLO speedy.tutby.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751175AbZAYGnP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 01:43:15 -0500
X-Greylist: delayed 904 seconds by postgrey-1.27 at vger.kernel.org; Sun, 25 Jan 2009 01:43:14 EST
Received: from [93.125.18.207] (account public_vi@tut.by HELO localhost.localdomain)
  by speedy.tutby.com (CommuniGate Pro SMTP 5.1.12)
  with ESMTPSA id 136267448; Sun, 25 Jan 2009 08:28:03 +0200
X-Mailer: git-send-email 1.6.1.224.gb56c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107045>


Signed-off-by: Vitaly "_Vi" Shukela <public_vi@tut.by>
---
 Documentation/git-svn.txt |    4 ++++
 git-svn.perl              |   25 +++++++++++++++++++++++--
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 63d2f5e..4aeb88b 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -96,6 +96,10 @@ COMMANDS
 	Store Git commit times in the local timezone instead of UTC.  This
 	makes 'git-log' (even without --date=local) show the same times
 	that `svn log` would in the local timezone.
+--ignore-paths=<regex>;;
+	This allows one to specify regular expression that will
+	cause skipping of all matching paths from checkout from SVN.
+	Example: --ignore-paths='^doc'
 
 This doesn't interfere with interoperating with the Subversion
 repository you cloned from, but if you wish for your local Git
diff --git a/git-svn.perl b/git-svn.perl
index d4cb538..4909b23 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -70,7 +70,8 @@ my ($_stdin, $_help, $_edit,
 $Git::SVN::_follow_parent = 1;
 my %remote_opts = ( 'username=s' => \$Git::SVN::Prompt::_username,
                     'config-dir=s' => \$Git::SVN::Ra::config_dir,
-                    'no-auth-cache' => \$Git::SVN::Prompt::_no_auth_cache );
+                    'no-auth-cache' => \$Git::SVN::Prompt::_no_auth_cache,
+                    'ignore-paths=s' => \$SVN::Git::Fetcher::ignoreRegex );
 my %fc_opts = ( 'follow-parent|follow!' => \$Git::SVN::_follow_parent,
 		'authors-file|A=s' => \$_authors,
 		'repack:i' => \$Git::SVN::_repack,
@@ -3245,6 +3246,15 @@ use warnings;
 use Carp qw/croak/;
 use File::Temp qw/tempfile/;
 use IO::File qw//;
+use vars qw/ $ignoreRegex/;
+
+# 0 -- don't ignore, 1 -- ignore
+sub isPathIgnored($) {
+    return 0 unless defined($ignoreRegex);
+    my $path = shift;
+    return 1 if $path =~ m!^$ignoreRegex!o;
+    return 0;
+}
 
 # file baton members: path, mode_a, mode_b, pool, fh, blob, base
 sub new {
@@ -3323,6 +3333,7 @@ sub git_path {
 sub delete_entry {
 	my ($self, $path, $rev, $pb) = @_;
 	return undef if in_dot_git($path);
+	return undef if isPathIgnored($path);
 
 	my $gpath = $self->git_path($path);
 	return undef if ($gpath eq '');
@@ -3353,6 +3364,7 @@ sub open_file {
 	my ($mode, $blob);
 
 	goto out if in_dot_git($path);
+	goto out if isPathIgnored($path);
 
 	my $gpath = $self->git_path($path);
 	($mode, $blob) = (command('ls-tree', $self->{c}, '--', $gpath)
@@ -3372,11 +3384,14 @@ sub add_file {
 	my ($self, $path, $pb, $cp_path, $cp_rev) = @_;
 	my $mode;
 
+	goto out if isPathIgnored($path);
+
 	if (!in_dot_git($path)) {
 		my ($dir, $file) = ($path =~ m#^(.*?)/?([^/]+)$#);
 		delete $self->{empty}->{$dir};
 		$mode = '100644';
 	}
+out:
 	{ path => $path, mode_a => $mode, mode_b => $mode,
 	  pool => SVN::Pool->new, action => 'A' };
 }
@@ -3384,6 +3399,7 @@ sub add_file {
 sub add_directory {
 	my ($self, $path, $cp_path, $cp_rev) = @_;
 	goto out if in_dot_git($path);
+	goto out if isPathIgnored($path);
 	my $gpath = $self->git_path($path);
 	if ($gpath eq '') {
 		my ($ls, $ctx) = command_output_pipe(qw/ls-tree
@@ -3408,6 +3424,7 @@ out:
 sub change_dir_prop {
 	my ($self, $db, $prop, $value) = @_;
 	return undef if in_dot_git($db->{path});
+	return undef if isPathIgnored($db->{path});
 	$self->{dir_prop}->{$db->{path}} ||= {};
 	$self->{dir_prop}->{$db->{path}}->{$prop} = $value;
 	undef;
@@ -3416,6 +3433,7 @@ sub change_dir_prop {
 sub absent_directory {
 	my ($self, $path, $pb) = @_;
 	return undef if in_dot_git($pb->{path});
+	return undef if isPathIgnored($path);
 	$self->{absent_dir}->{$pb->{path}} ||= [];
 	push @{$self->{absent_dir}->{$pb->{path}}}, $path;
 	undef;
@@ -3424,6 +3442,7 @@ sub absent_directory {
 sub absent_file {
 	my ($self, $path, $pb) = @_;
 	return undef if in_dot_git($pb->{path});
+	return undef if isPathIgnored($path);
 	$self->{absent_file}->{$pb->{path}} ||= [];
 	push @{$self->{absent_file}->{$pb->{path}}}, $path;
 	undef;
@@ -3432,6 +3451,7 @@ sub absent_file {
 sub change_file_prop {
 	my ($self, $fb, $prop, $value) = @_;
 	return undef if in_dot_git($fb->{path});
+	return undef if isPathIgnored($fb->{path});
 	if ($prop eq 'svn:executable') {
 		if ($fb->{mode_b} != 120000) {
 			$fb->{mode_b} = defined $value ? 100755 : 100644;
@@ -3448,6 +3468,7 @@ sub change_file_prop {
 sub apply_textdelta {
 	my ($self, $fb, $exp) = @_;
 	return undef if (in_dot_git($fb->{path}));
+	return undef if isPathIgnored($fb->{path});
 	my $fh = $::_repository->temp_acquire('svn_delta');
 	# $fh gets auto-closed() by SVN::TxDelta::apply(),
 	# (but $base does not,) so dup() it for reading in close_file
@@ -3495,7 +3516,7 @@ sub apply_textdelta {
 sub close_file {
 	my ($self, $fb, $exp) = @_;
 	return undef if (in_dot_git($fb->{path}));
-
+	return undef if isPathIgnored($fb->{path});
 	my $hash;
 	my $path = $self->git_path($fb->{path});
 	if (my $fh = $fb->{fh}) {
-- 
1.5.6.5
