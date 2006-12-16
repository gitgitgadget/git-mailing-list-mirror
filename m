X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/2] git-branch: rename config vars branch.<branch>.*, too
Date: Sat, 16 Dec 2006 15:15:02 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612161514280.3635@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sat, 16 Dec 2006 14:15:28 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34619>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvaJs-0007zE-Nq for gcvg-git@gmane.org; Sat, 16 Dec
 2006 15:15:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932451AbWLPOPG (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 16 Dec 2006
 09:15:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932433AbWLPOPF
 (ORCPT <rfc822;git-outgoing>); Sat, 16 Dec 2006 09:15:05 -0500
Received: from mail.gmx.net ([213.165.64.20]:36659 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S932467AbWLPOPE
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 16 Dec 2006 09:15:04 -0500
Received: (qmail invoked by alias); 16 Dec 2006 14:15:02 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp030) with SMTP; 16 Dec 2006 15:15:02 +0100
To: git@vger.kernel.org, junkio@cox.net
Sender: git-owner@vger.kernel.org


When renaming a branch, the corresponding config section should
be renamed, too.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 refs.c            |   10 ++++++++++
 t/t3200-branch.sh |    6 ++++++
 2 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/refs.c b/refs.c
index a02957c..d911b9e 100644
--- a/refs.c
+++ b/refs.c
@@ -867,6 +867,16 @@ int rename_ref(const char *oldref, const char *newref, const char *logmsg)
 		goto rollback;
 	}
 
+	if (!strncmp(oldref, "refs/heads/", 11) &&
+			!strncmp(newref, "refs/heads/", 11)) {
+		char oldsection[1024], newsection[1024];
+
+		snprintf(oldsection, 1024, "branch.%s", oldref + 11);
+		snprintf(newsection, 1024, "branch.%s", newref + 11);
+		if (git_config_rename_section(oldsection, newsection) < 0)
+			return 1;
+	}
+
 	return 0;
 
  rollback:
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 5782c30..a6ea0f6 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -94,6 +94,8 @@ test_expect_failure \
          git-branch r &&
          git-branch -m q r/q'
 
+git-repo-config branch.s/s.dummy Hello
+
 test_expect_success \
     'git branch -m s/s s should work when s/t is deleted' \
        'git-branch -l s/s &&
@@ -104,6 +106,10 @@ test_expect_success \
         git-branch -m s/s s &&
         test -f .git/logs/refs/heads/s'
 
+test_expect_success 'config information was renamed, too' \
+	"test $(git-repo-config branch.s.dummy) = Hello &&
+	 ! git-repo-config branch.s/s/dummy"
+
 test_expect_failure \
     'git-branch -m u v should fail when the reflog for u is a symlink' \
     'git-branch -l u &&
-- 
1.4.4.1.g0604-dirty
