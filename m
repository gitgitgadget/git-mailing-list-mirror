From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 6/6] remote.c: introduce branch.<name>.pushremote
Date: Tue,  2 Apr 2013 13:10:34 +0530
Message-ID: <1364888434-30388-7-git-send-email-artagnon@gmail.com>
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
	id 1UMvp9-0007OZ-3J
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 09:40:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111Ab3DBHjg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 03:39:36 -0400
Received: from mail-pb0-f53.google.com ([209.85.160.53]:45392 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932103Ab3DBHjf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 03:39:35 -0400
Received: by mail-pb0-f53.google.com with SMTP id un15so91713pbc.40
        for <git@vger.kernel.org>; Tue, 02 Apr 2013 00:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=N5e4lbh4Jt7UAEphx9zpyXn5Krr2ubDv3mZqm0lznKM=;
        b=PdtiGfEfKKHRci4uaw+pwrUkUwY3CtN36zROLiVr4boLZrhflDiC7h2E5JFzKox06l
         j2wX+1ec4kfY//HEmz25MBfts8P+EkOPHiY5sDN4fMonpMsEfmRRklpvGJxmTfpex/AO
         IPYaSAhia9UQ9dzFUdKeLBXXo+PPo0dGgk5EWzGOqCsvi39mfUAxGy5T/VMro739F+40
         k7SjloJx4BxRUrrsxGQ0TddthYhwedU44tYcJ7MmeqqQJbXRKan7myWbBNxFzfMwsh9E
         vyDoVp/eRZFratP1AtU4FcAptHr+a0JVeLhT7z2KDL0mDVbVFuT7XowX9rFkNd7FvIxC
         akEA==
X-Received: by 10.68.242.132 with SMTP id wq4mr22342733pbc.160.1364888373608;
        Tue, 02 Apr 2013 00:39:33 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPS id oq3sm1259341pac.16.2013.04.02.00.39.31
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 02 Apr 2013 00:39:33 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.363.g901f5bc
In-Reply-To: <1364888434-30388-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219748>

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
index 9c6fd4a..3d750e0 100644
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
index 6337e11..68eb99b 100644
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
index 797b537..7bf1555 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -519,6 +519,21 @@ test_expect_success 'push with config remote.*.pushurl' '
 	check_push_result testrepo $the_commit heads/master
 '
 
+test_expect_success 'push with config branch.*.pushremote' '
+	mk_test up_repo heads/master &&
+	mk_test side_repo heads/master &&
+	mk_test down_repo heads/master &&
+	test_config remote.up.url up_repo &&
+	test_config remote.pushdefault side_repo &&
+	test_config remote.down.url down_repo &&
+	test_config branch.master.remote up &&
+	test_config branch.master.pushremote down &&
+	git push &&
+	check_push_result up_repo $the_first_commit heads/master &&
+	check_push_result side_repo $the_first_commit heads/master &&
+	check_push_result down_repo $the_commit heads/master
+'
+
 test_expect_success 'push with dry-run' '
 
 	mk_test testrepo heads/master &&
-- 
1.8.2.363.g901f5bc
