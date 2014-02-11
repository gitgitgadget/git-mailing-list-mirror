From: Yoshihiro Sugi <sugi1982@gmail.com>
Subject: [PATCH] contrib/diff-highlight: multibyte characters diff
Date: Tue, 11 Feb 2014 18:09:10 +0900
Message-ID: <1392109750-47852-1-git-send-email-sugi1982@gmail.com>
Cc: Yoshihiro Sugi <sugi1982@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 11 10:09:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WD9LU-0002rG-Fq
	for gcvg-git-2@plane.gmane.org; Tue, 11 Feb 2014 10:09:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751667AbaBKJJc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Feb 2014 04:09:32 -0500
Received: from mail-pa0-f48.google.com ([209.85.220.48]:65072 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751416AbaBKJJ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Feb 2014 04:09:29 -0500
Received: by mail-pa0-f48.google.com with SMTP id kx10so7362579pab.21
        for <git@vger.kernel.org>; Tue, 11 Feb 2014 01:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=TydDiIYiRnAZG4je6lTAS9JHymUcvmJ/JHNkm4vwrRs=;
        b=ZQbzlVomKbp5Ot2rfHZWLUoRYfiVZbl17j34FYlsD0z7Uw/LmsD5bWn+++ab4mh9f9
         AIHEonpMRcknMXOsd87orVIkV1gEEDQnKJEdFH9ryJMsIJwHNoc1V/2puRXl2oeeKNCv
         T/abPyB98k5bXpbL+6oCADg21mbImh4aVqenoKD+3K1SifDNGwXoWs2Fp6ZT8MnMqFat
         vEM1Ix2Vt29hdUNm25iJc0MczF0GWKFRdhE2jvlczXv3LM7CRubTodiyXsl30smOh/Gt
         1EswvX5K+gtiBjTZ7zq/EX6ixC1kXUYqExQpAZpsIL+rxfv1+rGo9zIxe2lAzmoXNrDI
         fVBQ==
X-Received: by 10.66.228.201 with SMTP id sk9mr31033786pac.134.1392109767727;
        Tue, 11 Feb 2014 01:09:27 -0800 (PST)
Received: from localhost.localdomain ([103.5.142.38])
        by mx.google.com with ESMTPSA id n6sm50751984pbj.22.2014.02.11.01.09.25
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Feb 2014 01:09:26 -0800 (PST)
X-Mailer: git-send-email 1.8.5.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241941>

Signed-off-by: Yoshihiro Sugi <sugi1982@gmail.com>

diff-highlight split each hunks and compare them as byte sequences.
it causes problems when diff hunks include multibyte characters.
This change enable to work on such cases by decoding inputs and encoding output as utf8 string.
---
 contrib/diff-highlight/diff-highlight | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/contrib/diff-highlight/diff-highlight b/contrib/diff-highlight/diff-highlight
index c4404d4..49b4f53 100755
--- a/contrib/diff-highlight/diff-highlight
+++ b/contrib/diff-highlight/diff-highlight
@@ -2,6 +2,7 @@
 
 use warnings FATAL => 'all';
 use strict;
+use Encode qw(decode_utf8 encode_utf8);
 
 # Highlight by reversing foreground and background. You could do
 # other things like bold or underline if you prefer.
@@ -15,8 +16,9 @@ my @added;
 my $in_hunk;
 
 while (<>) {
+	$_ = decode_utf8($_);
 	if (!$in_hunk) {
-		print;
+		print encode_utf8($_);
 		$in_hunk = /^$COLOR*\@/;
 	}
 	elsif (/^$COLOR*-/) {
@@ -30,7 +32,7 @@ while (<>) {
 		@removed = ();
 		@added = ();
 
-		print;
+		print encode_utf8($_);
 		$in_hunk = /^$COLOR*[\@ ]/;
 	}
 
@@ -58,7 +60,8 @@ sub show_hunk {
 
 	# If one side is empty, then there is nothing to compare or highlight.
 	if (!@$a || !@$b) {
-		print @$a, @$b;
+		print encode_utf8($_) for @$a;
+		print encode_utf8($_) for @$b;
 		return;
 	}
 
@@ -67,17 +70,18 @@ sub show_hunk {
 	# stupid, and only handle multi-line hunks that remove and add the same
 	# number of lines.
 	if (@$a != @$b) {
-		print @$a, @$b;
+		print encode_utf8($_) for @$a;
+		print encode_utf8($_) for @$b;
 		return;
 	}
 
 	my @queue;
 	for (my $i = 0; $i < @$a; $i++) {
 		my ($rm, $add) = highlight_pair($a->[$i], $b->[$i]);
-		print $rm;
+		print encode_utf8($rm);
 		push @queue, $add;
 	}
-	print @queue;
+	print encode_utf8($_) for @queue;
 }
 
 sub highlight_pair {
-- 
1.8.5.3
