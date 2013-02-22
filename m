From: Joshua Clayton <stillcompiling@gmail.com>
Subject: [PATCH] Fix in Git.pm cat_blob crashes on large files (reviewed by
 Jeff King)
Date: Fri, 22 Feb 2013 09:03:56 -0800
Message-ID: <CAMB+bfLjewgKjSN6WNHGkwpRx9OaWipi_-TDa0MnJMDN+6tPZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 22 18:04:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8w2s-0000po-JJ
	for gcvg-git-2@plane.gmane.org; Fri, 22 Feb 2013 18:04:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758335Ab3BVRD7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2013 12:03:59 -0500
Received: from mail-ia0-f177.google.com ([209.85.210.177]:54960 "EHLO
	mail-ia0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758324Ab3BVRD5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2013 12:03:57 -0500
Received: by mail-ia0-f177.google.com with SMTP id o25so722089iad.36
        for <git@vger.kernel.org>; Fri, 22 Feb 2013 09:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to
         :content-type;
        bh=FWTlFZQldNiMcb3sT/MLAn600QilGT9h8RTlB9C2Gvw=;
        b=iFTzb6FZC1QNXf2X6MHDuBx3N318fE9+6WDtSrzxeMqVBdxftyNPAt8ejoeEHDfUnC
         hslIz4YiETnjpQMi4f4NUn5BXyy3VleLVayWofhWhQNyagYzvfBgJAXnoje75WwL0VPn
         yjcQIfW3a/kGwOUEj9Vf6nCgDMWzKR4M1pHT1hTXQb1ymyaAYOcOoQ2KZVRoOUUibXz1
         20wt75ZPkf1/F2z57eXG7ctVWYR9CGhqWoGYbaqAaqN/1QYh8WLIf8hxZiYL3CKKf6qR
         sZmzesyMK/Ffj66iK/4cWZICX1JpFxg+B7YtyLGr3hycDHXuFGukeihJflYofFh3cqp0
         J8MA==
X-Received: by 10.50.57.232 with SMTP id l8mr15557308igq.49.1361552636532;
 Fri, 22 Feb 2013 09:03:56 -0800 (PST)
Received: by 10.42.79.80 with HTTP; Fri, 22 Feb 2013 09:03:56 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216840>

Read and write each 1024 byte buffer, rather than trying to buffer
the entire content of the file.
Previous code would crash on all files > 2 Gib, when the offset variable
became negative (perhaps below the level of perl), resulting in a crash.
On a 32 bit system, or a system with low memory it might crash before
reaching 2 GiB due to memory exhaustion.

Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
---
 perl/Git.pm |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 931047c..cc91288 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -949,13 +949,16 @@ sub cat_blob {
 		last unless $bytesLeft;

 		my $bytesToRead = $bytesLeft < 1024 ? $bytesLeft : 1024;
-		my $read = read($in, $blob, $bytesToRead, $bytesRead);
+		my $read = read($in, $blob, $bytesToRead);
 		unless (defined($read)) {
 			$self->_close_cat_blob();
 			throw Error::Simple("in pipe went bad");
 		}
-
 		$bytesRead += $read;
+		unless (print $fh $blob) {
+			$self->_close_cat_blob();
+			throw Error::Simple("couldn't write to passed in filehandle");
+		}
 	}

 	# Skip past the trailing newline.
@@ -970,11 +973,6 @@ sub cat_blob {
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
