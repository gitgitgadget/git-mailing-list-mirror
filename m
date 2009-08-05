From: Jan Engelhardt <jengelh@medozas.de>
Subject: [PATCH] send-email: confirm on empty mail subjects
Date: Wed,  5 Aug 2009 18:49:54 +0200
Message-ID: <1249490994-23455-1-git-send-email-jengelh@medozas.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 05 18:50:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYjgf-0004in-M9
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 18:50:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934515AbZHEQty (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 12:49:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934451AbZHEQty
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 12:49:54 -0400
Received: from sovereign.computergmbh.de ([85.214.69.204]:53346 "EHLO
	sovereign.computergmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934379AbZHEQty (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 12:49:54 -0400
Received: by sovereign.computergmbh.de (Postfix, from userid 25121)
	id 1BBC76A808; Wed,  5 Aug 2009 18:49:54 +0200 (CEST)
X-Mailer: git-send-email 1.6.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124921>

When the user forgot to enter a subject in a compose session,
send-email will now inquire whether this is really intended, similar
to what the Alpine MUA does when a subject is absent.

Signed-off-by: Jan Engelhardt <jengelh@medozas.de>
---
 git-send-email.perl |   25 ++++++++++++++++++++-----
 1 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index d508f83..7d56fba 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -553,11 +553,26 @@ EOT
 	}
 	close(C);
 
-	if ($annotate) {
-		do_edit($compose_filename, @files);
-	} else {
-		do_edit($compose_filename);
-	}
+	my $re_edit = 0;
+	do {
+		if ($annotate) {
+			do_edit($compose_filename, @files);
+		} else {
+			do_edit($compose_filename);
+		}
+
+		open(C, "<", $compose_filename) ||
+			die "Failed to open $compose_filename: $!";
+		if (grep(/^Subject:\s*$/i, <C>)) {
+			my $r = ask("No Subject, send anyway? ".
+			            "([y]es|[n]o|[e]dit again): ",
+			            valid_re => qr/^[yne]/i,
+			            default => "n");
+			$re_edit = lc(substr($r, 0, 1)) eq "e";
+			exit(0) if lc(substr($r, 0, 1)) eq "n";
+		}
+		close C;
+	} while ($re_edit);
 
 	open(C2,">",$compose_filename . ".final")
 		or die "Failed to open $compose_filename.final : " . $!;
-- 
1.6.4
