From: Krzysztof Mazur <krzysiek@podlesie.net>
Subject: [PATCH 4/5] git-send-email: ask what to do with an invalid email address
Date: Thu, 22 Nov 2012 19:12:11 +0100
Message-ID: <1353607932-10436-4-git-send-email-krzysiek@podlesie.net>
References: <7v8v9vrgc9.fsf@alter.siamese.dyndns.org>
 <1353607932-10436-1-git-send-email-krzysiek@podlesie.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Felipe Balbi <balbi@ti.com>,
	Tomi Valkeinen <tomi.valkeinen@ti.com>,
	Krzysztof Mazur <krzysiek@podlesie.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 22 23:50:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tbfbb-0005rn-TW
	for gcvg-git-2@plane.gmane.org; Thu, 22 Nov 2012 23:50:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756183Ab2KVWu1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2012 17:50:27 -0500
Received: from [93.179.225.50] ([93.179.225.50]:46327 "EHLO shrek.podlesie.net"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753040Ab2KVScP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2012 13:32:15 -0500
Received: from geronimo.kostuchna.emnet (localhost [127.0.0.1])
	by shrek.podlesie.net (Postfix) with ESMTP id 51DF35F1;
	Thu, 22 Nov 2012 19:12:56 +0100 (CET)
X-Mailer: git-send-email 1.8.0.411.g71a7da8
In-Reply-To: <1353607932-10436-1-git-send-email-krzysiek@podlesie.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210218>

We used to warn about invalid emails and just drop them. Such warnings
can be unnoticed by user or noticed after sending email when we are not
giving the "final sanity check [Y/n]?"

Now we quit by default.

Signed-off-by: Krzysztof Mazur <krzysiek@podlesie.net>
Suggested-by: Junio C Hamano <gitster@pobox.com>
---
 git-send-email.perl | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 5056fdc..d42dca2 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -852,8 +852,16 @@ sub extract_valid_address_or_die {
 sub validate_address {
 	my $address = shift;
 	if (!extract_valid_address($address)) {
-		print STDERR "W: unable to extract a valid address from: $address\n";
-		return undef;
+		print STDERR "error: unable to extract a valid address from: $address\n";
+		$_ = ask("What to do with this address? ([q]uit|[d]rop): ",
+			valid_re => qr/^(?:quit|q|drop|d)/i,
+			default => 'q');
+		if (/^d/i) {
+			return undef;
+		} elsif (/^q/i) {
+			cleanup_compose_files();
+			exit(0);
+		}
 	}
 	return $address;
 }
-- 
1.8.0.393.gcc9701d
