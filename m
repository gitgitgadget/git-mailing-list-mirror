From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 10/28] cherry-pick: add --action-name option
Date: Fri, 30 Aug 2013 00:56:04 -0500
Message-ID: <1377842182-18724-11-git-send-email-felipe.contreras@gmail.com>
References: <1377842182-18724-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 30 08:01:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFHm2-0007Jh-IC
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 08:01:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755631Ab3H3GB2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 02:01:28 -0400
Received: from mail-oa0-f48.google.com ([209.85.219.48]:62144 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755466Ab3H3GB0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 02:01:26 -0400
Received: by mail-oa0-f48.google.com with SMTP id o17so1766955oag.7
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 23:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Pe/Q7bJVe/BXhFhYfU6q/u1twMee15r4lp5fmqBMdEA=;
        b=PNmgtJ1syVDrNlSSlSx/VT3a9jOUsUFU6Jo1Drmxr1Le9Oc556hqQYMcCLMuG75UB1
         h//EmRqUvzLZ9mYC2dlvFexT1Gvm1RrjMdKCKfdWVrwhoFzZjW3T4Ng3tlkiXGrENbcM
         9B1HuRWKOMllp1En5M7c2uro/Vm2iZu4/Tj8wdUHWq0lv4Iuy+ViDi5fPgPqxKBhdIy6
         TgJXTqLuV12rfyEErDLOlsSbmA/SaMFkzIGGZS/WOtge5UJBP1cRA/LJOEggraOAQ233
         W++vnjD+iK1X9F0yZvlx3gpj0GfKB3QN+x16/sQfxzYg0I7om9R9lc+yFQHslii/BQtl
         rCpg==
X-Received: by 10.60.60.5 with SMTP id d5mr5652710oer.0.1377842485777;
        Thu, 29 Aug 2013 23:01:25 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id z5sm35755452obg.13.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 29 Aug 2013 23:01:24 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1377842182-18724-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233405>

So it can be used by other tools (e.g. git rebase), and the right action
is passed to the hooks and notes rewrite stuff.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/revert.c           | 2 ++
 git-rebase--interactive.sh | 4 ++--
 sequencer.c                | 6 +++++-
 sequencer.h                | 2 ++
 4 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index d3ae2c4..ca28e52 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -124,6 +124,7 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 		OPT_END(),
 		OPT_END(),
 		OPT_END(),
+		OPT_END(),
 	};
 
 	if (opts->action == REPLAY_PICK) {
@@ -134,6 +135,7 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 			OPT_BOOLEAN(0, "allow-empty-message", &opts->allow_empty_message, N_("allow commits with empty messages")),
 			OPT_BOOLEAN(0, "keep-redundant-commits", &opts->keep_redundant_commits, N_("keep redundant, empty commits")),
 			OPT_BOOLEAN(0, "skip-empty", &opts->skip_empty, N_("skip empty commits")),
+			OPT_STRING(0, "action-name", &opts->action_name, N_("name"), N_("action name")),
 			OPT_END(),
 		};
 		if (parse_options_concat(options, ARRAY_SIZE(options), cp_extra))
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 83d6d46..e8143ae 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -251,7 +251,7 @@ pick_one () {
 
 	test -d "$rewritten" &&
 		pick_one_preserving_merges "$@" && return
-	output eval git cherry-pick "$strategy_args" $empty_args $ff "$@"
+	output eval git cherry-pick "--action-name ''" "$strategy_args" $empty_args $ff "$@"
 }
 
 pick_one_preserving_merges () {
@@ -361,7 +361,7 @@ pick_one_preserving_merges () {
 			echo "$sha1 $(git rev-parse HEAD^0)" >> "$rewritten_list"
 			;;
 		*)
-			output eval git cherry-pick "$strategy_args" "$@" ||
+			output eval git cherry-pick "--action-name ''" "$strategy_args" "$@" ||
 				die_with_patch $sha1 "Could not pick $sha1"
 			;;
 		esac
diff --git a/sequencer.c b/sequencer.c
index 56d791f..46848c4 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -829,7 +829,9 @@ static int populate_opts_cb(const char *key, const char *value, void *data)
 	else if (!strcmp(key, "options.strategy-option")) {
 		ALLOC_GROW(opts->xopts, opts->xopts_nr + 1, opts->xopts_alloc);
 		opts->xopts[opts->xopts_nr++] = xstrdup(value);
-	} else
+	} else if (!strcmp(key, "options.action-name"))
+		git_config_string(&opts->action_name, key, value);
+	else
 		return error(_("Invalid key: %s"), key);
 
 	if (!error_flag)
@@ -1006,6 +1008,8 @@ static void save_opts(struct replay_opts *opts)
 							"options.strategy-option",
 							opts->xopts[i], "^$", 0);
 	}
+	if (opts->action_name)
+		git_config_set_in_file(opts_file, "options.action-name", opts->action_name);
 }
 
 static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
diff --git a/sequencer.h b/sequencer.h
index efec1b5..6dfffaa 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -48,6 +48,8 @@ struct replay_opts {
 
 	/* Only used by REPLAY_NONE */
 	struct rev_info *revs;
+
+	const char *action_name;
 };
 
 int sequencer_pick_revisions(struct replay_opts *opts);
-- 
1.8.4-fc
