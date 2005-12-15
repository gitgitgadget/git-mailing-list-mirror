From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] We do not like "HEAD" as a new branch name
Date: Thu, 15 Dec 2005 12:46:54 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0512151244230.22400@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Dec 15 12:49:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmrZn-0004jY-SY
	for gcvg-git@gmane.org; Thu, 15 Dec 2005 12:47:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422695AbVLOLq4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Dec 2005 06:46:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422698AbVLOLq4
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Dec 2005 06:46:56 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:51113 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1422695AbVLOLq4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2005 06:46:56 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 2729113F73A; Thu, 15 Dec 2005 12:46:55 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 045949DE21; Thu, 15 Dec 2005 12:46:55 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id D14B99DDF7; Thu, 15 Dec 2005 12:46:54 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id C14D613FBA4; Thu, 15 Dec 2005 12:46:54 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13693>


This makes git-check-ref-format fail for "HEAD". Since the check is only
executed when creating refs, the existing symbolic ref is safe.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	This patch was triggered by Alex' mail. Even if it should be a 
	rare case, it could catch some bad errors: Just try to run

		git checkout -b HEAD

	and imagine what a regular git user makes of the error 
	message...

 refs.c                 |    5 +++++
 t/t3300-funny-names.sh |    2 ++
 2 files changed, 7 insertions(+), 0 deletions(-)

04d60f0bf743f91d03e03acebf123db527cb7507
diff --git a/refs.c b/refs.c
index bda45f7..293bfe7 100644
--- a/refs.c
+++ b/refs.c
@@ -332,6 +332,11 @@ int check_ref_format(const char *ref)
 		if (ch == '.' || bad_ref_char(ch))
 			return -1;
 
+		/* do not allow "HEAD" as ref name */
+		if (ch == 'H' && (!strcmp(cp, "EAD") ||
+					!strncmp(cp, "EAD/", 4)))
+			return -1;
+
 		/* scan the rest of the path component */
 		while ((ch = *cp++) != 0) {
 			if (bad_ref_char(ch))
diff --git a/t/t3300-funny-names.sh b/t/t3300-funny-names.sh
index 897c378..8ebd896 100755
--- a/t/t3300-funny-names.sh
+++ b/t/t3300-funny-names.sh
@@ -139,4 +139,6 @@ test_expect_success 'git-apply non-git d
 	 git-apply --stat | sed -e "s/|.*//" -e "s/ *\$//" >current &&
 	 diff -u expected current'
 
+test_expect_failure 'HEAD is special' 'git checkout -b HEAD'
+
 test_done
-- 
0.99.9.GIT
