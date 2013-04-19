From: Johan Herland <johan@herland.net>
Subject: [RFD/PATCH 4/5] branch.c: Look up refspecs to validate tracking branches
Date: Fri, 19 Apr 2013 08:20:41 +0200
Message-ID: <1366352442-501-5-git-send-email-johan@herland.net>
References: <1366352442-501-1-git-send-email-johan@herland.net>
Cc: johan@herland.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 19 08:21:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UT4hl-0002ou-0L
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 08:21:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966997Ab3DSGVr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 02:21:47 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:54655 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756737Ab3DSGVo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 02:21:44 -0400
Received: by mail-lb0-f173.google.com with SMTP id w20so3386895lbh.4
        for <git@vger.kernel.org>; Thu, 18 Apr 2013 23:21:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=ajieXvpJAR3nONuf/V1hC/ZkgcHlbynySz+TQp5jHHY=;
        b=O5jEhP4ugaecextdB1mJO1bpUDR6ceur0CQEeXy1XXPxW5AvWVYwLhAAF8l7sakF0j
         l/8TWSepqsLwSDGu1ZNFwuLzcEjDKj2qOZTf9kV6BEF41WAVUw4U+T1QjAcvFYaYKYJx
         S7qP+eF666bB59J0pBPD60fEEB+gLMJWrhfEDqaN+4vV4oFG4Gn4SDSov7dMpvmKW641
         ILhcXae8JF3EeCkzo/6Qca78jsKbMzzf0Uz6cYfVTqIaVZsCL+L3vJFlPch0GCbq6vrK
         t97Uj6pi7Uvlm8Hzz+IXc6d7BqQkOO1+2fSfS3SYkbcA1yv8t1VtfuXxlzYKxkmr7lDX
         /guQ==
X-Received: by 10.112.163.6 with SMTP id ye6mr7273508lbb.59.1366352503593;
        Thu, 18 Apr 2013 23:21:43 -0700 (PDT)
Received: from gamma.herland (cm-84.208.177.71.getinternet.no. [84.208.177.71])
        by mx.google.com with ESMTPS id f4sm2076904lbw.6.2013.04.18.23.21.42
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 18 Apr 2013 23:21:42 -0700 (PDT)
X-Mailer: git-send-email 1.8.1.3.704.g33f7d4f
In-Reply-To: <1366352442-501-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221747>

The current code for validating tracking branches (e.g. the argument to the
-t/--track option) hardcodes refs/heads/* and refs/remotes/* as the potential
locations for tracking branches. This works well with the conventional
refspecs created by "git clone" or "git remote add", but does not work if the
user tweaks the refspecs to place remote-tracking branches outside
refs/remotes/*.

This patch adds explicit checking of the refspecs for each remote to determine
whether a candidate tracking branch is indeed a valid remote-tracking branch,
even if placed outside refs/heads/* and refs/remotes/*.

This new check is added as a fallback after checking for match against
refs/heads/* and refs/remotes/*, so the code will not be run in the common
case.

This patch also fixes the last remaining test failure in t2024-checkout-dwim.

Signed-off-by: Johan Herland <johan@herland.net>
---
 branch.c                 | 18 +++++++++++++++++-
 t/t2024-checkout-dwim.sh |  2 +-
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/branch.c b/branch.c
index 6ae6a4c..c9f9dec 100644
--- a/branch.c
+++ b/branch.c
@@ -197,6 +197,21 @@ int validate_new_branchname(const char *name, struct strbuf *ref,
 	return 1;
 }
 
+static int check_tracking_branch(struct remote *remote, void *cb_data)
+{
+	char *tracking_branch = cb_data;
+	struct refspec query;
+	memset(&query, 0, sizeof(struct refspec));
+	query.dst = tracking_branch;
+	return !(remote_find_tracking(remote, &query) ||
+		 prefixcmp(query.src, "refs/heads/"));
+}
+
+static int validate_remote_tracking_branch(char *ref)
+{
+	return !for_each_remote(check_tracking_branch, ref);
+}
+
 static const char upstream_not_branch[] =
 N_("Cannot setup tracking information; starting point '%s' is not a branch.");
 static const char upstream_missing[] =
@@ -259,7 +274,8 @@ void create_branch(const char *head,
 	case 1:
 		/* Unique completion -- good, only if it is a real branch */
 		if (prefixcmp(real_ref, "refs/heads/") &&
-		    prefixcmp(real_ref, "refs/remotes/")) {
+		    prefixcmp(real_ref, "refs/remotes/") &&
+		    validate_remote_tracking_branch(real_ref)) {
 			if (explicit_tracking)
 				die(_(upstream_not_branch), start_name);
 			else
diff --git a/t/t2024-checkout-dwim.sh b/t/t2024-checkout-dwim.sh
index fc6edc9..a8f0a90 100755
--- a/t/t2024-checkout-dwim.sh
+++ b/t/t2024-checkout-dwim.sh
@@ -108,7 +108,7 @@ test_expect_success 'checkout of branch from a single remote succeeds #3' '
 	test_tracking_branch spam repo_c refs/remotes/extra_dir/repo_c/extra_dir/spam
 '
 
-test_expect_failure 'checkout of branch from a single remote succeeds #4' '
+test_expect_success 'checkout of branch from a single remote succeeds #4' '
 	git checkout eggs &&
 	test_tracking_branch eggs repo_d refs/repo_d/eggs
 '
-- 
1.8.1.3.704.g33f7d4f
