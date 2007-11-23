From: Wincent Colaiuta <win@wincent.com>
Subject: [PATCH 3/7] Add path-limiting to git-add--interactive
Date: Fri, 23 Nov 2007 20:20:46 +0100
Message-ID: <1195845650-85962-4-git-send-email-win@wincent.com>
References: <1195845650-85962-1-git-send-email-win@wincent.com>
 <1195845650-85962-2-git-send-email-win@wincent.com>
 <1195845650-85962-3-git-send-email-win@wincent.com>
Cc: gitster@pobox.com, peff@peff.net,
	Wincent Colaiuta <win@wincent.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 23 20:21:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ive5k-0007yW-DR
	for gcvg-git-2@gmane.org; Fri, 23 Nov 2007 20:21:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755797AbXKWTVQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2007 14:21:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755868AbXKWTVQ
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Nov 2007 14:21:16 -0500
Received: from wincent.com ([72.3.236.74]:60675 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755797AbXKWTVP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2007 14:21:15 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lANJKom0018032;
	Fri, 23 Nov 2007 13:20:56 -0600
X-Mailer: git-send-email 1.5.3.6.886.g6e20-dirty
In-Reply-To: <1195845650-85962-3-git-send-email-win@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65911>

Implement Junio's suggestion that git-add--interactive should reproduce the
path-limiting semantics of non-interactive git-add.

In otherwords, if "git add -i" (unrestricted) shows paths from a set A,
"git add -i paths..." should show paths from a subset of the set A and that
subset should be defined with the existing ls-files pathspec semantics.

Signed-off-by: Wincent Colaiuta <win@wincent.com>
---
 git-add--interactive.perl |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 81575e5..5fc48a5 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -37,7 +37,7 @@ sub list_untracked {
 		chomp $_;
 		$_;
 	}
-	run_cmd_pipe(qw(git ls-files --others --exclude-standard --), @_);
+	run_cmd_pipe(qw(git ls-files --others --exclude-standard --), @ARGV);
 }
 
 my $status_fmt = '%12s %12s %s';
@@ -58,7 +58,7 @@ sub list_modified {
 	my ($add, $del, $adddel, $file);
 
 	for (run_cmd_pipe(qw(git diff-index --cached
-			     --numstat --summary HEAD))) {
+			     --numstat --summary HEAD --), @ARGV)) {
 		if (($add, $del, $file) =
 		    /^([-\d]+)	([-\d]+)	(.*)/) {
 			my ($change, $bin);
@@ -81,7 +81,7 @@ sub list_modified {
 		}
 	}
 
-	for (run_cmd_pipe(qw(git diff-files --numstat --summary))) {
+	for (run_cmd_pipe(qw(git diff-files --numstat --summary --), @ARGV)) {
 		if (($add, $del, $file) =
 		    /^([-\d]+)	([-\d]+)	(.*)/) {
 			if (!exists $data{$file}) {
-- 
1.5.3.6.886.g3364
