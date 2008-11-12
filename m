From: Jeff King <peff@peff.net>
Subject: [PATCH 4/5] commit: loosen pattern for matching "-v" diff
Date: Wed, 12 Nov 2008 03:24:10 -0500
Message-ID: <20081112082410.GD3751@coredump.intra.peff.net>
References: <20081112081609.GA3720@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Santi =?utf-8?B?QsOpamFy?= <santi@agolina.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 12 09:25:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0B2V-0000Tn-65
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 09:25:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751427AbYKLIYN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 03:24:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbYKLIYN
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 03:24:13 -0500
Received: from peff.net ([208.65.91.99]:2360 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751399AbYKLIYM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 03:24:12 -0500
Received: (qmail 17695 invoked by uid 111); 12 Nov 2008 08:24:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 12 Nov 2008 03:24:11 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Nov 2008 03:24:10 -0500
Content-Disposition: inline
In-Reply-To: <20081112081609.GA3720@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100725>

When a user asks to see the diff to be applied via "git
commit -v", the diff ends up in the commit template, and we
must later remove it.

To detect the start of the included diff, we used to search
for a line beginning with "diff --git a/". However, in the
face of diff.mnemonicprefix, that will actually be "diff
--git i/".

So let's just loosen the pattern a bit to handle either
case.

Signed-off-by: Jeff King <peff@peff.net>
---
And this is the fix from before, with a test case.

 builtin-commit.c          |    2 +-
 t/t7507-commit-verbose.sh |   16 ++++++++++++++++
 2 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 93ca496..a721990 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -1015,7 +1015,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	}
 
 	/* Truncate the message just before the diff, if any. */
-	p = strstr(sb.buf, "\ndiff --git a/");
+	p = strstr(sb.buf, "\ndiff --git ");
 	if (p != NULL)
 		strbuf_setlen(&sb, p - sb.buf + 1);
 
diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
index 94b12e9..be70166 100755
--- a/t/t7507-commit-verbose.sh
+++ b/t/t7507-commit-verbose.sh
@@ -26,4 +26,20 @@ test_expect_success 'initial commit shows verbose diff' '
 	git commit --amend -v
 '
 
+check_message() {
+	git log -1 --pretty=format:%s%n%n%b >actual &&
+	test_cmp "$1" actual
+}
+
+test_expect_success 'verbose diff is stripped out' '
+	git commit --amend -v &&
+	check_message message
+'
+
+test_expect_success 'verbose diff is stripped out (mnemonicprefix)' '
+	git config diff.mnemonicprefix true &&
+	git commit --amend -v &&
+	check_message message
+'
+
 test_done
-- 
1.6.0.4.883.g4593ee.dirty
