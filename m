From: Krzysztof Mazur <krzysiek@podlesie.net>
Subject: [PATCH 2/5] git-send-email: fix fallback code in extract_valid_address()
Date: Thu, 22 Nov 2012 19:12:09 +0100
Message-ID: <1353607932-10436-2-git-send-email-krzysiek@podlesie.net>
References: <7v8v9vrgc9.fsf@alter.siamese.dyndns.org>
 <1353607932-10436-1-git-send-email-krzysiek@podlesie.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Felipe Balbi <balbi@ti.com>,
	Tomi Valkeinen <tomi.valkeinen@ti.com>,
	Krzysztof Mazur <krzysiek@podlesie.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 23 00:07:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TbfrM-0003XX-6P
	for gcvg-git-2@plane.gmane.org; Fri, 23 Nov 2012 00:07:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752050Ab2KVS2X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2012 13:28:23 -0500
Received: from [93.179.225.50] ([93.179.225.50]:44862 "EHLO shrek.podlesie.net"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751640Ab2KVS2O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2012 13:28:14 -0500
Received: from geronimo.kostuchna.emnet (localhost [127.0.0.1])
	by shrek.podlesie.net (Postfix) with ESMTP id 680FE5ED;
	Thu, 22 Nov 2012 19:12:54 +0100 (CET)
X-Mailer: git-send-email 1.8.0.411.g71a7da8
In-Reply-To: <1353607932-10436-1-git-send-email-krzysiek@podlesie.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210223>

In the fallback check, used when Email::Valid is not available, the
extract_valid_address() uses $1 without checking for success of matching
regex. The $1 variable may still hold the result of previous match,
which is the address when email address was in '<>' or be undefined
otherwise.

Now if match fails undefined value is always returned to indicate error.
The same value is used by Email::Valid->address() in that case.

Previously 'foo@bar' address was rejected by Email::Valid and fallback,
but '<foo@bar>' was rejected by Email::Valid, but accepted by fallback.

Signed-off-by: Krzysztof Mazur <krzysiek@podlesie.net>
---
 git-send-email.perl | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 9840d0a..356f99d 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -831,12 +831,12 @@ sub extract_valid_address {
 	$address =~ s/^\s*<(.*)>\s*$/$1/;
 	if ($have_email_valid) {
 		return scalar Email::Valid->address($address);
-	} else {
-		# less robust/correct than the monster regexp in Email::Valid,
-		# but still does a 99% job, and one less dependency
-		$address =~ /($local_part_regexp\@$domain_regexp)/;
-		return $1;
 	}
+
+	# less robust/correct than the monster regexp in Email::Valid,
+	# but still does a 99% job, and one less dependency
+	return $1 if $address =~ /($local_part_regexp\@$domain_regexp)/;
+	return undef;
 }
 
 # Usually don't need to change anything below here.
-- 
1.8.0.393.gcc9701d
