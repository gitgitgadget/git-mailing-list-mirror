From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 6/6] remote.c: introduce branch.<name>.pushremote
Date: Fri, 22 Mar 2013 13:22:36 +0530
Message-ID: <1363938756-13722-7-git-send-email-artagnon@gmail.com>
References: <1363938756-13722-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 22 08:52:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIwlm-0002QF-2E
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 08:52:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754588Ab3CVHvn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 03:51:43 -0400
Received: from mail-pb0-f44.google.com ([209.85.160.44]:44196 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754463Ab3CVHvm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 03:51:42 -0400
Received: by mail-pb0-f44.google.com with SMTP id wz12so2904004pbc.3
        for <git@vger.kernel.org>; Fri, 22 Mar 2013 00:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=rMitBYpTDrAi4n9qt4GpTfi3gwRP3LJvRq7vwuxbG94=;
        b=SGwOy4Oj9rq7+ZBEcGx1e6v4twqRki28M9nhjTdFHDCNRa8OQObHMM1uQs5oU/yeZz
         zj6T8SOKfvSztu5HVXkLu9MXqiHltAG9qRisPNahGwvPTKuizTuVl45mRKNW5far2V3M
         QfZ32jkD/vUG8JHbmrr99ts5G5XVdJ1Lpm9hFuvtg4VcXblzD6ESaVqu1E8ug3ZxnUMS
         Zhq5+TAtN+3sVZE8rtYdrA1vBHabclFNITrMxXo5U/toGzRkgh06GhiJg2pYxfBi912K
         QqjrySojYiywyK3p04Lgm06CRxsxCBL1aXY5PlqKeGJB+L8LIPbv5Td2eUIgxMECnNDE
         9YIw==
X-Received: by 10.66.156.196 with SMTP id wg4mr1889270pab.23.1363938701693;
        Fri, 22 Mar 2013 00:51:41 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPS id fh1sm2025227pac.1.2013.03.22.00.51.39
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 22 Mar 2013 00:51:41 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.62.ga35d936.dirty
In-Reply-To: <1363938756-13722-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218784>

This new configuration variable overrides `remote.pushdefault` and
`branch.<name>.remote` for pushes.  In a typical triangular-workflow
setup, you would want to set `remote.pushdefault` to specify the
remote to push to for all branches, and use this option to override it
for a specific branch.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/config.txt | 18 ++++++++++++++----
 remote.c                 |  4 ++++
 t/t5516-fetch-push.sh    | 15 +++++++++++++++
 3 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 09a8294..6595cd6 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -726,9 +726,18 @@ branch.<name>.remote::
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
+	When on branch <name>, it overrides `branch.<name>.remote`
+	when pushing.  It also overrides `remote.pushdefault` when
+	pushing from branch <name>.  In a typical triangular-workflow
+	setup, you would want to set `remote.pushdefault` to specify
+	the remote to push to for all branches, and use this option to
+	override it for a specific branch.
 
 branch.<name>.merge::
 	Defines, together with branch.<name>.remote, the upstream branch
@@ -1899,7 +1908,8 @@ receive.updateserverinfo::
 
 remote.pushdefault::
 	The remote to push to by default.  Overrides
-	`branch.<name>.remote` for all branches.
+	`branch.<name>.remote` for all branches, and is overridden by
+	`branch.<name>.pushremote` for specific branches.
 
 remote.<name>.url::
 	The URL of a remote repository.  See linkgit:git-fetch[1] or
diff --git a/remote.c b/remote.c
index bdb542c..0be648d 100644
--- a/remote.c
+++ b/remote.c
@@ -368,6 +368,10 @@ static int handle_config(const char *key, const char *value, void *cb)
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
index 63171f1..3f91874 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -539,6 +539,21 @@ test_expect_success 'push with config remote.*.pushurl' '
 	check_push_result $the_commit heads/master
 '
 
+test_expect_success 'push with config branch.*.pushremote' '
+	mk_test_with_name up_repo heads/frotz &&
+	mk_test_with_name side_repo heads/quux &&
+	mk_test_with_name down_repo heads/master &&
+	test_config remote.up.url up_repo &&
+	test_config remote.pushdefault side_repo &&
+	test_config remote.down.url down_repo &&
+	test_config branch.master.remote up &&
+	test_config branch.master.pushremote down &&
+	git push &&
+	test_must_fail check_push_result_with_name up_repo $the_commit heads/master &&
+	test_must_fail check_push_result_with_name side_repo $the_commit heads/master &&
+	check_push_result_with_name down_repo $the_commit heads/master
+'
+
 # clean up the cruft left with the previous one
 git config --remove-section remote.there
 
-- 
1.8.2.62.ga35d936.dirty
