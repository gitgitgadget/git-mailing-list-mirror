From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH] diff-tree: do not show the sha1 of the given head with
 --quiet
Date: Wed, 22 Jul 2015 09:29:42 +0000
Message-ID: <0000014eb518dc87-a69705c4-31e7-4983-99a8-f780a743aeac-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 22 11:44:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHqZE-0004hd-Gu
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jul 2015 11:44:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932900AbbGVJn4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2015 05:43:56 -0400
Received: from a6-243.smtp-out.eu-west-1.amazonses.com ([54.240.6.243]:43008
	"EHLO a6-243.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932172AbbGVJnz (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Jul 2015 05:43:55 -0400
X-Greylist: delayed 851 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 Jul 2015 05:43:55 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1437557382;
	h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
	bh=kDoSBaMDgnD5cehq5lU0zKqNzeurseLlorFlWCjKHWE=;
	b=GBOGsjzfMYNuqly3xzLiBtOG66+QNRXyzuwkcJpwOiAmyq9lYDJy4UUnZCnmq/4k
	4n3Ydy5U2d/2Pzs/shoTcuGVV2w6EIY+j+JTXwXSRmXhZtL3BfZHGOKIOm8plAwPR99
	FeFe82ljT0gCEZvSg3Ud3PzXSTHRQPFfkryGu/yk=
X-SES-Outgoing: 2015.07.22-54.240.6.243
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274438>

"--quite" is documented to "Disable all output of the program". Yet
calling diff-tree with a single commit like

$ git diff-tree --quiet c925fe2

was logging

c925fe23684455735c3bb1903803643a24a58d8f

to the console despite "--quite" being given. This is inconsistent with
both the docs and the behavior if more than a single commit is passed to
diff-tree. Moreover, the output of that single line seems to be documented
nowhere except in a comment for a test. Fix this inconsistency by making
diff-tree really output nothing if "--quiet" is given and fix the test
accordingly.

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 log-tree.c            | 3 ++-
 t/t4035-diff-quiet.sh | 3 +--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 01beb11..3c98234 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -741,7 +741,8 @@ int log_tree_diff_flush(struct rev_info *opt)
 	}
 
 	if (opt->loginfo && !opt->no_commit_id) {
-		show_log(opt);
+		if (!DIFF_OPT_TST(&opt->diffopt, QUICK))
+			show_log(opt);
 		if ((opt->diffopt.output_format & ~DIFF_FORMAT_NO_OUTPUT) &&
 		    opt->verbose_header &&
 		    opt->commit_format != CMIT_FMT_ONELINE &&
diff --git a/t/t4035-diff-quiet.sh b/t/t4035-diff-quiet.sh
index 461f4bb..9a8225f 100755
--- a/t/t4035-diff-quiet.sh
+++ b/t/t4035-diff-quiet.sh
@@ -40,11 +40,10 @@ test_expect_success 'git diff-tree HEAD^ HEAD -- b' '
 	test_expect_code 1 git diff-tree --quiet HEAD^ HEAD -- b >cnt &&
 	test_line_count = 0 cnt
 '
-# this diff outputs one line: sha1 of the given head
 test_expect_success 'echo HEAD | git diff-tree --stdin' '
 	echo $(git rev-parse HEAD) |
 	test_expect_code 1 git diff-tree --quiet --stdin >cnt &&
-	test_line_count = 1 cnt
+	test_line_count = 0 cnt
 '
 test_expect_success 'git diff-tree HEAD HEAD' '
 	test_expect_code 0 git diff-tree --quiet HEAD HEAD >cnt &&

---
https://github.com/git/git/pull/163
