From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] cvsimport: miscellaneous packed-ref fixes
Date: Wed, 28 Nov 2007 13:56:28 -0500
Message-ID: <20071128185628.GC11320@coredump.intra.peff.net>
References: <20071128185504.GA11236@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Emanuele Giaquinta <e.giaquinta@glauco.it>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 19:57:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxS5m-0005hf-7B
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 19:57:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755027AbXK1S4b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 13:56:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754979AbXK1S4b
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 13:56:31 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3346 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751012AbXK1S4b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 13:56:31 -0500
Received: (qmail 13223 invoked by uid 111); 28 Nov 2007 18:56:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 28 Nov 2007 13:56:30 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Nov 2007 13:56:28 -0500
Content-Disposition: inline
In-Reply-To: <20071128185504.GA11236@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66409>

These were found with a grep for '$git_dir'; they all
replace a direct access of "$git_dir/refs/..." with a call
to git-show-ref or git-update-ref.

Signed-off-by: Jeff King <peff@peff.net>
---
 git-cvsimport.perl |   20 +++++++++-----------
 1 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index b852f2f..1b5f187 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -864,29 +864,27 @@ while (<CVS>) {
 				print STDERR "Branch $branch erroneously stems from itself -- changed ancestor to $opt_o\n";
 				$ancestor = $opt_o;
 			}
-			if (-f "$git_dir/$remote/$branch") {
+			if (defined get_headref("$remote/$branch")) {
 				print STDERR "Branch $branch already exists!\n";
 				$state=11;
 				next;
 			}
-			unless (open(H,"$git_dir/$remote/$ancestor")) {
+			my $id = get_headref("$remote/$ancestor");
+			if (!$id) {
 				print STDERR "Branch $ancestor does not exist!\n";
 				$ignorebranch{$branch} = 1;
 				$state=11;
 				next;
 			}
-			chomp(my $id = <H>);
-			close(H);
-			unless (open(H,"> $git_dir/$remote/$branch")) {
-				print STDERR "Could not create branch $branch: $!\n";
+
+			system(qw(git update-ref -m cvsimport),
+				"$remote/$branch", $id);
+			if($? != 0) {
+				print STDERR "Could not create branch $branch\n";
 				$ignorebranch{$branch} = 1;
 				$state=11;
 				next;
 			}
-			print H "$id\n"
-				or die "Could not write branch $branch: $!";
-			close(H)
-				or die "Could not write branch $branch: $!";
 		}
 		$last_branch = $branch if $branch ne $last_branch;
 		$state = 9;
@@ -998,7 +996,7 @@ if ($orig_branch) {
 	$orig_branch = "master";
 	print "DONE; creating $orig_branch branch\n" if $opt_v;
 	system("git-update-ref", "refs/heads/master", "$remote/$opt_o")
-		unless -f "$git_dir/refs/heads/master";
+		defined get_headref('refs/heads/master');
 	system("git-symbolic-ref", "$remote/HEAD", "$remote/$opt_o")
 		if ($opt_r && $opt_o ne 'HEAD');
 	system('git-update-ref', 'HEAD', "$orig_branch");
-- 
1.5.3.6.2039.g0495
