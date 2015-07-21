From: David Turner <dturner@twopensource.com>
Subject: [PATCH v10 4/7] git-reflog: add exists command
Date: Tue, 21 Jul 2015 17:04:53 -0400
Message-ID: <1437512696-14672-4-git-send-email-dturner@twopensource.com>
References: <1437512696-14672-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhaggerty@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Jul 21 23:06:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHejk-0001wS-1Z
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jul 2015 23:06:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932836AbbGUVFz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2015 17:05:55 -0400
Received: from mail-qg0-f50.google.com ([209.85.192.50]:34982 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933408AbbGUVFM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2015 17:05:12 -0400
Received: by qgii95 with SMTP id i95so63123886qgi.2
        for <git@vger.kernel.org>; Tue, 21 Jul 2015 14:05:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vZUgB4pndvOBe7zXXgKnTHTqfsf/WOsXxRcEoNHqd14=;
        b=JKVR/xfulFIK3rMc7jsvWKbCxUsnpmB0UpuhaJDn8FtHSwgZlUAEauhAN34e0UdErb
         aMuzhLRFoMdyahHkwWBYkxv/RDEoBsDeB39+5H3FBZ9NIfRBfsLnhmsH16HZvBDw1rjs
         Fx/NzGaZOeqlTAjxKUnDHvCh8oRnUoV8guI8xVgiiUVNtjIEZkXw4vNecsTRjC6NvFYY
         4sQeL/D/e2Ec5D6xBetfn+nbXNtM9M0+7GVVVRSSMAl5SA+db8Rn6e+Q6eQdaUXmDgWP
         HX8N7iNyDr+ozz+6M2l6XM9CHRsr0Ts0r5Blqgbes39gTk2a22kyxDJmMw1hYqI6gexw
         1atA==
X-Gm-Message-State: ALoCoQm4Iku8ilaHLsO+ldVOUlyPDx50CKVQ3sJUW3H/AlTHUo4XRn2LAVYazxvJ0dnntI91o8nL
X-Received: by 10.55.41.74 with SMTP id p71mr56465543qkh.82.1437512711785;
        Tue, 21 Jul 2015 14:05:11 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id x137sm13430413qkx.28.2015.07.21.14.05.08
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 Jul 2015 14:05:10 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1437512696-14672-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274426>

This is necessary because alternate ref backends might store reflogs
somewhere other than .git/logs.  Code that now directly manipulates
.git/logs should instead go through git-reflog.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 Documentation/git-reflog.txt |  4 ++++
 builtin/reflog.c             | 33 ++++++++++++++++++++++++++++++++-
 t/t1411-reflog-show.sh       |  5 +++++
 3 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-reflog.txt b/Documentation/git-reflog.txt
index 5e7908e..44c736f 100644
--- a/Documentation/git-reflog.txt
+++ b/Documentation/git-reflog.txt
@@ -23,6 +23,7 @@ depending on the subcommand:
 	[--dry-run] [--verbose] [--all | <refs>...]
 'git reflog delete' [--rewrite] [--updateref]
 	[--dry-run] [--verbose] ref@\{specifier\}...
+'git reflog exists' <ref>
 
 Reference logs, or "reflogs", record when the tips of branches and
 other references were updated in the local repository. Reflogs are
@@ -52,6 +53,9 @@ argument must be an _exact_ entry (e.g. "`git reflog delete
 master@{2}`"). This subcommand is also typically not used directly by
 end users.
 
+The "exists" subcommand checks whether a ref has a reflog.  It exits
+with zero status if the reflog exists, and non-zero status if it does
+not.
 
 OPTIONS
 -------
diff --git a/builtin/reflog.c b/builtin/reflog.c
index c2eb8ff..7ed0e85 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -13,6 +13,8 @@ static const char reflog_expire_usage[] =
 "git reflog expire [--expire=<time>] [--expire-unreachable=<time>] [--rewrite] [--updateref] [--stale-fix] [--dry-run | -n] [--verbose] [--all] <refs>...";
 static const char reflog_delete_usage[] =
 "git reflog delete [--rewrite] [--updateref] [--dry-run | -n] [--verbose] <refs>...";
+static const char reflog_exists_usage[] =
+"git reflog exists <ref>";
 
 static unsigned long default_reflog_expire;
 static unsigned long default_reflog_expire_unreachable;
@@ -699,12 +701,38 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
 	return status;
 }
 
+static int cmd_reflog_exists(int argc, const char **argv, const char *prefix)
+{
+	int i, start = 0;
+
+	for (i = 1; i < argc; i++) {
+		const char *arg = argv[i];
+		if (!strcmp(arg, "--")) {
+			i++;
+			break;
+		}
+		else if (arg[0] == '-')
+			usage(reflog_exists_usage);
+		else
+			break;
+	}
+
+	start = i;
+
+	if (argc - start != 1)
+		usage(reflog_exists_usage);
+
+	if (check_refname_format(argv[start], REFNAME_ALLOW_ONELEVEL))
+		die("invalid ref format: %s", argv[start]);
+	return !reflog_exists(argv[start]);
+}
+
 /*
  * main "reflog"
  */
 
 static const char reflog_usage[] =
-"git reflog [ show | expire | delete ]";
+"git reflog [ show | expire | delete | exists ]";
 
 int cmd_reflog(int argc, const char **argv, const char *prefix)
 {
@@ -724,5 +752,8 @@ int cmd_reflog(int argc, const char **argv, const char *prefix)
 	if (!strcmp(argv[1], "delete"))
 		return cmd_reflog_delete(argc - 1, argv + 1, prefix);
 
+	if (!strcmp(argv[1], "exists"))
+		return cmd_reflog_exists(argc - 1, argv + 1, prefix);
+
 	return cmd_log_reflog(argc, argv, prefix);
 }
diff --git a/t/t1411-reflog-show.sh b/t/t1411-reflog-show.sh
index 6f47c0d..3eb4f10 100755
--- a/t/t1411-reflog-show.sh
+++ b/t/t1411-reflog-show.sh
@@ -166,4 +166,9 @@ test_expect_success 'git log -g -p shows diffs vs. parents' '
 	test_cmp expect actual
 '
 
+test_expect_success 'reflog exists works' '
+	git reflog exists refs/heads/master &&
+	! git reflog exists refs/heads/nonexistent
+'
+
 test_done
-- 
2.0.4.315.gad8727a-twtrsrc
