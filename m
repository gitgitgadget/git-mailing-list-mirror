From: Jeff King <peff@peff.net>
Subject: [PATCH 2/4] t5000: tar portability fix
Date: Tue, 13 May 2008 04:45:32 -0400
Message-ID: <20080513084532.GB23799@sigill.intra.peff.net>
References: <20080513084338.GA23729@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 13 10:46:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jvq9R-0007nZ-6c
	for gcvg-git-2@gmane.org; Tue, 13 May 2008 10:46:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758686AbYEMIpf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2008 04:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758750AbYEMIpe
	(ORCPT <rfc822;git-outgoing>); Tue, 13 May 2008 04:45:34 -0400
Received: from peff.net ([208.65.91.99]:1105 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757792AbYEMIpe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2008 04:45:34 -0400
Received: (qmail 19877 invoked by uid 111); 13 May 2008 08:45:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 13 May 2008 04:45:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 May 2008 04:45:32 -0400
Content-Disposition: inline
In-Reply-To: <20080513084338.GA23729@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82002>

The output of 'tar tv' varies from system to system. In
particular, the t5000 was expecting to parse the date from
something like:

  -rw-rw-r-- root/root         0 2008-05-13 04:27 file

but FreeBSD's tar produces this:

  -rw-rw-r--  0 root   root        0 May 13 04:27 file

Instead of relying on tar's output, let's just extract the
file using tar and stat the result using perl.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5000-tar-tree.sh |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index fa62b6a..9b0baac 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -67,10 +67,10 @@ test_expect_success \
 
 test_expect_success \
     'validate file modification time' \
-    'TZ=GMT $TAR tvf b.tar a/a |
-     awk \{print\ \$4,\ \(length\(\$5\)\<7\)\ ?\ \$5\":00\"\ :\ \$5\} \
-     >b.mtime &&
-     echo "2005-05-27 22:00:00" >expected.mtime &&
+    'mkdir extract &&
+     $TAR xf b.tar -C extract a/a &&
+     perl -e '\''print((stat("extract/a/a"))[9], "\n")'\'' >b.mtime &&
+     echo "1117231200" >expected.mtime &&
      diff expected.mtime b.mtime'
 
 test_expect_success \
-- 
1.5.5.1.296.gf618c
