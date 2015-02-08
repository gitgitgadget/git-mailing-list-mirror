From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 06/11] commit: add tests of commit races
Date: Sun,  8 Feb 2015 17:14:00 +0100
Message-ID: <1423412045-15616-7-git-send-email-mhagger@alum.mit.edu>
References: <1423412045-15616-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 08 17:14:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKUVL-0002tl-Ik
	for gcvg-git-2@plane.gmane.org; Sun, 08 Feb 2015 17:14:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756680AbbBHQO1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2015 11:14:27 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:52179 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756509AbbBHQO0 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Feb 2015 11:14:26 -0500
X-AuditID: 1207440d-f79976d000005643-18-54d78b6079e0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id FC.FC.22083.06B87D45; Sun,  8 Feb 2015 11:14:24 -0500 (EST)
Received: from michael.fritz.box (p4FC9719C.dip0.t-ipconnect.de [79.201.113.156])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t18GE9lA014021
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sun, 8 Feb 2015 11:14:23 -0500
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1423412045-15616-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsUixO6iqJvQfT3E4MM/Y4uuK91MFg29V5gt
	3t5cwmhxe8V8ZovuKW8ZLXr7PrFabN7czuLA7vH3/Qcmj52z7rJ7LNhU6nHxkrLH501yAaxR
	3DZJiSVlwZnpefp2CdwZrU1drAWTBCqWvz/M0sDYydvFyMkhIWAise3XC2YIW0ziwr31bF2M
	XBxCApcZJa48W8cC4ZxgkljbsBysik1AV2JRTzMTiC0ioCYxse0QC4jNLLCaSWLrXaBuDg5h
	AQuJpS3OIGEWAVWJVzPus4HYvAIuEl8W9rBCLJOTOH/8J9hITgFXiSVvesFsIaCaPbd6mSYw
	8i5gZFjFKJeYU5qrm5uYmVOcmqxbnJyYl5dapGukl5tZopeaUrqJERJkvDsY/6+TOcQowMGo
	xMPbIXc9RIg1say4MvcQoyQHk5Io79FwoBBfUn5KZUZicUZ8UWlOavEhRgkOZiUR3kWHr4UI
	8aYkVlalFuXDpKQ5WJTEedWWqPsJCaQnlqRmp6YWpBbBZGU4OJQkeE90Ag0VLEpNT61Iy8wp
	QUgzcXCCDOeSEilOzUtJLUosLcmIB0VGfDEwNkBSPEB7O0HaeYsLEnOBohCtpxgVpcR5/4Mk
	BEASGaV5cGNhqeMVozjQl8K8b0CqeIBpB677FdBgJqDBi5deARlckoiQkmpg1F264D5X0NIS
	IYXJjk9OVIVqejVytgi3Bzx7GXpDQ3vTxg89bdXd2+cmtL5dfX2y2xWtHW9KvCe9fBTVqfVl
	ztH8Ga+dXhU/XNLxwHbb4nIzL/eSBdJ/l9r80papT4/XauR4dn9nrOgF2W2zSo1j 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263516>

Committing involves the following steps:

1. Determine the current value of HEAD (if any).
2. Create the new commit object.
3. Update HEAD.

Please note that step 2 can take arbitrarily long, because it might
involve the user editing a commit message.

If a second process sneaks in a commit during step 2, then the first
commit process should fail. This is usually done correctly, because
step 3 verifies that HEAD still points at the same commit that it
pointed to during step 1.

However, if there is a race when creating an *orphan* commit, then the
test in step 3 is skipped.

Add tests for proper handling of such races. One of the new tests
fails. It will be fixed in a moment.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/t7516-commit-races.sh | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100755 t/t7516-commit-races.sh

diff --git a/t/t7516-commit-races.sh b/t/t7516-commit-races.sh
new file mode 100755
index 0000000..5efa351
--- /dev/null
+++ b/t/t7516-commit-races.sh
@@ -0,0 +1,38 @@
+#!/bin/sh
+#
+# Copyright (c) 2014 Michael Haggerty <mhagger@alum.mit.edu>
+#
+
+test_description='git commit races'
+. ./test-lib.sh
+
+test_tick
+
+test_expect_success 'set up editor' '
+	cat >editor <<-\EOF &&
+	#!/bin/sh
+	git commit --allow-empty -m hare
+	echo tortoise >"$1"
+	EOF
+	chmod +x editor
+'
+
+test_expect_failure 'race to create orphan commit' '
+	test_must_fail env EDITOR=./editor git commit --allow-empty &&
+	git show -s --pretty=format:%s >subject &&
+	grep -q hare subject &&
+	test -z "$(git show -s --pretty=format:%P)"
+'
+
+test_expect_success 'race to create non-orphan commit' '
+	git checkout --orphan branch &&
+	git commit --allow-empty -m base &&
+	git rev-parse HEAD >base &&
+	test_must_fail env EDITOR=./editor git commit --allow-empty &&
+	git show -s --pretty=format:%s >subject &&
+	grep -q hare subject &&
+	git rev-parse HEAD^ >parent &&
+	test_cmp base parent
+'
+
+test_done
-- 
2.1.4
