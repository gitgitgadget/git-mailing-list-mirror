From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 5/6] remote.c: introduce remote.pushdefault
Date: Wed, 20 Mar 2013 18:15:00 +0530
Message-ID: <1363783501-27981-6-git-send-email-artagnon@gmail.com>
References: <1363783501-27981-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 20 13:44:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIINq-0001vz-7w
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 13:44:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932953Ab3CTMoO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 08:44:14 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:43282 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932496Ab3CTMoM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 08:44:12 -0400
Received: by mail-pd0-f174.google.com with SMTP id 10so599836pdi.19
        for <git@vger.kernel.org>; Wed, 20 Mar 2013 05:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=xLgd/yyPlQ5gUzpC3t/Zc/0Aqlsqij7y8ZrDti2nB/M=;
        b=yZfZh+VphsSmhvtGiKX9VtwbROXeWSWYerhNBMY0D/B1NYW62Oe0W3DfSp0QajRhGN
         l7/yiD5Q9xGgU5/yt8PrmwzQIUK9BdeWOO8Gs502qYZI0eaYdq3ED1cqcguhmet+a/E5
         n07JOYWyLpEg5inmMQdJLj4nq6RBja7I8eaRv9+XMbYoAxsVwia9H+7cPMnlrTrpcjWO
         i7peq03+8m6lV6g8NfjY5VKBwnIQ+4gM2ojddGsUmc1AvNPxLJDg26dnRBDaie3yaevC
         9S31UN7xnRxdsK4SwcR77dP5Swt1D6cUKMoleDxt5BrWtJstbUjIeW6aEV9iP/rX2Xkk
         A8BQ==
X-Received: by 10.66.176.73 with SMTP id cg9mr8917572pac.37.1363783451591;
        Wed, 20 Mar 2013 05:44:11 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPS id y13sm2031559pbv.0.2013.03.20.05.44.07
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 20 Mar 2013 05:44:10 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1363783501-27981-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218604>

This new configuration variable defines the default remote to push to,
and overrides `branch.<name>.remote` for all branches.  It is useful
in the typical triangular-workflow setup, where the remote you're
fetching from is different from the remote you're pushing to.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/config.txt | 13 ++++++++++---
 remote.c                 |  4 ++++
 t/t5516-fetch-push.sh    | 12 ++++++++++++
 3 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index bbba728..e813c33 100644
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
index cf7a65d..68056c7 100644
--- a/remote.c
+++ b/remote.c
@@ -350,6 +350,10 @@ static int handle_config(const char *key, const char *value, void *cb)
 	const char *subkey;
 	struct remote *remote;
 	struct branch *branch;
+	if (!prefixcmp(key, "remote.")) {
+		if (!strcmp(key + 7, "pushdefault"))
+			git_config_string(&pushremote_name, key, value);
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
1.8.2
