From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCHv2 9/9] revert: use the OPT_CMDMODE for parsing, reducing code
Date: Wed, 31 Jul 2013 18:28:37 +0200
Message-ID: <1375288117-1576-10-git-send-email-stefanbeller@googlemail.com>
References: <1375288117-1576-1-git-send-email-stefanbeller@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 31 18:29:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4ZGq-00084w-W5
	for gcvg-git-2@plane.gmane.org; Wed, 31 Jul 2013 18:29:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231Ab3GaQ2p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Jul 2013 12:28:45 -0400
Received: from mail-ea0-f181.google.com ([209.85.215.181]:35743 "EHLO
	mail-ea0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932225Ab3GaQ2n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jul 2013 12:28:43 -0400
Received: by mail-ea0-f181.google.com with SMTP id d10so467224eaj.26
        for <git@vger.kernel.org>; Wed, 31 Jul 2013 09:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=x/8fVYbKeoSXxgjH5GY03tsIJIkxY21RKvgyPILcPlw=;
        b=WwklHt7/FgR4DW+t8Dt8Coh92BnFWW5qk8uJGbbM7CY/WGx0vILBVjLURAZWzJzRtr
         TROP4YO08KwH5hNsEftuJe/HITV1a4w/f5WDJEz/lzh32dpxitbB31wngMvJ8W55de1W
         Y8OkU78hrp0J1pSCqWmXoUoude+IndAP9ZiZrJRJ2eFhifqVUsnqnrtDJGlHRxUE63cc
         kMcOOVe8KKnEO9l0HKbkEstOTbGQo+L2FxDUDTdVTDRLYdK/shqIrqMm6inxtXEt+oQI
         6NuwGnWbixw2FaUrJcD1BDDR5g0rlTFA//DjH90MKX/8cljhQ88FyiYSURez6vtzCGrD
         yMiA==
X-Received: by 10.15.53.4 with SMTP id q4mr70234319eew.134.1375288121781;
        Wed, 31 Jul 2013 09:28:41 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id k3sm3695120een.16.2013.07.31.09.28.40
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 31 Jul 2013 09:28:41 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc0.1.g8f6a3e5
In-Reply-To: <1375288117-1576-1-git-send-email-stefanbeller@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231427>

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
1.8.4.rc0.1.g8f6a3e5
