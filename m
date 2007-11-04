From: Brian Gernhardt <benji@silverinsanity.com>
Subject: [PATCH 2/1] format-patch: Test --[no-]numbered and format.numbered
Date: Sun, 4 Nov 2007 01:50:23 -0400
Message-ID: <20071104055023.GA46329@Hermes.local>
References: <C9FC46B6-AF2E-4E61-A272-2C46BFA33641@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 04 06:50:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoYNc-0007xp-8H
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 06:50:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752959AbXKDFu0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 01:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752255AbXKDFu0
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 01:50:26 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:39804 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752041AbXKDFu0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 01:50:26 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by silverinsanity.com (Postfix) with ESMTP id 0BD4A1FFC229
	for <git@vger.kernel.org>; Sun,  4 Nov 2007 05:50:24 +0000 (UTC)
Received: from Mutt by mutt-smtp-wrapper.pl 1.2  (www.zdo.com/articles/mutt-smtp-wrapper.shtml)
Content-Disposition: inline
In-Reply-To: <C9FC46B6-AF2E-4E61-A272-2C46BFA33641@silverinsanity.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63355>

Just because there wasn't a test for --numbered isn't a good reason
not to test format.numbered.  So now we test both.

Signed-off-by: Brian Gernhardt <benji@silverinsanity.com>
---

 And here's that something I hacked up.  Hmm... that doesn't sound
 sanitary.

 As a side note, send-email is hard to troubleshoot.  Is there a way to
 get it to give more than "your setup doesn't work"?  And is the pile of
 warnings (mostly "Use of uninitialized value") in Term::Readline just a
 problem in my setup?  I tried to use it instead of mutt and did not
 have a happy experience.

 t/t4021-format-patch-numbered.sh |  106 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 106 insertions(+), 0 deletions(-)
 create mode 100755 t/t4021-format-patch-numbered.sh

diff --git a/t/t4021-format-patch-numbered.sh b/t/t4021-format-patch-numbered.sh
new file mode 100755
index 0000000..43d64bb
--- /dev/null
+++ b/t/t4021-format-patch-numbered.sh
@@ -0,0 +1,106 @@
+#!/bin/sh
+#
+# Copyright (c) 2006 Brian C Gernhardt
+#
+
+test_description='Format-patch numbering options'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+
+	echo A > file &&
+	git add file &&
+	git commit -m First &&
+
+	echo B >> file &&
+	git commit -a -m Second &&
+
+	echo C >> file &&
+	git commit -a -m Third
+
+'
+
+# Each of these gets used multiple times.
+
+test_num_no_numbered() {
+	cnt=$(grep "^Subject: \[PATCH\]" $1 | wc -l) &&
+	test $cnt = $2
+}
+
+test_single_no_numbered() {
+	test_num_no_numbered $1 1
+}
+
+test_no_numbered() {
+	test_num_no_numbered $1 2
+}
+
+test_single_numbered() {
+	grep "^Subject: \[PATCH 1/1\]" $1
+}
+
+test_numbered() {
+	grep "^Subject: \[PATCH 1/2\]" $1 &&
+	grep "^Subject: \[PATCH 2/2\]" $1
+}
+
+test_expect_success 'Default: no numbered' '
+
+	git format-patch --stdout HEAD~2 >patch0 &&
+	test_no_numbered patch0
+
+'
+
+test_expect_success 'Use --numbered' '
+
+	git format-patch --numbered --stdout HEAD~2 >patch1 &&
+	test_numbered patch1
+
+'
+
+test_expect_success 'format.numbered = true' '
+
+	git config format.numbered true &&
+	git format-patch --stdout HEAD~2 >patch2 &&
+	test_numbered patch2
+
+'
+
+test_expect_success 'format.numbered && single patch' '
+
+	git format-patch --stdout HEAD^ > patch3 &&
+	test_single_numbered patch3
+
+'
+
+test_expect_success 'format.numbered && --no-numbered' '
+
+	git format-patch --no-numbered --stdout HEAD~2 >patch4 &&
+	test_no_numbered patch4
+
+'
+
+test_expect_success 'format.numbered = auto' '
+
+	git config format.numbered auto
+	git format-patch --stdout HEAD~2 > patch5 &&
+	test_numbered patch5
+
+'
+
+test_expect_success 'format.numbered = auto && single patch' '
+
+	git format-patch --stdout HEAD^ > patch6 &&
+	test_single_no_numbered patch6
+
+'
+
+test_expect_success 'format.numbered = auto && --no-numbered' '
+
+	git format-patch --no-numbered --stdout HEAD~2 > patch7 &&
+	test_no_numbered patch7
+
+'
+
+test_done
-- 
1.5.3.5.530.gcd7a
