From: Joe Perches <joe@perches.com>
Subject: [PATCH V2] git-send-email.perl: Deduplicate "to:" and "cc:"
 entries with names
Date: Sat, 20 Nov 2010 15:06:05 -0800
Message-ID: <1290294365.31117.40.camel@Joe-Laptop>
References: <1290272809.27951.30.camel@Joe-Laptop>
	 <m2mxp3zr88.fsf@igel.home> <1290286877.31117.15.camel@Joe-Laptop>
	 <4CE84FF3.2070906@pcharlan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Andreas Schwab <schwab@linux-m68k.org>, git <git@vger.kernel.org>
To: Pete Harlan <pgit@pcharlan.com>
X-From: git-owner@vger.kernel.org Sun Nov 21 00:06:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJwVZ-0007PK-Vb
	for gcvg-git-2@lo.gmane.org; Sun, 21 Nov 2010 00:06:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755459Ab0KTXGH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Nov 2010 18:06:07 -0500
Received: from mail.perches.com ([173.55.12.10]:1614 "EHLO mail.perches.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755457Ab0KTXGG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Nov 2010 18:06:06 -0500
Received: from [192.168.1.156] (unknown [192.168.1.156])
	by mail.perches.com (Postfix) with ESMTP id D599224368;
	Sat, 20 Nov 2010 15:06:02 -0800 (PST)
In-Reply-To: <4CE84FF3.2070906@pcharlan.com>
X-Mailer: Evolution 2.30.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161848>

If an email address in the "to:" list is in the style
"First Last <email@domain.tld>", ie: not just a bare
address like "email@domain.tld", and the same named
entry style exists in the "cc:" list, the current
logic will not remove the entry from the "cc:" list.

Add logic to better deduplicate the "cc:" list by also
matching the email address with angle brackets.

Signed-off-by: Joe Perches <joe@perches.com>
---
V2: Added quote escaping suggested by Andreas Schwab

 git-send-email.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index f68ed5a..1ae5fbf 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -960,7 +960,7 @@ sub maildomain {
 sub send_message {
 	my @recipients = unique_email_list(@to);
 	@cc = (grep { my $cc = extract_valid_address($_);
-		      not grep { $cc eq $_ } @recipients
+		      not grep { $cc eq $_ || $_ =~ /<\Q${cc}\E>$/ } @recipients
 		    }
 	       map { sanitize_address($_) }
 	       @cc);
