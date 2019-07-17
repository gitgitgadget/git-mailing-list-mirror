Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE1381F4B6
	for <e@80x24.org>; Wed, 17 Jul 2019 02:00:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbfGQCAE (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Jul 2019 22:00:04 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37259 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfGQCAE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jul 2019 22:00:04 -0400
Received: by mail-pl1-f195.google.com with SMTP id b3so11082524plr.4
        for <git@vger.kernel.org>; Tue, 16 Jul 2019 19:00:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=kjwEi5/ytOQoUq1XL+FGUsqCwyDsz4QTWn9rHtfVKwA=;
        b=l+QHmf65VEHQTaSRt9A4VXDmxRY9gx3jXG+pvY/GbZK0+CEL/6bez6y458qLGYHEkD
         DQvbEomodNVrd8XrKh97HCOfCEj2k2HcZyhjqJLwlL9QxojvNoSbm9onmVzQYd4X3Qbf
         sH0TDQDPM8ag/ZjNzqqcAbZZcu9bA+H20C4TjgqtKaT2BIx5NMwsLLZ9/uEOupygx04w
         pgAZCd+QOKlWoqmuFXYUh+bfycYM5Nv2GZPIJjD7i78FbquV7gKLEH3+fMbxroBrjm7W
         Xnd1spKDTJCGwDUMr8rACGvA+BHUWlfy4BqH8B+H3AkrT1D3CMXBb0gzod03OtAzDCjk
         f02A==
X-Gm-Message-State: APjAAAW2SkSRzK/kh6Ea1c3vAfXKVvJ+Dj/7SlqYB9dUpICqCgQFJFxE
        aZ7NdZ9nmvYPa0hx99yG5kg=
X-Google-Smtp-Source: APXvYqwu9xJR/oQsOMcpVHROkZFi/Ww70nd8j30DJXMv0ROEcdGCkFlZrmcIG0gWRu9nUb3yImwuJA==
X-Received: by 2002:a17:902:aa09:: with SMTP id be9mr38470913plb.52.1563328803294;
        Tue, 16 Jul 2019 19:00:03 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id x26sm29776958pfq.69.2019.07.16.19.00.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 19:00:02 -0700 (PDT)
Subject: [PATCH] fetch: add "--parallel", which fetches all remotes in parallel
Date:   Tue, 16 Jul 2019 18:59:03 -0700
Message-Id: <20190717015903.4384-1-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     peff@peff.net, e@80x24.org, chriscool@tuxfamily.org,
        gitster@pobox.com, jonathantanmy@google.com, tboegi@web.de,
        bwilliams.eng@gmail.com, jeffhost@microsoft.com,
        Palmer Dabbelt <palmer@sifive.com>
From:   Palmer Dabbelt <palmer@sifive.com>
To:     git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have a handful of repositories with a bunch of remotes and this week
I'm on an internet connection with a high bandwidth high latency
connection to those remotes.  This results in "fetch --all" being
painfully slow: 3-4 seconds per remote, all at almost zero link
utilization (presumably doing an SSH handshake), for a total of a
minute or so.

This patch fixes the issue in the simplest way I could come up with: it
adds a "--parallel" argument to fetch that selects when to block on the
fetch children.  This results in every fetch child running in parallel,
which provides per-remote parallelism.  My "fetch --all" times go down
from ~60 seconds to ~5 seconds, which is great!

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>

---

This is more of an RFC that an actual patch, for three reasons:

* I'm not sure if it's safe to access the .git database from multiple
  processes at the same time.  This is my first time messing around with
  git to this degree, so I figured it's better to just ask than to try
  to figure it out.
* As I was writing the documentation I found "fetch --jobs".  It seems
  like I should use that instead of adding a new argrument, but I wasn't
  sure.  If I do this, I'd add some other config argument because
  submodule.jobs seems like a bad name for this.
* This implementation is recursive and I'm a bit worried about stack
  usage.  The stack-based implementation doesn't make nearly as much
  sense with --jobs, so I'd probably just do it right.

It's at the point where I've spent about as long writing the code as
I'll save waiting on "fetch --all" over the rest of my life, and given
the unknows I thought it would be best to just send out the patch and
see if it has any legs.

If this seems reasonable then I'll try to find some time to finish it.
Specificially, I'd like to:

* Use "--jobs" instead of "--parallel", to avoid the extra argument.
* Write some sort of test case.
---
 Documentation/fetch-options.txt |  3 +++
 builtin/fetch.c                 | 45 +++++++++++++++++++++++----------
 2 files changed, 34 insertions(+), 14 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 3c9b4f9e0951..99666f40e405 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -92,6 +92,9 @@ ifndef::git-pull[]
 	Run `git gc --auto` at the end to perform garbage collection
 	if needed. This is enabled by default.
 
+--parallel::
+	Fetch all remotes in parallel.
+
 -p::
 --prune::
 	Before fetching, remove any remote-tracking references that no
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 53ce99d2bbc4..2dfdeea3b3ec 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -71,6 +71,7 @@ static struct refspec refmap = REFSPEC_INIT_FETCH;
 static struct list_objects_filter_options filter_options;
 static struct string_list server_options = STRING_LIST_INIT_DUP;
 static struct string_list negotiation_tip = STRING_LIST_INIT_NODUP;
+static int parallel = 0;
 
 static int git_fetch_config(const char *k, const char *v, void *cb)
 {
@@ -178,6 +179,8 @@ static struct option builtin_fetch_options[] = {
 			TRANSPORT_FAMILY_IPV6),
 	OPT_STRING_LIST(0, "negotiation-tip", &negotiation_tip, N_("revision"),
 			N_("report that we have only objects reachable from this object")),
+	OPT_BOOL(0, "parallel", &parallel,
+		 N_("fetch in parallel from each remote")),
 	OPT_PARSE_LIST_OBJECTS_FILTER(&filter_options),
 	OPT_BOOL(0, "auto-gc", &enable_auto_gc,
 		 N_("run 'gc --auto' after fetching")),
@@ -1456,12 +1459,15 @@ static void add_options_to_argv(struct argv_array *argv)
 
 }
 
-static int fetch_multiple(struct string_list *list)
+static int fetch_multiple(struct string_list *list, int i)
 {
-	int i, result = 0;
+	int result = 0;
 	struct argv_array argv = ARGV_ARRAY_INIT;
+	const char *name = list->items[i].string;
+	struct child_process cmd = CHILD_PROCESS_INIT;
+	int code;
 
-	if (!append && !dry_run) {
+	if (i == 0 && !append && !dry_run) {
 		int errcode = truncate_fetch_head();
 		if (errcode)
 			return errcode;
@@ -1469,20 +1475,31 @@ static int fetch_multiple(struct string_list *list)
 
 	argv_array_pushl(&argv, "fetch", "--append", "--no-auto-gc", NULL);
 	add_options_to_argv(&argv);
+	argv_array_push(&argv, name);
 
-	for (i = 0; i < list->nr; i++) {
-		const char *name = list->items[i].string;
-		argv_array_push(&argv, name);
-		if (verbosity >= 0)
-			printf(_("Fetching %s\n"), name);
-		if (run_command_v_opt(argv.argv, RUN_GIT_CMD)) {
-			error(_("Could not fetch %s"), name);
-			result = 1;
-		}
-		argv_array_pop(&argv);
+	if (verbosity >= 0)
+		printf(_("Fetching %s\n"), name);
+
+	cmd.argv = argv.argv;
+	cmd.git_cmd = 1;
+	code = start_command(&cmd);
+
+	if (!code && !parallel)
+		code = finish_command(&cmd);
+
+	if (i+1 < list->nr)
+		result |= fetch_multiple(list, i+1);
+
+	if (!code && parallel)
+		code |= finish_command(&cmd);
+
+	if (code) {
+		error(_("Could not fetch %s"), name);
+		result |= 1;
 	}
 
 	argv_array_clear(&argv);
+
 	return result;
 }
 
@@ -1696,7 +1713,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 			die(_("--filter can only be used with the remote "
 			      "configured in extensions.partialclone"));
 		/* TODO should this also die if we have a previous partial-clone? */
-		result = fetch_multiple(&list);
+		result = fetch_multiple(&list, 0);
 	}
 
 	if (!result && (recurse_submodules != RECURSE_SUBMODULES_OFF)) {
-- 
2.21.0

