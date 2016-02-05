From: Dan Aloni <alonid@gmail.com>
Subject: [PATCH v6 2/3] ident: add user.useConfigOnly boolean for when ident shouldn't be guessed
Date: Fri,  5 Feb 2016 09:42:27 +0200
Message-ID: <1454658148-3031-3-git-send-email-alonid@gmail.com>
References: <1454658148-3031-1-git-send-email-alonid@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 05 08:43:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRb2q-0006eC-Ni
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 08:43:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbcBEHnE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 02:43:04 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:37382 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082AbcBEHm4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 02:42:56 -0500
Received: by mail-wm0-f44.google.com with SMTP id g62so14913409wme.0
        for <git@vger.kernel.org>; Thu, 04 Feb 2016 23:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EO8CYofmZlkwdVnMbnSjZQRs5ssiQphVrQx9qBXrzxI=;
        b=zqjL/uBwEKf14sATxcIPMVVrDfHJSOkzXEvXNrsRVoH4WqDxTHXVTML1jiScl8LpZB
         S/YA3VjfsgWot0uuA1MHMUT3Itb3zFmuChgUiKi4eu037hdsn8NmJmEvaHHrKKoZQzw7
         HNHJYlqn2L5pGvERryPju9USmyxPDCBzVw2qeJLOnRh7L7ghDh+yStt9ixwWnT1GbTrG
         Appm8qDu06foG1himiHH9w9DIchIcRsxj0GfAUuXSB3dFze0kAOE0Sb7b17qRBQAkmaW
         ZAFXLpHXzRSl/pLJm38iw6sLmgtpdigV4QD/PPUk6LFeCMMRiS8T/yfHn9x70BqI0Qw9
         dUCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EO8CYofmZlkwdVnMbnSjZQRs5ssiQphVrQx9qBXrzxI=;
        b=Q2a3ZdpZBL0GqSAb8bv1Ak/fR8ZQGPEsQK7+Xb637GTUi7tZnUA+vqUHUIA3aSLdBZ
         SvyzejXDKxDiSyLeZ0Lu4UDVF6nzyMXTDCgqEECD+p6UIl7rmBe+a303mH2PGDUZe2i+
         q1t+simbpmD5GOyv4wOpjc0eTMuBEUFSHQvbnQC2Jutt+fTxnQqQhRm2CGtM5tR0URqW
         DQRzgtwlg+6CzbWnndmt5VjFQWCXsDGT9PbSyde4q94oBhA7hnOHgwCYIM6Z7lVg6QVJ
         VDcWSRIKrRBGxxsMzAP9LsjaEzo8Kb+hnfUrRikf6mLRHMKZ4sQPqfg739xrZXkP94Qw
         gkXg==
X-Gm-Message-State: AG10YOR7aVrVFFmfxOOzHj+kAUfWOcJMfaPUG5wKTcf6DSr2ZS8pnqtL9Z1bHCH3FHjyEQ==
X-Received: by 10.28.210.143 with SMTP id j137mr34480734wmg.13.1454658175365;
        Thu, 04 Feb 2016 23:42:55 -0800 (PST)
Received: from nitrogen.home.aloni.org ([31.210.180.167])
        by smtp.gmail.com with ESMTPSA id w66sm16062302wmd.2.2016.02.04.23.42.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Feb 2016 23:42:54 -0800 (PST)
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1454658148-3031-1-git-send-email-alonid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285552>

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
