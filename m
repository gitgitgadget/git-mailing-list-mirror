From: Jens Stimpfle <debian@jstimpfle.de>
Subject: [PATCH] git-send-email.perl: Fix handling of suppresscc option.
Date: Wed, 12 Nov 2014 14:18:11 +0000
Message-ID: <1415801891-28471-1-git-send-email-debian@jstimpfle.de>
Cc: Jens Stimpfle <debian@jstimpfle.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 12 14:51:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XoYK5-0004F8-Jd
	for gcvg-git-2@plane.gmane.org; Wed, 12 Nov 2014 14:51:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752705AbaKLNu5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2014 08:50:57 -0500
Received: from jstimpfle.de ([85.214.245.181]:40205 "EHLO
	h1929017.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752377AbaKLNu5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2014 08:50:57 -0500
X-Greylist: delayed 1465 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Nov 2014 08:50:56 EST
Received: from jfs by h1929017.stratoserver.net with local (Exim 4.80)
	(envelope-from <debian@jstimpfle.de>)
	id 1XoXwL-00068u-TG; Wed, 12 Nov 2014 14:26:30 +0100
X-Mailer: git-send-email 2.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jens Stimpfle <debian@jstimpfle.de>
---

Notes:
    This patch makes sure that "sob", "cc" and "bodycc" values for
    sendemail.suppresscc option are handled, even when the email-addresses in
    question are equal to the sender and "self" in not configured in
    sendemail.suppresscc.
    
    Sounds complicated, I know. But the current behaviour is really confusing: For
    example, when sending, git-send-email logs
    
    (mbox) Adding cc: Jens Stimpfle <debian@jstimpfle.de> from line 'From: Jens Stimpfle <debian@jstimpfle.de>'
    (body) Adding cc: Jens Stimpfle <debian@jstimpfle.de> from line 'Signed-off-by: Jens Stimpfle <debian@jstimpfle.de>'
    
    even though I have "sob" configured in sendemail.suppresscc.
    
    With this patch, the suppression handling is also made consistent with the
    handling of the "author" value.

 git-send-email.perl | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 9949db0..452a783 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1377,11 +1377,8 @@ foreach my $t (@files) {
 				foreach my $addr (parse_address_line($1)) {
 					my $qaddr = unquote_rfc2047($addr);
 					my $saddr = sanitize_address($qaddr);
-					if ($saddr eq $sender) {
-						next if ($suppress_cc{'self'});
-					} else {
-						next if ($suppress_cc{'cc'});
-					}
+					next if $suppress_cc{'cc'};
+					next if $suppress_cc{'self'} and $saddr eq $sender;
 					printf("(mbox) Adding cc: %s from line '%s'\n",
 						$addr, $_) unless $quiet;
 					push @cc, $addr;
@@ -1425,12 +1422,9 @@ foreach my $t (@files) {
 			my ($what, $c) = ($1, $2);
 			chomp $c;
 			my $sc = sanitize_address($c);
-			if ($sc eq $sender) {
-				next if ($suppress_cc{'self'});
-			} else {
-				next if $suppress_cc{'sob'} and $what =~ /Signed-off-by/i;
-				next if $suppress_cc{'bodycc'} and $what =~ /Cc/i;
-			}
+			next if $suppress_cc{'sob'} and $what =~ /Signed-off-by/i;
+			next if $suppress_cc{'bodycc'} and $what =~ /Cc/i;
+			next if $suppress_cc{'self'} and $sc eq $sender;
 			push @cc, $c;
 			printf("(body) Adding cc: %s from line '%s'\n",
 				$c, $_) unless $quiet;
-- 
2.1.1
