From: Johan Herland <johan@herland.net>
Subject: [RFC/PATCH 6/6] Add testcase to verify handling of missing remote
 helper programs
Date: Tue, 11 Aug 2009 12:10:26 +0200
Message-ID: <1249985426-13726-7-git-send-email-johan@herland.net>
References: <alpine.LNX.2.00.0908101205120.27553@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Johan Herland <johan@herland.net>, barkalow@iabervon.org,
	gitster@pobox.com, benji@silverinsanity.com,
	Johannes.Schindelin@gmx.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 11 15:12:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mar98-0008GJ-Pe
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 15:12:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753055AbZHKNLI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 09:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751886AbZHKNLH
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 09:11:07 -0400
Received: from smtp.getmail.no ([84.208.15.66]:40825 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752116AbZHKNLE (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Aug 2009 09:11:04 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KO700LETIYHLEC0@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Tue, 11 Aug 2009 12:11:05 +0200 (MEST)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KO7008QYIY6Z330@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Tue, 11 Aug 2009 12:11:05 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.8.11.95426
X-Mailer: git-send-email 1.6.4.rc3.138.ga6b98.dirty
In-reply-to: <alpine.LNX.2.00.0908101205120.27553@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125550>

Signed-off-by: Johan Herland <johan@herland.net>
---
 t/t5590-remote-helper-missing.sh |   56 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 56 insertions(+), 0 deletions(-)
 create mode 100755 t/t5590-remote-helper-missing.sh

diff --git a/t/t5590-remote-helper-missing.sh b/t/t5590-remote-helper-missing.sh
new file mode 100755
index 0000000..3bc2bc2
--- /dev/null
+++ b/t/t5590-remote-helper-missing.sh
@@ -0,0 +1,56 @@
+#!/bin/sh
+
+test_description='test graceful failure when missing remote helper program'
+. ./test-lib.sh
+
+test_expect_success 'setup repository' '
+	echo content >file &&
+	git add file &&
+	git commit -m one &&
+	git config remote.missing.vcs foo &&
+	git remote add missing2 foo:/nonexisting/path
+'
+
+test_expect_success 'fetch changes from "missing" remote' '
+	cat <<EOF >expect &&
+warning: Could not find remote helper command "git remote-foo". Assuming native remote.
+EOF
+	! git fetch missing >actual 2>&1 &&
+	head -n1 actual >actual.first &&
+	test_cmp expect actual.first
+'
+
+test_expect_success 'fetch changes from "missing2" remote' '
+	cat <<EOF >expect &&
+warning: Could not find remote helper command "git remote-foo". Assuming native remote.
+EOF
+	! git fetch missing2 >actual 2>&1 &&
+	head -n1 actual >actual.first &&
+	test_cmp expect actual.first
+'
+
+test_expect_success 'push changes to "missing" remote' '
+	echo "more content" >>file &&
+	git add file &&
+	git commit -m two &&
+	cat <<EOF >expect &&
+warning: Could not find remote helper command "git remote-foo". Assuming native remote.
+EOF
+	! git push --all missing >actual 2>&1 &&
+	head -n1 actual >actual.first &&
+	test_cmp expect actual.first
+'
+
+test_expect_success 'push changes to "missing2" remote' '
+	echo "even more content" >>file &&
+	git add file &&
+	git commit -m three &&
+	cat <<EOF >expect &&
+warning: Could not find remote helper command "git remote-foo". Assuming native remote.
+EOF
+	! git push --all missing2 >actual 2>&1 &&
+	head -n1 actual >actual.first &&
+	test_cmp expect actual.first
+'
+
+test_done
-- 
1.6.4.rc3.138.ga6b98.dirty
