From: Chris Packham <judge.packham@gmail.com>
Subject: [RFC PATCH 1/3] add test for git grep --recursive
Date: Wed, 29 Sep 2010 13:28:52 -0700
Message-ID: <1285792134-26339-2-git-send-email-judge.packham@gmail.com>
References: <1285792134-26339-1-git-send-email-judge.packham@gmail.com>
Cc: git@vger.kernel.org, Chris Packham <judge.packham@gmail.com>
To: Jens.Lehmann@web.de
X-From: git-owner@vger.kernel.org Wed Sep 29 22:29:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P13Gt-00020m-3V
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 22:28:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755821Ab0I2U2z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Sep 2010 16:28:55 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:51467 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755733Ab0I2U2y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Sep 2010 16:28:54 -0400
Received: by pvg2 with SMTP id 2so290657pvg.19
        for <git@vger.kernel.org>; Wed, 29 Sep 2010 13:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=htCxNMnu0Ttrt5UhzPmkyCSnQzBZrSjmbzr1IX/H26k=;
        b=X7LTVjZi3y4jwvx0HzHXMcN1C3MrF2xnb7HZ0MH3CFlIOjquqCqs1vsj4PcNoe4WPz
         hbxo+TPT7HhuuWGPfQSDrKfTI5JP1+OjE94Pl8X8ewaqLxxavDVI2aLe/dAah1gYu1ad
         JdHeQEWEAE+P9yaB/3VV6Julsj6/ybTPnDZxs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=n3ILV8xl6K7W4GYs2YDEkgZQaBhvmdmaPHZpLRn+VgfmdjuIIehGvTsHGH3h8Brv9t
         HZZUaVgE5NVFhDR2L2iZ8vceqB/W+Ljptd6tOGYtlyFQz1noE5GeFqF5a2VFx1M7MUdZ
         h7Z/t3rJOkpANUTs1PFd10XZ065dqvCqpxRh0=
Received: by 10.114.127.10 with SMTP id z10mr2679006wac.62.1285792134528;
        Wed, 29 Sep 2010 13:28:54 -0700 (PDT)
Received: from localhost.localdomain (209-234-175-66.static.twtelecom.net [209.234.175.66])
        by mx.google.com with ESMTPS id o17sm15169981wal.9.2010.09.29.13.28.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 29 Sep 2010 13:28:53 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.dirty
In-Reply-To: <1285792134-26339-1-git-send-email-judge.packham@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157598>

Signed-off-by: Chris Packham <judge.packham@gmail.com>
---
 t/t7820-grep-recursive.sh |  101 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 101 insertions(+), 0 deletions(-)
 create mode 100644 t/t7820-grep-recursive.sh

diff --git a/t/t7820-grep-recursive.sh b/t/t7820-grep-recursive.sh
new file mode 100644
index 0000000..4bbd109
--- /dev/null
+++ b/t/t7820-grep-recursive.sh
@@ -0,0 +1,101 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 Chris Packham
+#
+
+test_description='git grep --recursive test
+
+This test checks the ability of git grep to search within submodules when told
+to do so with the --recursive option'
+
+. ./test-lib.sh
+
+test_expect_success 'setup - initial commit' '
+	printf "one two three\nfour five six\n" >t &&
+	git add t &&
+	git commit -m "initial commit"
+'
+submodurl=$TRASH_DIRECTORY
+
+test_expect_success 'setup submodules for test' '
+	for mod in $(seq 1 5 | sed "s/.*/submodule&/"); do
+		git submodule add "$submodurl" $mod &&
+		git submodule init $mod
+	done
+'
+
+test_expect_success 'update data in each submodule' '
+	for n in $(seq 1 5); do
+		(cd submodule$n &&
+			sed -i "s/^four.*/& #$n/" t &&
+			git commit -a -m"update")
+	done
+'
+
+cat >expected <<EOF
+t:four five six
+EOF
+test_expect_success 'non-recursive grep in base' '
+	git grep "five" >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<EOF
+foo/t:four five six
+EOF
+test_expect_success 'submodule-prefix option' '
+	git grep --submodule-prefix=foo/ "five" >actual &&
+	test_cmp expected actual
+'
+
+cat >submodule1/expected <<EOF
+t:four five six #1
+EOF
+test_expect_success 'non-recursive grep in submodule' '
+	(
+		cd submodule1 &&
+		git grep "five" >actual &&
+		test_cmp expected actual
+	)
+'
+
+cat >expected <<EOF
+t:four five six #1
+t:four five six #2
+t:four five six #3
+t:four five six #4
+t:four five six #5
+t:four five six
+EOF
+test_expect_success 'recursive grep' '
+	git grep --recurse-submodules "five" >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<EOF
+t:2:four five six #1
+t:2:four five six #2
+t:2:four five six #3
+t:2:four five six #4
+t:2:four five six #5
+t:2:four five six
+EOF
+test_expect_success 'recursive grep (with -n)' '
+	git grep --recurse-submodules -n "five" >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<EOF
+t
+t
+t
+t
+t
+t
+EOF
+test_expect_success 'recursive grep (with -l)' '
+	git grep --recurse-submodules -l "five" >actual &&
+	test_cmp expected actual
+'
+
+test_done
-- 
1.7.3.dirty
