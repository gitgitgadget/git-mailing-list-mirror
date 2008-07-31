From: Jeff King <peff@peff.net>
Subject: [PATCH] Advertise the ability to abort a commit
Date: Thu, 31 Jul 2008 02:36:19 -0400
Message-ID: <20080731063619.GA28345@sigill.intra.peff.net>
References: <7vwsj23896.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Anders Melchiorsen <mail@cup.kalibalik.dk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 31 08:37:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KORmt-0004aX-9H
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 08:37:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751658AbYGaGgW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 02:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752485AbYGaGgV
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 02:36:21 -0400
Received: from peff.net ([208.65.91.99]:4760 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751519AbYGaGgV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 02:36:21 -0400
Received: (qmail 20185 invoked by uid 111); 31 Jul 2008 06:36:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 31 Jul 2008 02:36:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 31 Jul 2008 02:36:19 -0400
Content-Disposition: inline
In-Reply-To: <7vwsj23896.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90898>

From: Anders Melchiorsen <mail@cup.kalibalik.dk>

We explicitly let the user know that an empty commit message
will abort the commit. At the same time, we take the
opportunity to reword the template text a bit to keep it
more compact.

This patch also makes the "fatal: empty commit message?"
warning a bit less scary, since this is now a "feature"
instead of an error. However, we retain the non-zero exit
status to indicate to callers that nothing was committed.

[jk: I compacted the text and expanded the commit message
from Anders' original patch]

Signed-off-by: Anders Melchiorsen <mail@cup.kalibalik.dk>
Signed-off-by: Jeff King <peff@peff.net>
---
 builtin-commit.c  |   18 ++++++++++++------
 t/t7502-commit.sh |    4 ++--
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 9a11ca0..b783e6e 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -554,13 +554,18 @@ static int prepare_to_commit(const char *index_file, const char *prefix)
 
 		fprintf(fp,
 			"\n"
-			"# Please enter the commit message for your changes.\n"
-			"# (Comment lines starting with '#' will ");
+			"# Please enter the commit message for your changes.");
 		if (cleanup_mode == CLEANUP_ALL)
-			fprintf(fp, "not be included)\n");
+			fprintf(fp,
+				" Lines starting\n"
+				"# with '#' will be ignored, and an empty"
+				" message aborts the commit.\n");
 		else /* CLEANUP_SPACE, that is. */
-			fprintf(fp, "be kept.\n"
-				"# You can remove them yourself if you want to)\n");
+			fprintf(fp,
+				" Lines starting\n"
+				"# with '#' will be kept; you may remove them"
+				" yourself if you want to.\n"
+				"# An empty message aborts the commit.\n");
 		if (only_include_assumed)
 			fprintf(fp, "# %s\n", only_include_assumed);
 
@@ -1003,7 +1008,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		stripspace(&sb, cleanup_mode == CLEANUP_ALL);
 	if (sb.len < header_len || message_is_empty(&sb, header_len)) {
 		rollback_index_files();
-		die("no commit message?  aborting commit.");
+		fprintf(stderr, "Aborting commit due to empty commit message.\n");
+		exit(1);
 	}
 	strbuf_addch(&sb, '\0');
 	if (is_encoding_utf8(git_commit_encoding) && !is_utf8(sb.buf))
diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index 4f2682e..3eb9fae 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -141,8 +141,8 @@ test_expect_success 'cleanup commit messages (strip,-F)' '
 
 echo "sample
 
-# Please enter the commit message for your changes.
-# (Comment lines starting with '#' will not be included)" >expect
+# Please enter the commit message for your changes. Lines starting
+# with '#' will be ignored, and an empty message aborts the commit." >expect
 
 test_expect_success 'cleanup commit messages (strip,-F,-e)' '
 
-- 
1.6.0.rc1.168.g8c00d.dirty
