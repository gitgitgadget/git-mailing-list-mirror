From: Kevin Ballard <kevin@sb.org>
Subject: [PATCH] git-send-email: Accept fifos as well as files
Date: Wed, 25 Jun 2008 15:44:40 -0700
Message-ID: <1214433880-19870-1-git-send-email-kevin@sb.org>
Cc: Kevin Ballard <kevin@sb.org>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 26 00:46:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBdki-0004Xm-MD
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 00:46:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755469AbYFYWom (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 18:44:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755254AbYFYWom
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 18:44:42 -0400
Received: from sd-green-bigip-207.dreamhost.com ([208.97.132.207]:48805 "EHLO
	randymail-a1.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753353AbYFYWol (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Jun 2008 18:44:41 -0400
Received: from localhost.localdomain (dsl092-049-214.sfo4.dsl.speakeasy.net [66.92.49.214])
	by randymail-a1.g.dreamhost.com (Postfix) with ESMTP id BDA4E18DB9F;
	Wed, 25 Jun 2008 15:44:40 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.130.g7a997
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86360>

When a fifo is given, validation must be skipped because we can't
read the fifo twice. Ideally git-send-email would cache the read
data instead of attempting to read twice, but for now just skip
validation.

Signed-off-by: Kevin Ballard <kevin@sb.org>
---
 git-send-email.perl |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 0b04ba3..16d4375 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -393,7 +393,7 @@ for my $f (@ARGV) {
 		push @files, grep { -f $_ } map { +$f . "/" . $_ }
 				sort readdir(DH);
 
-	} elsif (-f $f) {
+	} elsif (-f $f or -p $f) {
 		push @files, $f;
 
 	} else {
@@ -403,8 +403,10 @@ for my $f (@ARGV) {
 
 if (!$no_validate) {
 	foreach my $f (@files) {
-		my $error = validate_patch($f);
-		$error and die "fatal: $f: $error\nwarning: no patches were sent\n";
+		unless (-p $f) {
+			my $error = validate_patch($f);
+			$error and die "fatal: $f: $error\nwarning: no patches were sent\n";
+		}
 	}
 }
 
-- 
1.5.6.130.g7a997
