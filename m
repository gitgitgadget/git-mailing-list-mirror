From: Jeff King <peff@peff.net>
Subject: [PATCH v3 8/8] enable textconv for diff in verbose status/commit
Date: Sun, 26 Oct 2008 00:50:02 -0400
Message-ID: <20081026045002.GH21047@coredump.intra.peff.net>
References: <20081026043802.GA14530@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 26 05:51:23 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ktxaz-00069o-1m
	for gcvg-git-2@gmane.org; Sun, 26 Oct 2008 05:51:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751641AbYJZEuG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Oct 2008 00:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751495AbYJZEuG
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Oct 2008 00:50:06 -0400
Received: from peff.net ([208.65.91.99]:4383 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750779AbYJZEuF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Oct 2008 00:50:05 -0400
Received: (qmail 5104 invoked by uid 111); 26 Oct 2008 04:50:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 26 Oct 2008 00:50:04 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 26 Oct 2008 00:50:02 -0400
Content-Disposition: inline
In-Reply-To: <20081026043802.GA14530@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99148>

This diff is meant for human consumption, so it makes sense
to apply text conversion here, as we would for the regular
diff porcelain.

Signed-off-by: Jeff King <peff@peff.net>
---
Pretty straightforward, but depends on whether we find 7/8 acceptable.

 t/t4030-diff-textconv.sh |    8 ++++++++
 wt-status.c              |    1 +
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/t/t4030-diff-textconv.sh b/t/t4030-diff-textconv.sh
index 3945731..09967f5 100755
--- a/t/t4030-diff-textconv.sh
+++ b/t/t4030-diff-textconv.sh
@@ -76,6 +76,14 @@ test_expect_success 'format-patch produces binary' '
 	test_cmp expect.binary actual
 '
 
+test_expect_success 'status -v produces text' '
+	git reset --soft HEAD^ &&
+	git status -v >diff &&
+	find_diff <diff >actual &&
+	test_cmp expect.text actual &&
+	git reset --soft HEAD@{1}
+'
+
 cat >expect.stat <<'EOF'
  file |  Bin 2 -> 4 bytes
  1 files changed, 0 insertions(+), 0 deletions(-)
diff --git a/wt-status.c b/wt-status.c
index 54d2f58..6a7645e 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -301,6 +301,7 @@ static void wt_status_print_verbose(struct wt_status *s)
 	setup_revisions(0, NULL, &rev, s->reference);
 	rev.diffopt.output_format |= DIFF_FORMAT_PATCH;
 	rev.diffopt.detect_rename = 1;
+	DIFF_OPT_SET(&rev.diffopt, ALLOW_TEXTCONV);
 	rev.diffopt.file = s->fp;
 	rev.diffopt.close_file = 0;
 	/*
-- 
1.6.0.3.524.ge8b2e.dirty
