From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: [PATCH] log -g: ignore revision parameters that have no reflog
Date: Wed,  3 Feb 2016 00:32:41 +0100
Message-ID: <1454455961-10640-1-git-send-email-dennis@kaarsemaker.net>
References: <1454241144.2822.7.camel@kaarsemaker.net>
Cc: Dennis Kaarsemaker <dennis@kaarsemaker.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 03 00:32:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQkRL-0001he-Io
	for gcvg-git-2@plane.gmane.org; Wed, 03 Feb 2016 00:32:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754752AbcBBXcw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2016 18:32:52 -0500
Received: from koekblik.kaarsemaker.net ([141.138.139.206]:38385 "EHLO
	koekblik.kaarsemaker.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752099AbcBBXcv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2016 18:32:51 -0500
Received: from spirit.home.kaarsemaker.net (unknown [145.132.209.114])
	by koekblik.kaarsemaker.net (Postfix) with ESMTP id 9C42B828EB;
	Wed,  3 Feb 2016 00:32:48 +0100 (CET)
X-Mailer: git-send-email 2.7.0-345-gadc6f59
In-Reply-To: <1454241144.2822.7.camel@kaarsemaker.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285315>

git log -g (and by extension, git reflog) gets mightly confused when
trying to display the reflog of something that is not a ref that has a
reflog. We can help by teaching handle_revision_arg to check all
revision arguments for reflog existence if it's in reflog mode.

git log -g something-that-is-not-a ref makes no sense, so let's die when
the user is trying that. git log -g ref-that-has-no-reflog is perfectly
sensible, so we just ignore it.

Signed-off-by: Dennis Kaarsemaker <dennis@kaarsemaker.net>
---
 revision.c             | 12 ++++++++++++
 t/t1411-reflog-show.sh | 10 ++++++++++
 2 files changed, 22 insertions(+)

diff --git a/revision.c b/revision.c
index 0a282f5..43182c6 100644
--- a/revision.c
+++ b/revision.c
@@ -1498,6 +1498,18 @@ int handle_revision_arg(const char *arg_, struct rev_info *revs, int flags, unsi
 
 	flags = flags & UNINTERESTING ? flags | BOTTOM : flags & ~BOTTOM;
 
+	if (revs->reflog_info) {
+		/*
+		 * The reflog iterator gets confused when fed things that don't
+		 * have reflogs. Help it along a bit
+		 */
+		if (strchr(arg, '@') != arg &&
+		    !dwim_ref(arg, strchrnul(arg, '@')-arg, sha1, &dotdot))
+			die("only refs can have reflogs");
+		if(!reflog_exists(dotdot))
+			return 0;
+	}
+
 	dotdot = strstr(arg, "..");
 	if (dotdot) {
 		unsigned char from_sha1[20];
diff --git a/t/t1411-reflog-show.sh b/t/t1411-reflog-show.sh
index 6ac7734..e55518f 100755
--- a/t/t1411-reflog-show.sh
+++ b/t/t1411-reflog-show.sh
@@ -171,4 +171,14 @@ test_expect_success 'reflog exists works' '
 	! git reflog exists refs/heads/nonexistent
 '
 
+test_expect_success 'reflog against non-ref dies' '
+	test_must_fail git reflog HEAD^
+'
+
+test_expect_success 'reflog against ref with no log is empty' '
+	git tag nolog &&
+	git reflog nolog > actual &&
+	test_line_count = 0 actual
+'
+
 test_done
-- 
2.7.0-345-gadc6f59
