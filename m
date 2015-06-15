From: Patrick Palka <patrick@parcs.ath.cx>
Subject: [PATCH] Improve contrib/diff-highlight to highlight unevenly-sized hunks
Date: Mon, 15 Jun 2015 13:20:53 -0400
Message-ID: <1434388853-23915-1-git-send-email-patrick@parcs.ath.cx>
Cc: Patrick Palka <patrick@parcs.ath.cx>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 15 19:21:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4Y4T-00028X-NS
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jun 2015 19:21:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755916AbbFORVO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2015 13:21:14 -0400
Received: from mail-qc0-f169.google.com ([209.85.216.169]:35030 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755816AbbFORVM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2015 13:21:12 -0400
Received: by qcsf5 with SMTP id f5so5576856qcs.2
        for <git@vger.kernel.org>; Mon, 15 Jun 2015 10:21:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5fYvgktXmkpViEGNK393GfJIjALggusoXquHxWzt/qY=;
        b=QlYLmbSpAt6eA7SCkZ/S2u/BTY1wQOGfoFBEhtvRh4ufnUenj+GipEwBlX1y/bTztx
         uSJyJzE1LgBAAETxIHcGmyCvA7qyUmR0+cPxe3/zadCRVI70WdufOsx/l1JeqpQ0CMwA
         GtyQCllPAf37bJTGRai1uvk8Kt5VW5wAS4lwXND50GUJ11499gu/L9zIj/Z0f7/NI+x/
         6Ygpwxfd+vLWBZXhYDT+8/UCmFZsQltKycnhE66bUguBMR1PPTcTEt1JiMXMJXa8VjOW
         l9KD2curIFtj6Ot9QKK7SPPSPlENbr4toGvBFouXgxiadj0eR/rS2SCxm/UsN6DhO4ya
         f8OQ==
X-Gm-Message-State: ALoCoQlo3PXpCDsMQY6SieyOzXgYlxE/TkbYm/FdSc6VDA59cIoOwzsKdVel+SZrvBX5ExVTTd8L
X-Received: by 10.55.50.141 with SMTP id y135mr61907281qky.91.1434388871652;
        Mon, 15 Jun 2015 10:21:11 -0700 (PDT)
Received: from localhost.localdomain (ool-4353acd8.dyn.optonline.net. [67.83.172.216])
        by mx.google.com with ESMTPSA id u10sm6611989qgd.14.2015.06.15.10.21.10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Jun 2015 10:21:10 -0700 (PDT)
X-Mailer: git-send-email 2.4.3.413.ga5fe668
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271692>

Currently the diff-highlight script does not try to highlight hunks that
have different numbers of removed/added lines.  But we can be a little
smarter than that, without introducing much magic and complexity.

In the case of unevenly-sized hunks, we could still highlight the first
few (lexicographical) add/remove pairs.  It is not uncommon for hunks to
have common "prefixes", and in such a case this change is very useful
for spotting differences.

Signed-off-by: Patrick Palka <patrick@parcs.ath.cx>
---
 contrib/diff-highlight/diff-highlight | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/contrib/diff-highlight/diff-highlight b/contrib/diff-highlight/diff-highlight
index ffefc31..0dfbebd 100755
--- a/contrib/diff-highlight/diff-highlight
+++ b/contrib/diff-highlight/diff-highlight
@@ -88,22 +88,30 @@ sub show_hunk {
 		return;
 	}
 
-	# If we have mismatched numbers of lines on each side, we could try to
-	# be clever and match up similar lines. But for now we are simple and
-	# stupid, and only handle multi-line hunks that remove and add the same
-	# number of lines.
-	if (@$a != @$b) {
-		print @$a, @$b;
-		return;
-	}
+	# We match up the first MIN(a, b) lines on each side.
+	my $c = @$a < @$b ? @$a : @$b;
 
+	# Highlight each pair, and print each removed line of that pair.
 	my @queue;
-	for (my $i = 0; $i < @$a; $i++) {
+	for (my $i = 0; $i < $c; $i++) {
 		my ($rm, $add) = highlight_pair($a->[$i], $b->[$i]);
 		print $rm;
 		push @queue, $add;
 	}
+
+	# Print the remaining unmatched removed lines of the hunk.
+	for (my $i = $c; $i < @$a; $i++) {
+		print $a->[$i];
+	}
+
+	# Print the added lines of each highlighted pair.
 	print @queue;
+
+	# Print the remaining unmatched added lines of the hunk.
+	for (my $i = $c; $i < @$b; $i++) {
+		print $b->[$i];
+	}
+
 }
 
 sub highlight_pair {
-- 
2.4.3.413.ga5fe668
