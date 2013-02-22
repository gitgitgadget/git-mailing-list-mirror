From: Joshua Clayton <stillcompiling@gmail.com>
Subject: [PATCHv3] Fix in Git.pm cat_blob crashes on large files
Date: Fri, 22 Feb 2013 13:01:18 -0800
Message-ID: <1361566878-20117-1-git-send-email-stillcompiling@gmail.com>
Cc: Joshua Clayton <stillcompiling@gmail.com>,
	Jeff King <peff@peff.net>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 22 22:02:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8zlL-00056f-Vw
	for gcvg-git-2@plane.gmane.org; Fri, 22 Feb 2013 22:02:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756449Ab3BVVCM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2013 16:02:12 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33649 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754594Ab3BVVCK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2013 16:02:10 -0500
Received: by mail-pa0-f49.google.com with SMTP id kp6so668550pab.22
        for <git@vger.kernel.org>; Fri, 22 Feb 2013 13:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=kWJwVNC1EEXBWnZTz1qsc/G+sWJuDhSe/iOBHvb1Jng=;
        b=ILh6FtKQvk1iVgW9TY+zWkWe4jZaoHmoa/OJWEmBMsWcY46VFBeKOuNMYprvD/F8fd
         qNLUEFgkvpeqavhrtzNbN5UFfHo3XlFcO3dydxD0dC0q9f3dDlI74kApHbqM4VCPaF9T
         j0RmcVtW0QIqZ1kTjBbkFj2qM2AMysD17j/HQMGdkORuT3YLUJe+sPvqrIGrPEm4yE8o
         utB7fK/FXo+fO1VINr7jfLuv5J5QzSY9jwAaCVVognJbagbTHH/+BlNzUOiByl/79qEo
         9q4HKKP+aHKNewNZbOQgoCebZDMHi5Zqv8i/VGuHxOK1ch6mvSBGzi+Ku/+zujUgbKey
         xhKw==
X-Received: by 10.66.122.4 with SMTP id lo4mr6106116pab.114.1361566930224;
        Fri, 22 Feb 2013 13:02:10 -0800 (PST)
Received: from localhost.localdomain (68-185-59-186.static.knwc.wa.charter.com. [68.185.59.186])
        by mx.google.com with ESMTPS id hs8sm3600070pbc.27.2013.02.22.13.02.08
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 22 Feb 2013 13:02:09 -0800 (PST)
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216861>

Read and write each 1024 byte buffer, rather than trying to buffer
the entire content of the file.
Previous code would crash on all files > 2 Gib, when the offset variable
became negative (perhaps below the level of perl), resulting in a crash.
On a 32 bit system, or a system with low memory it might crash before
reaching 2 GiB due to memory exhaustion.
This code may leave a partial file behind in case of failure, where the
old code would leave a completely empty file.
Neither version verifies the correctness of the content.
Calling code must take care of verification and cleanup.

Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
Reviewed-by: Jeff King <peff@peff.net>
Reviewed-by: Junio C Hamano <gitster@pobox.com>
---
 perl/Git.pm |   17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 931047c..db6e0a8 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -942,20 +942,22 @@ sub cat_blob {
 	my $size = $1;
 
 	my $blob;
-	my $bytesRead = 0;
+	my $bytesLeft = $size;
 
 	while (1) {
-		my $bytesLeft = $size - $bytesRead;
 		last unless $bytesLeft;
 
 		my $bytesToRead = $bytesLeft < 1024 ? $bytesLeft : 1024;
-		my $read = read($in, $blob, $bytesToRead, $bytesRead);
+		my $read = read($in, $blob, $bytesToRead);
 		unless (defined($read)) {
 			$self->_close_cat_blob();
 			throw Error::Simple("in pipe went bad");
 		}
-
-		$bytesRead += $read;
+		unless (print $fh $blob) {
+			$self->_close_cat_blob();
+			throw Error::Simple("couldn't write to passed in filehandle");
+		}
+		$bytesLeft -= $read;
 	}
 
 	# Skip past the trailing newline.
@@ -970,11 +972,6 @@ sub cat_blob {
 		throw Error::Simple("didn't find newline after blob");
 	}
 
-	unless (print $fh $blob) {
-		$self->_close_cat_blob();
-		throw Error::Simple("couldn't write to passed in filehandle");
-	}
-
 	return $size;
 }
 
-- 
1.7.10.4
I'm trying to send this with git-send-email this time around to beat
 the linewrapping problem.
