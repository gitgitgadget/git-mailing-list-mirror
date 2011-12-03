From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH 2/2] builtin/apply.c: report error on failure to recognize input
Date: Sat,  3 Dec 2011 14:35:50 -0600
Message-ID: <1322944550-27344-2-git-send-email-drafnel@gmail.com>
References: <1322944550-27344-1-git-send-email-drafnel@gmail.com>
Cc: artem.bityutskiy@linux.intel.com, Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 03 21:36:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RWwKG-0003jF-UI
	for gcvg-git-2@lo.gmane.org; Sat, 03 Dec 2011 21:36:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753625Ab1LCUgH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Dec 2011 15:36:07 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:51427 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752896Ab1LCUgE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Dec 2011 15:36:04 -0500
Received: by yenm1 with SMTP id m1so1045749yen.19
        for <git@vger.kernel.org>; Sat, 03 Dec 2011 12:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=TDS6Z1etHSn+VCNRoB1ZmtM9HIx3wObRO07hEoyy4yY=;
        b=XQOIJQmBk6AWpva/D+sLG1wYOzpjQa0fBoyyIKCtTLJVxtOoHrzMsGZHu79WRUz2cL
         B8LKpq97Ig62NqZh3DVuG7nU0CxjG+xdlFOVIrf1hL8rURpv9z0F5fQYWCGhIkP+qPX8
         3yeyjbTgi/BJZalWV3mqQqNG/quEggaVGaUAM=
Received: by 10.236.154.166 with SMTP id h26mr4173275yhk.88.1322944563420;
        Sat, 03 Dec 2011 12:36:03 -0800 (PST)
Received: from localhost.localdomain (adsl-74-243-58-53.bix.bellsouth.net. [74.243.58.53])
        by mx.google.com with ESMTPS id q16sm13442727anb.19.2011.12.03.12.36.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 03 Dec 2011 12:36:02 -0800 (PST)
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1322944550-27344-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186260>

When git apply is passed something that is not a patch, it does not produce
an error message or exit with a non-zero status if it was not actually
"applying" the patch i.e. --check or --numstat etc were supplied on the
command line.

Fix this by producing an error when apply fails to find any hunks whatsoever
while parsing the patch.

This will cause some of the output formats (--numstat, --diffstat, etc) to
produce an error when they formerly would have reported zero changes and
exited successfully.  That seems like the correct behavior though.  Failure
to recognize the input as a patch should be an error.

Plus, add a test.

Reported-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Signed-off-by: Brandon Casey <drafnel@gmail.com>
---


Initially, I was reluctant to change the error message, thinking that
error messages for plumbing commands were not supposed to change.  But I
think I was wrong in that thought, so I changed the error message so it
was a more descriptive "unrecognized input".

-Brandon


 builtin/apply.c        |   10 +++++-----
 t/t4136-apply-check.sh |   19 +++++++++++++++++++
 2 files changed, 24 insertions(+), 5 deletions(-)
 create mode 100755 t/t4136-apply-check.sh

diff --git a/builtin/apply.c b/builtin/apply.c
index 84a8a0b..46dcf3c 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3590,15 +3590,12 @@ static int write_out_one_reject(struct patch *patch)
 	return -1;
 }
 
-static int write_out_results(struct patch *list, int skipped_patch)
+static int write_out_results(struct patch *list)
 {
 	int phase;
 	int errs = 0;
 	struct patch *l;
 
-	if (!list && !skipped_patch)
-		return error("No changes");
-
 	for (phase = 0; phase < 2; phase++) {
 		l = list;
 		while (l) {
@@ -3724,6 +3721,9 @@ static int apply_patch(int fd, const char *filename, int options)
 		offset += nr;
 	}
 
+	if (!list && !skipped_patch)
+		die("unrecognized input");
+
 	if (whitespace_error && (ws_error_action == die_on_ws_error))
 		apply = 0;
 
@@ -3741,7 +3741,7 @@ static int apply_patch(int fd, const char *filename, int options)
 	    !apply_with_reject)
 		exit(1);
 
-	if (apply && write_out_results(list, skipped_patch))
+	if (apply && write_out_results(list))
 		exit(1);
 
 	if (fake_ancestor)
diff --git a/t/t4136-apply-check.sh b/t/t4136-apply-check.sh
new file mode 100755
index 0000000..a321f7c
--- /dev/null
+++ b/t/t4136-apply-check.sh
@@ -0,0 +1,19 @@
+#!/bin/sh
+
+test_description='git apply should exit non-zero with unrecognized input.'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_commit 1
+'
+
+test_expect_success 'apply --check exits non-zero with unrecognized input' '
+	test_must_fail git apply --check - <<-\EOF
+	I am not a patch
+	I look nothing like a patch
+	git apply must fail
+	EOF
+'
+
+test_done
-- 
1.7.8
