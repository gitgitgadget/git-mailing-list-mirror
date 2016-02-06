From: Dan Aloni <alonid@gmail.com>
Subject: [PATCH v9 2/2] ident: add user.useConfigOnly boolean for when ident shouldn't be guessed
Date: Sat,  6 Feb 2016 08:23:36 +0200
Message-ID: <1454739816-24007-3-git-send-email-alonid@gmail.com>
References: <1454739816-24007-1-git-send-email-alonid@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 06 07:24:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRwIa-0004eX-OO
	for gcvg-git-2@plane.gmane.org; Sat, 06 Feb 2016 07:24:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbcBFGYP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Feb 2016 01:24:15 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:38387 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751111AbcBFGYF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Feb 2016 01:24:05 -0500
Received: by mail-wm0-f45.google.com with SMTP id p63so53469978wmp.1
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 22:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TGSftuQmCMHN3nLY4hxPfF6Csijkh+my/92VSx49r7U=;
        b=PX6YFcv3W4Saz5stzDHShCDaFGRQg+WnGM17v/gSv29/X1DaH8LHdjx4cdXG2lxBVT
         ludGYzaKisj4NyIcpNBR2hSxjICTk4x1S7x7PNVrkYLDZGK6H5UzZ2vJbAzsvReGh5mB
         hhag8A5spVAlG7iaHh7eC2Atagfe6ClE87sNXwwjm1ls1uhSogyv5P1KHYe8Mjav0IzP
         IZu3WTAx0FNELKB894FZnzWNuakYzh6bhYy9vs1f8a6J9gWn2a2D4azXHZdr7oz5tRTf
         xNMHgoqPmPQCFvA1OQ+PeGRhs5+vXZ3hw7WHbU7MPhKuHFITaGsz+ZUn/t+JaFXMNWD9
         YVPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TGSftuQmCMHN3nLY4hxPfF6Csijkh+my/92VSx49r7U=;
        b=W/L3p/JAo95VuJZWZ5fGYE+3WeK8GTfGxLilpvGnfyDcyB0yqAkrEqDTa4Lunmr9Xb
         74q136zdAA+IpKRVKlpv9zZWCZoaJ8vXt2IAhWKVKF1fljfPXDsx2+KaATtNwhH3Yf+a
         +Zqn6sGqlcF+0I3iyH0bXaGTTA2Ib0DwbE1D+AcWmQyyvrxzCKRXxx0QcHAcTErh9Ri+
         201VUdbsHTuQCWHB8m8d4RrVJrhToqHeqYYhmppj5I1K+lAgZhhG3vUs4U2+Qs+4fkP6
         jEcqIagVvh70gmZqnxD4n7ttoBDU1F1jVjeTn7xe2HfZQUlM84zmmvI7Q/96JI7Yvl0M
         qdKw==
X-Gm-Message-State: AG10YOTQqiR+yuPwDBICuKfEEQOlRBZnl0MsPtjK1SarvmKiFd/5SBLnkQ/+JaWDFrEmgw==
X-Received: by 10.28.129.10 with SMTP id c10mr31823942wmd.35.1454739844523;
        Fri, 05 Feb 2016 22:24:04 -0800 (PST)
Received: from nitrogen.home.aloni.org ([31.210.180.167])
        by smtp.gmail.com with ESMTPSA id k130sm1807554wmg.6.2016.02.05.22.24.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Feb 2016 22:24:03 -0800 (PST)
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1454739816-24007-1-git-send-email-alonid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285682>

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
index 02bcde6bb596..cfb7d0e7652d 100644
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
+	along with a name, Git will prompt you to set up an email before
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
