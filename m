From: Jari Aalto <jari.aalto@cante.net>
Subject: [PATCH] prune, rm, show remote: exit with error code 1 on failure
Date: Sun, 30 Sep 2007 09:18:48 +0300
Organization: Private
Message-ID: <641soeuv.fsf@blue.sea.net>
References: <ps01nxvd.fsf@blue.sea.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 30 08:14:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ibs4Z-0003Qd-5q
	for gcvg-git-2@gmane.org; Sun, 30 Sep 2007 08:14:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751815AbXI3GO1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2007 02:14:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751735AbXI3GO1
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Sep 2007 02:14:27 -0400
Received: from main.gmane.org ([80.91.229.2]:54746 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751781AbXI3GO0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Sep 2007 02:14:26 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Ibs4M-0000rX-UZ
	for git@vger.kernel.org; Sun, 30 Sep 2007 06:14:22 +0000
Received: from a81-197-175-198.elisa-laajakaista.fi ([81.197.175.198])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 30 Sep 2007 06:14:22 +0000
Received: from jari.aalto by a81-197-175-198.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 30 Sep 2007 06:14:22 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: a81-197-175-198.elisa-laajakaista.fi
User-Agent: Gnus/5.110007 (No Gnus v0.7) Emacs/22.1 (windows-nt)
Cancel-Lock: sha1:gU/cPFb4g3O2PJne/ob3Gv2Lc+o=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59524>

- (rm_remote): Return error code 1 on failure.
- (show_remote): Return error code 1 on failure.
- (prune_remote): Return error code 1 on failure.
- (@ARGV eq show):
  exit in case of 'No such remote'.
- (@ARGV eq prune):
- exitin case of 'No such remote'.
- (@ARGV eq rm):
- exit in case of 'No such remote'.

Signed-off-by: Jari Aalto <jari.aalto AT cante.net>
---
 git-remote.perl |   19 +++++++++++++------
 1 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/git-remote.perl b/git-remote.perl
index b7c1e01..84a9b5c 100755
--- a/git-remote.perl
+++ b/git-remote.perl
@@ -218,7 +218,7 @@ sub prune_remote {
 	my ($name, $ls_remote) = @_;
 	if (!exists $remote->{$name}) {
 		print STDERR "No such remote $name\n";
-		return;
+		return 1;
 	}
 	my $info = $remote->{$name};
 	update_ls_remote($ls_remote, $info);
@@ -235,7 +235,7 @@ sub show_remote {
 	my ($name, $ls_remote) = @_;
 	if (!exists $remote->{$name}) {
 		print STDERR "No such remote $name\n";
-		return;
+		return 1;
 	}
 	my $info = $remote->{$name};
 	update_ls_remote($ls_remote, $info);
@@ -320,7 +320,7 @@ sub rm_remote {
 	my ($name) = @_;
 	if (!exists $remote->{$name}) {
 		print STDERR "No such remote $name\n";
-		return;
+		return 1;
 	}
 
 	$git->command('config', '--remove-section', "remote.$name");
@@ -381,9 +381,12 @@ elsif ($ARGV[0] eq 'show') {
 		print STDERR "Usage: git remote show <remote>\n";
 		exit(1);
 	}
+	my $status = 0;
 	for (; $i < @ARGV; $i++) {
-		show_remote($ARGV[$i], $ls_remote);
+		my $ret = show_remote($ARGV[$i], $ls_remote);
+		$status = $ret if $ret;
 	}
+	exit($status);
 }
 elsif ($ARGV[0] eq 'update') {
 	if (@ARGV <= 1) {
@@ -409,9 +412,12 @@ elsif ($ARGV[0] eq 'prune') {
 		print STDERR "Usage: git remote prune <remote>\n";
 		exit(1);
 	}
+	my $status = 0;
 	for (; $i < @ARGV; $i++) {
-		prune_remote($ARGV[$i], $ls_remote);
+		my $ret = prune_remote($ARGV[$i], $ls_remote);
+                $status = $ret if $ret;
 	}
+        exit($status);
 }
 elsif ($ARGV[0] eq 'add') {
 	my %opts = ();
@@ -455,7 +461,8 @@ elsif ($ARGV[0] eq 'rm') {
 		print STDERR "Usage: git remote rm <remote>\n";
 		exit(1);
 	}
-	rm_remote($ARGV[1]);
+	my $status = rm_remote($ARGV[1]);
+        exit($status) if $status;
 }
 else {
 	print STDERR "Usage: git remote\n";
-- 
1.5.3.2.81.g17ed
