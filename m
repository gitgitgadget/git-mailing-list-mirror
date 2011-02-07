From: Masatake Osanai <unpush@gmail.com>
Subject: [PATCH] perl: Fix command_bidi_pipe() don't care about repository path
Date: Tue,  8 Feb 2011 00:09:20 +0900
Message-ID: <1297091360-11409-1-git-send-email-unpush@gmail.com>
Cc: Masatake Osanai <unpush@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Feb 07 16:11:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmSkW-0006w9-DO
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 16:11:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753806Ab1BGPLK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Feb 2011 10:11:10 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:64301 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753788Ab1BGPLH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Feb 2011 10:11:07 -0500
Received: by qyj19 with SMTP id 19so1629752qyj.19
        for <git@vger.kernel.org>; Mon, 07 Feb 2011 07:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=xpiHggVwzxsCMFmapR+K3alC6CGjbaIe67BDdatPMDA=;
        b=VXqyTdAiWwR0XMPo3THUasFRIRTzBUT8llA2GLpMhgJNRVoKaMf/edriWfkGTjm08L
         MbVZMWLJkOX7x43dZKwInS7K/QL6jLoeXftXJGv3w/M3EVCdldgoY3ycpjifpu6/vdFE
         5LnaKz1v622BarfU8zbLhTk972BZmI1UVnPV4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=BmEKl+lCD+xiyN82IGifnd3wM0wu7GTBtZUokxf3mNI5eIGem/o9NW2P3ccKtx63rw
         H7ZQSErs3hFftukh49nnwkb53I62MJOzzWS7bBt4lZIXlar2khAMhOzVr5Dpz8crpNzB
         8Ajq2SKxIJH7V2Y8+G0MCyTztwPlvHcqkncsc=
Received: by 10.224.90.20 with SMTP id g20mr14182425qam.276.1297091466523;
        Mon, 07 Feb 2011 07:11:06 -0800 (PST)
Received: from localhost.localdomain (ns.unpush.net [202.171.147.44])
        by mx.google.com with ESMTPS id g32sm2909646qck.34.2011.02.07.07.11.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 07 Feb 2011 07:11:06 -0800 (PST)
X-Mailer: git-send-email 1.7.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166265>

command_bidi_pipe must care about repo_path() in case of repository
instance.
This also fixes error on cat_blob() and hash_and_insert_object()
in case of using outside of working tree.

Signed-off-by: Masatake Osanai <unpush@gmail.com>
---
 perl/Git.pm     |   25 ++++++++++++++++++++-----
 t/t9700/test.pl |   10 ++++++++++
 2 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 205e48a..7b2aa46 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -99,7 +99,7 @@ increase notwithstanding).
 
 use Carp qw(carp croak); # but croak is bad - throw instead
 use Error qw(:try);
-use Cwd qw(abs_path);
+use Cwd qw(abs_path cwd);
 use IPC::Open2 qw(open2);
 use Fcntl qw(SEEK_SET SEEK_CUR);
 }
@@ -396,7 +396,16 @@ See C<command_close_bidi_pipe()> for details.
 
 sub command_bidi_pipe {
 	my ($pid, $in, $out);
+	my($self) = _maybe_self(@_);
+	local %ENV = %ENV;
+	my $cwd_save = undef;
+	if ($self) {
+		shift;
+		$cwd_save = cwd();
+		_setup_git_cmd_env($self);
+	}
 	$pid = open2($in, $out, 'git', @_);
+	chdir($cwd_save) if $cwd_save;
 	return ($pid, $in, $out, join(' ', @_));
 }
 
@@ -843,7 +852,7 @@ sub _open_hash_and_insert_object_if_needed {
 
 	($self->{hash_object_pid}, $self->{hash_object_in},
 	 $self->{hash_object_out}, $self->{hash_object_ctx}) =
-		command_bidi_pipe(qw(hash-object -w --stdin-paths --no-filters));
+		$self->command_bidi_pipe(qw(hash-object -w --stdin-paths --no-filters));
 }
 
 sub _close_hash_and_insert_object {
@@ -932,7 +941,7 @@ sub _open_cat_blob_if_needed {
 
 	($self->{cat_blob_pid}, $self->{cat_blob_in},
 	 $self->{cat_blob_out}, $self->{cat_blob_ctx}) =
-		command_bidi_pipe(qw(cat-file --batch));
+		$self->command_bidi_pipe(qw(cat-file --batch));
 }
 
 sub _close_cat_blob {
@@ -1279,6 +1288,14 @@ sub _command_common_pipe {
 # for the given repository and execute the git command.
 sub _cmd_exec {
 	my ($self, @args) = @_;
+	_setup_git_cmd_env($self);
+	_execv_git_cmd(@args);
+	die qq[exec "@args" failed: $!];
+}
+
+# set up the appropriate state for git command
+sub _setup_git_cmd_env {
+	my $self = shift;
 	if ($self) {
 		$self->repo_path() and $ENV{'GIT_DIR'} = $self->repo_path();
 		$self->repo_path() and $self->wc_path()
@@ -1286,8 +1303,6 @@ sub _cmd_exec {
 		$self->wc_path() and chdir($self->wc_path());
 		$self->wc_subdir() and chdir($self->wc_subdir());
 	}
-	_execv_git_cmd(@args);
-	die qq[exec "@args" failed: $!];
 }
 
 # Execute the given Git command ($_[0]) with arguments ($_[1..])
diff --git a/t/t9700/test.pl b/t/t9700/test.pl
index c15ca2d..13ba96e 100755
--- a/t/t9700/test.pl
+++ b/t/t9700/test.pl
@@ -113,6 +113,16 @@ like($last_commit, qr/^[0-9a-fA-F]{40}$/, 'rev-parse returned hash');
 my $dir_commit = $r2->command_oneline('log', '-n1', '--pretty=format:%H', '.');
 isnt($last_commit, $dir_commit, 'log . does not show last commit');
 
+# commands outside working tree
+chdir($abs_repo_dir . '/..');
+my $r3 = Git->repository(Directory => $abs_repo_dir);
+my $tmpfile3 = "$abs_repo_dir/file3.tmp";
+open TEMPFILE3, "+>$tmpfile3" or die "Can't open $tmpfile3: $!";
+is($r3->cat_blob($file1hash, \*TEMPFILE3), 15, "cat_blob(outside): size");
+close TEMPFILE3;
+unlink $tmpfile3;
+chdir($abs_repo_dir);
+
 printf "1..%d\n", Test::More->builder->current_test;
 
 my $is_passing = eval { Test::More->is_passing };
-- 
1.7.4
