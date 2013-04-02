From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 5/6] remote.c: introduce remote.pushdefault
Date: Tue,  2 Apr 2013 13:10:33 +0530
Message-ID: <1364888434-30388-6-git-send-email-artagnon@gmail.com>
References: <1364888434-30388-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 02 09:40:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMvp8-0007OZ-JC
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 09:40:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106Ab3DBHjf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 03:39:35 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:54135 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932098Ab3DBHjb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 03:39:31 -0400
Received: by mail-pd0-f180.google.com with SMTP id q11so92619pdj.25
        for <git@vger.kernel.org>; Tue, 02 Apr 2013 00:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=pVlRMQufw2X7De/KgVN1u8hzHq7i6F5hhGsn+T8FBSQ=;
        b=pHhMLYqOzAfEhEazFapMkWJzj4UBVtrmqMwcMw3+Ux9IhXIMD2+yVEabAeXz9SYVLl
         mO3b33pjfb3naKKQdRTvo+vjDQRFFx5Q4U0/60e6gDecWvfkp6iv5KwBT+IorK6iLfMT
         mk8T1qMerd42NoJcnWb0oaqlWdRpDTpVFc8zLJIgYqC2ye3wsK+MQlN3Uj/AoKj6zrus
         3p/b1+TgBNbBoD9K0Bagw0vj1vZCFbH3F+oBKcyMBRAmmFKjysQJi/z5O5Eqiv+jO7S2
         B1GfuJsgzqs9BfvpRPpM9QHQiG3GvpxE6C8MJLR01ZK0f+3bp6FGsu+8zHVQtx/9N5Rh
         StIA==
X-Received: by 10.66.120.99 with SMTP id lb3mr23355718pab.173.1364888371194;
        Tue, 02 Apr 2013 00:39:31 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPS id oq3sm1259341pac.16.2013.04.02.00.39.28
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 02 Apr 2013 00:39:30 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.363.g901f5bc
In-Reply-To: <1364888434-30388-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219746>

This new configuration variable defines the default remote to push to,
and overrides `branch.<name>.remote` for all branches.  It is useful
in the typical triangular-workflow setup, where the remote you're
fetching from is different from the remote you're pushing to.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/config.txt | 13 ++++++++++---
 remote.c                 |  7 +++++++
 t/t5516-fetch-push.sh    | 12 ++++++++++++
 3 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f79184c..9c6fd4a 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -727,9 +727,12 @@ branch.autosetuprebase::
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
@@ -1898,6 +1901,10 @@ receive.updateserverinfo::
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
index 2b06e22..6337e11 100644
--- a/remote.c
+++ b/remote.c
@@ -389,9 +389,16 @@ static int handle_config(const char *key, const char *value, void *cb)
 			add_instead_of(rewrite, xstrdup(value));
 		}
 	}
+
 	if (prefixcmp(key,  "remote."))
 		return 0;
 	name = key + 7;
+
+	/* Handle remote.* variables */
+	if (!strcmp(name, "pushdefault"))
+		return git_config_string(&pushremote_name, key, value);
+
+	/* Handle remote.<name>.* variables */
 	if (*name == '/') {
 		warning("Config remote shorthand cannot begin with '/': %s",
 			name);
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index b800a8e..797b537 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -497,6 +497,18 @@ test_expect_success 'push with config remote.*.push = HEAD' '
 	check_push_result testrepo $the_first_commit heads/local
 '
 
+test_expect_success 'push with remote.pushdefault' '
+	mk_test up_repo heads/master &&
+	mk_test down_repo heads/master &&
+	test_config remote.up.url up_repo &&
+	test_config remote.down.url down_repo &&
+	test_config branch.master.remote up &&
+	test_config remote.pushdefault down &&
+	git push &&
+	check_push_result up_repo $the_first_commit heads/master &&
+	check_push_result down_repo $the_commit heads/master
+'
+
 test_expect_success 'push with config remote.*.pushurl' '
 
 	mk_test testrepo heads/master &&
-- 
1.8.2.363.g901f5bc
