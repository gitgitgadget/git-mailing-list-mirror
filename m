From: Quy Tonthat <qtonthat@gmail.com>
Subject: [PATCH] git-remote exclude
Date: Mon, 15 Jan 2007 01:57:26 +1100
Message-ID: <45AA44D6.6080605@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Jan 15 19:13:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@m.gmane.org
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6Vbs-0003F9-RF
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 18:27:04 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1H6V7U-0003eK-SY
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 17:55:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751025AbXANO5d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 Jan 2007 09:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751059AbXANO5d
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Jan 2007 09:57:33 -0500
Received: from pecan-mail.exetel.com.au ([220.233.0.8]:54042 "EHLO
	pecan.exetel.com.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751052AbXANO5c (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jan 2007 09:57:32 -0500
Received: from [220.233.69.95] (helo=[192.168.64.35])
	by pecan.exetel.com.au with esmtp (Exim 4.63)
	(envelope-from <qtonthat@gmail.com>)
	id 1H66nX-0006LT-Gq
	for git@vger.kernel.org; Mon, 15 Jan 2007 01:57:28 +1100
User-Agent: Thunderbird 1.5.0.9 (X11/20070102)
To: git@vger.kernel.org
X-Enigmail-Version: 0.94.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36818>

"git-remote exclude" can be used to prevent one or more unwanted remote branches
from being tracked. After, for example,
    $ git-remote origin exclude man html
"git-fetch origin" will no longer fetch origin/man and origin/html.

"git-remote exclude" does not check whether the "unwanted" branch
really exists on the remote repo.

Signed-off-by: Quy Tonthat <qtonthat@gmail.com>
---
 git-remote.perl |   51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/git-remote.perl b/git-remote.perl
index fc055b6..8ee1bea 100755
--- a/git-remote.perl
+++ b/git-remote.perl
@@ -243,6 +243,47 @@ sub add_remote {
 		      "+refs/heads/*:refs/remotes/$name/*");
 }
 
+sub exclude_remote_branch {
+	my ($name, @branches) = @_;
+	if (!exists $remote->{$name}) {
+		print STDERR "remote $name does not exists.\n";
+		exit(1);
+	}
+
+	my $wildcard = "";
+	my %fetch_entries = ();
+	my @fetches = $git->command(qw(repo-config --get-all), "remote.$name.fetch");
+	foreach $fetch (@fetches) {
+		if ($fetch =~ m%^\+?refs/heads/\*:refs/remotes/$name/\*$%) {
+			$wildcard = $fetch;
+		}
+		else {
+			foreach $br (@branches) {
+				if ($fetch =~ m#^refs/heads/$br:.*$#) {
+					$fetch_entries{$br} = $fetch;
+				}
+			}
+		}
+	}
+
+	if (!$wildcard) {
+		print STDERR "No wildcard entry for $name. Config not changed\n";
+		exit(1);
+	}
+	my $clean;
+       	($clean = $wildcard) =~ s/([+*])/\\$1/g;
+	$git->command(qw(repo-config --unset), "remote.$name.fetch", $clean);
+	foreach $key (keys %fetch_entries) {
+		$git->command(qw(repo-config --unset), "remote.$name.fetch",
+				$fetch_entries{$key});
+	}
+	foreach $br (@branches) {
+		$git->command(qw(repo-config --add), "remote.$name.fetch",
+			"refs/heads/$br:");
+	}
+	$git->command(qw(repo-config --add), "remote.$name.fetch", $wildcard);
+}
+
 if (!@ARGV) {
 	for (sort keys %$remote) {
 		print "$_\n";
@@ -274,9 +315,19 @@ elsif ($ARGV[0] eq 'add') {
 	}
 	add_remote($ARGV[1], $ARGV[2]);
 }
+elsif ($ARGV[0] eq 'exclude') {
+	if (@ARGV < 3) {
+		print STDERR "Usage: git remote exclude <name> <branch>...\n";
+		exit(1);
+	}
+	my @branches = @ARGV;
+	shift(@branches); shift(@branches);
+	exclude_remote_branch($ARGV[1], @branches);
+}
 else {
 	print STDERR "Usage: git remote\n";
 	print STDERR "       git remote add <name> <url>\n";
+	print STDERR "       git remote exclude <name> <branch>...\n";
 	print STDERR "       git remote show <name>\n";
 	exit(1);
 }
