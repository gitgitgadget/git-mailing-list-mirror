From: Charles Bailey <charles@hashpling.org>
Subject: [PATCH 0/1] Add new test to demonstrate git archive core.autocrlf
	inconsistency
Date: Thu, 18 Sep 2008 21:01:13 +0100
Message-ID: <20080918200113.GA8631@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 18 22:05:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgPi0-0001cq-Av
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 22:02:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754968AbYIRUB0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2008 16:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755065AbYIRUBZ
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 16:01:25 -0400
Received: from ptb-relay03.plus.net ([212.159.14.147]:39009 "EHLO
	ptb-relay03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754929AbYIRUBZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 16:01:25 -0400
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by ptb-relay03.plus.net with esmtp (Exim) id 1KgPgg-0007Zd-CU; Thu, 18 Sep 2008 21:01:14 +0100
Received: from cayley.hashpling.org (cayley.hashpling.org [192.168.76.254])
	by hashpling.plus.com (8.14.2/8.14.2) with ESMTP id m8IK1DB4009059
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 18 Sep 2008 21:01:13 +0100
Received: (from charles@localhost)
	by cayley.hashpling.org (8.14.2/8.14.2/Submit) id m8IK1DWa009058;
	Thu, 18 Sep 2008 21:01:13 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Plusnet-Relay: 49ac87f52aedc18f6edc04f2b8b6c9b7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96238>

Signed-off-by: Charles Bailey <charles@hashpling.org>
---
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


-- 
Charles Bailey
http://ccgi.hashpling.plus.com/blog/
