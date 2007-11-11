From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 3/6] push: support pushing HEAD to real branch name
Date: Sun, 11 Nov 2007 15:01:45 +0100
Message-ID: <11947897083159-git-send-email-prohaska@zib.de>
References: <1194789708646-git-send-email-prohaska@zib.de>
 <11947897083381-git-send-email-prohaska@zib.de>
 <11947897081278-git-send-email-prohaska@zib.de>
Cc: Steffen Prohaska <gitster@pobox.com>,
	Steffen Prohaska <prohaska@zib.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 11 15:05:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrDRe-0003eX-TK
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 15:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752290AbXKKOEx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 09:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752495AbXKKOEw
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 09:04:52 -0500
Received: from mailer.zib.de ([130.73.108.11]:57965 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751738AbXKKOEq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 09:04:46 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lABE1nwx021597;
	Sun, 11 Nov 2007 15:04:43 +0100 (CET)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lABE1mlX027967;
	Sun, 11 Nov 2007 15:01:48 +0100 (MET)
X-Mailer: git-send-email 1.5.2.4
In-Reply-To: <11947897081278-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64459>

From: Steffen Prohaska <gitster@pobox.com>

This teaches "push <remote> HEAD" to resolve HEAD on the local
side to its real branch name, e.g. master, and then act as if
the real branch name was specified. So we have a shorthand for
pushing the current branch. Besides HEAD, no other symbolic ref
is resolved.

Thanks to Daniel Barkalow <barkalow@iabervon.org> for suggesting
this implementation, which is much simpler than the
implementation proposed before.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-push.c        |    9 +++++++++
 t/t5516-fetch-push.sh |   17 +++++++++++++++++
 2 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/builtin-push.c b/builtin-push.c
index 6d1da07..a99ba0c 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -44,6 +44,15 @@ static void set_refspecs(const char **refs, int nr)
 			strcat(tag, refs[i]);
 			ref = tag;
 		}
+		if (!strcmp("HEAD", ref)) {
+			unsigned char sha1_dummy[20];
+			ref = resolve_ref(ref, sha1_dummy, 1, NULL);
+			if (!ref)
+				die("HEAD cannot be resolved.");
+			if (strncmp(ref, "refs/heads/", 11))
+				die("HEAD cannot be resolved to branch.");
+			ref = xstrdup(ref + 11);
+		}
 		add_refspec(ref);
 	}
 }
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 86f9b53..b0ff488 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -244,6 +244,23 @@ test_expect_success 'push with colon-less refspec (4)' '
 
 '
 
+test_expect_success 'push with HEAD' '
+
+	mk_test heads/master &&
+	git checkout master &&
+	git push testrepo HEAD &&
+	check_push_result $the_commit heads/master
+
+'
+
+test_expect_success 'push with HEAD nonexisting at remote' '
+
+	mk_test heads/master &&
+	git checkout -b local master &&
+	git push testrepo HEAD &&
+	check_push_result $the_commit heads/local
+'
+
 test_expect_success 'push with dry-run' '
 
 	mk_test heads/master &&
-- 
1.5.3.5.578.g886d
