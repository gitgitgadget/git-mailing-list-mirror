From: Joshua Clayton <stillcompiling@gmail.com>
Subject: [PATCH] Fix in Git.pm cat_blob crashes on large files (resubmit with reviewed-by)
Date: Fri, 22 Feb 2013 09:30:57 -0800
Message-ID: <CAMB+bfLvpKNLaEUyUUYsO5n2y+9tyd_QcnPVzX0s2Z2t3Fr9=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 22 18:31:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8wSx-00059e-9b
	for gcvg-git-2@plane.gmane.org; Fri, 22 Feb 2013 18:31:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758211Ab3BVRa6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2013 12:30:58 -0500
Received: from mail-ia0-f176.google.com ([209.85.210.176]:43608 "EHLO
	mail-ia0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757714Ab3BVRa5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2013 12:30:57 -0500
Received: by mail-ia0-f176.google.com with SMTP id i18so735531iac.35
        for <git@vger.kernel.org>; Fri, 22 Feb 2013 09:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to:cc
         :content-type;
        bh=iAKefu0yx71Fa0bILHgahWs3fn+biJ2KneNLerwH928=;
        b=uwA3XvaJ2D/HmWB5gHa8zHDXkxyGFogTR9q5yq93wx1FDtDuhw/snBTTq1YUGqXv6w
         ZHxIRDKmdqswSVih/Ga9H+Tss2YhdEclERO8dH1R67qgqrdQEVvWoZ9mQnyD4Z+mXq2V
         2jjqzP17SriJK5aeXOsmeaLLOuj2Ya+eHWp2dmt+drUucWSwVTuuFg2CcWJRa6TQ5qtG
         sgB4Vsc+xivegdZSE1YG6QZ8Em4yvMCQsNA6LVxXu1hIhpSWvriQqqm+TouGdKC9FL58
         jqBrwIPTp6yNMGnD8GLYr6+tEhNBkHd73iNGz6N+YMSAUtfZOkk1jLrYmf3u45D2tUr1
         jgYg==
X-Received: by 10.50.36.169 with SMTP id r9mr4738650igj.96.1361554257351; Fri,
 22 Feb 2013 09:30:57 -0800 (PST)
Received: by 10.42.79.80 with HTTP; Fri, 22 Feb 2013 09:30:57 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216847>

Read and write each 1024 byte buffer, rather than trying to buffer
the entire content of the file.
Previous code would crash on all files > 2 Gib, when the offset variable
became negative (perhaps below the level of perl), resulting in a crash.
On a 32 bit system, or a system with low memory it might crash before
reaching 2 GiB due to memory exhaustion.

Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
Reviewed-by: Jeff King <peff@peff.net>
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
-               my $read = read($in, $blob, $bytesToRead, $bytesRead);
+               my $read = read($in, $blob, $bytesToRead);
                unless (defined($read)) {
                        $self->_close_cat_blob();
                        throw Error::Simple("in pipe went bad");
                }
-
                $bytesRead += $read;
+               unless (print $fh $blob) {
+                       $self->_close_cat_blob();
+                       throw Error::Simple("couldn't write to passed
in filehandle");
+               }
        }

        # Skip past the trailing newline.
@@ -970,11 +973,6 @@ sub cat_blob {
                throw Error::Simple("didn't find newline after blob");
        }

-       unless (print $fh $blob) {
-               $self->_close_cat_blob();
-               throw Error::Simple("couldn't write to passed in filehandle");
-       }
-
        return $size;
 }

--
1.7.10.4
