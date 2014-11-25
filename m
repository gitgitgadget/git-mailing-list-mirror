From: Paolo Bonzini <bonzini@gnu.org>
Subject: [PATCH 1/2] git-send-email: delay creation of MIME headers
Date: Tue, 25 Nov 2014 15:00:26 +0100
Message-ID: <1416924027-29862-2-git-send-email-bonzini@gnu.org>
References: <1416924027-29862-1-git-send-email-bonzini@gnu.org>
Cc: lersek@redhat.com, Paolo Bonzini <pbonzini@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 25 15:00:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtGfZ-0007Jb-Om
	for gcvg-git-2@plane.gmane.org; Tue, 25 Nov 2014 15:00:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbaKYOAi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2014 09:00:38 -0500
Received: from mail-wi0-f178.google.com ([209.85.212.178]:55851 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876AbaKYOAh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2014 09:00:37 -0500
Received: by mail-wi0-f178.google.com with SMTP id hi2so1537015wib.5
        for <git@vger.kernel.org>; Tue, 25 Nov 2014 06:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o5OiBdKkbN0BADV8xKm6YK1d/mfeqXsnf+fiAaU1LQs=;
        b=ZpKSUBBGmIbSjVt8jwn8SCLXDp59qxxwX9UyKNEofG3I977HXflfoylh8IjpccPVNh
         ZiMA1zhurRV5QEwuZaZ+4kFhuULm4HbuAAlrRHFj0epTeOx+NuzqO0tSIDtpWtS3AJs6
         jjBSU+LySYJfoL5RRFJtE5fS19X15aNn7uIV+0bWwL6oH6GKKcDPF28WXRp5PmKRBDUm
         t3s+IyEoYSYxQA8inkQOwtyt7SKRLn5LPgBKritlrJEByQB0I1Ugtmf/2redc7oO1oYf
         2dykP90rpRv1rsu0n8vX/pxMj4wPEyssHhe6RpmjfzOUUumFqTS5Az+G3SC4gVxL15hX
         JtOQ==
X-Received: by 10.180.95.37 with SMTP id dh5mr31953743wib.64.1416924036415;
        Tue, 25 Nov 2014 06:00:36 -0800 (PST)
Received: from donizetti.redhat.com (net-93-146-133-240.cust.vodafonedsl.it. [93.146.133.240])
        by mx.google.com with ESMTPSA id cq4sm2005989wjc.35.2014.11.25.06.00.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Nov 2014 06:00:35 -0800 (PST)
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1416924027-29862-1-git-send-email-bonzini@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260216>

From: Paolo Bonzini <pbonzini@redhat.com>

After the next patch, git-send-email will sometimes modify
existing Content-Transfer-Encoding headers.  Delay the addition
of the header to @xh until just before sending.  Do the same
for MIME-Version, to avoid adding it twice.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 git-send-email.perl | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 9949db0..b29a304 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1324,6 +1324,8 @@ foreach my $t (@files) {
 	my $author_encoding;
 	my $has_content_type;
 	my $body_encoding;
+	my $xfer_encoding;
+	my $has_mime_version;
 	@to = ();
 	@cc = ();
 	@xh = ();
@@ -1394,9 +1396,16 @@ foreach my $t (@files) {
 				}
 				push @xh, $_;
 			}
+			elsif (/^MIME-Version/i) {
+				$has_mime_version = 1;
+				push @xh, $_;
+			}
 			elsif (/^Message-Id: (.*)/i) {
 				$message_id = $1;
 			}
+			elsif (/^Content-Transfer-Encoding: (.*)/i) {
+				$xfer_encoding = $1 if not defined $xfer_encoding;
+			}
 			elsif (!/^Date:\s/i && /^[-A-Za-z]+:\s+\S/) {
 				push @xh, $_;
 			}
@@ -1444,10 +1453,9 @@ foreach my $t (@files) {
 		if defined $cc_cmd && !$suppress_cc{'cccmd'};
 
 	if ($broken_encoding{$t} && !$has_content_type) {
+		$xfer_encoding = '8bit' if not defined $xfer_encoding;
 		$has_content_type = 1;
-		push @xh, "MIME-Version: 1.0",
-			"Content-Type: text/plain; charset=$auto_8bit_encoding",
-			"Content-Transfer-Encoding: 8bit";
+		push @xh, "Content-Type: text/plain; charset=$auto_8bit_encoding";
 		$body_encoding = $auto_8bit_encoding;
 	}
 
@@ -1467,14 +1475,19 @@ foreach my $t (@files) {
 				}
 			}
 			else {
+				$xfer_encoding = '8bit' if not defined $xfer_encoding;
 				$has_content_type = 1;
 				push @xh,
-				  'MIME-Version: 1.0',
-				  "Content-Type: text/plain; charset=$author_encoding",
-				  'Content-Transfer-Encoding: 8bit';
+				  "Content-Type: text/plain; charset=$author_encoding";
 			}
 		}
 	}
+	if (defined $xfer_encoding) {
+		push @xh, "Content-Transfer-Encoding: $xfer_encoding";
+	}
+	if (defined $xfer_encoding or $has_content_type) {
+		unshift @xh, 'MIME-Version: 1.0' unless $has_mime_version;
+	}
 
 	$needs_confirm = (
 		$confirm eq "always" or
-- 
2.1.0
