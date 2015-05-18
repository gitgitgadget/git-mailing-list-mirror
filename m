From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH 02/14] pull: pass verbosity, --progress flags to fetch and merge
Date: Mon, 18 May 2015 23:05:59 +0800
Message-ID: <1431961571-20370-3-git-send-email-pyokagan@gmail.com>
References: <1431961571-20370-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 18 17:07:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuMdn-0004GS-K7
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 17:07:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753653AbbERPHf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 11:07:35 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:35010 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753623AbbERPHd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 11:07:33 -0400
Received: by pdea3 with SMTP id a3so152068269pde.2
        for <git@vger.kernel.org>; Mon, 18 May 2015 08:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iaaL1wuW2NUa65ykEoftTiZqBMEEy4A8WfU+BmFJDLM=;
        b=YGXZLvfK/wxe7mgY0+Fjj5pWsYtWup7N7ggyq6fzT4CC23Kvkd4AcHlszr2gia/4dc
         qsZ2cKIZMjBenMxiih2HIEvTzwt/QoVWTfIJWHCN1eDH46/4RsoWIvfx2TmuA+JPSCaW
         cacHuzsn4KQIfStcPNZiI73wIq2QzWQd019rN13fNzMBDDA64XInvXH/7LZc2bKWFpwG
         zgiCziDVaE44wQrlTTawZNMF8sXQoatS+dDowdVKJetF1F1mDd5lkwmnBWBaM9Pq0v9w
         1b7Nosy7BCyTzHvV5kzq9r/rwGq6gnSQ6fdAC1tXxAmDpQ52kYXRHHHeNc56Fal6OjYL
         rE5w==
X-Received: by 10.70.128.36 with SMTP id nl4mr45297131pdb.43.1431961652455;
        Mon, 18 May 2015 08:07:32 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id i9sm10370062pdj.27.2015.05.18.08.07.29
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 May 2015 08:07:31 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1431961571-20370-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269259>

7f87aff (Teach/Fix pull/fetch -q/-v options, 2008-11-15) taught git-pull
to accept the verbosity -v and -q options and pass them to git-fetch and
git-merge.

Re-implement support for the verbosity flags by adding it to the options
list and introducing argv_push_verbosity() to push the flags into the
argv array used to execute git-fetch and git-merge.

9839018 (fetch and pull: learn --progress, 2010-02-24) and bebd2fd
(pull: propagate --progress to merge, 2011-02-20) taught git-pull to
accept the --progress option and pass it to git-fetch and git-merge.

Re-implement support for this flag by introducing the option callback
handler parse_opt_passthru(). This callback is used to pass the
"--progress" or "--no-progress" command-line switch to git-fetch and
git-merge.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/pull.c          | 60 +++++++++++++++++++++++++++++++++++++++++++++++++
 t/t5521-pull-options.sh |  8 +++----
 2 files changed, 64 insertions(+), 4 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 0b771b9..a4d9c92 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -11,16 +11,64 @@
 #include "argv-array.h"
 #include "run-command.h"
 
+/**
+ * Given an option opt, where opt->value points to a char* and opt->defval is a
+ * string, sets opt->value to the evaluation of "--$defval=$arg". If `arg` is
+ * NULL, then opt->value is set to "--$defval". If unset is true, then
+ * opt->value is set to "--no-$defval".
+ */
+static int parse_opt_passthru(const struct option *opt, const char *arg, int unset)
+{
+	struct strbuf sb = STRBUF_INIT;
+	char **opt_value = opt->value;
+
+	assert(opt->defval);
+	strbuf_addstr(&sb, unset ? "--no-" : "--");
+	strbuf_addstr(&sb, (const char*) opt->defval);
+	if (arg) {
+		strbuf_addch(&sb, '=');
+		strbuf_addstr(&sb, arg);
+	}
+	if (*opt_value)
+		free(*opt_value);
+	*opt_value = strbuf_detach(&sb, NULL);
+	return 0;
+}
+
 static const char * const pull_usage[] = {
 	N_("git pull [options] [<repo> [<refspec>...]]"),
 	NULL
 };
 
+/* Shared options */
+static int opt_verbosity;
+static char *opt_progress;
+
 static struct option pull_options[] = {
+	/* Shared options */
+	OPT__VERBOSITY(&opt_verbosity),
+	{ OPTION_CALLBACK, 0, "progress", &opt_progress, NULL,
+	  N_("force progress reporting"),
+	  PARSE_OPT_NOARG, parse_opt_passthru},
+
 	OPT_END()
 };
 
 /**
+ * Pushes "-q" or "-v" switches into arr to match the opt_verbosity level.
+ */
+static void argv_push_verbosity(struct argv_array *arr)
+{
+	int verbosity;
+
+	for (verbosity = opt_verbosity; verbosity > 0; verbosity--)
+		argv_array_push(arr, "-v");
+
+	for (verbosity = opt_verbosity; verbosity < 0; verbosity++)
+		argv_array_push(arr, "-q");
+}
+
+/**
  * Parses argv into [<repo> [<refspecs>...]], returning their values in `repo`
  * as a string and `refspecs` as a null-terminated array of strings. If `repo`
  * is not provided in argv, it is set to NULL.
@@ -45,6 +93,12 @@ static int run_fetch(const char *repo, const char **refspecs)
 	int ret;
 
 	argv_array_pushl(&args, "fetch", "--update-head-ok", NULL);
+
+	/* Shared options */
+	argv_push_verbosity(&args);
+	if (opt_progress)
+		argv_array_push(&args, opt_progress);
+
 	if (repo)
 		argv_array_push(&args, repo);
 	while (*refspecs)
@@ -63,6 +117,12 @@ static int run_merge(void)
 	struct argv_array args = ARGV_ARRAY_INIT;
 
 	argv_array_pushl(&args, "merge", NULL);
+
+	/* Shared options */
+	argv_push_verbosity(&args);
+	if (opt_progress)
+		argv_array_push(&args, opt_progress);
+
 	argv_array_push(&args, "FETCH_HEAD");
 	ret = run_command_v_opt(args.argv, RUN_GIT_CMD);
 	argv_array_clear(&args);
diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
index 0f6094b..89e2104 100755
--- a/t/t5521-pull-options.sh
+++ b/t/t5521-pull-options.sh
@@ -11,7 +11,7 @@ test_expect_success 'setup' '
 	 git commit -m one)
 '
 
-test_expect_failure 'git pull -q' '
+test_expect_success 'git pull -q' '
 	mkdir clonedq &&
 	(cd clonedq && git init &&
 	git pull -q "../parent" >out 2>err &&
@@ -46,7 +46,7 @@ test_expect_failure 'git pull --rebase' '
 	test_must_be_empty out)
 '
 
-test_expect_failure 'git pull -v' '
+test_expect_success 'git pull -v' '
 	mkdir clonedv &&
 	(cd clonedv && git init &&
 	git pull -v "../parent" >out 2>err &&
@@ -62,7 +62,7 @@ test_expect_failure 'git pull -v --rebase' '
 	test_must_be_empty out)
 '
 
-test_expect_failure 'git pull -v -q' '
+test_expect_success 'git pull -v -q' '
 	mkdir clonedvq &&
 	(cd clonedvq && git init &&
 	git pull -v -q "../parent" >out 2>err &&
@@ -70,7 +70,7 @@ test_expect_failure 'git pull -v -q' '
 	test_must_be_empty err)
 '
 
-test_expect_failure 'git pull -q -v' '
+test_expect_success 'git pull -q -v' '
 	mkdir clonedqv &&
 	(cd clonedqv && git init &&
 	git pull -q -v "../parent" >out 2>err &&
-- 
2.1.4
