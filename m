From: William Pursell <bill.pursell@gmail.com>
Subject: [PATCH 3/3] In add --patch, Handle K,k,J,j slightly more gracefully.
Date: Thu, 27 Nov 2008 04:08:03 +0000
Message-ID: <492E1D23.7010709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 27 05:09:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5YC5-0005Gi-Lt
	for gcvg-git-2@gmane.org; Thu, 27 Nov 2008 05:09:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752295AbYK0EIL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2008 23:08:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752270AbYK0EIK
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Nov 2008 23:08:10 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:17118 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752017AbYK0EIJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2008 23:08:09 -0500
Received: by nf-out-0910.google.com with SMTP id d3so430512nfc.21
        for <git@vger.kernel.org>; Wed, 26 Nov 2008 20:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=vTyuycRjzP8bVqoFWbKaLyvsBusaheZqftjOoDnOZJg=;
        b=xrt/KnEfvq4OYFV3zIwrw5SHDQ7fL+fKeQQVOiL0/gUvjoK28aPMPs3dlJqQeE8zPL
         h2c/U9ocLjYeawyuq3qLksEBVeriDwgodc2ckjlnhFaRfUPxpPY2A0+KqpEamIVBWVVb
         4gbrU4v598a5REaZd0pLFNDsifINTBLiBsw6o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=W1p6aJG/wXOa5ose9vcCUmb8bhE3cnH9bXBB36k4F6LFWyAcDL3FiRpIcNOziRe/zh
         Gg+lRZLkrnBqP7Mq+bKvuCT8Nr3mHkfYLd0hKBoh4R41FCzbsp+7W7acYdsWXfm8Lyml
         dUGtRMXFfSqarkoYWXSwirBPtMfTCic9u4kzA=
Received: by 10.210.130.14 with SMTP id c14mr6885618ebd.131.1227758886412;
        Wed, 26 Nov 2008 20:08:06 -0800 (PST)
Received: from clam.local (5ad934ac.bb.sky.com [90.217.52.172])
        by mx.google.com with ESMTPS id k9sm4281134nfh.23.2008.11.26.20.08.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 26 Nov 2008 20:08:05 -0800 (PST)
User-Agent: Thunderbird 2.0.0.18 (Macintosh/20081105)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101790>


Instead of printing the help menu, this will print
"No next hunk" and then process the given hunk again.

Signed-off-by: William Pursell <bill.pursell@gmail.com>
---
  git-add--interactive.perl |   43 ++++++++++++++++++++++++++++---------------
  1 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 547b5c8..66f6629 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -965,29 +965,42 @@ sub patch_update_file {
  			elsif ($line =~ m|^/(.*)|) {
  				$search_s = qr{$1}m;
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
1.6.0.4.782.geea74.dirty


-- 
William Pursell
