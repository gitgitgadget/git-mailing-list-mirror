From: David Greene <greened@obbligato.org>
Subject: [PATCH 1/5] Teach cherry-pick to skip redundant commits if asked
Date: Sun, 10 Jan 2016 23:00:17 -0600
Message-ID: <1452488421-26823-2-git-send-email-greened@obbligato.org>
References: <1452488421-26823-1-git-send-email-greened@obbligato.org>
Cc: gitster@pobox.com, peff@peff.net, chris@arachsys.com,
	nhorman@tuxdriver.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 11 06:01:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIUbM-0005FY-KS
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 06:01:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751023AbcAKFAh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 00:00:37 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:53947 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750743AbcAKFAg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 00:00:36 -0500
Received: from chippewa-nat.cray.com ([136.162.34.1] helo=waller.us.cray.com)
	by johnson.obbligato.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
	(Exim 4.85)
	(envelope-from <greened@obbligato.org>)
	id 1aIUbw-0005H8-FR; Sun, 10 Jan 2016 23:01:44 -0600
X-Mailer: git-send-email 2.6.1
In-Reply-To: <1452488421-26823-1-git-send-email-greened@obbligato.org>
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283634>

From: "David A. Greene" <greened@obbligato.org>

Add a "--skip-redundant-commits" option to cherry-pick to avoid
aborting if the cherry-picked commit becomes empty due to
conflict resolution.

Signed-off-by: David A. Greene <greened@obbligato.org>
---
 builtin/revert.c |  7 +++++++
 sequencer.c      | 23 +++++++++++++++++++++++
 sequencer.h      |  1 +
 3 files changed, 31 insertions(+)

diff --git a/builtin/revert.c b/builtin/revert.c
index 56a2c36..befd3ce 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -91,6 +91,12 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 			N_("option for merge strategy"), option_parse_x),
 		{ OPTION_STRING, 'S', "gpg-sign", &opts->gpg_sign, N_("key-id"),
 		  N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
+		/*
+		 * There must be enough OPT_END() here to match the
+		 * size of cp_extra below so that parse_options_concat
+		 * will work.
+		 */
+		OPT_END(),
 		OPT_END(),
 		OPT_END(),
 		OPT_END(),
@@ -106,6 +112,7 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 			OPT_BOOL(0, "allow-empty", &opts->allow_empty, N_("preserve initially empty commits")),
 			OPT_BOOL(0, "allow-empty-message", &opts->allow_empty_message, N_("allow commits with empty messages")),
 			OPT_BOOL(0, "keep-redundant-commits", &opts->keep_redundant_commits, N_("keep redundant, empty commits")),
+			OPT_BOOL(0, "skip-redundant-commits", &opts->skip_redundant_commits, N_("skip redundant, empty commits")),
 			OPT_END(),
 		};
 		if (parse_options_concat(options, ARRAY_SIZE(options), cp_extra))
diff --git a/sequencer.c b/sequencer.c
index 8c58fa2..12361e7 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -185,6 +185,7 @@ static void print_advice(int show_hint, struct replay_opts *opts)
 		else
 			advise(_("after resolving the conflicts, mark the corrected paths\n"
 				 "with 'git add <paths>' or 'git rm <paths>'\n"
+
 				 "and commit the result with 'git commit'"));
 	}
 }
@@ -614,6 +615,28 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 		res = allow;
 		goto leave;
 	}
+
+	// If told, do not try to commit things that don't make any
+	// changes.
+	if (opts->skip_redundant_commits) {
+		int index_unchanged = is_index_unchanged();
+		if (index_unchanged < 0) {
+			// Something bad happened readhing HEAD or the
+			// index.  Abort.
+			res = index_unchanged;
+			goto leave;
+		}
+		if (index_unchanged) {
+			fputs(_("Skipping redundant commit "), stderr);
+			fputs(find_unique_abbrev(commit->object.oid.hash,
+						 GIT_SHA1_HEXSZ),
+			      stderr);
+			fputs("\n", stderr);
+			res = 0;
+			goto leave;
+		}
+	}
+
 	if (!opts->no_commit)
 		res = run_git_commit(git_path_merge_msg(), opts, allow);
 
diff --git a/sequencer.h b/sequencer.h
index 5ed5cb1..ad6145d 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -34,6 +34,7 @@ struct replay_opts {
 	int allow_empty;
 	int allow_empty_message;
 	int keep_redundant_commits;
+	int skip_redundant_commits;
 
 	int mainline;
 
-- 
2.6.1
