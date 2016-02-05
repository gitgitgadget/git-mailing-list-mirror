From: Dan Aloni <alonid@gmail.com>
Subject: [PATCH v7 2/2] ident: add user.useConfigOnly boolean for when ident shouldn't be guessed
Date: Fri,  5 Feb 2016 23:29:06 +0200
Message-ID: <1454707746-18672-3-git-send-email-alonid@gmail.com>
References: <1454707746-18672-1-git-send-email-alonid@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 05 22:29:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRnwz-0006UT-5P
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 22:29:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753559AbcBEV3x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 16:29:53 -0500
Received: from mail-wm0-f43.google.com ([74.125.82.43]:37641 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751115AbcBEV3t (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 16:29:49 -0500
Received: by mail-wm0-f43.google.com with SMTP id g62so44737176wme.0
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 13:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4EyD3UP3lmaxytgRg++IXhoLl/dnyg6/mMRb5KERHsg=;
        b=E/9TUGEzo5IVou/Y/0XdAcFj8W88XcOfSM096am6rjLcjIewz32hYIIQnlMao/gF0m
         gzmtbSo98OMpRLiLnf0Ez4i6Rt7gSjNtHZNMZTCXzzhHKDaJoJd2QXq4gnzD4hVOuzWS
         YO5tKT3b/d7OInMQzfz8IwMwx7M58OfBQlPPAEz8ut8X5Sn8HuTVscN78hboqHU9TB6y
         9jHJFpXIIg8z6lmREsa+6URx2W5BEHSKxRhydKzVymkcLhdfToV99I7bzrwmbBlZit/y
         IAH2/+CDNPIlGztbhg85EGZS97G7eXDTUrIntqID7CSS7fQKcVEOdtX2ZfL0abdnM+S/
         NgFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4EyD3UP3lmaxytgRg++IXhoLl/dnyg6/mMRb5KERHsg=;
        b=N8UUP1y60EdQP2jGlVcNMMG+lGEx9Fq7gGotioaS6Z080QPDKJSU5E9fDGnFckqnqc
         9Yms5ZVJM/5JegL6qLDQ606V95EZpWv7nUsHbYgUaHGQ72nlfPVVOgx1iw/VmobQK5uj
         DflVajD3+rO1EdhyuKfN08l2l3YgcE3z9OWZ23YrRee5LD2/ZO0/TDahlNjJrDKNKcrH
         eoPyNEydooXF841XKey3hfsgTfAAnSzmUH13aX/ADOdlbxlN/AclbtAy7ujJ+OBN9E2o
         MXvCUPxSavue7Uek47Ojg53BN6riPVqfpU8ro4Onidn8AC9W1ShxGbvl4HGdrp0b5Yq3
         ZpWg==
X-Gm-Message-State: AG10YOTEcVJhPRIFpiqEhbHCfTeAFrfNbEkm7T4CjMKY1oKF+4GRfr7FuiOxClaF83cx6g==
X-Received: by 10.28.90.67 with SMTP id o64mr36721989wmb.38.1454707787973;
        Fri, 05 Feb 2016 13:29:47 -0800 (PST)
Received: from nitrogen.home.aloni.org ([31.210.180.167])
        by smtp.gmail.com with ESMTPSA id q75sm446574wmd.6.2016.02.05.13.29.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Feb 2016 13:29:47 -0800 (PST)
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1454707746-18672-1-git-send-email-alonid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285638>

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
 Documentation/config.txt  | 10 +++++++++
 ident.c                   | 16 ++++++++++++++
 t/t9904-per-repo-email.sh | 55 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 81 insertions(+)
 create mode 100755 t/t9904-per-repo-email.sh

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 02bcde6bb596..0d168d92fd79 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2821,6 +2821,16 @@ user.name::
 	Can be overridden by the 'GIT_AUTHOR_NAME' and 'GIT_COMMITTER_NAME'
 	environment variables.  See linkgit:git-commit-tree[1].
 
+user.useConfigOnly::
+	This instructs Git to avoid trying to guess defaults for 'user.email'
+	and 'user.name' other than strictly from config. For example, if
+	you have multiple email addresses and would like to use a different
+	one for each repository, then with this configuration option set
+	to `true` in the global config along with a name, Git would prompt
+	for you for setting up an email upon making new commits in a newly
+	cloned repository.
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
 
diff --git a/t/t9904-per-repo-email.sh b/t/t9904-per-repo-email.sh
new file mode 100755
index 000000000000..f2b33881e46b
--- /dev/null
+++ b/t/t9904-per-repo-email.sh
@@ -0,0 +1,55 @@
+#!/bin/sh
+#
+# Copyright (c) 2016 Dan Aloni
+#
+
+test_description='per-repo forced setting of email address'
+
+. ./test-lib.sh
+
+reprepare () {
+	git reset --hard initial
+}
+
+test_expect_success setup '
+	# Initial repo state
+	echo "Initial" >foo &&
+	git add foo &&
+	git commit -m foo &&
+	git tag initial &&
+
+	# Setup a likely user.useConfigOnly use case
+	sane_unset GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL &&
+	sane_unset GIT_COMMITTER_NAME GIT_COMMITTER_EMAIL &&
+	git config user.name "test" &&
+	git config --global user.useConfigOnly true &&
+
+	reprepare
+'
+
+test_expect_success 'fails committing if clone email is not set' '
+	test_when_finished reprepare &&
+
+	test_must_fail git commit --allow-empty -m msg
+'
+
+test_expect_success 'fails committing if clone email is not set, but EMAIL set' '
+	test_when_finished reprepare &&
+
+	test_must_fail env EMAIL=test@fail.com git commit --allow-empty -m msg
+'
+
+test_expect_success 'succeeds committing if clone email is set' '
+	test_when_finished reprepare &&
+
+	test_config user.email "test@ok.com" &&
+	git commit --allow-empty -m msg
+'
+
+test_expect_success 'succeeds cloning if global email is not set' '
+	test_when_finished reprepare &&
+
+	git clone . clone
+'
+
+test_done
-- 
2.5.0
