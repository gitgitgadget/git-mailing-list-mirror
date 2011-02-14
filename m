From: Masatake Osanai <unpush@gmail.com>
Subject: [PATCH v2] perl: command_bidi_pipe() should be set-up git environments
Date: Tue, 15 Feb 2011 07:13:04 +0900
Message-ID: <1297721584-20572-1-git-send-email-unpush@gmail.com>
References: <7v7hd8q5zi.fsf@alter.siamese.dyndns.org>
Cc: git@vger.kernel.org, Masatake Osanai <unpush@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 14 23:15:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp6hP-0007C7-Jb
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 23:15:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201Ab1BNWPK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 17:15:10 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:53235 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750864Ab1BNWPI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Feb 2011 17:15:08 -0500
Received: by gyb11 with SMTP id 11so2286765gyb.19
        for <git@vger.kernel.org>; Mon, 14 Feb 2011 14:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=zhlVTAWKDwPj1wo4yncuZ+1oMBLyGdmuEliMIAhJ02w=;
        b=rict6RVpGP+b+7xRe4CklM1CZGA0TaoCuC/bEPrf3/CSfxfF1Ylxi/VlsauB6eOn5E
         AM5DjUIvQwAEMarL0MkZWU4JompJIiBXaMlIk8JFX/HrXMC5caRyh++l7zx7k73gxIp8
         ITQGnMUBezXRM6wQkwkXFtlZ++Y4PK8vH6gx4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=pqsingFWSk/AjRWllkGZuCB95UAscszpqCjuEHIiNb2Xi1s7NaePHCphL8CT/eStTN
         b49ovFqi8RiAwHp4P1L3q0UCD5iSDPPDAJHU713XF+rLE2cKKY7dOSkE29kQZjWqdRgl
         0CVE6Ymfa2TFnQZ9nCHpfVyLUy9f1ocuPzQc8=
Received: by 10.90.7.9 with SMTP id 9mr3726020agg.109.1297721706727;
        Mon, 14 Feb 2011 14:15:06 -0800 (PST)
Received: from localhost.localdomain (ns.unpush.net [202.171.147.44])
        by mx.google.com with ESMTPS id b11sm4074095ana.38.2011.02.14.14.15.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 14 Feb 2011 14:15:06 -0800 (PST)
X-Mailer: git-send-email 1.7.4
In-Reply-To: <7v7hd8q5zi.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166783>

When command_input_pipe and command_output_pipe are used as a
method of a Git::repository instance, they eventually call into
_cmd_exec method that sets up the execution environment such as
GIT_DIR, GIT_WORK_TREE environment variables and the current
working directory in the child process that interacts with the
repository.

command_bidi_pipe however didn't expect to be called as such, and
lacked all these set-up.  Because of this, a program that did this
did not work as expected:

    my $repo = Git->repository(Directory => '/some/where/else');
    my ($pid, $in, $out, $ctx) =
    $repo->command_bidi_pipe(qw(hash-object -w --stdin-paths));

This patch refactors the _cmd_exec into _setup_git_cmd_env that
sets up the execution environment, and makes _cmd_exec and
command_bidi_pipe to use it.

Note that unlike _cmd_exec that execv's a git command as an
external process, command_bidi_pipe is called from the main line
of control, and the execution environment needs to be restored
after open2() does its magic.

Signed-off-by: Masatake Osanai <unpush@gmail.com>
---

On Wed, Feb 09, 2011 at 12:59:29PM -0800, Junio C Hamano wrote:

> Nit; s/my/my /.

Oops, It was careless.

> The POD description for this function says that it runs the same way as
> command_output_pipe, which in turn uses _command_common_pipe that is
> shared with command_input_pipe.  The reason these two other functions are
> Ok without this patch is because _cmd_exec() has the logic to do the repo
> dependent set-up, as far as I can tell.  But command_bidi_pipe() does not
> use _cmd_exec(), and does not have a corresponding logic, and that is what
> you are trying to fix.
> 
> Am I following your logic Ok so far?

You're absolutely correct. That's what I meant.

> It would have saved reviewers' time if you explained your patch a bit
> better, perhaps like...

I'm sorry for lack of my explanation.
Thank you for your help and the lead.

Description of patch v2 is use entirely of your example because it is
so perfect.  Does this way have the problem?

 perl/Git.pm     |   25 ++++++++++++++++++++-----
 t/t9700/test.pl |   10 ++++++++++
 2 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 205e48a..a86ab70 100644
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
+	my ($self) = _maybe_self(@_);
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
