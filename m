From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCHv3 9/9] revert: use the OPT_CMDMODE for parsing, reducing code
Date: Sat,  3 Aug 2013 13:51:26 +0200
Message-ID: <1375530686-2309-10-git-send-email-stefanbeller@googlemail.com>
References: <1375530686-2309-1-git-send-email-stefanbeller@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com
X-From: git-owner@vger.kernel.org Sat Aug 03 13:51:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5aN6-0005cc-96
	for gcvg-git-2@plane.gmane.org; Sat, 03 Aug 2013 13:51:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752323Ab3HCLvg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Aug 2013 07:51:36 -0400
Received: from mail-ee0-f53.google.com ([74.125.83.53]:46548 "EHLO
	mail-ee0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752187Ab3HCLvY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Aug 2013 07:51:24 -0400
Received: by mail-ee0-f53.google.com with SMTP id b15so768591eek.40
        for <git@vger.kernel.org>; Sat, 03 Aug 2013 04:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=tDa/tyfZOT6uwbnKb0zNNJ/qA5+HR2bOaUgQTaFMy3Q=;
        b=q04FFsVYi7xE3AXO/hZvBddSzlygrlk0ffNMHXVaYH8B0epnS+NWHMmDRVaVpJeNfV
         H26bH8rCiedSGUjPSqn3YJqnCGIBpwoMZzaIKvqPZfqkHYnR6dkWGuIkA/ZP6XIRosCD
         zy7Em5qk5IaeuQzo/UfChgsK68B01qUOefM68/bv7wsLZ76kWhYEPrJ+C2ehkD41UFym
         QGawmja4L7L/Bkvz1fHrLiQXVsckyLk0gAFLX/guBILglB+MCgW4Jyz2w/F0U6sKEMGR
         QnaibWaOekA0v6p9bY2juPBEU2FBcr/tQfxgTcONJoLIyc51ItjsqYtSwsAa5okeBrDK
         jIsA==
X-Received: by 10.14.104.130 with SMTP id i2mr9128412eeg.120.1375530683442;
        Sat, 03 Aug 2013 04:51:23 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id a4sm18917746eez.0.2013.08.03.04.51.22
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 03 Aug 2013 04:51:22 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc0.16.g7fca822.dirty
In-Reply-To: <1375530686-2309-1-git-send-email-stefanbeller@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231587>

The revert command comes with their own implementation of checking
for exclusiveness of parameters.
Now that the OPT_CMDMODE is in place, we can also rely on that macro
instead of cooking that solution for each command itself.

This commit also replaces OPT_BOOLEAN, which was deprecated by b04ba2bb
(parse-options: deprecate OPT_BOOLEAN, 2011-09-27). Instead OPT_BOOL is
used.

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
---
 builtin/revert.c | 62 ++++++++++++++------------------------------------------
 1 file changed, 15 insertions(+), 47 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 1d2648b..8e87acd 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -71,44 +71,19 @@ static void verify_opt_compatible(const char *me, const char *base_opt, ...)
 		die(_("%s: %s cannot be used with %s"), me, this_opt, base_opt);
 }
 
-LAST_ARG_MUST_BE_NULL
-static void verify_opt_mutually_compatible(const char *me, ...)
-{
-	const char *opt1, *opt2 = NULL;
-	va_list ap;
-
-	va_start(ap, me);
-	while ((opt1 = va_arg(ap, const char *))) {
-		if (va_arg(ap, int))
-			break;
-	}
-	if (opt1) {
-		while ((opt2 = va_arg(ap, const char *))) {
-			if (va_arg(ap, int))
-				break;
-		}
-	}
-	va_end(ap);
-
-	if (opt1 && opt2)
-		die(_("%s: %s cannot be used with %s"),	me, opt1, opt2);
-}
-
 static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 {
 	const char * const * usage_str = revert_or_cherry_pick_usage(opts);
 	const char *me = action_name(opts);
-	int remove_state = 0;
-	int contin = 0;
-	int rollback = 0;
+	int cmd = 0;
 	struct option options[] = {
-		OPT_BOOLEAN(0, "quit", &remove_state, N_("end revert or cherry-pick sequence")),
-		OPT_BOOLEAN(0, "continue", &contin, N_("resume revert or cherry-pick sequence")),
-		OPT_BOOLEAN(0, "abort", &rollback, N_("cancel revert or cherry-pick sequence")),
-		OPT_BOOLEAN('n', "no-commit", &opts->no_commit, N_("don't automatically commit")),
-		OPT_BOOLEAN('e', "edit", &opts->edit, N_("edit the commit message")),
+		OPT_CMDMODE(0, "quit", &cmd, N_("end revert or cherry-pick sequence"), 'q'),
+		OPT_CMDMODE(0, "continue", &cmd, N_("resume revert or cherry-pick sequence"), 'c'),
+		OPT_CMDMODE(0, "abort", &cmd, N_("cancel revert or cherry-pick sequence"), 'a'),
+		OPT_BOOL('n', "no-commit", &opts->no_commit, N_("don't automatically commit")),
+		OPT_BOOL('e', "edit", &opts->edit, N_("edit the commit message")),
 		OPT_NOOP_NOARG('r', NULL),
-		OPT_BOOLEAN('s', "signoff", &opts->signoff, N_("add Signed-off-by:")),
+		OPT_BOOL('s', "signoff", &opts->signoff, N_("add Signed-off-by:")),
 		OPT_INTEGER('m', "mainline", &opts->mainline, N_("parent number")),
 		OPT_RERERE_AUTOUPDATE(&opts->allow_rerere_auto),
 		OPT_STRING(0, "strategy", &opts->strategy, N_("strategy"), N_("merge strategy")),
@@ -124,11 +99,11 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 
 	if (opts->action == REPLAY_PICK) {
 		struct option cp_extra[] = {
-			OPT_BOOLEAN('x', NULL, &opts->record_origin, N_("append commit name")),
-			OPT_BOOLEAN(0, "ff", &opts->allow_ff, N_("allow fast-forward")),
-			OPT_BOOLEAN(0, "allow-empty", &opts->allow_empty, N_("preserve initially empty commits")),
-			OPT_BOOLEAN(0, "allow-empty-message", &opts->allow_empty_message, N_("allow commits with empty messages")),
-			OPT_BOOLEAN(0, "keep-redundant-commits", &opts->keep_redundant_commits, N_("keep redundant, empty commits")),
+			OPT_BOOL('x', NULL, &opts->record_origin, N_("append commit name")),
+			OPT_BOOL(0, "ff", &opts->allow_ff, N_("allow fast-forward")),
+			OPT_BOOL(0, "allow-empty", &opts->allow_empty, N_("preserve initially empty commits")),
+			OPT_BOOL(0, "allow-empty-message", &opts->allow_empty_message, N_("allow commits with empty messages")),
+			OPT_BOOL(0, "keep-redundant-commits", &opts->keep_redundant_commits, N_("keep redundant, empty commits")),
 			OPT_END(),
 		};
 		if (parse_options_concat(options, ARRAY_SIZE(options), cp_extra))
@@ -139,23 +114,16 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 			PARSE_OPT_KEEP_ARGV0 |
 			PARSE_OPT_KEEP_UNKNOWN);
 
-	/* Check for incompatible subcommands */
-	verify_opt_mutually_compatible(me,
-				"--quit", remove_state,
-				"--continue", contin,
-				"--abort", rollback,
-				NULL);
-
 	/* implies allow_empty */
 	if (opts->keep_redundant_commits)
 		opts->allow_empty = 1;
 
 	/* Set the subcommand */
-	if (remove_state)
+	if (cmd == 'q')
 		opts->subcommand = REPLAY_REMOVE_STATE;
-	else if (contin)
+	else if (cmd == 'c')
 		opts->subcommand = REPLAY_CONTINUE;
-	else if (rollback)
+	else if (cmd == 'a')
 		opts->subcommand = REPLAY_ROLLBACK;
 	else
 		opts->subcommand = REPLAY_NONE;
-- 
1.8.4.rc0.16.g7fca822.dirty
