From: Joshua Clayton <stillcompiling@gmail.com>
Subject: [PATCH] Fix in Git.pm cat_blob crashes on large files
Date: Thu, 21 Feb 2013 14:13:32 -0800
Message-ID: <CAMB+bfKYLjmDavcLaO7scBPfTLmzqAmH+k9uBj0WJ+dzj9vuyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 21 23:14:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8eOt-0004D6-Ph
	for gcvg-git-2@plane.gmane.org; Thu, 21 Feb 2013 23:14:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756181Ab3BUWNe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2013 17:13:34 -0500
Received: from mail-la0-f49.google.com ([209.85.215.49]:34255 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753892Ab3BUWNe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2013 17:13:34 -0500
Received: by mail-la0-f49.google.com with SMTP id fs13so21401lab.22
        for <git@vger.kernel.org>; Thu, 21 Feb 2013 14:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to
         :content-type;
        bh=sI/JIbVvSyNlvn2bxVldLY+gXTZGe6bvxu8gT0+ffOU=;
        b=jWCghsnIc4Ugen1NR5OhDUSDmXbebIq+tZijxgXcrkRV0co5XJKrHPmInbJ1N+pdrd
         aI9iat79lI9r1DBTL+b82a29H4iRC0XORS5U2JJyxlw4RiJka50h0FprwubT8DFRUAu6
         qEGT2wSRkI8czzzN7BAsz3otwEesqursoYXdadrz6MvuOVio+JiVoZg3Q2ayLlQIE2BJ
         d4LRjgEOqJ073mS/NjL13Tb/19DvTz5Cs8yanzh1sm35R8z2r0OwYWpU+oDhefOyNOwH
         a/TfcETmticmxfFXok9tFT995zlwvdGWzKWWzkFbr4EAcSPFHHYPWNvAX7UOhc+ZMXBB
         63hA==
X-Received: by 10.112.24.199 with SMTP id w7mr113424lbf.102.1361484812387;
 Thu, 21 Feb 2013 14:13:32 -0800 (PST)
Received: by 10.114.38.67 with HTTP; Thu, 21 Feb 2013 14:13:32 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216800>

Greetings.
This is my first patch here. Hopefully I get the stylistic & political
details right... :)
Patch applies against maint and master

(If I understand the mechanics, in theory a negative offset should work,
 if the values lined up just right, but would be very wrong, overwriting the
lower contents of the file)

        Developer's Certificate of Origin 1.1

        By making a contribution to this project, I certify that:

        (a) The contribution was created in whole or in part by me and I
            have the right to submit it under the open source license
            indicated in the file; or

        (b) The contribution is based upon previous work that, to the best
            of my knowledge, is covered under an appropriate open source
            license and I have the right under that license to submit that
            work with modifications, whether created in whole or in part
            by me, under the same open source license (unless I am
            permitted to submit under a different license), as indicated
            in the file; or

        (c) The contribution was provided directly to me by some other
            person who certified (a), (b) or (c) and I have not modified
            it.

(d) I understand and agree that this project and the contribution
are public and that a record of the contribution (including all
personal information I submit with it, including my sign-off) is
maintained indefinitely and may be redistributed consistent with
this project or the open source license(s) involved.

Affects git svn clone/fetch
Original code loaded entire file contents into a variable
before writing to disk. If the offset within the variable passed
2 GiB, it becrame negative, resulting in a crash.
On a 32 bit system, or a system with low memory it may crash before
reaching 2 GiB due to memory exhaustion.
Fix writes in smaller 64K increments. Tested to work on git svn fetch

Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
---
 perl/Git.pm |   19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 931047c..e55840f 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -942,6 +942,8 @@ sub cat_blob {
 	my $size = $1;

 	my $blob;
+	my $blobSize = 0;
+	my $flushSize = 1024*64;
 	my $bytesRead = 0;

 	while (1) {
@@ -949,13 +951,21 @@ sub cat_blob {
 		last unless $bytesLeft;

 		my $bytesToRead = $bytesLeft < 1024 ? $bytesLeft : 1024;
-		my $read = read($in, $blob, $bytesToRead, $bytesRead);
+		my $read = read($in, $blob, $bytesToRead, $blobSize);
 		unless (defined($read)) {
 			$self->_close_cat_blob();
 			throw Error::Simple("in pipe went bad");
 		}
-
 		$bytesRead += $read;
+		$blobSize += $read;
+		if (($blobSize >= $flushSize) || ($bytesLeft <= 1024)) {
+			unless (print $fh $blob) {
+				$self->_close_cat_blob();
+				throw Error::Simple("couldn't write to passed in filehandle");
+			}
+			$blob = "";
+			$blobSize = 0;
+		}
 	}

 	# Skip past the trailing newline.
@@ -970,11 +980,6 @@ sub cat_blob {
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
