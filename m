From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 6/6] remote.c: introduce branch.<name>.pushremote
Date: Thu, 28 Mar 2013 18:56:42 +0530
Message-ID: <1364477202-5742-7-git-send-email-artagnon@gmail.com>
References: <1364477202-5742-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 28 14:26:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULCqP-0003hF-0i
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 14:26:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756144Ab3C1NZt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 09:25:49 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:46180 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756135Ab3C1NZo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 09:25:44 -0400
Received: by mail-pa0-f52.google.com with SMTP id fb10so1120941pad.11
        for <git@vger.kernel.org>; Thu, 28 Mar 2013 06:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=39Ur8Nfer9tW0NCPV5L5NxvsmxvYhtELDEoTU2U137k=;
        b=BCHHkHC7d7lrKZ2uyG5q6Ybnsrqdx3wJMhehD/l1PrYG3OvBgqJdHWWYxdx7hTWy+l
         nZIFpC0gMJHZ2XbA94d7l343xR88wEKrylF3Os7uKPefl/kfQfLf7GktYmD9wn1YoJqo
         w2lJvGj1KjHo0368g+wkOcVzphH3Hhe+Qs+ZttCX3mG2adQ0Bc2uqq3FZ/Ymk9L5F4fk
         0i+JwFoulu6udwmoC1nJLY1UGuwnkjQmayZFiACguc/smqu9n7UJGBE9otSrkWGG9aPe
         TIweMcvdd77UYjWk7/pKkQ541p4yuZqCje7ToYxSC1MnAO4GfAv7IjMHvqbl9L1KAD+0
         5qMw==
X-Received: by 10.66.116.12 with SMTP id js12mr36032049pab.149.1364477143951;
        Thu, 28 Mar 2013 06:25:43 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPS id tm1sm25586603pbc.11.2013.03.28.06.25.41
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 28 Mar 2013 06:25:43 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.141.g3797f84
In-Reply-To: <1364477202-5742-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219391>

This new configuration variable overrides `remote.pushdefault` and
`branch.<name>.remote` for pushes.  When you pull from one
place (e.g. your upstream) and push to another place (e.g. your own
publishing repository), you would want to set `remote.pushdefault` to
specify the remote to push to for all branches, and use this option to
override it for a specific branch.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/config.txt | 19 +++++++++++++++----
 remote.c                 |  4 ++++
 t/t5516-fetch-push.sh    | 15 +++++++++++++++
 3 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index dd78171..ec579c5 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -730,9 +730,19 @@ branch.<name>.remote::
 	When on branch <name>, it tells 'git fetch' and 'git push'
 	which remote to fetch from/push to.  The remote to push to
 	may be overridden with `remote.pushdefault` (for all branches).
-	If no remote is configured, or if you are not on any branch,
-	it defaults to `origin` for fetching and `remote.pushdefault`
-	for pushing.
+	The remote to push to, for the current branch, may be further
+	overridden by `branch.<name>.pushremote`.  If no remote is
+	configured, or if you are not on any branch, it defaults to
+	`origin` for fetching and `remote.pushdefault` for pushing.
+
+branch.<name>.pushremote::
+	When on branch <name>, it overrides `branch.<name>.remote` for
+	pushing.  It also overrides `remote.pushdefault` for pushing
+	from branch <name>.  When you pull from one place (e.g. your
+	upstream) and push to another place (e.g. your own publishing
+	repository), you would want to set `remote.pushdefault` to
+	specify the remote to push to for all branches, and use this
+	option to override it for a specific branch.
 
 branch.<name>.merge::
 	Defines, together with branch.<name>.remote, the upstream branch
@@ -1903,7 +1913,8 @@ receive.updateserverinfo::
 
 remote.pushdefault::
 	The remote to push to by default.  Overrides
-	`branch.<name>.remote` for all branches.
+	`branch.<name>.remote` for all branches, and is overridden by
+	`branch.<name>.pushremote` for specific branches.
 
 remote.<name>.url::
 	The URL of a remote repository.  See linkgit:git-fetch[1] or
diff --git a/remote.c b/remote.c
index 49c4b8b..e89b1b7 100644
--- a/remote.c
+++ b/remote.c
@@ -364,6 +364,10 @@ static int handle_config(const char *key, const char *value, void *cb)
 				default_remote_name = branch->remote_name;
 				explicit_default_remote_name = 1;
 			}
+		} else if (!strcmp(subkey, ".pushremote")) {
+			if (branch == current_branch)
+				if (git_config_string(&pushremote_name, key, value))
+					return -1;
 		} else if (!strcmp(subkey, ".merge")) {
 			if (!value)
 				return config_error_nonbool(key);
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index ac1ec9d..13028a4 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -542,6 +542,21 @@ test_expect_success 'push with config remote.*.pushurl' '
 	check_push_result testrepo $the_commit heads/master
 '
 
+test_expect_success 'push with config branch.*.pushremote' '
+	mk_test up_repo heads/frotz &&
+	mk_test side_repo heads/quux &&
+	mk_test down_repo heads/master &&
+	test_config remote.up.url up_repo &&
+	test_config remote.pushdefault side_repo &&
+	test_config remote.down.url down_repo &&
+	test_config branch.master.remote up &&
+	test_config branch.master.pushremote down &&
+	git push &&
+	test_must_fail check_push_result up_repo $the_commit heads/master &&
+	test_must_fail check_push_result side_repo $the_commit heads/master &&
+	check_push_result down_repo $the_commit heads/master
+'
+
 # clean up the cruft left with the previous one
 git config --remove-section remote.there
 
-- 
1.8.2.141.g3797f84
