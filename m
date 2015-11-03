From: Jonathan Lebon <jonathan.lebon@gmail.com>
Subject: [PATCH 4/4] diff-highlight: add maxhunksize config option
Date: Mon,  2 Nov 2015 21:05:34 -0500
Message-ID: <1446516334-27652-5-git-send-email-jonathan.lebon@gmail.com>
References: <1446516334-27652-1-git-send-email-jonathan.lebon@gmail.com>
Cc: peff@peff.net, Jonathan Lebon <jonathan.lebon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 03 03:06:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtQzV-00030D-NI
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 03:06:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754687AbbKCCG1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Nov 2015 21:06:27 -0500
Received: from mail-qg0-f53.google.com ([209.85.192.53]:36805 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754662AbbKCCGX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2015 21:06:23 -0500
Received: by qgad10 with SMTP id d10so2284089qga.3
        for <git@vger.kernel.org>; Mon, 02 Nov 2015 18:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FRwjm2R+WgUq1PmI3Xkdsstv2H3mOMMBsLW+SL34J1A=;
        b=qP4wx0sO7iYok//DiOmHywMlizAOeKn4hj7KmJlTdARuXEpwZKQTepRWbaaEKMhUoj
         Q5VzG+YIhXs887+akt/BQMCtRUCknJbVbFQJ4eM8i4LbRWzFJ8hSM3ZqKeRhafuVLDt/
         LBjsDm4Txf/HhVl96SyibIS8whWtlvNXPwHbytDAePBie8sK4qv/nihPEcun8q2TW2Ej
         2hJ4kyMa6O6rFvO/X+RPF+yx183qjHdzMo3bblS4RVehxurYBjqvHJ0FDwdp/GH6xwRb
         oBKVqZ6d1QH1Nz0Cm8G2wSLPY9H4aLZyFcv01Q8kH1PYZTZBmYSDfek1IRTPM0rTDQ6B
         G/0A==
X-Received: by 10.140.94.40 with SMTP id f37mr33357893qge.3.1446516382513;
        Mon, 02 Nov 2015 18:06:22 -0800 (PST)
Received: from vostro.yyz.redhat.com ([38.104.156.250])
        by smtp.gmail.com with ESMTPSA id s21sm9013447qkl.36.2015.11.02.18.06.21
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Nov 2015 18:06:22 -0800 (PST)
X-Mailer: git-send-email 2.6.0
In-Reply-To: <1446516334-27652-1-git-send-email-jonathan.lebon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280743>

As the size of the hunk gets bigger, it becomes harder to jump back and
forth between the removed and added lines, and highlighting becomes less
beneficial. We add a new config option called

	diff-highlight.maxhunksize

which controls the maximum size of the hunk allowed for which
highlighting is still performed. The default value is set to 20.

Signed-off-by: Jonathan Lebon <jonathan.lebon@gmail.com>
---
 contrib/diff-highlight/README         | 20 ++++++++++++++++++++
 contrib/diff-highlight/diff-highlight | 16 ++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/contrib/diff-highlight/README b/contrib/diff-highlight/README
index 885ff2f..ed12be1 100644
--- a/contrib/diff-highlight/README
+++ b/contrib/diff-highlight/README
@@ -89,6 +89,26 @@ newHighlight = "black #aaffaa"
 ---------------------------------------------
 
 
+Max Hunk Config
+---------------
+
+By default, diff-highlight will not do any highlighting if either the
+number of removed or added lines is greater than 20. This is because as
+the hunk gets bigger, it becomes harder to jump back and forth between
+the removed and added lines, and highlighting becomes less beneficial.
+
+You can change this default by setting the "diff-highlight.maxhunksize"
+configuration.
+
+Example:
+
+---------------------------------------------
+# Increase the maximum diff-highlight to 30
+[diff-highlight]
+maxhunksize = 30
+---------------------------------------------
+
+
 Bugs
 ----
 
diff --git a/contrib/diff-highlight/diff-highlight b/contrib/diff-highlight/diff-highlight
index 46556fc..a005146 100755
--- a/contrib/diff-highlight/diff-highlight
+++ b/contrib/diff-highlight/diff-highlight
@@ -17,6 +17,8 @@ my @NEW_HIGHLIGHT = (
 	color_config('color.diff-highlight.newreset', $OLD_HIGHLIGHT[2])
 );
 
+my $MAX_HUNK_SIZE = config('diff-highlight.maxhunksize', 20);
+
 my $RESET = "\x1b[m";
 my $COLOR = qr/\x1b\[[0-9;]*m/;
 my $BORING = qr/$COLOR|\s/;
@@ -79,6 +81,13 @@ sub color_config {
 	return length($s) ? $s : $default;
 }
 
+# Also handle our own fallback here to be independent.
+sub config {
+	my ($key, $default) = @_;
+	my $s = `git config --get $key 2>/dev/null`;
+	return length($s) ? $s : $default;
+}
+
 sub show_hunk {
 	my ($a, $b) = @_;
 
@@ -88,6 +97,13 @@ sub show_hunk {
 		return;
 	}
 
+	# Skip highlighting if the hunk gets bigger than the user configured
+	# limit.
+	if (@$a > $MAX_HUNK_SIZE || @$b > $MAX_HUNK_SIZE) {
+		print @$a, @$b;
+		return;
+	}
+
 	my @queue;
 	match_and_highlight_pairs($a, 0, scalar @$a, $b, 0, scalar @$b, \@queue);
 	print @queue;
-- 
2.6.0
