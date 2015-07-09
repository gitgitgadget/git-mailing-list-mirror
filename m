From: David Turner <dturner@twopensource.com>
Subject: [PATCH v8 4/7] git-reflog: add exists command
Date: Thu,  9 Jul 2015 18:50:57 -0400
Message-ID: <1436482260-28088-5-git-send-email-dturner@twopensource.com>
References: <1436482260-28088-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu, j6t@kdbg.org
X-From: git-owner@vger.kernel.org Fri Jul 10 00:51:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDKfK-00075y-Tw
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jul 2015 00:51:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751531AbbGIWvd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2015 18:51:33 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36488 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751144AbbGIWv3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2015 18:51:29 -0400
Received: by pacgz10 with SMTP id gz10so84063433pac.3
        for <git@vger.kernel.org>; Thu, 09 Jul 2015 15:51:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=T+VaT1Nd3IA35Nc0Y5Qrw09S24yb5qqSntk+uk9zef0=;
        b=NSDryI0A9xBfCH+1Cl+B214vXTswQvi7MgeZHEnnwx5ohWn5ssf6GPwAT4a9bBJ82+
         fX84J+eu1cQ9keShDIh5FYlxh81Nl88wthtzp8eX4gnQ3Rug9VMMM/rRDZY6brHougyy
         nb7onjF/SPbbjHqHsInFSQnsiNa3AYy2k5BD4WSxdZ2bnIbN2JQS6M8INcltR+RnbFDr
         tFZl5reBnxoBp+c8/azhanePAHg/BEGVY2LnCxubIaHY7uTvVDlKnXkvdMLoK1y8ji6w
         Cyd4qv/vm6VGazd8xra/ShaCxL21Z+8jVXDgjkipYSKqCWMtnSbXbuWzdPEd1/t2bTrJ
         CANg==
X-Gm-Message-State: ALoCoQnaPDu1am0ahUaqtDVapda0G2vDxsvRJ6sLj5LHOwlnif/cZdibz7mC3EUbUsgC4ZOaa4a9
X-Received: by 10.66.121.101 with SMTP id lj5mr35166434pab.113.1436482288546;
        Thu, 09 Jul 2015 15:51:28 -0700 (PDT)
Received: from ubuntu.twitter.corp? (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id fr2sm7129684pdb.22.2015.07.09.15.51.26
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 09 Jul 2015 15:51:27 -0700 (PDT)
X-Mailer: git-send-email 2.0.5.499.g01f6352.dirty-twtrsrc
In-Reply-To: <1436482260-28088-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273791>

Theis are necessary because alternate ref backends might store reflogs
somewhere other than .git/logs.  Code that now directly manipulates
.git/logs should instead go through git-reflog.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 Documentation/git-reflog.txt |  4 ++++
 builtin/reflog.c             | 33 ++++++++++++++++++++++++++++++++-
 t/t1411-reflog-show.sh       |  5 +++++
 3 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-reflog.txt b/Documentation/git-reflog.txt
index 5e7908e..4b08fc7 100644
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
 
+The "exists" subcommand checks whether a ref has a reflog.  It exists
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
2.0.5.499.g01f6352.dirty-twtrsrc
