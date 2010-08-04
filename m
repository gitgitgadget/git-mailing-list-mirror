From: =?UTF-8?q?Zolt=C3=A1n=20F=C3=BCzesi?= <zfuzesi@eaglet.hu>
Subject: [PATCH] submodule: show_submodule_summary: preserve diff queue
Date: Wed,  4 Aug 2010 16:45:06 +0200
Message-ID: <1280933106-7016-1-git-send-email-zfuzesi@eaglet.hu>
Cc: =?UTF-8?q?Zolt=C3=A1n=20F=C3=BCzesi?= <zfuzesi@eaglet.hu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 04 16:50:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgfIQ-0003ML-QT
	for gcvg-git-2@lo.gmane.org; Wed, 04 Aug 2010 16:50:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932703Ab0HDOuK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Aug 2010 10:50:10 -0400
Received: from mail.icell.hu ([80.99.238.252]:50363 "EHLO icell.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757728Ab0HDOuJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Aug 2010 10:50:09 -0400
X-Greylist: delayed 463 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Aug 2010 10:50:08 EDT
Received: from localhost (localhost [127.0.0.1])
	by icell.hu (Postfix) with ESMTP id AD1E9B52;
	Wed,  4 Aug 2010 16:42:23 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mail.icell.hu
Received: from icell.hu ([127.0.0.1])
	by localhost (mail.icell.hu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OfdowXIMnRBc; Wed,  4 Aug 2010 16:42:23 +0200 (CEST)
Received: from source.ifleet (unknown [10.1.1.250])
	by icell.hu (Postfix) with ESMTP id 98D8D760;
	Wed,  4 Aug 2010 16:42:23 +0200 (CEST)
Received: from fuge by source.ifleet with local (Exim 4.69)
	(envelope-from <zoltan.fuzesi@icell.hu>)
	id 1OgfDP-0001ph-UY; Wed, 04 Aug 2010 16:45:07 +0200
X-Mailer: git-send-email 1.7.2.1.22.ge7bdd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152581>

git-diff with --submodule option stopped printing diff lines after a submodule
change, because show_submodule_summary reset diff queue.
---
 submodule.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/submodule.c b/submodule.c
index 61cb6e2..5b57536 100644
--- a/submodule.c
+++ b/submodule.c
@@ -46,6 +46,12 @@ done:
 	return ret;
 }
 
+static void diff_q_copy(struct diff_queue_struct *dst,
+			struct diff_queue_struct *src)
+{
+	memcpy(dst, src, sizeof(struct diff_queue_struct));
+}
+
 void handle_ignore_submodules_arg(struct diff_options *diffopt,
 				  const char *arg)
 {
@@ -71,6 +77,7 @@ void show_submodule_summary(FILE *f, const char *path,
 	struct strbuf sb = STRBUF_INIT;
 	static const char *format = "  %m %s";
 	int fast_forward = 0, fast_backward = 0;
+	struct diff_queue_struct diff_q_backup;
 
 	if (is_null_sha1(two))
 		message = "(submodule deleted)";
@@ -83,6 +90,7 @@ void show_submodule_summary(FILE *f, const char *path,
 		message = "(commits not present)";
 
 	if (!message) {
+		diff_q_copy(&diff_q_backup, &diff_queued_diff);
 		init_revisions(&rev, NULL);
 		setup_revisions(0, NULL, &rev, NULL);
 		rev.left_right = 1;
@@ -146,6 +154,7 @@ void show_submodule_summary(FILE *f, const char *path,
 		}
 		clear_commit_marks(left, ~0);
 		clear_commit_marks(right, ~0);
+		diff_q_copy(&diff_queued_diff, &diff_q_backup);
 	}
 	strbuf_release(&sb);
 }
-- 
1.7.2.1.22.ge7bdd
