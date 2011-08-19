From: Chris Li <christ.li@gmail.com>
Subject: [PATCH] git-p4: don't convert utf16 files.
Date: Fri, 19 Aug 2011 15:50:20 -0700
Message-ID: <CANeU7QmGJTr4V-tWzuPnP2P=9eQbGDgQxv2phAVbGXjU5tqYPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 20 00:50:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuXtT-0006GZ-Ik
	for gcvg-git-2@lo.gmane.org; Sat, 20 Aug 2011 00:50:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756433Ab1HSWuV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Aug 2011 18:50:21 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:54135 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754662Ab1HSWuV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2011 18:50:21 -0400
Received: by qwk3 with SMTP id 3so2237977qwk.19
        for <git@vger.kernel.org>; Fri, 19 Aug 2011 15:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=RipaoFhpNhjkFpdL2TDladQl/OADAKBpnXJnkjCz3/U=;
        b=GYTwRWeZqqgvGz7/E4nX/SGK7GHBXtw1E7/+f5xJFLXJ/V1DZ1MjsBJpD/zA/343u/
         DlaCv/90viHEX8ZJ0jQyVlAXy4zO/zFDSxZ5KUE3irf0DDVrUs3g1/BqGfvbWAsV6iUm
         YDnSBlDJbeKoBWrVNI8Mk4PISeRAX454RBPWc=
Received: by 10.224.213.194 with SMTP id gx2mr266475qab.312.1313794220301;
 Fri, 19 Aug 2011 15:50:20 -0700 (PDT)
Received: by 10.229.149.15 with HTTP; Fri, 19 Aug 2011 15:50:20 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179739>

Some repository has some utf16 files git-p4 don't know
how to convert. For those files, git-p4 just write the utf8
files. That is wrong, because git get different file than
perforce does, causing some windows resource file fail
to compile.

Using the "p4 print -o tmpfile depotfile" can avoid this
convertion (and possible failure) all together.

Signed-off-by: Chris Li <git@chrisli.org>

---
 git-p4 |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/git-p4 b/git-p4
index 672b0c2..0c6a5cc 100755
--- a/git-p4
+++ b/git-p4
@@ -755,12 +755,11 @@ class P4FileReader:
                     break

             if header['type'].startswith('utf16'):
-                try:
-                    text = textBuffer.getvalue().encode('utf_16')
-                except UnicodeDecodeError:
-                    # File checked in to Perforce has an error. Try
without encoding
-                    print "Corrupt UTF-16 file in Perforce: %s" %
header['depotFile']
-                    text = textBuffer.getvalue()
+                # Don't even try to convert utf16. Ask p4 to write
the file directly.
+                tmpFile = tempfile.NamedTemporaryFile()
+                P4Helper().p4_system("print -o %s %s"%(tmpFile.name,
header['depotFile']))
+                text = open(tmpFile.name).read()
+      	        tmpFile.close()
             else:
                 text = textBuffer.getvalue()
             textBuffer.close()
-- 
1.7.6
