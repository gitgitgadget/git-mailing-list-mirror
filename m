From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v2 06/19] pull: pass verbosity, --progress flags to fetch and merge
Date: Wed,  3 Jun 2015 14:48:50 +0800
Message-ID: <1433314143-4478-7-git-send-email-pyokagan@gmail.com>
References: <1433314143-4478-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 03 08:50:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z02V8-0004Wg-OW
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 08:50:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753304AbbFCGuG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 02:50:06 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:35038 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753284AbbFCGuD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 02:50:03 -0400
Received: by pdbnf5 with SMTP id nf5so739451pdb.2
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 23:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B/0QQPz+1VU9hzE1jjU4RvkY4p+nuT26g/zTsmVe2vo=;
        b=dQ8OLMU9y1qoIt5thg9Z/29vFOECzkZcmaH79mSuVOws/Apg917+BViezUSy0m5a8w
         AOhKpFCqiyrq/nbhc8KALpkZiQKBGa0/Ij1sW1NtfUgKn2SibBgAvaIbgiDV/WEvtTAR
         eC+mEuPMYOhNh0SkI1P4EhhxtL7Xn8ppWoO/V82iOtH1cjDvEV5NrvtiEY/lwwNXQ3kS
         GDseTRhEHXouRT7oPZwxUp9BoZDZKbUSLoNkHPv28Tbdkdpsf9bgwIuM68HHA4lVVbph
         ZO1pzG6uU1e8GS7oy5eTDlXMrA5SgkzCtmvTzqMyfw1o05LMOgk535wh2ZLjWxaeU7ui
         TZLw==
X-Received: by 10.70.55.199 with SMTP id u7mr56847525pdp.42.1433314202754;
        Tue, 02 Jun 2015 23:50:02 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id qt4sm19474130pbc.86.2015.06.02.23.49.59
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Jun 2015 23:50:01 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1433314143-4478-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270645>

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

Notes:
    v2
    
    * Use parse_opt_pass_strbuf().

 builtin/pull.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/builtin/pull.c b/builtin/pull.c
index 0ca23a3..c9c2cc0 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -16,11 +16,35 @@ static const char * const pull_usage[] = {
 	NULL
 };
 
+/* Shared options */
+static int opt_verbosity;
+static struct strbuf opt_progress = STRBUF_INIT;
+
 static struct option pull_options[] = {
+	/* Shared options */
+	OPT__VERBOSITY(&opt_verbosity),
+	{ OPTION_CALLBACK, 0, "progress", &opt_progress, NULL,
+	  N_("force progress reporting"),
+	  PARSE_OPT_NOARG, parse_opt_pass_strbuf},
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
@@ -46,6 +70,12 @@ static int run_fetch(const char *repo, const char **refspecs)
 	int ret;
 
 	argv_array_pushl(&args, "fetch", "--update-head-ok", NULL);
+
+	/* Shared options */
+	argv_push_verbosity(&args);
+	if (opt_progress.len)
+		argv_array_push(&args, opt_progress.buf);
+
 	if (repo)
 		argv_array_push(&args, repo);
 	while (*refspecs)
@@ -64,6 +94,12 @@ static int run_merge(void)
 	struct argv_array args = ARGV_ARRAY_INIT;
 
 	argv_array_pushl(&args, "merge", NULL);
+
+	/* Shared options */
+	argv_push_verbosity(&args);
+	if (opt_progress.len)
+		argv_array_push(&args, opt_progress.buf);
+
 	argv_array_push(&args, "FETCH_HEAD");
 	ret = run_command_v_opt(args.argv, RUN_GIT_CMD);
 	argv_array_clear(&args);
-- 
2.1.4
