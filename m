From: Christoph Mallon <christoph.mallon@gmx.de>
Subject: [PATCH] Show the correct line number, when git diff --check detects
 a blank line at EOF.
Date: Sun, 10 Oct 2010 19:24:06 +0200
Message-ID: <4CB1F6B6.2060000@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 10 19:24:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4zdA-0007mI-IK
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 19:24:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754700Ab0JJRYL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Oct 2010 13:24:11 -0400
Received: from mailout-de.gmx.net ([213.165.64.23]:52935 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1751716Ab0JJRYK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Oct 2010 13:24:10 -0400
Received: (qmail invoked by alias); 10 Oct 2010 17:24:07 -0000
Received: from p5B14C6A8.dip.t-dialin.net (EHLO tron.homeunix.org) [91.20.198.168]
  by mail.gmx.net (mp009) with SMTP; 10 Oct 2010 19:24:07 +0200
X-Authenticated: #1673122
X-Provags-ID: V01U2FsdGVkX19gSbQXQvtgiYRGoo7O/sfiBMyZKbQekaL9wb5m3X
	yK77M65dMYOFsx
User-Agent: Mozilla/5.0 (X11; U; FreeBSD i386; de-DE; rv:1.9.2.9) Gecko/20100919 Thunderbird/3.1.4
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158679>

The whitespace check printed the value of the wrong variable, i.e. the line number of the hunk in the old file.

Signed-off-by: Christoph Mallon <christoph.mallon@gmx.de>
---
The bug was introduced in d68fe26f3e03b230ac9bbbcf002a9acdc4bebde9. The patch is on top of this commit and can be applied to master (c752e7f3e8d96a9673ad248addc9418164bd3ce6), too.

 diff.c                  |    2 +-
 t/t4019-diff-wserror.sh |    9 +++++++++
 2 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/diff.c b/diff.c
index 63a3bfc..3a3b404 100644
--- a/diff.c
+++ b/diff.c
@@ -1730,7 +1730,7 @@ static void builtin_checkdiff(const char *name_a, const char *name_b,
 
 			ecbdata.ws_rule = data.ws_rule;
 			check_blank_at_eof(&mf1, &mf2, &ecbdata);
-			blank_at_eof = ecbdata.blank_at_eof_in_preimage;
+			blank_at_eof = ecbdata.blank_at_eof_in_postimage;
 
 			if (blank_at_eof) {
 				static char *err;
diff --git a/t/t4019-diff-wserror.sh b/t/t4019-diff-wserror.sh
index 3a3663f..61119e6 100755
--- a/t/t4019-diff-wserror.sh
+++ b/t/t4019-diff-wserror.sh
@@ -178,6 +178,15 @@ test_expect_success 'trailing empty lines (2)' '
 
 '
 
+test_expect_success 'checkdiff shows correct line number for trailing blank lines' '
+
+	printf "a\nb\n" > G &&
+	git add G &&
+	printf "x\nx\nx\na\nb\nc\n\n" > G &&
+	[ "$(git diff --check -- G)" = "G:7: new blank line at EOF." ]
+
+'
+
 test_expect_success 'do not color trailing cr in context' '
 	git config --unset core.whitespace
 	rm -f .gitattributes &&
-- 
1.7.3
