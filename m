From: Dan Aloni <alonid@gmail.com>
Subject: [PATCH v8 2/2] ident: add user.useConfigOnly boolean for when ident shouldn't be guessed
Date: Sat,  6 Feb 2016 00:28:57 +0200
Message-ID: <1454711337-25508-3-git-send-email-alonid@gmail.com>
References: <1454711337-25508-1-git-send-email-alonid@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 05 23:29:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRosZ-0001Y5-D7
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 23:29:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754634AbcBEW3X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 17:29:23 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:33051 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754592AbcBEW3U (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 17:29:20 -0500
Received: by mail-wm0-f52.google.com with SMTP id g62so66239233wme.0
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 14:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JxCeQJKjI8voBM3G0Tnz6+KY4VHMm7suVwYB7rBm7Ac=;
        b=wE5w1v3QCK9eKxba76DJrFVsRHqrQRVmmQSmANSCe0XtLwPEpjeUvMQ81Qz8SJ9kgE
         aX9eUufPYsKCaea7taCwcfqhVsk/flUA8vnNUaY0Kagg5NIYCck6rp+s7a1Z0iPjU525
         /3jiQjYbPL37pt88AbpP6/3bn2b/kWRp60f48LeKjPN4zFaAbnkyM6KUbc5C93zhjptr
         3IOAlYls3wgGbB8F1p7VoGdaVJkayV6jgS+9/YD5yY/A9WzGCdxGHLi1p+OfL5DBsK0I
         NLWpPuuuZv8VuOTl2Yrub17WWwNpNbh33Fwa9S570so5cRoBzjm8mbBpaKQBjfvFozjN
         VwkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JxCeQJKjI8voBM3G0Tnz6+KY4VHMm7suVwYB7rBm7Ac=;
        b=VwnzFs5hihkKem1jFGhfKIrIdMavd4VLcyMlAsz4+gxZzxwlEEcdr+kEo0Rv7nIMUc
         qgZOPi+695XUM9HLPvhJB57wWYiqdxDDpD1L+OJFJsxU4eHQ9/YoNFkKCS/BR2WrVFHI
         IY7DuPRdgdz73ZpZWSoqqGMBvHQt9wb+tnqDiTmyvzAjQTL25HbvHjPO2qZDMEtwlVBc
         HN7cox+4u1If1sxIqZEPHemOuoEM+UeoCdydritSM6cewDIsB3TFx8clMMeBYD15mOxW
         5kegfSCahD3yg7faseRXNBpv52zHOAhH9OzBu80ttHtH7G0hX6Zus2vVVv8Zn0kpkZSF
         3/bw==
X-Gm-Message-State: AG10YOQTtGwEa8ajmLgp6GyQIjG7eDWsR6l8jNnek/pzQ39Ridvy7fZEim1UsEyLS/sD2A==
X-Received: by 10.28.19.204 with SMTP id 195mr42207847wmt.1.1454711359236;
        Fri, 05 Feb 2016 14:29:19 -0800 (PST)
Received: from nitrogen.home.aloni.org ([31.210.180.167])
        by smtp.gmail.com with ESMTPSA id t3sm17729626wjz.11.2016.02.05.14.29.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Feb 2016 14:29:18 -0800 (PST)
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1454711337-25508-1-git-send-email-alonid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285649>

It used to be that:

   git config --global user.email "(none)"

was a viable way for people to force themselves to set user.email in
each repository.  This was helpful for people with more than one
email address, targeting different email addresses for different
clones, as it barred git from creating a commit unless the user.email
config was set in the per-repo config to the correct email address.

A recent change, 19ce497c (ident: keep a flag for bogus
default_email, 2015-12-10), however, declared that an explicitly
configured user.email is not bogus, no matter what its value is, so
this hack no longer works.

Provide the same functionality by adding a new configuration
variable user.useConfigOnly; when this variable is set, the
user must explicitly set user.email configuration.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Dan Aloni <alonid@gmail.com>
---
 Documentation/config.txt  | 10 ++++++++++
 ident.c                   | 16 ++++++++++++++++
 t/t7517-per-repo-email.sh | 39 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 65 insertions(+)
 create mode 100755 t/t7517-per-repo-email.sh

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 02bcde6bb596..e153c7c1ec35 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2821,6 +2821,16 @@ user.name::
 	Can be overridden by the 'GIT_AUTHOR_NAME' and 'GIT_COMMITTER_NAME'
 	environment variables.  See linkgit:git-commit-tree[1].
 
+user.useConfigOnly::
+	Instruct Git to avoid trying to guess defaults for 'user.email'
+	and 'user.name', and instead retrieve the values only from the
+	configuration. For example, if you have multiple email addresses
+	and would like to use a different one for each repository, then
+	with this configuration option set to `true` in the global config
+	along with a name, Git will prompt you to set up an email upon
+	making new commits in a newly cloned repository.
+	Defaults to `false`.
+
 user.signingKey::
 	If linkgit:git-tag[1] or linkgit:git-commit[1] is not selecting the
 	key you want it to automatically when creating a signed tag or
diff --git a/ident.c b/ident.c
index f3a431f738cc..6e125821f056 100644
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
+			if (strict && ident_use_config_only
+			    && !(ident_config_given & IDENT_NAME_GIVEN))
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
 
diff --git a/t/t7517-per-repo-email.sh b/t/t7517-per-repo-email.sh
new file mode 100755
index 000000000000..337e6e30c35f
--- /dev/null
+++ b/t/t7517-per-repo-email.sh
@@ -0,0 +1,39 @@
+#!/bin/sh
+#
+# Copyright (c) 2016 Dan Aloni
+# Copyright (c) 2016 Jeff King
+#
+
+test_description='per-repo forced setting of email address'
+
+. ./test-lib.sh
+
+test_expect_success 'setup a likely user.useConfigOnly use case' '
+	# we want to make sure a reflog is written, since that needs
+	# a non-strict ident. So be sure we have an actual commit.
+	test_commit foo &&
+
+	sane_unset GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL &&
+	sane_unset GIT_COMMITTER_NAME GIT_COMMITTER_EMAIL &&
+	git config user.name "test" &&
+	git config --global user.useConfigOnly true
+'
+
+test_expect_success 'fails committing if clone email is not set' '
+	test_must_fail git commit --allow-empty -m msg
+'
+
+test_expect_success 'fails committing if clone email is not set, but EMAIL set' '
+	test_must_fail env EMAIL=test@fail.com git commit --allow-empty -m msg
+'
+
+test_expect_success 'succeeds committing if clone email is set' '
+	test_config user.email "test@ok.com" &&
+	git commit --allow-empty -m msg
+'
+
+test_expect_success 'succeeds cloning if global email is not set' '
+	git clone . clone
+'
+
+test_done
-- 
2.5.0
