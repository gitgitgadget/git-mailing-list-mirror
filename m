From: Jonathan Lebon <jonathan.lebon@gmail.com>
Subject: [PATCH 2/4] diff-highlight: factor out prefix/suffix functions
Date: Mon,  2 Nov 2015 21:05:32 -0500
Message-ID: <1446516334-27652-3-git-send-email-jonathan.lebon@gmail.com>
References: <1446516334-27652-1-git-send-email-jonathan.lebon@gmail.com>
Cc: peff@peff.net, Jonathan Lebon <jonathan.lebon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 03 03:06:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtQzk-0003Ee-K8
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 03:06:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754658AbbKCCGf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Nov 2015 21:06:35 -0500
Received: from mail-qg0-f49.google.com ([209.85.192.49]:33342 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754657AbbKCCGW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2015 21:06:22 -0500
Received: by qgeo38 with SMTP id o38so2387882qge.0
        for <git@vger.kernel.org>; Mon, 02 Nov 2015 18:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xaM33Ykv5Bhi5PVxQQ3jcAGzTiuGU7V9TO9N8NPCYXA=;
        b=xP0i9uGNBFlJtV2oMyvTiddEchtREzKEz/IT61vGjyWNA94YkrT9FXuBi/i+erMjbW
         1ch6BykNop9kh7b4kbrmUZWMs+x/Ha3ev8jDU9xkBNcg+BifKZIzLNh4ILyhpUUcwoHl
         un8suIti1LcYVpYS6Oyd9DoKAJDMBm/YeubE6VOMAohmEP3FvNe5cWAZLNwk3C3j5o+P
         33jeFjIswjnesJ6T4QGtJdyK5lrI+TgKwDtPHXAIb7H8bi64/ocoal7hIeinrwirTlGe
         wrdu6CoaQEJ90+VTFkapcF+Rgr122smD/gDm3HUD0n6oZXbyi/YXXQbSzetPZFqdS4Zt
         U9ZA==
X-Received: by 10.140.21.133 with SMTP id 5mr32903309qgl.36.1446516381390;
        Mon, 02 Nov 2015 18:06:21 -0800 (PST)
Received: from vostro.yyz.redhat.com ([38.104.156.250])
        by smtp.gmail.com with ESMTPSA id s21sm9013447qkl.36.2015.11.02.18.06.20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Nov 2015 18:06:20 -0800 (PST)
X-Mailer: git-send-email 2.6.0
In-Reply-To: <1446516334-27652-1-git-send-email-jonathan.lebon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280744>

In preparation for the next patch, we factor out the functions for
finding the common prefix and suffix between two lines.

Signed-off-by: Jonathan Lebon <jonathan.lebon@gmail.com>
---
 contrib/diff-highlight/diff-highlight | 98 ++++++++++++++++++++---------------
 1 file changed, 56 insertions(+), 42 deletions(-)

diff --git a/contrib/diff-highlight/diff-highlight b/contrib/diff-highlight/diff-highlight
index ffefc31..a332f86 100755
--- a/contrib/diff-highlight/diff-highlight
+++ b/contrib/diff-highlight/diff-highlight
@@ -110,48 +110,8 @@ sub highlight_pair {
 	my @a = split_line(shift);
 	my @b = split_line(shift);
 
-	# Find common prefix, taking care to skip any ansi
-	# color codes.
-	my $seen_plusminus;
-	my ($pa, $pb) = (0, 0);
-	while ($pa < @a && $pb < @b) {
-		if ($a[$pa] =~ /$COLOR/) {
-			$pa++;
-		}
-		elsif ($b[$pb] =~ /$COLOR/) {
-			$pb++;
-		}
-		elsif ($a[$pa] eq $b[$pb]) {
-			$pa++;
-			$pb++;
-		}
-		elsif (!$seen_plusminus && $a[$pa] eq '-' && $b[$pb] eq '+') {
-			$seen_plusminus = 1;
-			$pa++;
-			$pb++;
-		}
-		else {
-			last;
-		}
-	}
-
-	# Find common suffix, ignoring colors.
-	my ($sa, $sb) = ($#a, $#b);
-	while ($sa >= $pa && $sb >= $pb) {
-		if ($a[$sa] =~ /$COLOR/) {
-			$sa--;
-		}
-		elsif ($b[$sb] =~ /$COLOR/) {
-			$sb--;
-		}
-		elsif ($a[$sa] eq $b[$sb]) {
-			$sa--;
-			$sb--;
-		}
-		else {
-			last;
-		}
-	}
+	my ($pa, $pb) = find_common_prefix(\@a, \@b);
+	my ($sa, $sb) = find_common_suffix(\@a, $pa, \@b, $pb);
 
 	if (is_pair_interesting(\@a, $pa, $sa, \@b, $pb, $sb)) {
 		return highlight_line(\@a, $pa, $sa, \@OLD_HIGHLIGHT),
@@ -173,6 +133,60 @@ sub split_line {
 		split /($COLOR+)/;
 }
 
+sub find_common_prefix {
+	my ($a, $b) = @_;
+
+	# Take care to skip any ansi color codes.
+	my $seen_plusminus;
+	my ($pa, $pb) = (0, 0);
+	while ($pa < @$a && $pb < @$b) {
+		if ($a->[$pa] =~ /$COLOR/) {
+			$pa++;
+		}
+		elsif ($b->[$pb] =~ /$COLOR/) {
+			$pb++;
+		}
+		elsif ($a->[$pa] eq $b->[$pb]) {
+			$pa++;
+			$pb++;
+		}
+		elsif (!$seen_plusminus && $a->[$pa] eq '-' && $b->[$pb] eq '+') {
+			$seen_plusminus = 1;
+			$pa++;
+			$pb++;
+		}
+		else {
+			last;
+		}
+	}
+
+	return $pa, $pb;
+}
+
+sub find_common_suffix {
+	my ($a, $pa, $b, $pb) = @_;
+
+	# Take care to skip any ansi color codes.
+	my ($sa, $sb) = ($#$a, $#$b);
+	while ($sa >= $pa && $sb >= $pb) {
+		if ($a->[$sa] =~ /$COLOR/) {
+			$sa--;
+		}
+		elsif ($b->[$sb] =~ /$COLOR/) {
+			$sb--;
+		}
+		elsif ($a->[$sa] eq $b->[$sb]) {
+			$sa--;
+			$sb--;
+		}
+		else {
+			last;
+		}
+	}
+
+	return $sa, $sb;
+}
+
 sub highlight_line {
 	my ($line, $prefix, $suffix, $theme) = @_;
 
-- 
2.6.0
