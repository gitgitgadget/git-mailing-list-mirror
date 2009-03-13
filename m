From: Kristian Amlie <kristian.amlie@nokia.com>
Subject: [PATCH 1/2] Add a test for checking whether gitattributes is honored by checkout.
Date: Fri, 13 Mar 2009 14:24:15 +0100
Message-ID: <1236950656-1967-2-git-send-email-kristian.amlie@nokia.com>
References: <49B8DD1D.3060908@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Cc: Kristian Amlie <kristian.amlie@nokia.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 13 14:26:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Li7Ok-0001ew-UX
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 14:26:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754645AbZCMNY2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2009 09:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754335AbZCMNY0
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 09:24:26 -0400
Received: from hoat.troll.no ([62.70.27.150]:59316 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753647AbZCMNYY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Mar 2009 09:24:24 -0400
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id 91DFC2131E;
	Fri, 13 Mar 2009 14:24:17 +0100 (CET)
Received: from sx01.troll.no (sx01.troll.no [62.70.27.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id 8450B21319;
	Fri, 13 Mar 2009 14:24:17 +0100 (CET)
Received: from sx01.troll.no (localhost.localdomain [127.0.0.1])
	by sx01.troll.no (8.13.8/8.13.8) with ESMTP id n2DDOHBT007237;
	Fri, 13 Mar 2009 14:24:17 +0100
Received: from axis.localdomain ( [172.24.90.99])
    by sx01.troll.no (Scalix SMTP Relay 11.4.1.11929)
    via ESMTP; Fri, 13 Mar 2009 14:24:17 +0100 (CET)
Received: by axis.localdomain (Postfix, from userid 1000)
	id D7A1936183BC; Fri, 13 Mar 2009 14:24:16 +0100 (CET)
In-Reply-To: <1236950656-1967-1-git-send-email-kristian.amlie@nokia.com>
References: <1236950656-1967-1-git-send-email-kristian.amlie@nokia.com>
x-scalix-Hops: 1
X-Mailer: git-send-email 1.6.1.1
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113183>

The original bug will not honor new entries in gitattributes if they
are changed in the same checkout as the files they affect.

It will also keep using .gitattributes, even if it is deleted in the
same commit as the files it affects.
---
 t/t2013-checkout-crlf.sh |   41 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 41 insertions(+), 0 deletions(-)
 create mode 100755 t/t2013-checkout-crlf.sh

diff --git a/t/t2013-checkout-crlf.sh b/t/t2013-checkout-crlf.sh
new file mode 100755
index 0000000..d9d6465
--- /dev/null
+++ b/t/t2013-checkout-crlf.sh
@@ -0,0 +1,41 @@
+#!/bin/sh
+
+test_description='checkout should honor .gitattributes'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+
+        git config core.autocrlf true &&
+        printf ".file2 -crlf\r\n" > .gitattributes &&
+        git add .gitattributes &&
+        git commit -m initial &&
+        printf ".file -crlf\n" >> .gitattributes &&
+        printf "contents\n" > .file &&
+        git add .gitattributes .file &&
+        git commit -m second &&
+        git rm .gitattributes &&
+        printf "contents\r\n" > .file2 &&
+        git add .file2 &&
+        git commit -m third
+
+'
+
+test_expect_failure 'checkout with existing .gitattributes' '
+
+        git checkout master~2 &&
+        git checkout master~1 &&
+        test "$(git diff-files --raw)" = ""
+
+'
+
+test_expect_failure 'checkout when deleting .gitattributes' '
+
+        git checkout master~1 &&
+        git checkout master &&
+        test "$(stat -c %s .file2)" = "10"
+
+'
+
+test_done
+
-- 
1.6.1.1
