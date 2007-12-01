From: Wincent Colaiuta <win@wincent.com>
Subject: [PATCH 2/2] Teach git-add--interactive to highlight untracked file prefixes
Date: Sat,  1 Dec 2007 15:07:20 +0100
Message-ID: <1196518040-85584-2-git-send-email-win@wincent.com>
References: <7vy7cf87jz.fsf@gitster.siamese.dyndns.org>
 <1196518040-85584-1-git-send-email-win@wincent.com>
Cc: gitster@pobox.com, dzwell@gmail.com, peff@peff.net,
	Matthieu.Moy@imag.fr, Wincent Colaiuta <win@wincent.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 01 15:08:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyT1c-0005mL-Fu
	for gcvg-git-2@gmane.org; Sat, 01 Dec 2007 15:08:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752128AbXLAOIh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Dec 2007 09:08:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752091AbXLAOIh
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Dec 2007 09:08:37 -0500
Received: from wincent.com ([72.3.236.74]:55162 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752038AbXLAOIg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Dec 2007 09:08:36 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lB1E7MMr029732;
	Sat, 1 Dec 2007 08:07:27 -0600
X-Mailer: git-send-email 1.5.3.6.953.gdffc
In-Reply-To: <1196518040-85584-1-git-send-email-win@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66720>

Tweak the list_and_choose function so that untracked files will
use the automatic prefix detection machinery.

This works because while previously we handled arrays (command
menus), hashes (patch subcommand) now we explicitly handle strings
(add untracked subcommand).

Signed-off-by: Wincent Colaiuta <win@wincent.com>
---
 git-add--interactive.perl |   30 +++++++++++++++---------------
 1 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 0fb808f..a1aee21 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -256,21 +256,21 @@ sub list_and_choose {
 		for ($i = 0; $i < @stuff; $i++) {
 			my $chosen = $chosen[$i] ? '*' : ' ';
 			my $print = $stuff[$i];
-			if (ref $print) {
-				if ((ref $print) eq 'ARRAY') {
-					$print = @prefixes ?
-					    highlight_prefix(@{$prefixes[$i]}) :
-					    $print->[0];
-				}
-				else {
-					my $value = @prefixes ?
-					    highlight_prefix(@{$prefixes[$i]}) :
-					    $print->{VALUE};
-					$print = sprintf($status_fmt,
-					    $print->{INDEX},
-					    $print->{FILE},
-					    $value);
-				}
+			my $ref = ref $print;
+			my $highlighted = highlight_prefix(@{$prefixes[$i]})
+			    if @prefixes;
+			if ($ref eq 'ARRAY') {
+				$print = $highlighted || $print->[0];
+			}
+			elsif ($ref eq 'HASH') {
+				my $value = $highlighted || $print->{VALUE};
+				$print = sprintf($status_fmt,
+				    $print->{INDEX},
+				    $print->{FILE},
+				    $value);
+			}
+			else {
+				$print = $highlighted || $print;
 			}
 			printf("%s%2d: %s", $chosen, $i+1, $print);
 			if (($opts->{LIST_FLAT}) &&
-- 
1.5.3.6.953.gdffc
