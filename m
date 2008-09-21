From: Charles Bailey <charles@hashpling.org>
Subject: [PATCH 1/2] Add new test to show git archive autocrlf bug
Date: Sun, 21 Sep 2008 21:25:26 +0100
Message-ID: <1222028727-30097-1-git-send-email-charles@hashpling.org>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 21 22:26:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhVW4-0003ZV-Ke
	for gcvg-git-2@gmane.org; Sun, 21 Sep 2008 22:26:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752425AbYIUUZf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Sep 2008 16:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752533AbYIUUZe
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Sep 2008 16:25:34 -0400
Received: from pih-relay06.plus.net ([212.159.14.19]:52916 "EHLO
	pih-relay06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752413AbYIUUZc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Sep 2008 16:25:32 -0400
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by pih-relay06.plus.net with esmtp (Exim) id 1KhVUm-0007tB-7g; Sun, 21 Sep 2008 21:25:28 +0100
Received: from cayley.hashpling.org (cayley.hashpling.org [192.168.76.254])
	by hashpling.plus.com (8.14.2/8.14.2) with ESMTP id m8LKPRwK030119
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 21 Sep 2008 21:25:28 +0100
Received: (from charles@localhost)
	by cayley.hashpling.org (8.14.2/8.14.2/Submit) id m8LKPRTT030118;
	Sun, 21 Sep 2008 21:25:27 +0100
X-Mailer: git-send-email 1.6.0.1.309.g4f56
X-Plusnet-Relay: 28d61e933fc1c0228a098ee939d99bfc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96428>

Signed-off-by: Charles Bailey <charles@hashpling.org>
---

As the few responses to this patch were only positive last time around
(despite my attempt to confuse things by messing up the threading), I'm
resending for inclusion. I believe that the current behaviour is buggy,
so I hope that this patch is 'maint' worthy.

 t/t0024-crlf-archive.sh |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 46 insertions(+), 0 deletions(-)
 create mode 100644 t/t0024-crlf-archive.sh

diff --git a/t/t0024-crlf-archive.sh b/t/t0024-crlf-archive.sh
new file mode 100644
index 0000000..3511439
--- /dev/null
+++ b/t/t0024-crlf-archive.sh
@@ -0,0 +1,46 @@
+#!/bin/sh
+
+test_description='respect crlf in git archive'
+
+. ./test-lib.sh
+UNZIP=${UNZIP:-unzip}
+
+test_expect_success setup '
+
+	git config core.autocrlf true
+
+	printf "CRLF line ending\r\nAnd another\r\n" > sample &&
+	git add sample &&
+
+	test_tick &&
+	git commit -m Initial
+
+'
+
+test_expect_success 'tar archive' '
+
+	git archive --format=tar HEAD |
+	( mkdir untarred && cd untarred && "$TAR" -xf - )
+
+	test_cmp sample untarred/sample
+
+'
+
+"$UNZIP" -v >/dev/null 2>&1
+if [ $? -eq 127 ]; then
+	echo "Skipping ZIP test, because unzip was not found"
+	test_done
+	exit
+fi
+
+test_expect_failure 'zip archive' '
+
+	git archive --format=zip HEAD >test.zip &&
+
+	( mkdir unzipped && cd unzipped && unzip ../test.zip ) &&
+
+	test_cmp sample unzipped/sample
+
+'
+
+test_done
-- 
1.6.0.1.309.g4f56
