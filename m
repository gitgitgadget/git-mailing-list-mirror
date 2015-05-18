From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH 06/14] pull: support pull.ff config
Date: Mon, 18 May 2015 23:06:03 +0800
Message-ID: <1431961571-20370-7-git-send-email-pyokagan@gmail.com>
References: <1431961571-20370-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 18 17:08:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuMe7-0004Uz-Bi
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 17:07:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753121AbbERPHu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 11:07:50 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:33577 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753702AbbERPHp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 11:07:45 -0400
Received: by pdbqa5 with SMTP id qa5so153146414pdb.0
        for <git@vger.kernel.org>; Mon, 18 May 2015 08:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lGzRwtpK8JbkFtdj2JBzHZLQkoeTg7ewNvlQtr1MYwA=;
        b=vZVlMeB5ClkM+g1hWEvASDclSdjcfkkRR+MpBBZYrRNXrZm8YHYFPZMdX1qe5zIHGw
         gCcDzs/kKbEfgg+O3h/opJDcSiReqnn6stibF+fQ74wc7z+IhmvsvI4yunA/pn3OskbI
         czUNm4BNzOmJyG/n97AInrePj+3nITp2aiRQjNQB3rJus6BLUfrAERyIGTjo1mWTTi58
         MBUfnLppgHf0n7JCpDK+AgI8jevkFKtIVc01lgK/2NYbJq1VWoEf1ouoRKhFArd1qa5o
         lNeYXBCzjZTikEs9P2apFK3sQfyXfAEoHdAXEFwcAqKtq7ess+1KS7k+p+3qHpGxJwHC
         tJ3g==
X-Received: by 10.68.219.42 with SMTP id pl10mr45352707pbc.154.1431961665460;
        Mon, 18 May 2015 08:07:45 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id i9sm10370062pdj.27.2015.05.18.08.07.42
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 May 2015 08:07:44 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1431961571-20370-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269268>

Since b814da8 (pull: add pull.ff configuration, 2014-01-15), git-pull.sh
would lookup the configuration value of "pull.ff", and set the flag
"--ff" if its value is "true", "--no-ff" if its value is "false" and
"--ff-only" if its value is "only".

Re-implement this behavior.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/pull.c               | 25 +++++++++++++++++++++++++
 t/t7601-merge-pull-config.sh |  4 ++--
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 8982fdf..b305a47 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -209,6 +209,28 @@ static void argv_push_force(struct argv_array *arr)
 		argv_array_push(arr, "-f");
 }
 
+/**
+ * If pull.ff is "true", returns "--ff". If pull.ff is "false", returns
+ * "--no-ff". If pull.ff is "only", returns "--ff-only". Otherwise, returns
+ * NULL.
+ */
+static const char *config_get_ff(void)
+{
+	const char *value;
+
+	if (git_config_get_value("pull.ff", &value))
+		return NULL;
+	switch (git_config_maybe_bool("pull.ff", value)) {
+		case 0:
+			return "--no-ff";
+		case 1:
+			return "--ff";
+	}
+	if (!strcmp("pull.ff", "only"))
+		return "--ff-only";
+	die(_("Invalid value for pull.ff: %s"), value);
+}
+
 struct known_remote {
 	struct known_remote *next;
 	struct remote *remote;
@@ -449,6 +471,9 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, pull_options, pull_usage, 0);
 	parse_repo_refspecs(argc, argv, &repo, &refspecs);
 
+	if (!opt_ff)
+		opt_ff = xstrdup_or_null(config_get_ff());
+
 	if (run_fetch(repo, refspecs))
 		return 1;
 
diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
index 7a846a2..f768c90 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -45,7 +45,7 @@ test_expect_success 'fast-forward pull succeeds with "true" in pull.ff' '
 	test "$(git rev-parse HEAD)" = "$(git rev-parse c1)"
 '
 
-test_expect_failure 'fast-forward pull creates merge with "false" in pull.ff' '
+test_expect_success 'fast-forward pull creates merge with "false" in pull.ff' '
 	git reset --hard c0 &&
 	test_config pull.ff false &&
 	git pull . c1 &&
@@ -53,7 +53,7 @@ test_expect_failure 'fast-forward pull creates merge with "false" in pull.ff' '
 	test "$(git rev-parse HEAD^2)" = "$(git rev-parse c1)"
 '
 
-test_expect_failure 'pull prevents non-fast-forward with "only" in pull.ff' '
+test_expect_success 'pull prevents non-fast-forward with "only" in pull.ff' '
 	git reset --hard c1 &&
 	test_config pull.ff only &&
 	test_must_fail git pull . c3
-- 
2.1.4
