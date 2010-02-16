From: Larry D'Anna <larry@elder-gods.org>
Subject: [PATCH 2/2] bugfix: git diff --quiet -w never returns with exit status 1
Date: Tue, 16 Feb 2010 01:55:21 -0500
Message-ID: <1266303321-28337-1-git-send-email-larry@elder-gods.org>
References: <20100216064539.GA18741@cthulhu>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Larry D'Anna <larry@elder-gods.org>
To: Larry D'Anna <larry@elder-gods.org>
X-From: git-owner@vger.kernel.org Tue Feb 16 07:55:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhHLP-0006La-TE
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 07:55:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754266Ab0BPGzf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 01:55:35 -0500
Received: from cthulhu.elder-gods.org ([140.239.99.253]:47914 "EHLO
	cthulhu.elder-gods.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753917Ab0BPGze (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 01:55:34 -0500
Received: by cthulhu.elder-gods.org (Postfix, from userid 1000)
	id D6C76822010; Tue, 16 Feb 2010 01:55:33 -0500 (EST)
X-Mailer: git-send-email 1.7.0.rc2.40.g7d8aa
In-Reply-To: <20100216064539.GA18741@cthulhu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140076>

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
 diff.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/diff.c b/diff.c
index 68def6c..2984c41 100644
--- a/diff.c
+++ b/diff.c
@@ -3522,6 +3522,29 @@ void diff_flush(struct diff_options *options)
 		separator++;
 	}
 
+	if (output_format & DIFF_FORMAT_NO_OUTPUT &&
+	    DIFF_OPT_TST(options, EXIT_WITH_STATUS) &&
+	    DIFF_OPT_TST(options, DIFF_FROM_CONTENTS)) {
+		/*
+		 * run diff_flush_patch for the exit status.
+		 * setting options->file to /dev/null should be safe, becaue we
+		 * aren't supposed to produce any output anyways
+		 */
+		if (options->close_file)
+			fclose(options->file);
+		options->file = fopen("/dev/null", "w");
+		if (!options->file)
+			die_errno("Could not open /dev/null");
+		options->close_file = 1;
+		for (i = 0; i < q->nr; i++) {
+			struct diff_filepair *p = q->queue[i];
+			if (check_pair_status(p))
+				diff_flush_patch(p, options);
+			if (options->found_changes)
+				break;
+		}
+	}
+
 	if (output_format & DIFF_FORMAT_PATCH) {
 		if (separator) {
 			putc(options->line_termination, options->file);
-- 
1.7.0.rc2.40.g7d8aa
