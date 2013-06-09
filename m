From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 21/36] cherry-pick: add --action-name option
Date: Sun,  9 Jun 2013 14:24:35 -0500
Message-ID: <1370805890-3453-22-git-send-email-felipe.contreras@gmail.com>
References: <1370805890-3453-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 21:27:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UllHM-0003fR-Iq
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 21:27:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752375Ab3FIT1q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 15:27:46 -0400
Received: from mail-oa0-f52.google.com ([209.85.219.52]:44226 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752367Ab3FIT1o (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 15:27:44 -0400
Received: by mail-oa0-f52.google.com with SMTP id g12so292909oah.11
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 12:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=GMQudK708JjDuFltWfJVxGtIksqD0aCShrIhKO+JteU=;
        b=bpypSeIJa5I97Iyx0UP8hsBKqY41MiEFK9MQqDChm7Z43c2/PUSLoUP0BuAWO3h3cS
         tBYN9ykhbvIexHt9BFJ0PjSpK1qcECopmi7qXqymHecduDH+JbyeLogLIJjdy0TBJ18x
         Bet74QZ2i31pBbTnoywB0iA+mOg7MPWwlLDERK87W2yBXXPW6WG0e1c5ub1Kgro/hmAr
         BxIo20lbKxxsuqrLrvyUMqJ+PpTHeAGVf1fn36p/uYbRDoJ0lpjI9a4UKsWbGxPZWHb5
         jpi8aoASsHmlMxDu9yYu/ySxMgNZBywH4R2cK4/GQPib55Dytg5XxFg9Tv5zE3zCfNyR
         kyTA==
X-Received: by 10.60.136.234 with SMTP id qd10mr5781021oeb.15.1370806064307;
        Sun, 09 Jun 2013 12:27:44 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id nt17sm15937552obb.13.2013.06.09.12.27.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 12:27:43 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370805890-3453-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227128>

So it can be used by other tools (e.g. git rebase), and the right action
is passed to the hooks and notes rewrite stuff.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/revert.c           |  2 ++
 builtin/sequencer.c        | 17 ++++++++++++++---
 builtin/sequencer.h        |  2 ++
 git-rebase--interactive.sh |  4 ++--
 4 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index d3d5600..6066ad2 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -122,6 +122,7 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 		OPT_END(),
 		OPT_END(),
 		OPT_END(),
+		OPT_END(),
 	};
 
 	if (opts->action == REPLAY_PICK) {
@@ -132,6 +133,7 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 			OPT_BOOLEAN(0, "allow-empty-message", &opts->allow_empty_message, N_("allow commits with empty messages")),
 			OPT_BOOLEAN(0, "keep-redundant-commits", &opts->keep_redundant_commits, N_("keep redundant, empty commits")),
 			OPT_BOOLEAN(0, "skip-empty", &opts->skip_empty, N_("skip empty commits")),
+			OPT_STRING(0, "action-name", &opts->action_name, N_("name"), N_("action name")),
 			OPT_END(),
 		};
 		if (parse_options_concat(options, ARRAY_SIZE(options), cp_extra))
diff --git a/builtin/sequencer.c b/builtin/sequencer.c
index c87008e..3fec505 100644
--- a/builtin/sequencer.c
+++ b/builtin/sequencer.c
@@ -23,11 +23,18 @@ static struct rewritten rewritten;
 
 static void finish(struct replay_opts *opts)
 {
+	const char *name;
+
 	if (opts->action != REPLAY_PICK)
 		return;
 
-	copy_rewrite_notes(&rewritten, "cherry-pick");
-	run_rewrite_hook(&rewritten, "cherry-pick");
+	name = opts->action_name ? opts->action_name : "cherry-pick";
+
+	if (!*name)
+		return;
+
+	copy_rewrite_notes(&rewritten, name);
+	run_rewrite_hook(&rewritten, name);
 }
 
 static void remove_sequencer_state(void)
@@ -744,7 +751,9 @@ static int populate_opts_cb(const char *key, const char *value, void *data)
 	else if (!strcmp(key, "options.strategy-option")) {
 		ALLOC_GROW(opts->xopts, opts->xopts_nr + 1, opts->xopts_alloc);
 		opts->xopts[opts->xopts_nr++] = xstrdup(value);
-	} else
+	} else if (!strcmp(key, "options.action-name"))
+		git_config_string(&opts->action_name, key, value);
+	else
 		return error(_("Invalid key: %s"), key);
 
 	if (!error_flag)
@@ -921,6 +930,8 @@ static void save_opts(struct replay_opts *opts)
 							"options.strategy-option",
 							opts->xopts[i], "^$", 0);
 	}
+	if (opts->action_name)
+		git_config_set_in_file(opts_file, "options.action-name", opts->action_name);
 }
 
 static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
diff --git a/builtin/sequencer.h b/builtin/sequencer.h
index 63ba274..c69eeff 100644
--- a/builtin/sequencer.h
+++ b/builtin/sequencer.h
@@ -46,6 +46,8 @@ struct replay_opts {
 
 	/* Only used by REPLAY_NONE */
 	struct rev_info *revs;
+
+	const char *action_name;
 };
 
 int sequencer_pick_revisions(struct replay_opts *opts);
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index f953d8d..9f42a71 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -239,7 +239,7 @@ pick_one () {
 
 	test -d "$rewritten" &&
 		pick_one_preserving_merges "$@" && return
-	output git cherry-pick $empty_args $ff "$@"
+	output git cherry-pick --action-name '' $empty_args $ff "$@"
 }
 
 pick_one_preserving_merges () {
@@ -350,7 +350,7 @@ pick_one_preserving_merges () {
 			echo "$sha1 $(git rev-parse HEAD^0)" >> "$rewritten_list"
 			;;
 		*)
-			output git cherry-pick "$@" ||
+			output git cherry-pick --action-name '' "$@" ||
 				die_with_patch $sha1 "Could not pick $sha1"
 			;;
 		esac
-- 
1.8.3.698.g079b096
