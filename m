From: Christian Biesinger <cbiesinger@web.de>
Subject: [PATCH] Don't send copies to the From: address
Date: Sat, 11 Feb 2006 03:47:17 +0100
Message-ID: <11396260373307-git-send-email-cbiesinger@web.de>
Reply-To: Christian Biesinger <cbiesinger@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Sat Feb 11 03:47:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7knN-0002da-TD
	for gcvg-git@gmane.org; Sat, 11 Feb 2006 03:47:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbWBKCrZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Feb 2006 21:47:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932122AbWBKCrZ
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Feb 2006 21:47:25 -0500
Received: from 85-124-17-142.dynamic.xdsl-line.inode.at ([85.124.17.142]:29372
	"EHLO biesi.no-ip.org") by vger.kernel.org with ESMTP
	id S932117AbWBKCrY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2006 21:47:24 -0500
Received: from christian (localhost.localdomain [127.0.0.1])
	by biesi.no-ip.org (8.13.4/8.13.4) with SMTP id k1B2lHVF019416
	for <git@vger.kernel.org>; Sat, 11 Feb 2006 03:47:18 +0100
In-Reply-To: 
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15918>

Sending copies to the from address is pointless. Not
sending copies there makes it possible to do:

  git-format-patch --mbox origin
  git-send-email 00*

and get a reasonable result.

Signed-off-by: Christian Biesinger <cbiesinger@web.de>

---

 git-send-email.perl |   16 ++++++++++------
 1 files changed, 10 insertions(+), 6 deletions(-)

486a15e29dff39ff5885d7a1e38d6c5c3b70127b
diff --git a/git-send-email.perl b/git-send-email.perl
index 3f1b3ca..31d23d6 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -304,9 +304,11 @@ foreach my $t (@files) {
 					$subject = $1;
 
 				} elsif (/^(Cc|From):\s+(.*)$/) {
-					printf("(mbox) Adding cc: %s from line '%s'\n",
-						$2, $_) unless $quiet;
-					push @cc, $2;
+					unless ($2 eq $from) {
+						printf("(mbox) Adding cc: %s from line '%s'\n",
+							$2, $_) unless $quiet;
+						push @cc, $2;
+					}
 				}
 
 			} else {
@@ -335,9 +337,11 @@ foreach my $t (@files) {
 			if (/^Signed-off-by: (.*)$/i) {
 				my $c = $1;
 				chomp $c;
-				push @cc, $c;
-				printf("(sob) Adding cc: %s from line '%s'\n",
-					$c, $_) unless $quiet;
+				unless ($c eq $from) {
+					push @cc, $c;
+					printf("(sob) Adding cc: %s from line '%s'\n",
+						$c, $_) unless $quiet;
+				}
 			}
 		}
 	}
-- 
1.1.6.g71f7-dirty
