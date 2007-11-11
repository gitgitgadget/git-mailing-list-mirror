From: Steffen Prohaska <prohaska@zib.de>
Subject: [REPLACEMENT PATCH 3/6] push: support pushing HEAD to real branch name
Date: Sun, 11 Nov 2007 15:35:07 +0100
Message-ID: <1194791707467-git-send-email-prohaska@zib.de>
References: <47370EDF.3090907@op5.se>
Cc: Steffen Prohaska <prohaska@zib.de>
To: git@vger.kernel.org, ericsson Andreas <ae@op5.se>
X-From: git-owner@vger.kernel.org Sun Nov 11 15:35:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrDuK-0002x5-3n
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 15:35:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753050AbXKKOfM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 09:35:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753074AbXKKOfL
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 09:35:11 -0500
Received: from mailer.zib.de ([130.73.108.11]:61220 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752976AbXKKOfK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 09:35:10 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lABEZ7bd025306;
	Sun, 11 Nov 2007 15:35:07 +0100 (CET)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lABEZ7Wm007597;
	Sun, 11 Nov 2007 15:35:07 +0100 (MET)
X-Mailer: git-send-email 1.5.2.4
In-Reply-To: <47370EDF.3090907@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64467>

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
 t/t5516-fetch-push.sh |   17 +++++++++++++++++
 2 files changed, 26 insertions(+), 0 deletions(-)

prefixcmp() is simpler.

    Steffen

diff --git a/builtin-push.c b/builtin-push.c
index 6d1da07..54fba0e 100644
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
+			if (prefixcmp(ref, "refs/heads/"))
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
1.5.3.5.643.g20245
