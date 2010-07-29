From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] t7005: fix subdirectory-filter test
Date: Thu, 29 Jul 2010 17:10:22 +0200
Message-ID: <8fe9ee3cfe2404b719fc0464db9a34c09175052a.1280416055.git.trast@student.ethz.ch>
References: <4C519810.6090108@dbservice.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Tomas Carnecky <tom@dbservice.com>, <ramercer@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 29 17:10:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeUkf-0001pw-Sf
	for gcvg-git-2@lo.gmane.org; Thu, 29 Jul 2010 17:10:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754224Ab0G2PKZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jul 2010 11:10:25 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:42359 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753848Ab0G2PKY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jul 2010 11:10:24 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Thu, 29 Jul
 2010 17:10:22 +0200
Received: from localhost.localdomain (129.132.153.233) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.0.702.0; Thu, 29 Jul
 2010 17:10:20 +0200
X-Mailer: git-send-email 1.7.2.1.342.g676a4
In-Reply-To: <4C519810.6090108@dbservice.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152181>

The test would not fail if the filtering failed to do anything, since
in

  test -z "$(git diff HEAD directorymoved:newsubdir)"'

'directorymoved:newsubdir' is not valid, so git-diff fails without
printing anything on stdout.  But then the exit status of git-diff is
lost, whereas test -z "" succeeds.

Use 'git diff --exit-code' instead, which does the right thing and has
the added bonus of showing the differences if there are any.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Tomas Carnecky wrote:
> Now the test fails. And with the other patch applied on top of it, the
> test passes again.

Ok.  Here's a slightly nicer solution, let's add this on top of the
earlier patch.

 t/t7003-filter-branch.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index e90da6d..84c2612 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -148,7 +148,8 @@ test_expect_success 'use index-filter to move into a subdirectory' '
 	          GIT_INDEX_FILE=\$GIT_INDEX_FILE.new \
 			git update-index --index-info &&
 		  mv \"\$GIT_INDEX_FILE.new\" \"\$GIT_INDEX_FILE\"" directorymoved &&
-	test -z "$(git diff HEAD directorymoved:newsubdir)"'
+	git diff --exit-code HEAD directorymoved:newsubdir
+'
 
 test_expect_success 'stops when msg filter fails' '
 	old=$(git rev-parse HEAD) &&
-- 
1.7.2.1.342.g676a4
