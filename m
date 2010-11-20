From: Joe Perches <joe@perches.com>
Subject: [PATCH] git-send-email.perl: Deduplicate "to:" and "cc:" entries
 with names
Date: Sat, 20 Nov 2010 09:06:49 -0800
Message-ID: <1290272809.27951.30.camel@Joe-Laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Nov 20 18:07:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJqu7-0006J4-Vl
	for gcvg-git-2@lo.gmane.org; Sat, 20 Nov 2010 18:07:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754256Ab0KTRGv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Nov 2010 12:06:51 -0500
Received: from mail.perches.com ([173.55.12.10]:1590 "EHLO mail.perches.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753844Ab0KTRGu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Nov 2010 12:06:50 -0500
Received: from [192.168.1.162] (unknown [192.168.1.162])
	by mail.perches.com (Postfix) with ESMTP id 4B1DD2436B
	for <git@vger.kernel.org>; Sat, 20 Nov 2010 09:06:41 -0800 (PST)
X-Mailer: Evolution 2.30.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161828>

If an email address in the "to:" list is in the style
"First Last <email@domain.tld>", ie: not just a bare
address like "email@domain.tld", and the same named
entry style exists in the "cc:" list, the current
logic will not remove the entry from the "cc:" list.

Add logic to better deduplicate the "cc:" list by also
matching the email address with angle brackets.

Signed-off-by: Joe Perches <joe@perches.com>
---
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
+		      not grep { $cc eq $_ || $_ =~ /<${cc}>$/ } @recipients
 		    }
 	       map { sanitize_address($_) }
 	       @cc);
