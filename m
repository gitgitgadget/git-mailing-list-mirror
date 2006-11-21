X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Do not use esc_html in esc_path
Date: Tue, 21 Nov 2006 21:43:43 +0100
Message-ID: <11641418231756-git-send-email-jnareb@gmail.com>
NNTP-Posting-Date: Tue, 21 Nov 2006 20:42:56 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=hDN2k25HdKWzD6wOX2ptFL79BK3ADbw2I3VEmCattLuhGuBsNOqHYOBg5eJcv9S2aIxYAF26/IHFXp65m0ONHjqb4mQj80sttU9RVTG+oaHcAfhAh8oXvFy9HDNocLbSigFjXuT2yl2mpSjTJ/HUK6BckEDEKExwvtjFJOkS0Ew=
X-Mailer: git-send-email 1.4.3.4
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32038>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmcRi-0007SX-3W for gcvg-git@gmane.org; Tue, 21 Nov
 2006 21:42:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031422AbWKUUmS (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006
 15:42:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031423AbWKUUmS
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 15:42:18 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:25291 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1031422AbWKUUmR
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006 15:42:17 -0500
Received: by ug-out-1314.google.com with SMTP id m3so1646096ugc for
 <git@vger.kernel.org>; Tue, 21 Nov 2006 12:42:15 -0800 (PST)
Received: by 10.67.19.13 with SMTP id w13mr1771068ugi.1164141734943; Tue, 21
 Nov 2006 12:42:14 -0800 (PST)
Received: from roke.D-201 ( [81.190.24.209]) by mx.google.com with ESMTP id
 54sm10577979ugp.2006.11.21.12.42.14; Tue, 21 Nov 2006 12:42:14 -0800 (PST)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1]) by roke.D-201
 (8.13.4/8.13.4) with ESMTP id kALKhiTB014652; Tue, 21 Nov 2006 21:43:44 +0100
Received: (from jnareb@localhost) by roke.D-201 (8.13.4/8.13.4/Submit) id
 kALKhhL0014651; Tue, 21 Nov 2006 21:43:43 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Do not use esc_html in esc_path subroutine to avoid double quoting;
expand esc_html body (except quoting) in esc_path.

Move esc_path before quot_cec and quot_upr. Add some comments.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   28 +++++++++++++++++-----------
 1 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index ce185d9..53214b0 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -585,7 +585,21 @@ sub esc_html ($;%) {
 	return $str;
 }
 
-# Make control characterss "printable".
+# quote control characters and escape filename to HTML
+sub esc_path {
+	my $str = shift;
+	my %opts = @_;
+
+	$str = to_utf8($str);
+	$str = escapeHTML($str);
+	if ($opts{'-nbsp'}) {
+		$str =~ s/ /&nbsp;/g;
+	}
+	$str =~ s|([[:cntrl:]])|quot_cec($1)|eg;
+	return $str;
+}
+
+# Make control characters "printable", using character escape codes (CEC)
 sub quot_cec {
 	my $cntrl = shift;
 	my %es = ( # character escape codes, aka escape sequences
@@ -605,22 +619,14 @@ sub quot_cec {
 	return "<span class=\"cntrl\">$chr</span>";
 }
 
-# Alternatively use unicode control pictures codepoints.
+# Alternatively use unicode control pictures codepoints,
+# Unicode "printable representation" (PR)
 sub quot_upr {
 	my $cntrl = shift;
 	my $chr = sprintf('&#%04d;', 0x2400+ord($cntrl));
 	return "<span class=\"cntrl\">$chr</span>";
 }
 
-# quote control characters and escape filename to HTML
-sub esc_path {
-	my $str = shift;
-
-	$str = esc_html($str);
-	$str =~ s|([[:cntrl:]])|quot_cec($1)|eg;
-	return $str;
-}
-
 # git may return quoted and escaped filenames
 sub unquote {
 	my $str = shift;
-- 
1.4.3.4
