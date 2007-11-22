From: Wincent Colaiuta <win@wincent.com>
Subject: [PATCH] Add path-limiting to git-add--interactive
Date: Thu, 22 Nov 2007 02:36:24 +0100
Message-ID: <1195695384-41329-1-git-send-email-win@wincent.com>
References: <7vk5obb09a.fsf@gitster.siamese.dyndns.org>
Cc: gitster@pobox.com, peff@peff.net,
	Wincent Colaiuta <win@wincent.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 22 02:36:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iv0zu-0001sB-VQ
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 02:36:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752736AbXKVBgg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 20:36:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752673AbXKVBgg
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 20:36:36 -0500
Received: from wincent.com ([72.3.236.74]:56274 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752672AbXKVBgf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 20:36:35 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lAM1aOL6032216;
	Wed, 21 Nov 2007 19:36:26 -0600
X-Mailer: git-send-email 1.5.3.6.870.g8799-dirty
In-Reply-To: <7vk5obb09a.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65730>

Implement Junio's suggestion that git-add--interactive should reproduce the
path-limiting semantics of non-interactive git-add.

In otherwords, if "git add -i" (unrestricted) shows paths from a set A,
"git add -i paths..." should show paths from a subset of the set A and that
subset should be defined with the existing ls-files pathspec semantics.

Signed-off-by: Wincent Colaiuta <win@wincent.com>
---
 git-add--interactive.perl |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 2bba07d..a5a07bc 100755
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
@@ -56,9 +56,14 @@ sub list_modified {
 	my ($only) = @_;
 	my (%data, @return);
 	my ($add, $del, $adddel, $file);
+	my @tracked = grep {
+		defined run_cmd_pipe(qw(git ls-files
+			                --exclude-standard --), $_)
+	} @ARGV;
+	return if $#tracked == -1 && $#ARGV != -1;
 
 	for (run_cmd_pipe(qw(git diff-index --cached
-			     --numstat --summary HEAD))) {
+			     --numstat --summary HEAD --), @tracked)) {
 		if (($add, $del, $file) =
 		    /^([-\d]+)	([-\d]+)	(.*)/) {
 			my ($change, $bin);
@@ -81,7 +86,7 @@ sub list_modified {
 		}
 	}
 
-	for (run_cmd_pipe(qw(git diff-files --numstat --summary))) {
+	for (run_cmd_pipe(qw(git diff-files --numstat --summary --), @tracked)) {
 		if (($add, $del, $file) =
 		    /^([-\d]+)	([-\d]+)	(.*)/) {
 			if (!exists $data{$file}) {
-- 
1.5.3.6.870.g8799-dirty
