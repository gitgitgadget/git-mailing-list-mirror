From: Larry D'Anna <larry@elder-gods.org>
Subject: [PATCH 2/2] bugfix: git diff --quiet -w never returns with exit status 1
Date: Mon, 15 Feb 2010 23:10:46 -0500
Message-ID: <1266293446-8092-2-git-send-email-larry@elder-gods.org>
References: <1266293446-8092-1-git-send-email-larry@elder-gods.org>
Cc: Larry D'Anna <larry@elder-gods.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 05:11:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhEmD-0004OH-2P
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 05:11:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932593Ab0BPEK4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2010 23:10:56 -0500
Received: from cthulhu.elder-gods.org ([140.239.99.253]:58100 "EHLO
	cthulhu.elder-gods.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932547Ab0BPEKy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2010 23:10:54 -0500
Received: by cthulhu.elder-gods.org (Postfix, from userid 1000)
	id E75EE822010; Mon, 15 Feb 2010 23:10:53 -0500 (EST)
X-Mailer: git-send-email 1.7.0.rc2.40.g7d8aa
In-Reply-To: <1266293446-8092-1-git-send-email-larry@elder-gods.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140065>

The problem: -w causes the flag DIFF_FROM_CONTENTS to be set, which causes
diff_flush to set the flag HAS_CHANGES based on options->found_changes, which is
set by diff_flush_patch (if there were any changes).  However, --quiet causes
diff_flush to never call diff_flush_patch, so options->found_changes is always 0.

The solution: In this situation, call diff_flush_patch with options->file set to
/dev/null.

Rationale: diff_flush_patch expects to write its output to options->file.
Adding a "silence" flag to diff_flush_patch and everything it calls would be
more invasive.

Signed-off-by: Larry D'Anna <larry@elder-gods.org>
---
 diff.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/diff.c b/diff.c
index 68def6c..ff00816 100644
--- a/diff.c
+++ b/diff.c
@@ -3522,6 +3522,26 @@ void diff_flush(struct diff_options *options)
 		separator++;
 	}
 
+	if (output_format & DIFF_FORMAT_NO_OUTPUT &&
+	    DIFF_OPT_TST(options, EXIT_WITH_STATUS) &&
+	    DIFF_OPT_TST(options, DIFF_FROM_CONTENTS)) {
+		/* run diff_flush_patch for the exit status */
+		/* setting options->file to /dev/null should be safe, becaue we
+		   aren't supposed to produce any output anyways */
+		static FILE *devnull = NULL;
+		if(!devnull) {
+			devnull = fopen("/dev/null", "w");
+			if (!devnull)
+				die_errno("Could not open /dev/null");
+		}
+		options->file = devnull;
+		for (i = 0; i < q->nr; i++) {
+			struct diff_filepair *p = q->queue[i];
+			if (check_pair_status(p))
+				diff_flush_patch(p, options);
+		}
+	}
+
 	if (output_format & DIFF_FORMAT_PATCH) {
 		if (separator) {
 			putc(options->line_termination, options->file);
-- 
1.7.0.rc2.40.g7d8aa
