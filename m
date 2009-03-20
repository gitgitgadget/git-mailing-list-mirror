From: Kristian Amlie <kristian.amlie@nokia.com>
Subject: [PATCH] Add a test for checking whether gitattributes is honored by checkout.
Date: Fri, 20 Mar 2009 10:32:09 +0100
Message-ID: <1237541529-29477-1-git-send-email-kristian.amlie@nokia.com>
References: <49C34FB1.4040100@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Cc: Kristian Amlie <kristian.amlie@nokia.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 20 10:34:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lkb78-0006nN-6y
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 10:34:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752102AbZCTJch (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 05:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751974AbZCTJcf
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 05:32:35 -0400
Received: from hoat.troll.no ([62.70.27.150]:49918 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751644AbZCTJce convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Mar 2009 05:32:34 -0400
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id 5365A2118A;
	Fri, 20 Mar 2009 10:32:30 +0100 (CET)
Received: from sx01.troll.no (sx01.troll.no [62.70.27.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id 4C06721160;
	Fri, 20 Mar 2009 10:32:30 +0100 (CET)
Received: from sx01.troll.no (localhost.localdomain [127.0.0.1])
	by sx01.troll.no (8.13.8/8.13.8) with ESMTP id n2K9WUNp028405;
	Fri, 20 Mar 2009 10:32:30 +0100
Received: from axis.localdomain ( [172.24.90.99])
    by sx01.troll.no (Scalix SMTP Relay 11.4.1.11929)
    via ESMTP; Fri, 20 Mar 2009 10:32:30 +0100 (CET)
Received: by axis.localdomain (Postfix, from userid 1000)
	id C7B1A36187BF; Fri, 20 Mar 2009 10:32:29 +0100 (CET)
In-Reply-To: <49C34FB1.4040100@nokia.com>
x-scalix-Hops: 1
X-Mailer: git-send-email 1.6.2.1.222.g570cc.dirty
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113923>

The original bug will not honor new entries in gitattributes if they
are changed in the same checkout as the files they affect.

It will also keep using .gitattributes, even if it is deleted in the
same commit as the files it affects.
---
 t/t0020-crlf.sh |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/t/t0020-crlf.sh b/t/t0020-crlf.sh
index 1be7446..4e72b53 100755
--- a/t/t0020-crlf.sh
+++ b/t/t0020-crlf.sh
@@ -429,6 +429,37 @@ test_expect_success 'in-tree .gitattributes (4)' '
 	}
 '
 
+test_expect_success 'checkout with existing .gitattributes' '
+
+	git config core.autocrlf true &&
+	git config --unset core.safecrlf &&
+	echo ".file2 -crlfQ" | q_to_cr >> .gitattributes &&
+	git add .gitattributes &&
+	git commit -m initial &&
+	echo ".file -crlfQ" | q_to_cr >> .gitattributes &&
+	echo "contents" > .file &&
+	git add .gitattributes .file &&
+	git commit -m second &&
+
+	git checkout master~1 &&
+	git checkout master &&
+	test "$(git diff-files --raw)" = ""
+
+'
+
+test_expect_success 'checkout when deleting .gitattributes' '
+
+	git rm .gitattributes &&
+	echo "contentsQ" | q_to_cr > .file2 &&
+	git add .file2 &&
+	git commit -m third
+
+	git checkout master~1 &&
+	git checkout master &&
+	remove_cr .file2 >/dev/null
+
+'
+
 test_expect_success 'invalid .gitattributes (must not crash)' '
 
 	echo "three +crlf" >>.gitattributes &&
-- 
1.6.2.1.222.g570cc.dirty
