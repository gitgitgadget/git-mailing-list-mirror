From: David Turner <dturner@twopensource.com>
Subject: [PATCH v5 6/7] git-reflog: add create and exists functions
Date: Mon, 29 Jun 2015 13:54:27 -0400
Message-ID: <1435600468-21710-7-git-send-email-dturner@twopensource.com>
References: <1435600468-21710-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Mon Jun 29 19:55:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9dGr-0005zR-Ka
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jun 2015 19:55:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753569AbbF2Ry7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2015 13:54:59 -0400
Received: from mail-qc0-f172.google.com ([209.85.216.172]:33601 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753482AbbF2Ryp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2015 13:54:45 -0400
Received: by qcbcf1 with SMTP id cf1so45252254qcb.0
        for <git@vger.kernel.org>; Mon, 29 Jun 2015 10:54:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2MvJh6LlIspxX7JQ54+hgceUMDc48/K6owUy8LtdXrM=;
        b=ASQkdCVQU/+t9Im+WkqbqQGyqqanA8nMICOyFJs7+hdBqoE/T3WtlCYicybKlh7Knx
         9k5zJ5He23FMHjcvAHL3koI8DcSzqw++0ijMSBBfZUjWY3XID5YSPOWFv9TiE1L8Qw+s
         fTDREZhW40m6ht/0G2+OJVuBUpbUB/ABe77ujI5UbsDU+y7MdoA2/SdfEQ/m9fIxaEiX
         RpXrB4gUPOEzboPBJ+/mECMTKWihE3bOSCf4m2lnFvEU7VtPWhd9TwGzgmTWuw9rCUIg
         Cc/1CBu666qDEY4g5Pe2VhWgbR5sENSAHjgHv2jDjO4d49HzSn9CBFUI+MsK2dJQe0Ga
         xVDg==
X-Gm-Message-State: ALoCoQloHyGR5skI7J/UovN9ae6rxKEUvziYy0wp2ay19rcUL6eHBS6Zsrz8JSjNjOkAJ4i4GU0D
X-Received: by 10.141.28.131 with SMTP id f125mr16076315qhe.54.1435600484989;
        Mon, 29 Jun 2015 10:54:44 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.145])
        by mx.google.com with ESMTPSA id w67sm11860026qgw.41.2015.06.29.10.54.43
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 29 Jun 2015 10:54:44 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1435600468-21710-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272987>

These are necessary because alternate ref backends might store reflogs
somewhere other than .git/logs.  Code that now directly manipulates
.git/logs should instead go through git-reflog.

In a moment, we will use these functions to make git stash work with
alternate ref backends.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 Documentation/git-reflog.txt | 10 ++++++
 builtin/reflog.c             | 75 +++++++++++++++++++++++++++++++++++++++++++-
 t/t1411-reflog-show.sh       | 12 +++++++
 3 files changed, 96 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-reflog.txt b/Documentation/git-reflog.txt
index 5e7908e..7ab2c42 100644
--- a/Documentation/git-reflog.txt
+++ b/Documentation/git-reflog.txt
@@ -23,6 +23,8 @@ depending on the subcommand:
 	[--dry-run] [--verbose] [--all | <refs>...]
 'git reflog delete' [--rewrite] [--updateref]
 	[--dry-run] [--verbose] ref@\{specifier\}...
+'git reflog create <refs>...
+'git reflog exists <ref>
 
 Reference logs, or "reflogs", record when the tips of branches and
 other references were updated in the local repository. Reflogs are
@@ -52,6 +54,14 @@ argument must be an _exact_ entry (e.g. "`git reflog delete
 master@{2}`"). This subcommand is also typically not used directly by
 end users.
 
+The "create" subcommand creates a reflog for one or more refs. Most
+refs (those under refs/heads, refs/remotes, and refs/tags) will
+automatically have reflogs created. Other refs will not. This command
+allows manual ref creation.
+
+The "exists" subcommand checks whether a ref has a reflog.  It exists
+with zero status if the reflog exists, and non-zero status if it does
+not.
 
 OPTIONS
 -------
diff --git a/builtin/reflog.c b/builtin/reflog.c
index c2eb8ff..1ecbfb6 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -13,6 +13,10 @@ static const char reflog_expire_usage[] =
 "git reflog expire [--expire=<time>] [--expire-unreachable=<time>] [--rewrite] [--updateref] [--stale-fix] [--dry-run | -n] [--verbose] [--all] <refs>...";
 static const char reflog_delete_usage[] =
 "git reflog delete [--rewrite] [--updateref] [--dry-run | -n] [--verbose] <refs>...";
+static const char reflog_create_usage[] =
+"git reflog create <refs>...";
+static const char reflog_exists_usage[] =
+"git reflog exists <ref>";
 
 static unsigned long default_reflog_expire;
 static unsigned long default_reflog_expire_unreachable;
@@ -699,12 +703,75 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
 	return status;
 }
 
+static int cmd_reflog_create(int argc, const char **argv, const char *prefix)
+{
+	int i, status = 0, start = 0;
+	struct strbuf err = STRBUF_INIT;
+
+	for (i = 1; i < argc; i++) {
+		const char *arg = argv[i];
+		if (!strcmp(arg, "--")) {
+			i++;
+			break;
+		}
+		else if (arg[0] == '-')
+			usage(reflog_create_usage);
+		else
+			break;
+	}
+
+	start = i;
+
+	if (argc - start < 1)
+		return error("Nothing to create?");
+
+	for (i = start; i < argc; i++) {
+		if (check_refname_format(argv[i], REFNAME_ALLOW_ONELEVEL))
+			die("invalid ref format: %s", argv[i]);
+	}
+	for (i = start; i < argc; i++) {
+		if (safe_create_reflog(argv[i], &err, 1)) {
+			error("could not create reflog %s: %s", argv[i],
+			      err.buf);
+			status = 1;
+			strbuf_release(&err);
+		}
+	}
+	return status;
+}
+
+static int cmd_reflog_exists(int argc, const char **argv, const char *prefix)
+{
+	int i, status = 0, start = 0;
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
+"git reflog [ show | expire | delete | create | exists ]";
 
 int cmd_reflog(int argc, const char **argv, const char *prefix)
 {
@@ -724,5 +791,11 @@ int cmd_reflog(int argc, const char **argv, const char *prefix)
 	if (!strcmp(argv[1], "delete"))
 		return cmd_reflog_delete(argc - 1, argv + 1, prefix);
 
+	if (!strcmp(argv[1], "create"))
+		return cmd_reflog_create(argc - 1, argv + 1, prefix);
+
+	if (!strcmp(argv[1], "exists"))
+		return cmd_reflog_exists(argc - 1, argv + 1, prefix);
+
 	return cmd_log_reflog(argc, argv, prefix);
 }
diff --git a/t/t1411-reflog-show.sh b/t/t1411-reflog-show.sh
index 6f47c0d..6e1abe7 100755
--- a/t/t1411-reflog-show.sh
+++ b/t/t1411-reflog-show.sh
@@ -166,4 +166,16 @@ test_expect_success 'git log -g -p shows diffs vs. parents' '
 	test_cmp expect actual
 '
 
+test_expect_success 'reflog exists works' '
+	git reflog exists refs/heads/master &&
+	! git reflog exists refs/heads/nonexistent
+'
+
+test_expect_success 'reflog create works' '
+	git update-ref non-refs-dir HEAD &&
+	! git reflog exists non-refs-dir &&
+	git reflog create non-refs-dir &&
+	git reflog exists non-refs-dir
+'
+
 test_done
-- 
2.0.4.315.gad8727a-twtrsrc
