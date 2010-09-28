From: Tomas Carnecky <tom@dbservice.com>
Subject: [PATCH] stash drops the stash even if creating the branch fails because it already exists
Date: Tue, 28 Sep 2010 13:25:20 +0200
Message-ID: <1285673120-43354-1-git-send-email-tom@dbservice.com>
Cc: tla@land.ru, Tomas Carnecky <tom@dbservice.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 28 13:34:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0YS7-0003Bg-33
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 13:34:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751869Ab0I1LeR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Sep 2010 07:34:17 -0400
Received: from gw.ptr-62-65-141-13.customer.ch.netstream.com ([62.65.141.13]:65113
	"EHLO calvin.caurea.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751141Ab0I1LeR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Sep 2010 07:34:17 -0400
X-Greylist: delayed 523 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Sep 2010 07:34:17 EDT
Received: by calvin.caurea.org (Postfix, from userid 501)
	id 9817E2372438; Tue, 28 Sep 2010 13:25:32 +0200 (CEST)
X-Mailer: git-send-email 1.7.3.3.gd2416
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157409>

This bug was disovered by someone on IRC when he tried to 'git stash branch <branch> <stash>'
while <branch> already existed. In that case the stash is dropped even though it isn't
applied on any branch, so the stash is effectively lost. I think that shouldn't happen,
so here is a test.

---
 t/t3903-stash.sh |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 9ed2396..0f6b2e4 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -545,4 +545,15 @@ test_expect_success 'invalid ref of the form stash@{n}, n >= N' '
 	git stash drop
 '
 
+test_expect_failure 'stash branch should not drop the stash if the branch exists' '
+	git stash clear &&
+	echo foo > file &&
+	git add file &&
+	git commit -m initial &&
+	echo bar > file &&
+	git stash &&
+	test_must_fail git stash branch master stash@{0} &&
+	git rev-parse stash@{0} --
+'
+
 test_done
-- 
1.7.3.3.gd2416
