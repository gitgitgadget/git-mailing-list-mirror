From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH] blame: add a failing test for a CRLF issue.
Date: Tue, 18 Feb 2014 19:45:35 +0000
Message-ID: <1392752735-168203-1-git-send-email-sandals@crustytoothpaste.net>
References: <20140214191015.GG4582@vauxhall.crustytoothpaste.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 18 20:46:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFqcP-0005Xe-5o
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 20:46:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752552AbaBRTqH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Feb 2014 14:46:07 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:52025 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752359AbaBRTqG (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Feb 2014 14:46:06 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 9172428074;
	Tue, 18 Feb 2014 19:46:03 +0000 (UTC)
X-Mailer: git-send-email 1.9.0.rc3.1008.gd08b47c.dirty
In-Reply-To: <20140214191015.GG4582@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242345>

If a file contains CRLF line endings in a repository with
core.autocrlf=input, then blame always marks the lines as "Not Committed
Yet", even if they are unmodified.  Add a failing test for this case, so we
are at least aware of this issue.

Reported-by: Ephrim Khong <dr.khong@gmail.com>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---

Obviously, this doesn't actually fix the issue, but at least we're aware of it
so we don't lose track of it and can fix it.  A future patch can mark the test
passing.

 t/t8003-blame-corner-cases.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/t/t8003-blame-corner-cases.sh b/t/t8003-blame-corner-cases.sh
index e7cac1d..903f775 100755
--- a/t/t8003-blame-corner-cases.sh
+++ b/t/t8003-blame-corner-cases.sh
@@ -191,4 +191,14 @@ test_expect_success 'indent of line numbers, ten lines' '
 	test $(grep -c "  " actual) = 9
 '
 
+test_expect_failure 'blaming files with CRLF newlines' '
+	git config core.autocrlf false &&
+	printf "testcase\r\n" >crlffile &&
+	git add crlffile &&
+	git commit -m testcase &&
+	git config core.autocrlf input &&
+	git blame crlffile >actual &&
+	grep "A U Thor" actual
+'
+
 test_done
-- 
1.9.0.rc3.1008.gd08b47c.dirty
