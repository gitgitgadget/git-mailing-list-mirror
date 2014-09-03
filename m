From: Johan Herland <johan@herland.net>
Subject: [RFC/PATCH 2/3] revert/cherry-pick: Add --no-verify option, and pass it on to commit
Date: Wed,  3 Sep 2014 16:03:53 +0200
Message-ID: <1409753034-9459-3-git-send-email-johan@herland.net>
References: <1409753034-9459-1-git-send-email-johan@herland.net>
Cc: =?UTF-8?q?Lars=20Gullik=20Bj=C3=B8nnes?= <larsbj@gullik.org>,
	Junio C Hamano <gitster@pobox.com>,
	Neil Horman <nhorman@tuxdriver.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Johan Herland <johan@herland.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 03 16:13:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPBJc-0005XN-6G
	for gcvg-git-2@plane.gmane.org; Wed, 03 Sep 2014 16:13:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932581AbaICONf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2014 10:13:35 -0400
Received: from alln-iport-6.cisco.com ([173.37.142.93]:45561 "EHLO
	alln-iport-6.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932495AbaICONe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2014 10:13:34 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AisFAK8eB1StJV2T/2dsb2JhbABZgw1TV8hKh1ABgQsWd4QEAQUnUhBRVxmIQr1oARePTQeETAWVYJwbghuBSDsvgQYkgSUBAQE
X-IronPort-AV: E=Sophos;i="5.04,457,1406592000"; 
   d="scan'208";a="74559140"
Received: from rcdn-core-11.cisco.com ([173.37.93.147])
  by alln-iport-6.cisco.com with ESMTP; 03 Sep 2014 14:04:06 +0000
Received: from jherland.rd.tandberg.com ([10.47.39.59])
	by rcdn-core-11.cisco.com (8.14.5/8.14.5) with ESMTP id s83E41HC005685;
	Wed, 3 Sep 2014 14:04:04 GMT
X-Mailer: git-send-email 2.0.0.rc4.501.gdaf83ca
In-Reply-To: <1409753034-9459-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256392>

Allow users to temporarily disable the pre-commit and commit-msg hooks
when running "git revert" or "git cherry-pick", just like they currently
can for "git commit".

The --no-verify option is added to the sequencer machinery and handled
like the other commit-related options.

This fixes the failing t7503/t7504 test cases added previously.

Signed-off-by: Johan Herland <johan@herland.net>
---
 builtin/revert.c           | 1 +
 sequencer.c                | 7 +++++++
 sequencer.h                | 1 +
 t/t7503-pre-commit-hook.sh | 4 ++--
 t/t7504-commit-msg-hook.sh | 4 ++--
 5 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index f9ed5bd..831c2cd 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -91,6 +91,7 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 			N_("option for merge strategy"), option_parse_x),
 		{ OPTION_STRING, 'S', "gpg-sign", &opts->gpg_sign, N_("key-id"),
 		  N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
+		OPT_BOOL('n', "no-verify", &opts->no_verify, N_("bypass pre-commit hook")),
 		OPT_END(),
 		OPT_END(),
 		OPT_END(),
diff --git a/sequencer.c b/sequencer.c
index 3c060e0..3d68113 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -378,6 +378,9 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 	if (opts->allow_empty_message)
 		argv_array_push(&array, "--allow-empty-message");
 
+	if (opts->no_verify)
+		argv_array_push(&array, "--no-verify");
+
 	rc = run_command_v_opt(array.argv, RUN_GIT_CMD);
 	argv_array_clear(&array);
 	return rc;
@@ -773,6 +776,8 @@ static int populate_opts_cb(const char *key, const char *value, void *data)
 		opts->record_origin = git_config_bool_or_int(key, value, &error_flag);
 	else if (!strcmp(key, "options.allow-ff"))
 		opts->allow_ff = git_config_bool_or_int(key, value, &error_flag);
+	else if (!strcmp(key, "options.no-verify"))
+		opts->no_verify = git_config_bool_or_int(key, value, &error_flag);
 	else if (!strcmp(key, "options.mainline"))
 		opts->mainline = git_config_int(key, value);
 	else if (!strcmp(key, "options.strategy"))
@@ -944,6 +949,8 @@ static void save_opts(struct replay_opts *opts)
 		git_config_set_in_file(opts_file, "options.record-origin", "true");
 	if (opts->allow_ff)
 		git_config_set_in_file(opts_file, "options.allow-ff", "true");
+	if (opts->no_verify)
+		git_config_set_in_file(opts_file, "options.no-verify", "true");
 	if (opts->mainline) {
 		struct strbuf buf = STRBUF_INIT;
 		strbuf_addf(&buf, "%d", opts->mainline);
diff --git a/sequencer.h b/sequencer.h
index db43e9c..abfadc0 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -34,6 +34,7 @@ struct replay_opts {
 	int allow_empty;
 	int allow_empty_message;
 	int keep_redundant_commits;
+	int no_verify;
 
 	int mainline;
 
diff --git a/t/t7503-pre-commit-hook.sh b/t/t7503-pre-commit-hook.sh
index adc892b..b0307f4 100755
--- a/t/t7503-pre-commit-hook.sh
+++ b/t/t7503-pre-commit-hook.sh
@@ -80,13 +80,13 @@ test_expect_success '--no-verify with failing hook' '
 
 '
 
-test_expect_failure 'revert --no-verify with failing hook' '
+test_expect_success 'revert --no-verify with failing hook' '
 
 	git revert --no-verify HEAD
 
 '
 
-test_expect_failure 'cherry-pick --no-verify with failing hook' '
+test_expect_success 'cherry-pick --no-verify with failing hook' '
 
 	git cherry-pick --no-verify HEAD^
 
diff --git a/t/t7504-commit-msg-hook.sh b/t/t7504-commit-msg-hook.sh
index 4f8b9fe..e819c25 100755
--- a/t/t7504-commit-msg-hook.sh
+++ b/t/t7504-commit-msg-hook.sh
@@ -138,13 +138,13 @@ test_expect_success '--no-verify with failing hook' '
 
 '
 
-test_expect_failure 'revert --no-verify with failing hook' '
+test_expect_success 'revert --no-verify with failing hook' '
 
 	git revert --no-verify HEAD
 
 '
 
-test_expect_failure 'cherry-pick --no-verify with failing hook' '
+test_expect_success 'cherry-pick --no-verify with failing hook' '
 
 	git cherry-pick --no-verify HEAD^
 
-- 
2.0.0.rc4.501.gdaf83ca
