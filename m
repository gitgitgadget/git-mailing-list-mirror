From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 1/2] git-remote-mediawiki: reset private ref after non-dumb push
Date: Wed, 21 Aug 2013 10:10:16 +0200
Message-ID: <1377072617-25086-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Aug 21 10:11:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VC3WI-0005JK-Ez
	for gcvg-git-2@plane.gmane.org; Wed, 21 Aug 2013 10:11:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751626Ab3HUILx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Aug 2013 04:11:53 -0400
Received: from mx1.imag.fr ([129.88.30.5]:33197 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751364Ab3HUILv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Aug 2013 04:11:51 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r7L8AKQv031126
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 21 Aug 2013 10:10:21 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1VC3Uj-0005GR-O6; Wed, 21 Aug 2013 10:10:21 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1VC3Uj-0006Xf-Dh; Wed, 21 Aug 2013 10:10:21 +0200
X-Mailer: git-send-email 1.8.4.rc2.18.g030d947
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 21 Aug 2013 10:10:21 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r7L8AKQv031126
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1377677424.79359@QfKxAGCzx3dW/jgxvtHJaA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232692>

Git-mediawiki's "dumb push" sends the local revisions to the remote wiki,
but does not update the local metadata to reflect the push (hence, the
next pull will have to re-import the exported revisions).

The previous implementation was simply omitting the update to the private
ref after a dumb push. This was broken by 664059fb62 (Felipe Contreras,
Apr 17 2013, transport-helper: update remote helper namespace), which
does an automatic update of the private ref (not just the
remote-tracking) on push.

This patch fixes git-remote-mediawiki to reset the private ref after the
push is completed, cancelling the automatic update triggered by
664059fb62.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
Just a resend of the RFC
( http://thread.gmane.org/gmane.comp.version-control.git/232224 ),
which received no comment.

 contrib/mw-to-git/git-remote-mediawiki.perl | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-to-git/git-remote-mediawiki.perl
index f8d7d2c..13919ad 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -53,6 +53,7 @@ if (@ARGV != 2) {
 
 my $remotename = $ARGV[0];
 my $url = $ARGV[1];
+my $reset_private_ref_to = undef;
 
 # Accept both space-separated and multiple keys in config file.
 # Spaces should be written as _ anyway because we'll use chomp.
@@ -161,6 +162,9 @@ sub parse_command {
 	my ($line) = @_;
 	my @cmd = split(/ /, $line);
 	if (!defined $cmd[0]) {
+		if ($reset_private_ref_to) {
+			run_git("update-ref -m \"Git-MediaWiki non-dumb push\" refs/mediawiki/$remotename/master $reset_private_ref_to");
+		}
 		return 0;
 	}
 	if ($cmd[0] eq 'capabilities') {
@@ -1209,9 +1213,10 @@ sub mw_push_revision {
 				die("Unknown error from mw_push_file()\n");
 			}
 		}
-		if (!$dumb_push) {
+		if ($dumb_push) {
+			$reset_private_ref_to = $remoteorigin_sha1;
+		} else {
 			run_git(qq(notes --ref=${remotename}/mediawiki add -f -m "mediawiki_revision: ${mw_revision}" ${sha1_commit}));
-			run_git(qq(update-ref -m "Git-MediaWiki push" refs/mediawiki/${remotename}/master ${sha1_commit} ${sha1_child}));
 		}
 	}
 
-- 
1.8.4.rc2.18.g030d947
