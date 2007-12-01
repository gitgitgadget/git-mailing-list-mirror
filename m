From: "Dmitry V. Levin" <ldv@altlinux.org>
Subject: [PATCH] xdiff-interface.c (buffer_is_binary): Remove buffer size limitation
Date: Sat, 1 Dec 2007 19:01:13 +0300
Message-ID: <20071201160113.GA20849@nomad.office.altlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Dec 01 17:29:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyVDQ-0006My-Q8
	for gcvg-git-2@gmane.org; Sat, 01 Dec 2007 17:29:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbXLAQ2x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Dec 2007 11:28:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbXLAQ2w
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Dec 2007 11:28:52 -0500
Received: from vhq.altlinux.org ([194.107.17.3]:53565 "EHLO
	sendmail.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750746AbXLAQ2w (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Dec 2007 11:28:52 -0500
X-Greylist: delayed 1657 seconds by postgrey-1.27 at vger.kernel.org; Sat, 01 Dec 2007 11:28:51 EST
Received: from nomad.office.altlinux.org (localhost.localdomain [127.0.0.1])
	by sendmail.altlinux.org (Postfix) with ESMTP id D488D1B5874C;
	Sat,  1 Dec 2007 19:01:12 +0300 (MSK)
Received: by nomad.office.altlinux.org (Postfix, from userid 501)
	id 8FC67170DB; Sat,  1 Dec 2007 19:01:13 +0300 (MSK)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66725>

When checking buffer for NUL byte, do not limit size of buffer we check.
Otherwise we break git-rebase: git-format-patch may generate output which
git-mailinfo cannot handle properly.

Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---
 t/t3407-rebase-binary.sh |   32 ++++++++++++++++++++++++++++++++
 xdiff-interface.c        |    3 ---
 2 files changed, 32 insertions(+), 3 deletions(-)
 create mode 100755 t/t3407-rebase-binary.sh

diff --git a/t/t3407-rebase-binary.sh b/t/t3407-rebase-binary.sh
new file mode 100755
index 0000000..213dc9d
--- /dev/null
+++ b/t/t3407-rebase-binary.sh
@@ -0,0 +1,32 @@
+#!/bin/sh
+
+test_description='rebase binary test'
+
+. ./test-lib.sh
+
+yes 1234567 |head -n 2003 >text
+yes 1234567 |head -n 2000 >bin && printf 'binary\0bin\n' >>bin && yes 1234567 |head -n 3 >>bin
+
+test_expect_success setup '
+
+	cat text >file &&
+	git add file &&
+	git commit -m"text" &&
+
+	git branch bin &&
+
+	echo side >side &&
+	git add side &&
+	git commit -m"side" &&
+
+	git checkout bin &&
+	cat bin >file &&
+	git commit -a -m"bin"
+'
+
+test_expect_success rebase '
+
+	git rebase master
+'
+
+test_done
diff --git a/xdiff-interface.c b/xdiff-interface.c
index be866d1..fa9f58d 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -122,11 +122,8 @@ int read_mmfile(mmfile_t *ptr, const char *filename)
 	return 0;
 }
 
-#define FIRST_FEW_BYTES 8000
 int buffer_is_binary(const char *ptr, unsigned long size)
 {
-	if (FIRST_FEW_BYTES < size)
-		size = FIRST_FEW_BYTES;
 	return !!memchr(ptr, 0, size);
 }
 
-- 
ldv
