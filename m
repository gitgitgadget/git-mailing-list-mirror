From: Sven Verdoolaege <skimo@kotnet.org>
Subject: [PATCH] git-diff: don't squelch the new SHA1 in submodule diffs
Date: Sat, 08 Sep 2007 12:30:22 +0200
Message-ID: <20070908103022.GA15229MdfPADPa@greensroom.kotnet.org>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 08 12:30:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITxaC-0006UY-1O
	for gcvg-git@gmane.org; Sat, 08 Sep 2007 12:30:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbXIHKaZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Sep 2007 06:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbXIHKaY
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Sep 2007 06:30:24 -0400
Received: from psmtp09.wxs.nl ([195.121.247.23]:55151 "EHLO psmtp09.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750918AbXIHKaY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Sep 2007 06:30:24 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp09.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JO100H4UP6M6R@psmtp09.wxs.nl> for git@vger.kernel.org; Sat,
 08 Sep 2007 12:30:23 +0200 (MEST)
Received: (qmail 15269 invoked by uid 500); Sat, 08 Sep 2007 10:30:22 +0000
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58116>

The code to squelch empty diffs introduced by commit
fb13227e089f22dc31a3b1624559153821056848 would inadvertently
populate filespec "two" of a submodule change using the uninitialized
(null) SHA1, thereby replacing the submodule SHA1 by 0{40} in the output.

This change teaches diffcore_skip_stat_unmatch to handle
submodule changes correctly.

Signed-off-by: Sven Verdoolaege <skimo@kotnet.org>
---
 diff.c                     |   21 +++++++++++++++++----
 t/t7400-submodule-basic.sh |    4 ++++
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/diff.c b/diff.c
index 0d30d05..1aca5df 100644
--- a/diff.c
+++ b/diff.c
@@ -3144,6 +3144,22 @@ static void diffcore_apply_filter(const char *filter)
 	*q = outq;
 }
 
+/* Check whether two filespecs with the same mode and size are identical */
+static int diff_filespec_is_identical(struct diff_filespec *one,
+				      struct diff_filespec *two)
+{
+	if (S_ISGITLINK(one->mode)) {
+		diff_fill_sha1_info(one);
+		diff_fill_sha1_info(two);
+		return !hashcmp(one->sha1, two->sha1);
+	}
+	if (diff_populate_filespec(one, 0))
+		return 0;
+	if (diff_populate_filespec(two, 0))
+		return 0;
+	return !memcmp(one->data, two->data, one->size);
+}
+
 static void diffcore_skip_stat_unmatch(struct diff_options *diffopt)
 {
 	int i;
@@ -3175,10 +3191,7 @@ static void diffcore_skip_stat_unmatch(struct diff_options *diffopt)
 		    diff_populate_filespec(p->one, 1) ||
 		    diff_populate_filespec(p->two, 1) ||
 		    (p->one->size != p->two->size) ||
-
-		    diff_populate_filespec(p->one, 0) || /* (2) */
-		    diff_populate_filespec(p->two, 0) ||
-		    memcmp(p->one->data, p->two->data, p->one->size))
+		    !diff_filespec_is_identical(p->one, p->two)) /* (2) */
 			diff_q(&outq, p);
 		else {
 			/*
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 9d142ed..4fe3a41 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -152,6 +152,10 @@ test_expect_success 'the --cached sha1 should be rev1' '
 	git-submodule --cached status | grep "^+$rev1"
 '
 
+test_expect_success 'git diff should report the SHA1 of the new submodule commit' '
+	git-diff | grep "^+Subproject commit $rev2"
+'
+
 test_expect_success 'update should checkout rev1' '
 	git-submodule update &&
 	head=$(cd lib && git rev-parse HEAD) &&
-- 
1.5.3.1.20.g3d038
