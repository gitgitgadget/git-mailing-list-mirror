From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] In add --patch, Handle K,k,J,j slightly more gracefully.
Date: Sun,  1 Feb 2009 19:42:39 -0800
Message-ID: <1233546159-30347-4-git-send-email-gitster@pobox.com>
References: <1233546159-30347-1-git-send-email-gitster@pobox.com>
 <1233546159-30347-2-git-send-email-gitster@pobox.com>
 <1233546159-30347-3-git-send-email-gitster@pobox.com>
Cc: William Pursell <bill.pursell@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 02 04:44:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTpje-0006Ug-4z
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 04:44:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754188AbZBBDm5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Feb 2009 22:42:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754118AbZBBDm4
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Feb 2009 22:42:56 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61578 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754151AbZBBDmz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Feb 2009 22:42:55 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 6024D2A43B;
	Sun,  1 Feb 2009 22:42:54 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id AA29D2A436; Sun, 
 1 Feb 2009 22:42:52 -0500 (EST)
X-Mailer: git-send-email 1.6.1.2.331.g8c4c8
In-Reply-To: <1233546159-30347-3-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 92E2B092-F0DB-11DD-9033-F63E8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108043>

From: William Pursell <bill.pursell@gmail.com>

Instead of printing the help menu, this will print "No next hunk" and then
process the given hunk again.

Signed-off-by: William Pursell <bill.pursell@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-add--interactive.perl |   43 ++++++++++++++++++++++++++++---------------
 1 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 64ad289..30ddab2 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1039,29 +1039,42 @@ sub patch_update_file {
 				$ix = $iy;
 				next;
 			}
-			elsif ($other =~ /K/ && $line =~ /^K/) {
-				$ix--;
+			elsif ($line =~ /^K/) {
+				if ($other =~ /K/) {
+					$ix--;
+				}
+				else {
+					print STDERR "No previous hunk\n";
+				}
 				next;
 			}
-			elsif ($other =~ /J/ && $line =~ /^J/) {
-				$ix++;
+			elsif ($line =~ /^J/) {
+				if ($other =~ /J/) {
+					$ix++;
+				}
+				else {
+					print STDERR "No next hunk\n";
+				}
 				next;
 			}
-			elsif ($other =~ /k/ && $line =~ /^k/) {
-				while (1) {
-					$ix--;
-					last if (!$ix ||
-						 !defined $hunk[$ix]{USE});
+			elsif ($line =~ /^k/) {
+				if ($other =~ /k/) {
+					while (1) {
+						$ix--;
+						last if (!$ix ||
+							 !defined $hunk[$ix]{USE});
+					}
+				}
+				else {
+					print STDERR "No previous hunk\n";
 				}
 				next;
 			}
-			elsif ($other =~ /j/ && $line =~ /^j/) {
-				while (1) {
-					$ix++;
-					last if ($ix >= $num ||
-						 !defined $hunk[$ix]{USE});
+			elsif ($line =~ /^j/) {
+				if ($other !~ /j/) {
+					print STDERR "No next hunk\n";
+					next;
 				}
-				next;
 			}
 			elsif ($other =~ /s/ && $line =~ /^s/) {
 				my @split = split_hunk($hunk[$ix]{TEXT}, $hunk[$ix]{DISPLAY});
-- 
1.6.1.2.331.g8c4c8
