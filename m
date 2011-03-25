From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] dir.c: do not trip over difference in "/"
Date: Fri, 25 Mar 2011 16:52:22 +0100
Message-ID: <b28c22b42c43f5dced45bee8ba4c76965b736d9a.1301068238.git.git@drmicha.warpmail.net>
References: <1301060989-7246-1-git-send-email-pclouds@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthijs Kooijman <matthijs@stdin.nl>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 25 16:56:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q39N2-00061I-8y
	for gcvg-git-2@lo.gmane.org; Fri, 25 Mar 2011 16:56:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754166Ab1CYPz7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2011 11:55:59 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:48731 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753999Ab1CYPz6 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Mar 2011 11:55:58 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id B28BA20B93;
	Fri, 25 Mar 2011 11:55:57 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Fri, 25 Mar 2011 11:55:57 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=OBvrmySLawp5g6hJBc4MQSrdWlQ=; b=B73679NcvpvCu/CERJPM0P63F5GRGLv3xeamJOW4zK/nkoK7BCLctN2eT+D1nbZGN+OWn6oRI46sHm//j3YF98uo2j431ghYZ8ii4+Y7oGVyMyrEo5MGhoD4gMZu3ayNDGh1hz56y1ZknfcQz8Q/LNpLQnOxXas7bU1Iy2zdwS8=
X-Sasl-enc: YMtTttaB6WV6ltvCePnNhwZrYjIwBqAw8wmO8lRP2Eds 1301068557
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 00C74404455;
	Fri, 25 Mar 2011 11:55:56 -0400 (EDT)
X-Mailer: git-send-email 1.7.4.1.607.g888da
In-Reply-To: <1301060989-7246-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169991>

get_relative_cwd() tries to determine a common prefix for dir and cwd.
The fix in
490544b (get_cwd_relative(): do not misinterpret suffix as subdirectory, 2010-05-22)
made the logic less naive (so that foo-bar is not misdetected as being
within foo) but broke some other cases, in particular foo not being
detected as being within foo/ any more.

Fix it by taking into a account that a directory name may or may not end
in /.

Document with a test.

Reported-by: Matthijs Kooijman <matthijs@stdin.nl>
Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
So I think this would be a proper fix.

I tried to be nice and base it on the commit which I bisected the problem to. I
saw much too late that their were later (failed) attempts at fixing this and a
major rewrite of the test, which is quite a nuisance. Anyway, this problem needs a fix,
and by taking get_cwd_relative() from this patch on top of next the problem is fixed.
I have not looked into resolving the merge conflict in the test.

 dir.c               |   23 +++++++++++++++--------
 t/t1501-worktree.sh |   13 +++++++++++++
 2 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/dir.c b/dir.c
index 5615f33..b090cd0 100644
--- a/dir.c
+++ b/dir.c
@@ -956,16 +956,23 @@ char *get_relative_cwd(char *buffer, int size, const char *dir)
 		dir++;
 		cwd++;
 	}
-	if (*dir)
+
+	/* dir has more than just '/' left */
+	if (*dir && ((*dir != '/') || *(dir+1)))
 		return NULL;
-	switch (*cwd) {
-	case '\0':
+	/* *dir is now '\0' or '/' followed by '\0' */
+	if (cwd == buffer) /* we did not move */
+		return (*cwd) ? NULL : cwd;
+	/* we have moved at least by 1 */
+	if (*dir) /* == '/' */
+		return (*cwd) ? NULL : cwd;
+	if (!(*cwd)) /* both ended */
 		return cwd;
-	case '/':
-		return cwd + 1;
-	default:
-		return NULL;
-	}
+	if (*(dir-1) == '/') /* must have been common */
+		return cwd;
+	if (*cwd == '/')
+		return cwd+1;
+	return NULL;
 }
 
 int is_inside_dir(const char *dir)
diff --git a/t/t1501-worktree.sh b/t/t1501-worktree.sh
index bd8b607..f0dbdd8 100755
--- a/t/t1501-worktree.sh
+++ b/t/t1501-worktree.sh
@@ -63,6 +63,19 @@ cd sub/dir || exit 1
 test_rev_parse 'subdirectory' false false true sub/dir/
 cd ../../.. || exit 1
 
+say "core.worktree = absolute path/"
+GIT_DIR=$(pwd)/repo.git
+GIT_CONFIG=$GIT_DIR/config
+git config core.worktree "$(pwd)/work/"
+test_rev_parse 'outside'      false false false
+cd work2
+test_rev_parse 'outside2'     false false false
+cd ../work || exit 1
+test_rev_parse 'inside'       false false true ''
+cd sub/dir || exit 1
+test_rev_parse 'subdirectory' false false true sub/dir/
+cd ../../.. || exit 1
+
 say "GIT_WORK_TREE=relative path (override core.worktree)"
 GIT_DIR=$(pwd)/repo.git
 GIT_CONFIG=$GIT_DIR/config
-- 
1.7.4.1.607.g888da
