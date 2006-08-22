From: Haavard Skinnemoen <hskinnemoen@atmel.com>
Subject: [PATCH] git-send-email: Don't set author_not_sender from Cc: lines
Date: Tue, 22 Aug 2006 15:38:39 +0200
Message-ID: <1156253919761-git-send-email-hskinnemoen@atmel.com>
Cc: Haavard Skinnemoen <hskinnemoen@atmel.com>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Aug 22 15:39:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFWT5-0005yQ-Tv
	for gcvg-git@gmane.org; Tue, 22 Aug 2006 15:39:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932238AbWHVNiv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Aug 2006 09:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbWHVNiv
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Aug 2006 09:38:51 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:19183 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S932238AbWHVNit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Aug 2006 09:38:49 -0400
Received: from cad-250-152.norway.atmel.com (cad-250-152.norway.atmel.com [10.191.250.152])
	by relay.atmel.no (8.13.4/8.13.4) with ESMTP id k7MDcdrE030973;
	Tue, 22 Aug 2006 15:38:39 +0200 (CEST)
	(envelope-from hskinnemoen@norway.atmel.com)
Received: from hskinnemoen by cad-250-152.norway.atmel.com with local (Exim 4.62)
	(envelope-from <hskinnemoen@cad-250-165.norway.atmel.com>)
	id 1GFWSl-0000ZL-Dx; Tue, 22 Aug 2006 15:38:39 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.2.ga6bd
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25853>

When an mbox-style patch contains a Cc: line in the header,
git-send-email will check the address against the sender specified
on the command line. If they don't match, sender_not_author will
be set to the address obtained from the Cc line.

When this happens, git-send-email inserts a From: line at the
beginning of the message body with the address obtained from the
Cc line in the header, and the sender might be accused of forging
patch authors.

This patch fixes this by only updating sender_not_author when
processing From: lines, not when processing Cc: lines.

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---

This email was sent using git-send-email with the patch applied. Junio
was Cc'ed by editing the patch header -- let's see if it works...

 git-send-email.perl |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index a83c7e9..0197454 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -506,7 +506,7 @@ foreach my $t (@files) {
 				if (/^Subject:\s+(.*)$/) {
 					$subject = $1;
 
-				} elsif (/^(Cc|From):\s+(.*)$/) {
+				} elsif (/^(From):\s+(.*)$/) {
 					if ($2 eq $from) {
 						next if ($suppress_from);
 					}
@@ -516,8 +516,11 @@ foreach my $t (@files) {
 					printf("(mbox) Adding cc: %s from line '%s'\n",
 						$2, $_) unless $quiet;
 					push @cc, $2;
+				} elsif (/^(Cc):\s+(.*)$/) {
+					printf("(mbox) Adding cc: %s from line '%s'\n",
+						$2, $_) unless $quiet;
+					push @cc, $2;
 				}
-
 			} else {
 				# In the traditional
 				# "send lots of email" format,
-- 
1.4.0
