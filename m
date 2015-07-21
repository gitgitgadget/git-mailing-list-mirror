From: David Turner <dturner@twopensource.com>
Subject: [PATCH v9 4/7] git-reflog: add exists command
Date: Tue, 21 Jul 2015 11:45:01 -0400
Message-ID: <1437493504-3699-5-git-send-email-dturner@twopensource.com>
References: <1437493504-3699-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Jul 21 17:45:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHZjc-000447-Pd
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jul 2015 17:45:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933139AbbGUPpS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2015 11:45:18 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:34468 "EHLO
	mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754146AbbGUPpQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2015 11:45:16 -0400
Received: by qkfc129 with SMTP id c129so92652140qkf.1
        for <git@vger.kernel.org>; Tue, 21 Jul 2015 08:45:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V5amPFF0E/Ap5IhK1iT5Fft6cVGrb1G1fzgE14dgSX0=;
        b=c7EIe4jqN3OMbcpwau3KQ5TmbwcPwMtlc75G+ROIlDfzr8+1ALDpkYWA+WxM+AjaAt
         OMkD9VwwcHTBrFKnTyxfRPopYatqYeX6uiuwXA6KBECmDFfmaU0+BUZKovh3Co41wuQy
         Va3pydmw351o5iSRhcf+AX7yrGuVVNPK0xYnaHzjOlhdSdt1xIhO9lVkrTr6MQ5Qza3f
         7wBFVntNIiWVSjm2EUO8TJJO6SQX0LcBKAqOcByEHLjvYcpY8EZviQNV1Qg1Jv/gmFBJ
         XIpoDkBlDvZ855f6iOAUvF6rxQUbsaRTdmYA7PE2YcSQ+hsJjPJty6SvuzSNEX2mIXcp
         I6Xw==
X-Gm-Message-State: ALoCoQkB8KYdT/orbNJnbu0VCQIDB6ZSclMg46nz/EDLbBDw27UkO9t9nRtNTiSEs6BfPSUrZtcP
X-Received: by 10.140.28.97 with SMTP id 88mr28224437qgy.69.1437493515307;
        Tue, 21 Jul 2015 08:45:15 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id g33sm12941288qgg.4.2015.07.21.08.45.14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 Jul 2015 08:45:14 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.586.g889ef79-twtrsrc
In-Reply-To: <1437493504-3699-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274383>

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
2.4.2.586.g889ef79-twtrsrc
