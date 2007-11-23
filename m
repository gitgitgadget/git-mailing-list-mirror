From: Wincent Colaiuta <win@wincent.com>
Subject: [PATCH 6/7] Add "--patch" option to git-add--interactive
Date: Fri, 23 Nov 2007 20:20:49 +0100
Message-ID: <1195845650-85962-7-git-send-email-win@wincent.com>
References: <1195845650-85962-1-git-send-email-win@wincent.com>
 <1195845650-85962-2-git-send-email-win@wincent.com>
 <1195845650-85962-3-git-send-email-win@wincent.com>
 <1195845650-85962-4-git-send-email-win@wincent.com>
 <1195845650-85962-5-git-send-email-win@wincent.com>
 <1195845650-85962-6-git-send-email-win@wincent.com>
Cc: gitster@pobox.com, peff@peff.net,
	Wincent Colaiuta <win@wincent.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 23 20:21:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ive67-00087R-R5
	for gcvg-git-2@gmane.org; Fri, 23 Nov 2007 20:21:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755980AbXKWTVU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2007 14:21:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755938AbXKWTVU
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Nov 2007 14:21:20 -0500
Received: from wincent.com ([72.3.236.74]:60676 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755935AbXKWTVT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2007 14:21:19 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lANJKom3018032;
	Fri, 23 Nov 2007 13:21:01 -0600
X-Mailer: git-send-email 1.5.3.6.886.g6e20-dirty
In-Reply-To: <1195845650-85962-6-git-send-email-win@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65913>

When the "--patch" option is supplied, the patch_update_file function is
called, once for each supplied pathspec argument, and then we exit.

This commit adds an early return mechanism to the patch_update_pathspec
function to prevent spurious line feeds from being echoed when the user
passes in pathspecs which match unchanged files.

Signed-off-by: Wincent Colaiuta <win@wincent.com>
---
 git-add--interactive.perl |   35 ++++++++++++++++++++++++++++++++---
 1 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 8706528..43a5344 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1,6 +1,10 @@
 #!/usr/bin/perl -w
 
 use strict;
+use Getopt::Long;
+
+# command line options
+my $patch;
 
 sub run_cmd_pipe {
 	if ($^O eq 'MSWin32') {
@@ -335,7 +339,8 @@ sub add_untracked_cmd {
 
 sub parse_diff {
 	my ($path) = @_;
-	my @diff = run_cmd_pipe(qw(git diff-files -p --), $path);
+	my @diff = run_cmd_pipe(qw(git diff-files -p --), $path)
+	    or return undef;
 	my (@hunk) = { TEXT => [] };
 
 	for (@diff) {
@@ -571,6 +576,7 @@ sub patch_update_pathspec {
 	my ($ix, $num);
 	my $path = shift;
 	my ($head, @hunk) = parse_diff($path);
+	return unless $head;
 	for (@{$head->{TEXT}}) {
 		print;
 	}
@@ -781,6 +787,19 @@ sub check_args {
 	    --error-unmatch --with-tree=HEAD --), @ARGV);
 }
 
+sub usage {
+	print <<EOT;
+git-add--interactive [options] [--] [<filepattern>...]
+Options:
+     -p, --patch        Execute the "patch" subcommand and exit
+EOT
+	exit(1);
+}
+
+sub process_options {
+	GetOptions("patch!" => \$patch) or usage();
+}
+
 sub main_loop {
 	my @cmd = ([ 'status', \&status_cmd, ],
 		   [ 'update', \&update_cmd, ],
@@ -809,7 +828,17 @@ sub main_loop {
 	}
 }
 
+process_options();
 refresh();
 check_args();
-status_cmd();
-main_loop();
+if ($patch) {
+	print "No filepattern specified: what did you want to patch?\n"
+	    unless @ARGV;
+	foreach my $pathspec (@ARGV) {
+		patch_update_pathspec($pathspec);
+	}
+}
+else {
+	status_cmd();
+	main_loop();
+}
-- 
1.5.3.6.886.g3364
