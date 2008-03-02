From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/2] format-patch: wrap cover-letter's shortlog sensibly
Date: Sun, 2 Mar 2008 15:53:39 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0803021553090.22527@racer.site>
References: <alpine.LSU.1.00.0802290144130.22527@racer.site> <7vwsoofrue.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0802282104500.19665@iabervon.org> <alpine.LSU.1.00.0802291118540.22527@racer.site> <alpine.LSU.1.00.0803021511420.22527@racer.site>
 <alpine.LSU.1.00.0803021531230.22527@racer.site> <alpine.LSU.1.00.0803021552210.22527@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Mar 02 16:55:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVqWn-0005tu-0e
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 16:55:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753182AbYCBPy2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 10:54:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753361AbYCBPy2
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 10:54:28 -0500
Received: from mail.gmx.net ([213.165.64.20]:47333 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752945AbYCBPy1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 10:54:27 -0500
Received: (qmail invoked by alias); 02 Mar 2008 15:54:25 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp049) with SMTP; 02 Mar 2008 16:54:25 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/iI7c+BJLiRyYUs5qnJ07bCQsDWxvfv4cL3FZdDb
	xj5us1byORZ8kk
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LSU.1.00.0803021552210.22527@racer.site>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75796>


Earlier, overly-long onelines would not be wrapped at all, and indented
with 6 spaces.

Instead, we now wrap around at 72 characters, with a first-line indent
of 2 spaces, and the rest with 4 spaces (like the "What's in" messages
of Junio).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin-log.c                                      |    4 ++++
 ...tch_--stdout_--cover-letter_-n_initial..master^ |    4 ++--
 t/t4014-format-patch.sh                            |   19 +++++++++++++++++++
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index fd9b3ae..fe8fc6f 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -683,6 +683,10 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 	strbuf_release(&sb);
 
 	shortlog_init(&log);
+	log.wrap_lines = 1;
+	log.wrap = 72;
+	log.in1 = 2;
+	log.in2 = 4;
 	for (i = 0; i < nr; i++)
 		shortlog_add_commit(&log, list[i]);
 
diff --git a/t/t4013/diff.format-patch_--stdout_--cover-letter_-n_initial..master^ b/t/t4013/diff.format-patch_--stdout_--cover-letter_-n_initial..master^
index 0151453..8dab4bf 100644
--- a/t/t4013/diff.format-patch_--stdout_--cover-letter_-n_initial..master^
+++ b/t/t4013/diff.format-patch_--stdout_--cover-letter_-n_initial..master^
@@ -7,8 +7,8 @@ Subject: [DIFFERENT_PREFIX 0/2] *** SUBJECT HERE ***
 *** BLURB HERE ***
 
 A U Thor (2):
-      Second
-      Third
+  Second
+  Third
 
  dir/sub |    4 ++++
  file0   |    3 +++
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 6d86b7d..b2b7a8d 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -211,4 +211,23 @@ test_expect_success 'cover-letter inherits diff options' '
 	grep "file => foo .* 0 *$" 0000-cover-letter.patch
 
 '
+
+cat > expect << EOF
+  This is an excessively long subject line for a message due to the
+    habit some projects have of not having a short, one-line subject at
+    the start of the commit message, but rather sticking a whole
+    paragraph right at the start as the only thing in the commit
+    message. It had better not become the filename for the patch.
+  foo
+
+EOF
+
+test_expect_success 'shortlog of cover-letter wraps overly-long onelines' '
+
+	git format-patch --cover-letter -2 &&
+	sed -e "1,/A U Thor/d" -e "/^$/q" < 0000-cover-letter.patch > output &&
+	git diff expect output
+
+'
+
 test_done
-- 
1.5.4.3.510.g7cdd


