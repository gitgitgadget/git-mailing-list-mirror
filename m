From: Jeff King <peff@peff.net>
Subject: [PATCH] fix off-by-one error in split_ident_line
Date: Tue, 22 May 2012 02:12:20 -0400
Message-ID: <20120522061220.GA17886@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Bryan Turner <bturner@atlassian.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 22 08:12:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWiKb-0005md-8c
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 08:12:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328Ab2EVGMY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 May 2012 02:12:24 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51505
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751168Ab2EVGMX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2012 02:12:23 -0400
Received: (qmail 13337 invoked by uid 107); 22 May 2012 06:12:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 22 May 2012 02:12:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 May 2012 02:12:20 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198182>

Commit 4b340cf split the logic to parse an ident line out of
pretty.c's format_person_part. But in doing so, it
accidentally introduced an off-by-one error that caused it
to think that single-character names were invalid.

This manifested itself as the "%an" format failing to show
anything at all for a single-character name.

Reported-by: Brian Turner <bturner@atlassian.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 ident.c                    | 2 +-
 t/t6006-rev-list-format.sh | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/ident.c b/ident.c
index 87c697c..5df094d 100644
--- a/ident.c
+++ b/ident.c
@@ -244,7 +244,7 @@ int split_ident_line(struct ident_split *split, const char *line, int len)
 	if (!split->mail_begin)
 		return status;
 
-	for (cp = split->mail_begin - 2; line < cp; cp--)
+	for (cp = split->mail_begin - 2; line <= cp; cp--)
 		if (!isspace(*cp)) {
 			split->name_end = cp + 1;
 			break;
diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index a01d244..f94f0c4 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -283,4 +283,11 @@ test_expect_success 'oneline with empty message' '
 	test_line_count = 5 testg.txt
 '
 
+test_expect_success 'single-character name is parsed correctly' '
+	git commit --author="a <a@example.com>" --allow-empty -m foo &&
+	echo "a <a@example.com>" >expect &&
+	git log -1 --format="%an <%ae>" >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.7.9.7.33.gc430a50
