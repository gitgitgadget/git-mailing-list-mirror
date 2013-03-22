From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 5/6] remote.c: introduce remote.pushdefault
Date: Fri, 22 Mar 2013 13:22:35 +0530
Message-ID: <1363938756-13722-6-git-send-email-artagnon@gmail.com>
References: <1363938756-13722-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 22 08:52:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIwll-0002QF-IL
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 08:52:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754575Ab3CVHvl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 03:51:41 -0400
Received: from mail-pb0-f43.google.com ([209.85.160.43]:52889 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754463Ab3CVHvj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 03:51:39 -0400
Received: by mail-pb0-f43.google.com with SMTP id md12so2914406pbc.16
        for <git@vger.kernel.org>; Fri, 22 Mar 2013 00:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=G03AkWxoMjhYElTmehIpXoLW4L8vbbybg5d1qrg0cSU=;
        b=lcrELJgi02AI3xMsTJILvj1aAWLXGunzSrlA91Tgxkxvllp7MV9B3CBwcwT9ZngV0c
         xQ+UDj0HpdJmgJWKY45FgHwFpbQWxi/sHcXt+KqTMmSwxszneoWjuAPHQ/2MWVnArdJP
         sji1RQ/CXsQo3wSkUQgpDlKSBLwFOA9oDWwXb0Z/7pCofgRW0/QnhHOaNLGKKB+a/HqT
         KR4YskygdyYukFCGMxp8EqEpi9nqk45O9loH8CPCGKX8xK2HUB1QeSx2BrKljM5d+yZn
         R+BXX88bfYXRCilekCK2mOO/JDGJOytkogB9Gewopjk/PVrKj0x1Eqcax/jiV8Ju/KhA
         JFNA==
X-Received: by 10.66.163.99 with SMTP id yh3mr1905341pab.32.1363938699176;
        Fri, 22 Mar 2013 00:51:39 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPS id fh1sm2025227pac.1.2013.03.22.00.51.36
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 22 Mar 2013 00:51:38 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.62.ga35d936.dirty
In-Reply-To: <1363938756-13722-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218783>

This new configuration variable defines the default remote to push to,
and overrides `branch.<name>.remote` for all branches.  It is useful
in the typical triangular-workflow setup, where the remote you're
fetching from is different from the remote you're pushing to.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/config.txt | 13 ++++++++++---
 remote.c                 |  5 +++++
 t/t5516-fetch-push.sh    | 12 ++++++++++++
 3 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index b3023b8..09a8294 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -723,9 +723,12 @@ branch.autosetuprebase::
 	This option defaults to never.
 
 branch.<name>.remote::
-	When in branch <name>, it tells 'git fetch' and 'git push' which
-	remote to fetch from/push to.  It defaults to `origin` if no remote is
-	configured. `origin` is also used if you are not on any branch.
+	When on branch <name>, it tells 'git fetch' and 'git push'
+	which remote to fetch from/push to.  The remote to push to
+	may be overridden with `remote.pushdefault` (for all branches).
+	If no remote is configured, or if you are not on any branch,
+	it defaults to `origin` for fetching and `remote.pushdefault`
+	for pushing.
 
 branch.<name>.merge::
 	Defines, together with branch.<name>.remote, the upstream branch
@@ -1894,6 +1897,10 @@ receive.updateserverinfo::
 	If set to true, git-receive-pack will run git-update-server-info
 	after receiving data from git-push and updating refs.
 
+remote.pushdefault::
+	The remote to push to by default.  Overrides
+	`branch.<name>.remote` for all branches.
+
 remote.<name>.url::
 	The URL of a remote repository.  See linkgit:git-fetch[1] or
 	linkgit:git-push[1].
diff --git a/remote.c b/remote.c
index 185ac11..bdb542c 100644
--- a/remote.c
+++ b/remote.c
@@ -350,6 +350,11 @@ static int handle_config(const char *key, const char *value, void *cb)
 	const char *subkey;
 	struct remote *remote;
 	struct branch *branch;
+	if (!prefixcmp(key, "remote.")) {
+		if (!strcmp(key + 7, "pushdefault"))
+			if (git_config_string(&pushremote_name, key, value))
+				return -1;
+	}
 	if (!prefixcmp(key, "branch.")) {
 		name = key + 7;
 		subkey = strrchr(name, '.');
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index a546c2c..63171f1 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -517,6 +517,18 @@ test_expect_success 'push with config remote.*.push = HEAD' '
 git config --remove-section remote.there
 git config --remove-section branch.master
 
+test_expect_success 'push with remote.pushdefault' '
+	mk_test_with_name up_repo heads/frotz &&
+	mk_test_with_name down_repo heads/master &&
+	test_config remote.up.url up_repo &&
+	test_config remote.down.url down_repo &&
+	test_config branch.master.remote up &&
+	test_config remote.pushdefault down &&
+	git push &&
+	test_must_fail check_push_result_with_name up_repo $the_commit heads/master &&
+	check_push_result_with_name down_repo $the_commit heads/master
+'
+
 test_expect_success 'push with config remote.*.pushurl' '
 
 	mk_test heads/master &&
-- 
1.8.2.62.ga35d936.dirty
