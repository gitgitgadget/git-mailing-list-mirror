From: "martin f. krafft" <madduck@madduck.net>
Subject: [PATCH] fall back to mozilla's sha.h if openssl/sha.h is not available
Date: Sat, 14 Jul 2007 11:25:18 +0200
Message-ID: <11844051182286-git-send-email-madduck@madduck.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 14 12:17:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9ehC-0003Ss-Do
	for gcvg-git@gmane.org; Sat, 14 Jul 2007 12:17:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755657AbXGNKRh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jul 2007 06:17:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752106AbXGNKRf
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jul 2007 06:17:35 -0400
Received: from armagnac.ifi.unizh.ch ([130.60.75.72]:56195 "EHLO
	albatross.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752221AbXGNKRe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2007 06:17:34 -0400
Received: from localhost (albatross.madduck.net [127.0.0.1])
	by albatross.madduck.net (postfix) with ESMTP id 36186895D8B
	for <git@vger.kernel.org>; Sat, 14 Jul 2007 12:17:33 +0200 (CEST)
Received: from albatross.madduck.net ([127.0.0.1])
	by localhost (albatross.madduck.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 30832-07-2 for <git@vger.kernel.org>;
	Sat, 14 Jul 2007 12:17:33 +0200 (CEST)
Received: from lapse.madduck.net (77-56-87-151.dclient.hispeed.ch [77.56.87.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by albatross.madduck.net (postfix) with ESMTP id 2031B895D81
	for <git@vger.kernel.org>; Sat, 14 Jul 2007 12:17:32 +0200 (CEST)
Received: by lapse.madduck.net (Postfix, from userid 1000)
	id C91564FD4A; Sat, 14 Jul 2007 11:25:18 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.rc1.9.gf029
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at madduck.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52463>

Uses $(CPP) to attempt to preprocess an include <openssl/sha.h> directive. If
that fails, NO_OPENSSL is defined, causing the Makefile to fall back to using
mozilla's SHA implementation.

This should possibly go to configure.ac, but maybe *also* to Makefile to make
from-source compilations easier. git HEAD already comes with a Makefile (rather
than a Makefile.in), so I just ran it while testing out patches. I introduced
the test because I thought the computer could find out about libssl for me,
rather than myself having to forget to specify NO_OPENSSL every time.

Signed-off-by: martin f. krafft <madduck@madduck.net>
---
 Makefile |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index d7541b4..1676343 100644
--- a/Makefile
+++ b/Makefile
@@ -532,6 +532,12 @@ ifndef NO_CURL
 	endif
 endif
 
+HAS_OPENSSL := $(shell echo "\#include <openssl/sha.h>" \
+			| $(CPP) -o/dev/null - 2>/dev/null || echo no)
+ifeq "$(HAS_OPENSSL)" "no"
+	NO_OPENSSL = "openssl_sha.h_not_found"
+endif
+
 ifndef NO_OPENSSL
 	OPENSSL_LIBSSL = -lssl
 	ifdef OPENSSLDIR
-- 
1.5.3.rc1.9.gf029
