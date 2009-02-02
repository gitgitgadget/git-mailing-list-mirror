From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] Add / command in add --patch
Date: Sun,  1 Feb 2009 19:42:38 -0800
Message-ID: <1233546159-30347-3-git-send-email-gitster@pobox.com>
References: <1233546159-30347-1-git-send-email-gitster@pobox.com>
 <1233546159-30347-2-git-send-email-gitster@pobox.com>
Cc: William Pursell <bill.pursell@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 02 04:44:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTpjd-0006Ug-Dv
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 04:44:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754154AbZBBDmz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Feb 2009 22:42:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754118AbZBBDmy
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Feb 2009 22:42:54 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40070 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754115AbZBBDmx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Feb 2009 22:42:53 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 806AB94341;
	Sun,  1 Feb 2009 22:42:50 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 8F9B194340; Sun,
  1 Feb 2009 22:42:48 -0500 (EST)
X-Mailer: git-send-email 1.6.1.2.331.g8c4c8
In-Reply-To: <1233546159-30347-2-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 90946DA8-F0DB-11DD-A92E-CC4CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108044>

From: William Pursell <bill.pursell@gmail.com>

This command allows the user to skip hunks that don't match the specified
regex.

Signed-off-by: William Pursell <bill.pursell@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-add--interactive.perl |   28 +++++++++++++++++++++++++++-
 1 files changed, 27 insertions(+), 1 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index ca50363..64ad289 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -801,6 +801,7 @@ n - do not stage this hunk
 a - stage this and all the remaining hunks in the file
 d - do not stage this hunk nor any of the remaining hunks in the file
 g - select a hunk to go to
+/ - search for a hunk matching the given regex
 j - leave this hunk undecided, see next undecided hunk
 J - leave this hunk undecided, see next hunk
 k - leave this hunk undecided, see previous undecided hunk
@@ -964,7 +965,7 @@ sub patch_update_file {
 		for (@{$hunk[$ix]{DISPLAY}}) {
 			print;
 		}
-		print colored $prompt_color, "Stage this hunk [y,n,a,d$other,?]? ";
+		print colored $prompt_color, "Stage this hunk [y,n,a,d,/$other,?]? ";
 		my $line = <STDIN>;
 		if ($line) {
 			if ($line =~ /^y/i) {
@@ -1013,6 +1014,31 @@ sub patch_update_file {
 				}
 				next;
 			}
+			elsif ($line =~ m|^/(.*)|) {
+				my $search_string;
+				eval {
+					$search_string = qr{$1}m;
+				};
+				if ($@) {
+					my ($err,$exp) = ($@, $1);
+					$err =~ s/ at .*git-add--interactive line \d+, <STDIN> line \d+.*$//;
+					print STDERR "Malformed search regexp $exp: $err\n";
+					next;
+				}
+				my $iy = $ix;
+				while (1) {
+					my $text = join ("", @{$hunk[$iy]{TEXT}});
+					last if ($text =~ $search_string);
+					$iy++;
+					$iy = 0 if ($iy >= $num);
+					if ($ix == $iy) {
+						print STDERR "No hunk matches the given pattern\n";
+						last;
+					}
+				}
+				$ix = $iy;
+				next;
+			}
 			elsif ($other =~ /K/ && $line =~ /^K/) {
 				$ix--;
 				next;
-- 
1.6.1.2.331.g8c4c8
