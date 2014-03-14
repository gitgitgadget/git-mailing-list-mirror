From: Uwe Storbeck <uwe@ibr.ch>
Subject: [PATCH/RFC] t3404: test autosquash for fixup! commits with funny
 messages
Date: Sat, 15 Mar 2014 00:58:11 +0100
Message-ID: <20140314235811.GA4213@ibr.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 15 00:58:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WObzV-0008EI-9q
	for gcvg-git-2@plane.gmane.org; Sat, 15 Mar 2014 00:58:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756315AbaCNX6N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2014 19:58:13 -0400
Received: from gate.ibr.ch ([83.150.36.130]:47256 "EHLO gate.ibr.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752030AbaCNX6N (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2014 19:58:13 -0400
Received: from bacardi.ibr.ch (bacardi.ibr.ch [172.16.1.1])
	by gate.ibr.ch (Postfix) with ESMTP id 33F6613B62A
	for <git@vger.kernel.org>; Sat, 15 Mar 2014 00:58:12 +0100 (CET)
Received: from grappa.ibr.ch (grappa [172.16.8.20])
	by bacardi.ibr.ch (Postfix) with ESMTP id A6953153F5
	for <git@vger.kernel.org>; Sat, 15 Mar 2014 00:58:11 +0100 (CET)
Received: by grappa.ibr.ch (Postfix, from userid 1111)
	id 043B9D0AF7; Sat, 15 Mar 2014 00:58:11 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244127>

This commit adds a test to verify the correct behavior when
rebase -i is used to autosquash fixup! commits where the commit
message contains a backslash sequence (\n).

When echo is used instead of printf to handle such a commit
message the test will fail on shells (e.g. dash) where the echo
command interprets backslash sequences as control characters.

Signed-off-by: Uwe Storbeck <uwe@ibr.ch>
---
 t/t3404-rebase-interactive.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 50e22b1..6d32661 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -798,6 +798,18 @@ test_expect_success 'rebase-i history with funny messages' '
 	test_cmp expect actual
 '
 
+test_expect_success 'autosquash fixup! commits with funny messages' '
+	test_when_finished "git rebase --abort || :" &&
+	echo >>file1 &&
+	git commit -a -m "something that looks like a newline (\n)" &&
+	echo >>file1 &&
+	git commit -a --fixup HEAD &&
+	set_fake_editor &&
+	FAKE_LINES="" &&
+	export FAKE_LINES &&
+	git rebase -i --autosquash HEAD~2
+'
+
 
 test_expect_success 'prepare for rebase -i --exec' '
 	git checkout master &&
-- 
1.9.0
