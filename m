From: Wincent Colaiuta <win@wincent.com>
Subject: [PATCH 4/7] Bail if user supplies an invalid pathspec
Date: Fri, 23 Nov 2007 20:20:47 +0100
Message-ID: <1195845650-85962-5-git-send-email-win@wincent.com>
References: <1195845650-85962-1-git-send-email-win@wincent.com>
 <1195845650-85962-2-git-send-email-win@wincent.com>
 <1195845650-85962-3-git-send-email-win@wincent.com>
 <1195845650-85962-4-git-send-email-win@wincent.com>
Cc: gitster@pobox.com, peff@peff.net,
	Wincent Colaiuta <win@wincent.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 23 20:21:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ive68-00087R-FR
	for gcvg-git-2@gmane.org; Fri, 23 Nov 2007 20:21:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756248AbXKWTVd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2007 14:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756209AbXKWTVd
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Nov 2007 14:21:33 -0500
Received: from wincent.com ([72.3.236.74]:60677 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755938AbXKWTVc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2007 14:21:32 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lANJKom1018032;
	Fri, 23 Nov 2007 13:20:58 -0600
X-Mailer: git-send-email 1.5.3.6.886.g6e20-dirty
In-Reply-To: <1195845650-85962-4-git-send-email-win@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65912>

Use git-ls-files to detect whether the user has supplied an invalid
pathspec.

Note that the run_cmd_pipe function unfortunately does not transmit the
exit status of the child process, so there is no way to use it in
conjunction with a command like "git-ls-files --error-unmatch".

The alternative is to use Perl's system() function, but that floods the
standard output. So here we make use of the new -q switch to git-ls-files
so that we can both obtain the exit status of the command and not have to
worry about the standard output. Error conditions are still echoed back to
the user because they come through on the standard error.

Signed-off-by: Wincent Colaiuta <win@wincent.com>
---
 git-add--interactive.perl |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 5fc48a5..8706528 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -775,6 +775,12 @@ add untracked - add contents of untracked files to the staged set of changes
 EOF
 }
 
+sub check_args {
+	return unless @ARGV;
+	exit $? if system(qw(git ls-files -q --exclude-standard
+	    --error-unmatch --with-tree=HEAD --), @ARGV);
+}
+
 sub main_loop {
 	my @cmd = ([ 'status', \&status_cmd, ],
 		   [ 'update', \&update_cmd, ],
@@ -804,5 +810,6 @@ sub main_loop {
 }
 
 refresh();
+check_args();
 status_cmd();
 main_loop();
-- 
1.5.3.6.886.g3364
