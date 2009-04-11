From: Michael Witten <mfwitten@gmail.com>
Subject: [PATCH RFC 05/10] send-email: Handle "GIT:" rather than "GIT: " during --compose
Date: Sat, 11 Apr 2009 14:08:23 -0500
Message-ID: <1239476908-25944-5-git-send-email-mfwitten@gmail.com>
References: <1239476908-25944-1-git-send-email-mfwitten@gmail.com>
 <1239476908-25944-2-git-send-email-mfwitten@gmail.com>
 <1239476908-25944-3-git-send-email-mfwitten@gmail.com>
 <1239476908-25944-4-git-send-email-mfwitten@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 11 21:14:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lsieo-0002PV-Mf
	for gcvg-git-2@gmane.org; Sat, 11 Apr 2009 21:14:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758522AbZDKTMy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Apr 2009 15:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758377AbZDKTMy
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Apr 2009 15:12:54 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:55576 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757787AbZDKTMy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Apr 2009 15:12:54 -0400
Received: by yx-out-2324.google.com with SMTP id 31so1617182yxl.1
        for <git@vger.kernel.org>; Sat, 11 Apr 2009 12:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=JiH6PIZgppuC7eoxa/tXiuW2Y7HKu8+pHKqX+iDhkNU=;
        b=kYn3K5z8eLVRYxZqgIk2coc37B9PepsjUGXbmcflHXi4fxe87hwOmc88l/FHVMcE6x
         WNZcJSpkweyhlC5lz5VvU8uJidaC2tAjOS2Jpf2t0Ctxgtf+17K4CjRPWHZ/QOIgL2cJ
         j3DTmSnuVxQsmob7wEe7MfsyUcipNblrrSUBU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        b=m1XtjcRJlzlU1ZsHNqw/L/l/CAkE96YR3vLcBD0YdJ9Eckg9KsBx9+6cBMdk4aB2hg
         j8fVld6UyF3Fn0c4+eOEQbp4kkzryEdpEj8OdmYumY1RfA7jIxyALTEhoasQZPNEWr+f
         BfRC7ZOeb5P9+unb4hMb+y92g4T/v8dTQnOA0=
Received: by 10.100.216.10 with SMTP id o10mr939276ang.159.1239477172773;
        Sat, 11 Apr 2009 12:12:52 -0700 (PDT)
Received: from localhost.localdomain (97-116-109-29.mpls.qwest.net [97.116.109.29])
        by mx.google.com with ESMTPS id 9sm5461438ywf.6.2009.04.11.12.12.51
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 11 Apr 2009 12:12:52 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.479.g2aec
In-Reply-To: <1239476908-25944-4-git-send-email-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116314>

This should make things a little more robust in terms of user input;
before, even the program got it wrong by outputting a line with only
"GIT:", which was left in place as a header, because there would be
no following space character.

Also, I cleaned up get_patch_subject().

Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 git-send-email.perl |   23 ++++++++++++-----------
 1 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index b689cc7..502f5af 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -507,15 +507,16 @@ if (@files) {
 }
 
 sub get_patch_subject($) {
-	my $fn = shift;
-	open (my $fh, '<', $fn);
-	while (my $line = <$fh>) {
-		next unless ($line =~ /^Subject: (.*)$/);
-		close $fh;
-		return "GIT: $1\n";
+
+	my $patch = shift;
+	open (my $fh, '<', $patch);
+
+	while (<$fh>) {
+		next unless (/^Subject: (.*)$/);
+		return $1;
 	}
-	close $fh;
-	die "No subject line in $fn ?";
+
+	die "'Subject:' line expected in '$patch'";
 }
 
 if ($compose) {
@@ -534,7 +535,7 @@ if ($compose) {
 
 	print C <<EOT;
 From $tpl_sender # This line is ignored.
-GIT: Lines beginning in "GIT: " will be removed.
+GIT: Lines beginning in "GIT:" will be removed.
 GIT: Consider including an overall diffstat or table of contents
 GIT: for the patch you are writing.
 GIT:
@@ -545,7 +546,7 @@ In-Reply-To: $tpl_reply_to
 
 EOT
 	for my $f (@files) {
-		print C get_patch_subject($f);
+		print C "GIT: ", get_patch_subject($f), "\n";
 	}
 	close(C);
 
@@ -567,7 +568,7 @@ EOT
 	my $in_body = 0;
 	my $summary_empty = 1;
 	while(<C>) {
-		next if m/^GIT: /;
+		next if m/^GIT:/;
 		if ($in_body) {
 			$summary_empty = 0 unless (/^\n$/);
 		} elsif (/^\n$/) {
-- 
1.6.2.2.479.g2aec
