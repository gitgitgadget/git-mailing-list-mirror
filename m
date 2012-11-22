From: Krzysztof Mazur <krzysiek@podlesie.net>
Subject: [PATCH 5/5] git-send-email: allow edit invalid email address
Date: Thu, 22 Nov 2012 19:12:12 +0100
Message-ID: <1353607932-10436-5-git-send-email-krzysiek@podlesie.net>
References: <7v8v9vrgc9.fsf@alter.siamese.dyndns.org>
 <1353607932-10436-1-git-send-email-krzysiek@podlesie.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Felipe Balbi <balbi@ti.com>,
	Tomi Valkeinen <tomi.valkeinen@ti.com>,
	Krzysztof Mazur <krzysiek@podlesie.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 22 19:37:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TbbeE-0002vK-BC
	for gcvg-git-2@plane.gmane.org; Thu, 22 Nov 2012 19:37:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752172Ab2KVSgV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2012 13:36:21 -0500
Received: from [93.179.225.50] ([93.179.225.50]:47820 "EHLO shrek.podlesie.net"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1750896Ab2KVSgR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2012 13:36:17 -0500
Received: from geronimo.kostuchna.emnet (localhost [127.0.0.1])
	by shrek.podlesie.net (Postfix) with ESMTP id 13EC4601;
	Thu, 22 Nov 2012 19:12:57 +0100 (CET)
X-Mailer: git-send-email 1.8.0.411.g71a7da8
In-Reply-To: <1353607932-10436-1-git-send-email-krzysiek@podlesie.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210182>

In some cases the user may want to send email with "Cc:" line with
email address we cannot extract. Now we allow user to extract
such email address for us.

Signed-off-by: Krzysztof Mazur <krzysiek@podlesie.net>
---
 git-send-email.perl | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index d42dca2..9996735 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -851,10 +851,10 @@ sub extract_valid_address_or_die {
 
 sub validate_address {
 	my $address = shift;
-	if (!extract_valid_address($address)) {
+	while (!extract_valid_address($address)) {
 		print STDERR "error: unable to extract a valid address from: $address\n";
-		$_ = ask("What to do with this address? ([q]uit|[d]rop): ",
-			valid_re => qr/^(?:quit|q|drop|d)/i,
+		$_ = ask("What to do with this address? ([q]uit|[d]rop|[e]dit): ",
+			valid_re => qr/^(?:quit|q|drop|d|edit|e)/i,
 			default => 'q');
 		if (/^d/i) {
 			return undef;
@@ -862,6 +862,9 @@ sub validate_address {
 			cleanup_compose_files();
 			exit(0);
 		}
+		$address = ask("Who should the email be sent to (if any)? ",
+			default => "",
+			valid_re => qr/\@.*\./, confirm_only => 1);
 	}
 	return $address;
 }
-- 
1.8.0.393.gcc9701d
