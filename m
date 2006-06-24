From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH 12/12] Convert git-mv to use Git.pm
Date: Sat, 24 Jun 2006 04:34:53 +0200
Message-ID: <20060624023453.32751.73126.stgit@machine.or.cz>
References: <20060624023429.32751.80619.stgit@machine.or.cz>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 24 04:35:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ftxzm-0006kM-GD
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 04:35:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933203AbWFXCff (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Jun 2006 22:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933195AbWFXCfe
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jun 2006 22:35:34 -0400
Received: from w241.dkm.cz ([62.24.88.241]:65175 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S933196AbWFXCfd (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Jun 2006 22:35:33 -0400
Received: (qmail 396 invoked from network); 24 Jun 2006 04:34:53 +0200
Received: from localhost (HELO machine.or.cz) (xpasky@127.0.0.1)
  by localhost with SMTP; 24 Jun 2006 04:34:53 +0200
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <20060624023429.32751.80619.stgit@machine.or.cz>
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22477>

Fairly straightforward.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 git-mv.perl |   46 ++++++++++++++++++++++------------------------
 1 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/git-mv.perl b/git-mv.perl
index 75aa8fe..b9e3537 100755
--- a/git-mv.perl
+++ b/git-mv.perl
@@ -10,6 +10,8 @@ # at the discretion of Linus Torvalds.
 use warnings;
 use strict;
 use Getopt::Std;
+use Git;
+use Error qw(:try);
 
 sub usage() {
 	print <<EOT;
@@ -24,9 +26,7 @@ getopts("hnfkv") || usage;
 usage() if $opt_h;
 @ARGV >= 1 or usage;
 
-my $GIT_DIR = `git rev-parse --git-dir`;
-exit 1 if $?; # rev-parse would have given "not a git dir" message.
-chomp($GIT_DIR);
+my $repo = Git->repository();
 
 my (@srcArgs, @dstArgs, @srcs, @dsts);
 my ($src, $dst, $base, $dstDir);
@@ -62,11 +62,11 @@ else {
     $dstDir = "";
 }
 
-my $subdir_prefix = `git rev-parse --show-prefix`;
-chomp($subdir_prefix);
+my $subdir_prefix = $repo->wc_subdir();
 
 # run in git base directory, so that git-ls-files lists all revisioned files
-chdir "$GIT_DIR/..";
+chdir $repo->wc_path();
+$repo->wc_chdir('');
 
 # normalize paths, needed to compare against versioned files and update-index
 # also, this is nicer to end-users by doing ".//a/./b/.//./c" ==> "a/b/c"
@@ -84,12 +84,10 @@ my (@allfiles,@srcfiles,@dstfiles);
 my $safesrc;
 my (%overwritten, %srcForDst);
 
-$/ = "\0";
-open(F, 'git-ls-files -z |')
-        or die "Failed to open pipe from git-ls-files: " . $!;
-
-@allfiles = map { chomp; $_; } <F>;
-close(F);
+{
+	local $/ = "\0";
+	@allfiles = $repo->command('ls-files', '-z');
+}
 
 
 my ($i, $bad);
@@ -219,28 +217,28 @@ if ($opt_n) {
 }
 else {
     if (@changedfiles) {
-	open(H, "| git-update-index -z --stdin")
-		or die "git-update-index failed to update changed files with code $!\n";
+	my ($fd, $ctx) = $repo->command_input_pipe('update-index', '-z', '--stdin');
 	foreach my $fileName (@changedfiles) {
-		print H "$fileName\0";
+		print $fd "$fileName\0";
 	}
-	close(H);
+	git_cmd_try { $repo->command_close_pipe($fd, $ctx); }
+		'git-update-index failed to update changed files with code %d';
     }
     if (@addedfiles) {
-	open(H, "| git-update-index --add -z --stdin")
-		or die "git-update-index failed to add new names with code $!\n";
+	my ($fd, $ctx) = $repo->command_input_pipe('update-index', '--add', '-z', '--stdin');
 	foreach my $fileName (@addedfiles) {
-		print H "$fileName\0";
+		print $fd "$fileName\0";
 	}
-	close(H);
+	git_cmd_try { $repo->command_close_pipe($fd, $ctx); }
+		'git-update-index failed to add new files with code %d';
     }
     if (@deletedfiles) {
-	open(H, "| git-update-index --remove -z --stdin")
-		or die "git-update-index failed to remove old names with code $!\n";
+	my ($fd, $ctx) = $repo->command_input_pipe('update-index', '--remove', '-z', '--stdin');
 	foreach my $fileName (@deletedfiles) {
-		print H "$fileName\0";
+		print $fd "$fileName\0";
 	}
-	close(H);
+	git_cmd_try { $repo->command_close_pipe($fd, $ctx); }
+		'git-update-index failed to remove old files with code %d';
     }
 }
 
