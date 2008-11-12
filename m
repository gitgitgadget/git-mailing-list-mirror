From: Jeff King <peff@peff.net>
Subject: [PATCH 3/5] status: show "-v" diff even for initial commit
Date: Wed, 12 Nov 2008 03:23:37 -0500
Message-ID: <20081112082337.GC3751@coredump.intra.peff.net>
References: <20081112081609.GA3720@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Santi =?utf-8?B?QsOpamFy?= <santi@agolina.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 12 09:24:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0B1y-0000Js-CX
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 09:24:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394AbYKLIXk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 03:23:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751382AbYKLIXk
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 03:23:40 -0500
Received: from peff.net ([208.65.91.99]:2354 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751378AbYKLIXj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 03:23:39 -0500
Received: (qmail 17671 invoked by uid 111); 12 Nov 2008 08:23:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 12 Nov 2008 03:23:38 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Nov 2008 03:23:37 -0500
Content-Disposition: inline
In-Reply-To: <20081112081609.GA3720@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100724>

Since we can use the same "diff against empty tree" trick as
we do for the non-initial case, it is trivial to make this
work.

Signed-off-by: Jeff King <peff@peff.net>
---
I ran across this while writing my test cases for the later patches. I
don't see any reason why it shouldn't behave this way, and I suspect the
reason was just that the original author saw how we did
"wt_status_print_initial" and didn't want to have to do the equivalent
for generating diff output.

 t/t7507-commit-verbose.sh |   29 +++++++++++++++++++++++++++++
 wt-status.c               |    5 +++--
 2 files changed, 32 insertions(+), 2 deletions(-)
 create mode 100755 t/t7507-commit-verbose.sh

diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
new file mode 100755
index 0000000..94b12e9
--- /dev/null
+++ b/t/t7507-commit-verbose.sh
@@ -0,0 +1,29 @@
+#!/bin/sh
+
+test_description='verbose commit template'
+. ./test-lib.sh
+
+cat >check-for-diff <<EOF
+#!$SHELL_PATH
+exec grep '^diff --git' "\$1"
+EOF
+chmod +x check-for-diff
+test_set_editor "$PWD/check-for-diff"
+
+cat >message <<'EOF'
+subject
+
+body
+EOF
+
+test_expect_success 'setup' '
+	echo content >file &&
+	git add file &&
+	git commit -F message
+'
+
+test_expect_success 'initial commit shows verbose diff' '
+	git commit --amend -v
+'
+
+test_done
diff --git a/wt-status.c b/wt-status.c
index c78588e..3edae43 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -279,7 +279,8 @@ static void wt_status_print_verbose(struct wt_status *s)
 	struct rev_info rev;
 
 	init_revisions(&rev, NULL);
-	setup_revisions(0, NULL, &rev, s->reference);
+	setup_revisions(0, NULL, &rev,
+		s->is_initial ? EMPTY_TREE_SHA1_HEX : s->reference);
 	rev.diffopt.output_format |= DIFF_FORMAT_PATCH;
 	rev.diffopt.detect_rename = 1;
 	DIFF_OPT_SET(&rev.diffopt, ALLOW_TEXTCONV);
@@ -352,7 +353,7 @@ void wt_status_print(struct wt_status *s)
 	else if (s->commitable)
 		 fprintf(s->fp, "# Untracked files not listed (use -u option to show untracked files)\n");
 
-	if (s->verbose && !s->is_initial)
+	if (s->verbose)
 		wt_status_print_verbose(s);
 	if (!s->commitable) {
 		if (s->amend)
-- 
1.6.0.4.883.g4593ee.dirty
