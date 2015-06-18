From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v4 06/19] pull: pass verbosity, --progress flags to fetch and merge
Date: Thu, 18 Jun 2015 18:53:59 +0800
Message-ID: <1434624852-6869-7-git-send-email-pyokagan@gmail.com>
References: <1434624852-6869-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 18 12:55:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5XTw-000210-45
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 12:55:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754374AbbFRKzL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 06:55:11 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:34469 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754193AbbFRKy7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 06:54:59 -0400
Received: by pdbki1 with SMTP id ki1so64215623pdb.1
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 03:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qbNSRd6wOSdJK/M+h7nmqDBJD9Fa36PSMuHbYvhpPp0=;
        b=WoINfdBIdw2L6Hvr+lHmaVPonuHbmsZP4aCUUgIeobQYl3TRW0I94htxVWDCTMdMS/
         az+hb22Zhse5vX9i3mbcAtx9nqNIh/K2Xyzll+KyHp6MbC1B+SD0Aw+1aZ3AQgos3HZV
         ZXCRDFKUYJuLvcUKyfEhVOzQEqt3abN7tmELjqLaoWBi2MVqm/2NeVucPZUcg13zSjRy
         ywAkXRdZL/jnQDqWyJlMsZ62E8D8uYf3DYemg11qv6YcSCeSPRUStve37ZSUyTHvIU6R
         T/L0qMnN/dlwZxg3w+UJYAi5XEXflcRArXG0f2ga1aqTRruTywtnWS0m+KCskFrMunDD
         VlVA==
X-Received: by 10.70.47.138 with SMTP id d10mr19757784pdn.137.1434624898830;
        Thu, 18 Jun 2015 03:54:58 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id eu5sm7735063pac.37.2015.06.18.03.54.55
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Jun 2015 03:54:57 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1434624852-6869-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271949>

7f87aff (Teach/Fix pull/fetch -q/-v options, 2008-11-15) taught git-pull
to accept the verbosity -v and -q options and pass them to git-fetch and
git-merge.

Re-implement support for the verbosity flags by adding it to the options
list and introducing argv_push_verbosity() to push the flags into the
argv array used to execute git-fetch and git-merge.

9839018 (fetch and pull: learn --progress, 2010-02-24) and bebd2fd
(pull: propagate --progress to merge, 2011-02-20) taught git-pull to
accept the --progress option and pass it to git-fetch and git-merge.

Use OPT_PASSTHRU() implemented earlier to pass the "--[no-]progress"
command line options to git-fetch and git-merge.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/pull.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/builtin/pull.c b/builtin/pull.c
index 9157536..5d9f2b5 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -16,11 +16,35 @@ static const char * const pull_usage[] = {
 	NULL
 };
 
+/* Shared options */
+static int opt_verbosity;
+static char *opt_progress;
+
 static struct option pull_options[] = {
+	/* Shared options */
+	OPT__VERBOSITY(&opt_verbosity),
+	OPT_PASSTHRU(0, "progress", &opt_progress, NULL,
+		N_("force progress reporting"),
+		PARSE_OPT_NOARG),
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
+	if (opt_progress)
+		argv_array_push(&args, opt_progress);
+
 	if (repo) {
 		argv_array_push(&args, repo);
 		argv_array_pushv(&args, refspecs);
@@ -65,6 +95,12 @@ static int run_merge(void)
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
-- 
2.1.4
