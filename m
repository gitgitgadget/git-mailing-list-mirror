From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 03/10] push: support pushing HEAD to real branch name
Date: Sun, 28 Oct 2007 18:46:14 +0100
Message-ID: <1193593581486-git-send-email-prohaska@zib.de>
References: <1193593581312-git-send-email-prohaska@zib.de>
 <11935935812741-git-send-email-prohaska@zib.de>
 <1193593581114-git-send-email-prohaska@zib.de>
Cc: Steffen Prohaska <prohaska@zib.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 28 18:50:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImCH0-0000QQ-7Y
	for gcvg-git-2@gmane.org; Sun, 28 Oct 2007 18:50:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754630AbXJ1Rtu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2007 13:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754531AbXJ1Rtu
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Oct 2007 13:49:50 -0400
Received: from mailer.zib.de ([130.73.108.11]:63826 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751506AbXJ1Rtt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2007 13:49:49 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9SHkMpO016195
	for <git@vger.kernel.org>; Sun, 28 Oct 2007 18:49:47 +0100 (CET)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9SHkLsX019730;
	Sun, 28 Oct 2007 18:46:21 +0100 (MET)
X-Mailer: git-send-email 1.5.2.4
In-Reply-To: <1193593581114-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62578>

This teaches "push <remote> HEAD" to resolve HEAD on the local
side to its real branch name, e.g. master, and then act as if
the real branch name was specified. So we have a shorthand for
pushing the current branch. Besides HEAD, no other symbolic ref
is resolved.

Thanks to Daniel Barkalow <barkalow@iabervon.org> for suggesting
this implementation, which is much simpler than the
implementation proposed before.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 builtin-push.c        |    9 +++++++++
 t/t5516-fetch-push.sh |   31 +++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/builtin-push.c b/builtin-push.c
index 4ab1401..2e3c8c6 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -40,6 +40,15 @@ static void set_refspecs(const char **refs, int nr)
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
index 42ca0ff..8becaf8 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -282,6 +282,37 @@ test_expect_success 'push with colon-less refspec (4)' '
 
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
+test_expect_success 'push with HEAD (--create)' '
+
+	mk_test &&
+	git checkout master &&
+	git push --create testrepo HEAD &&
+	check_push_result $the_commit heads/master
+
+'
+
+test_expect_success 'push with HEAD nonexisting at remote' '
+
+	mk_test heads/master &&
+	git checkout -b local master &&
+	if git push testrepo HEAD
+	then
+		echo "Oops, should have failed"
+		false
+	else
+		check_push_result $the_first_commit heads/master
+	fi
+'
+
 test_expect_success 'push with dry-run' '
 
 	mk_test heads/master &&
-- 
1.5.3.4.439.ge8b49
