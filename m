From: Chris Packham <judge.packham@gmail.com>
Subject: [PATCHv3 2/2] tests for git alternate command
Date: Mon, 29 Mar 2010 14:39:41 -0700
Message-ID: <1269898781-18564-3-git-send-email-judge.packham@gmail.com>
References: <1269898781-18564-1-git-send-email-judge.packham@gmail.com>
Cc: jrnieder@gmail.com, gitster@pobox.com, j.sixt@viscovery.net,
	bebarino@gmail.com, Chris Packham <judge.packham@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 29 23:42:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwMjS-0006g2-KX
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 23:42:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754039Ab0C2Vm3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Mar 2010 17:42:29 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:49392 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754037Ab0C2Vm2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Mar 2010 17:42:28 -0400
Received: by mail-pw0-f46.google.com with SMTP id 5so7068685pwi.19
        for <git@vger.kernel.org>; Mon, 29 Mar 2010 14:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=+WJnGwYbexvtULNmgTWNm3HZG7oqQ2dXjuv6ih+f+og=;
        b=vj66SjWuqbDp/3xxKEYh/qr1ccgRUD5UjZmoXLl/yeZuXESi4RpTZZmxW770piXyJ3
         ceKL9DdO5Pf7GO2e5xAXayi0ljgxsijLkA69T7HXifEJXtNZASx9lx8JX6Y0WwXQ/545
         wNmLTV9VUv2O8qbVHVQsAv/hml8w/4yJ2Fgwo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=kw0b+513rSrqwer4ATRGYxD8fxUdRljrbv2wbP0IcnL3+QJmnMIj42MT3huKryH4G0
         8zPwdJbKLei6CL7VHufLElsacuiXE5kGvzhe9XKFuH4sz0gdacQ1KWbXwXyHJPWU7BPo
         gkwKifZES+BYSAx2TeICguigwOfRWlrLuJP/Y=
Received: by 10.141.105.19 with SMTP id h19mr5074494rvm.281.1269898948013;
        Mon, 29 Mar 2010 14:42:28 -0700 (PDT)
Received: from localhost.localdomain (222-153-44-49.jetstream.xtra.co.nz [222.153.44.49])
        by mx.google.com with ESMTPS id o38sm877571rvp.15.2010.03.29.14.42.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 29 Mar 2010 14:42:27 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.3
In-Reply-To: <1269898781-18564-1-git-send-email-judge.packham@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143520>

Signed-off-by: Chris Packham <judge.packham@gmail.com>
---
 t/t1430-alternate-cmd.sh |  154 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 154 insertions(+), 0 deletions(-)
 create mode 100644 t/t1430-alternate-cmd.sh

diff --git a/t/t1430-alternate-cmd.sh b/t/t1430-alternate-cmd.sh
new file mode 100644
index 0000000..ba27633
--- /dev/null
+++ b/t/t1430-alternate-cmd.sh
@@ -0,0 +1,154 @@
+#!/bin/sh
+#
+# Copyright (c) Chris Packham
+#
+
+test_description='Test of git alternate command'
+
+. ./test-lib.sh
+
+test_expect_success 'setup for rest of the test' '
+
+	mkdir -p base &&
+	(
+		cd base &&
+		git init &&
+		echo test > a.txt &&
+		echo test > b.txt &&
+		echo test > c.txt &&
+		git add *.txt &&
+		git commit -a -m "Initial Commit"
+	)
+	git clone base A &&
+	git clone A B &&
+	git clone A C &&
+	git clone A D
+	testbase=$(pwd)
+'
+
+test_expect_success 'can add alternate after clone' '
+
+	(
+		cd B &&
+		git alternate -a ../base/.git/objects &&
+
+		echo "$testbase/base/.git/objects" > expect &&
+		cp .git/objects/info/alternates actual   &&
+
+		test_cmp expect actual
+
+	)
+'
+
+test_expect_success 'add same alternate fails (absolute path)' '
+
+	(
+		cd B &&
+		test_must_fail git alternate -a $(pwd)/base/.git/objects
+	)
+'
+
+test_expect_success 'add same alternate fails (relative path)' '
+
+	(
+		cd B &&
+		test_must_fail git alternate -a ../base/.git/objects
+	)
+'
+
+test_expect_success 'can add multiple alternates' '
+
+	(
+		cd C &&
+		git alternate -a ../base/.git/objects &&
+		git alternate -a ../B/.git/objects &&
+
+		{
+			echo "$testbase/base/.git/objects"
+			echo "$testbase/B/.git/objects"
+		} > expect &&
+
+		cp .git/objects/info/alternates actual   &&
+
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'can add recursive alternate' '
+
+	(
+		cd D &&
+		git alternate -a ../C/.git/objects
+
+		echo "$testbase/C/.git/objects" > expect &&
+		cp .git/objects/info/alternates actual   &&
+
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'simple display' '
+
+	(
+		cd B &&
+		git alternate >actual &&
+		{
+			echo "Object store $testbase/base/.git/objects"
+			echo "    referenced via $testbase/B/.git"
+		} >expect &&
+
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'recursive display' '
+
+	(
+		cd D &&
+		git alternate -r >actual &&
+
+		{
+			echo "Object store $testbase/C/.git/objects"
+			echo "    referenced via $testbase/D/.git"
+			echo "Object store $testbase/base/.git/objects"
+			echo "    referenced via $testbase/C/.git"
+			echo "Object store $testbase/B/.git/objects"
+			echo "    referenced via $testbase/C/.git"
+			echo "Object store $testbase/base/.git/objects"
+			echo "    referenced via $testbase/B/.git"
+		} >expect &&
+
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'cannot delete unless --forced' '
+	(
+		cd C &&
+		test_must_fail git alternate -d "$testbase/B/.git/objects"
+	)
+'
+
+test_expect_success 'can delete one alternate' '
+	(
+		cd C &&
+		git alternate -f -d "$testbase/B/.git/objects" &&
+
+		echo "$testbase/base/.git/objects" > expect &&
+		cp .git/objects/info/alternates actual   &&
+
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'last alternate deleted removes file' '
+	(
+		cd C &&
+		git alternate -f -d "$testbase/base/.git/objects" &&
+
+		test ! -e .git/objects/info/alternates
+
+	)
+'
+
+test_done
-- 
1.7.0.3
