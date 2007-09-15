From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] revision walker: --cherry-pick is a limited operation
Date: Sat, 15 Sep 2007 18:39:52 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709151838270.28586@racer.site>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1006391016-1189877992=:28586"
To: mbaehr@iaeste.at, gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 15 19:40:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWbdJ-00021i-WE
	for gcvg-git-2@gmane.org; Sat, 15 Sep 2007 19:40:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752898AbXIORki (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2007 13:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752847AbXIORki
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Sep 2007 13:40:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:49564 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752709AbXIORkh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2007 13:40:37 -0400
Received: (qmail invoked by alias); 15 Sep 2007 17:40:35 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp057) with SMTP; 15 Sep 2007 19:40:35 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+iNMcdTtai7CueepncxYLJqwthR7soVQC+MOt3l4
	dJNZxFYMDaTLMk
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58267>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1006391016-1189877992=:28586
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT


We used to rely on the fact that cherry-pick would trigger the code path 
to set limited = 1 in handle_commit(), when an uninteresting commit was 
encountered.

However, when cherry picking between two independent branches, i.e. when 
there are no merge bases, and there is only linear development (which can 
happen when you cvsimport a fork of a project), no uninteresting commit 
will be encountered.

So set limited = 1 when --cherry-pick was asked for.

Noticed by Martin Bähr.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 revision.c                           |    1 +
 t/t6007-rev-list-cherry-pick-file.sh |   14 ++++++++++++++
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/revision.c b/revision.c
index c193c3e..33d092c 100644
--- a/revision.c
+++ b/revision.c
@@ -1024,6 +1024,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 			}
 			if (!strcmp(arg, "--cherry-pick")) {
 				revs->cherry_pick = 1;
+				revs->limited = 1;
 				continue;
 			}
 			if (!strcmp(arg, "--objects")) {
diff --git a/t/t6007-rev-list-cherry-pick-file.sh b/t/t6007-rev-list-cherry-pick-file.sh
index 3faeae6..4b8611c 100755
--- a/t/t6007-rev-list-cherry-pick-file.sh
+++ b/t/t6007-rev-list-cherry-pick-file.sh
@@ -40,4 +40,18 @@ test_expect_success '--cherry-pick bar does not come up empty' '
 	! test -z "$(git rev-list --left-right --cherry-pick B...C -- bar)"
 '
 
+test_expect_success '--cherry-pick with independent, but identical branches' '
+	git symbolic-ref HEAD refs/heads/independent &&
+	rm .git/index &&
+	echo Hallo > foo &&
+	git add foo &&
+	test_tick &&
+	git commit -m "independent" &&
+	echo Bello > foo &&
+	test_tick &&
+	git commit -m "independent, too" foo &&
+	test -z "$(git rev-list --left-right --cherry-pick \
+		HEAD...master -- foo)"
+'
+
 test_done
-- 
1.5.3.1.949.g98c3

--8323584-1006391016-1189877992=:28586--
