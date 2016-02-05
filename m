From: Dan Aloni <alonid@gmail.com>
Subject: [PATCH v5 2/3] ident: add user.useConfigOnly boolean for when ident shouldn't be guessed
Date: Fri,  5 Feb 2016 09:01:41 +0200
Message-ID: <1454655702-28164-3-git-send-email-alonid@gmail.com>
References: <1454655702-28164-1-git-send-email-alonid@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 05 08:02:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRaPY-00080F-Im
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 08:02:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751910AbcBEHC0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 02:02:26 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:38134 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751885AbcBEHCS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 02:02:18 -0500
Received: by mail-wm0-f52.google.com with SMTP id p63so13658960wmp.1
        for <git@vger.kernel.org>; Thu, 04 Feb 2016 23:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EO8CYofmZlkwdVnMbnSjZQRs5ssiQphVrQx9qBXrzxI=;
        b=heMbmhpIeFKpx0uy3tCqurKwTWQeGMW9ewFy8GO/uYn6tbl8fchsoqziGaGGzQYgt+
         WCe91bEyLHNut9xI5ouaqfQsRAdbtkxRCmfex68YZV6eRNDJm9jNP5LV2QhAleBuhULK
         blK28Ifyfz4UufMXBAATZLJ/zePyxHmuhHCeEE31L8D8KrQ5e9TzojgwMOnOaGaXiYB/
         KNiq5HHC+HkVqeYE8hf/yiXgXxuViHjViEI1VLjVD8FxYWOnUbBCc4MW0nfaMhS4lSLG
         uF+yxWsNdt2lxAkgRp3k8rvcPVQOzBdmMOGxh11GcmKCXpZhClkXa5tGuGgmnNM284A2
         R5Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EO8CYofmZlkwdVnMbnSjZQRs5ssiQphVrQx9qBXrzxI=;
        b=dp6ELfffD8HNsKDOP4wXCrHsTSMfpIel6lfVNbu6A6QrOseemjwoHSY7qlfPmFsgif
         iptkxPYZm6zhCenTo64bg21mH9qBsqgvMvVt2p0V5pTQUBU5UH50R6iaF2GwQCr0JYvB
         p73c93ZdHSszcrjsvRtcfuGZiZPzvmRIGh+1mwkIMRVMYVeX9gfk825aLscBuSz29Hv3
         yRANiwZQdzjq5yvFUC/h+bL7X7sMiYmsTbTetRKQOR0PtuqR02vjnXn54SPLqfnGw6bs
         gt8yBPuhczRvlZBXMG7UEsW0xXYziK5gHWlZf1y6jJousptazTJzDFwfUU34KECOfGwI
         LzpA==
X-Gm-Message-State: AG10YOSe72RKs4gQourU/a5K+4fQinf7zcvBJCJqH5pq8yAxp/8HY4UFc226bvNNkbvzBA==
X-Received: by 10.195.13.129 with SMTP id ey1mr11900838wjd.132.1454655736814;
        Thu, 04 Feb 2016 23:02:16 -0800 (PST)
Received: from nitrogen.home.aloni.org ([31.210.180.167])
        by smtp.gmail.com with ESMTPSA id i2sm14442915wjx.42.2016.02.04.23.02.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Feb 2016 23:02:16 -0800 (PST)
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1454655702-28164-1-git-send-email-alonid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285547>

It used to be that:

   git config --global user.email "(none)"

was a viable way for people to force themselves to set user.email in
each repository.  This was helpful for people with more than one
email address, targeting different email addresses for different
clones, as it barred git from creating commit unless the user.email
config was set in the per-repo config to the correct email address.

A recent change, 19ce497c (ident: keep a flag for bogus
default_email, 2015-12-10), however declared that an explicitly
configured user.email is not bogus, no matter what its value is, so
this hack no longer works.

Provide the same functionality by adding a new configuration
variable user.useConfigOnly; when this variable is set, the
user must explicitly set user.email configuration.

Signed-off-by: Dan Aloni <alonid@gmail.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/config.txt  |  9 ++++++++
 ident.c                   | 16 +++++++++++++
 t/t9904-per-repo-email.sh | 58 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 83 insertions(+)
 create mode 100755 t/t9904-per-repo-email.sh

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 02bcde6bb596..25cf7ce4e83a 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2821,6 +2821,15 @@ user.name::
 	Can be overridden by the 'GIT_AUTHOR_NAME' and 'GIT_COMMITTER_NAME'
 	environment variables.  See linkgit:git-commit-tree[1].
 
+user.useConfigOnly::
+	This instruct Git to avoid trying to guess defaults for 'user.email'
+	and 'user.name' other than strictly from environment or config.
+	If you have multiple email addresses that you would like to set
+	up per repository, you may want to set this to 'true' in the global
+	config, and then Git would prompt you to set user.email separately,
+	in each of the cloned repositories.
+	Defaults to `false`.
+
 user.signingKey::
 	If linkgit:git-tag[1] or linkgit:git-commit[1] is not selecting the
 	key you want it to automatically when creating a signed tag or
diff --git a/ident.c b/ident.c
index f3a431f738cc..9bd6ac69bfe8 100644
--- a/ident.c
+++ b/ident.c
@@ -13,11 +13,14 @@ static struct strbuf git_default_date = STRBUF_INIT;
 static int default_email_is_bogus;
 static int default_name_is_bogus;
 
+static int ident_use_config_only;
+
 #define IDENT_NAME_GIVEN 01
 #define IDENT_MAIL_GIVEN 02
 #define IDENT_ALL_GIVEN (IDENT_NAME_GIVEN|IDENT_MAIL_GIVEN)
 static int committer_ident_explicitly_given;
 static int author_ident_explicitly_given;
+static int ident_config_given;
 
 #ifdef NO_GECOS_IN_PWENT
 #define get_gecos(ignored) "&"
@@ -354,6 +357,9 @@ const char *fmt_ident(const char *name, const char *email,
 				fputs(env_hint, stderr);
 				die("unable to auto-detect name (got '%s')", name);
 			}
+			if (strict && ident_use_config_only &&
+			    !(ident_config_given & IDENT_NAME_GIVEN))
+				die("user.useConfigOnly set but no name given");
 		}
 		if (!*name) {
 			struct passwd *pw;
@@ -373,6 +379,9 @@ const char *fmt_ident(const char *name, const char *email,
 			fputs(env_hint, stderr);
 			die("unable to auto-detect email address (got '%s')", email);
 		}
+		if (strict && ident_use_config_only
+		    && !(ident_config_given & IDENT_MAIL_GIVEN))
+			die("user.useConfigOnly set but no mail given");
 	}
 
 	strbuf_reset(&ident);
@@ -446,6 +455,11 @@ int author_ident_sufficiently_given(void)
 
 int git_ident_config(const char *var, const char *value, void *data)
 {
+	if (!strcmp(var, "user.useconfigonly")) {
+		ident_use_config_only = git_config_bool(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "user.name")) {
 		if (!value)
 			return config_error_nonbool(var);
@@ -453,6 +467,7 @@ int git_ident_config(const char *var, const char *value, void *data)
 		strbuf_addstr(&git_default_name, value);
 		committer_ident_explicitly_given |= IDENT_NAME_GIVEN;
 		author_ident_explicitly_given |= IDENT_NAME_GIVEN;
+		ident_config_given |= IDENT_NAME_GIVEN;
 		return 0;
 	}
 
@@ -463,6 +478,7 @@ int git_ident_config(const char *var, const char *value, void *data)
 		strbuf_addstr(&git_default_email, value);
 		committer_ident_explicitly_given |= IDENT_MAIL_GIVEN;
 		author_ident_explicitly_given |= IDENT_MAIL_GIVEN;
+		ident_config_given |= IDENT_MAIL_GIVEN;
 		return 0;
 	}
 
diff --git a/t/t9904-per-repo-email.sh b/t/t9904-per-repo-email.sh
new file mode 100755
index 000000000000..0430f2e38434
--- /dev/null
+++ b/t/t9904-per-repo-email.sh
@@ -0,0 +1,58 @@
+#!/bin/sh
+#
+# Copyright (c) 2016 Dan Aloni
+#
+
+test_description='per-repo forced setting of email address'
+
+. ./test-lib.sh
+
+prepare () {
+	# Have a non-empty repository
+	rm -fr .git
+	git init
+	echo "Initial" >foo &&
+	git add foo &&
+	git commit -m foo &&
+
+	# Setup a likely user.useConfigOnly use case
+	sane_unset GIT_AUTHOR_NAME &&
+	sane_unset GIT_AUTHOR_EMAIL &&
+	test_unconfig --global user.name &&
+	test_unconfig --global user.email &&
+	test_config user.name "test" &&
+	test_unconfig user.email &&
+	test_config_global user.useConfigOnly true
+}
+
+about_to_commit () {
+	echo "Second" >>foo &&
+	git add foo
+}
+
+test_expect_success 'fails committing if clone email is not set' '
+	prepare && about_to_commit &&
+
+	test_must_fail git commit -m msg
+'
+
+test_expect_success 'fails committing if clone email is not set, but EMAIL set' '
+	prepare && about_to_commit &&
+
+	test_must_fail env EMAIL=test@fail.com git commit -m msg
+'
+
+test_expect_success 'succeeds committing if clone email is set' '
+	prepare && about_to_commit &&
+
+	test_config user.email "test@ok.com" &&
+	git commit -m msg
+'
+
+test_expect_success 'succeeds cloning if global email is not set' '
+	prepare &&
+
+	git clone . clone
+'
+
+test_done
-- 
2.5.0
