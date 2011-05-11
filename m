From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 7/8] revert: Implement parsing --continue, --abort and --skip
Date: Wed, 11 May 2011 13:30:21 +0530
Message-ID: <1305100822-20470-8-git-send-email-artagnon@gmail.com>
References: <1305100822-20470-1-git-send-email-artagnon@gmail.com>
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 11 18:27:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKCGT-00085q-J1
	for gcvg-git-2@lo.gmane.org; Wed, 11 May 2011 18:27:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757567Ab1EKQ1l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2011 12:27:41 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:50247 "EHLO
	smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757613Ab1EKQ1k (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2011 12:27:40 -0400
X-IronPort-AV: E=Sophos;i="4.64,351,1301875200"; 
   d="scan'208";a="433241190"
Received: from smtp-in-1105.vdc.amazon.com ([10.140.9.24])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 11 May 2011 08:01:02 +0000
Received: from ramkum.desktop.amazon.com (ramkum.desktop.amazon.com [172.25.205.64])
	by smtp-in-1105.vdc.amazon.com (8.13.8/8.13.8) with ESMTP id p4B80xDL022008;
	Wed, 11 May 2011 08:01:02 GMT
Received: by ramkum.desktop.amazon.com (Postfix, from userid 272482)
	id A92BB754838; Wed, 11 May 2011 13:30:22 +0530 (IST)
X-Mailer: git-send-email 1.7.5.GIT
In-Reply-To: <1305100822-20470-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173405>

Introduce three new command-line options: --continue, --abort, and
--skip resembling the correspoding options in "rebase -i".  For now,
just parse the options into the replay_opts structure, making sure
that two of them are not specified together. They will actually be
implemented later in the series.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 This patch is fairly straightforward.

 builtin/revert.c |   50 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 49 insertions(+), 1 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 13569c2..ccfc295 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -46,6 +46,11 @@ static const char * const cherry_pick_usage[] = {
 static struct replay_opts {
 	enum { REVERT, CHERRY_PICK } action;
 
+	/* --abort, --skip, and --continue */
+	int abort_oper;
+	int skip_oper;
+	int continue_oper;
+
 	/* Boolean options */
 	int edit;
 	int no_replay;
@@ -112,6 +117,9 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 	int noop;
 
 	struct option options[] = {
+		OPT_BOOLEAN(0, "abort", &(opts->abort_oper), "abort the current operation"),
+		OPT_BOOLEAN(0, "skip", &(opts->skip_oper), "skip the current commit"),
+		OPT_BOOLEAN(0, "continue", &(opts->continue_oper), "continue the current operation"),
 		OPT_BOOLEAN('n', "no-commit", &(opts->no_commit), "don't automatically commit"),
 		OPT_BOOLEAN('e', "edit", &(opts->edit), "edit the commit message"),
 		OPT_BOOLEAN('r', NULL, &noop, "no-op (backward compatibility)"),
@@ -145,7 +153,47 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 	opts->xopts_nr = xopts_nr;
 	opts->xopts_alloc = xopts_alloc;
 
-	if (opts->commit_argc < 2)
+	/* Check for incompatible command line arguments */
+	if (opts->abort_oper || opts->skip_oper || opts->continue_oper) {
+		char *this_oper;
+		if (opts->abort_oper) {
+			this_oper = "--abort";
+			die_opt_incompatible(me, this_oper,
+					"--skip", opts->skip_oper,
+					NULL);
+			die_opt_incompatible(me, this_oper,
+					"--continue", opts->continue_oper,
+					NULL);
+		} else if (opts->skip_oper) {
+			this_oper = "--skip";
+			die_opt_incompatible(me, this_oper,
+					"--abort", opts->abort_oper,
+					NULL);
+			die_opt_incompatible(me, this_oper,
+					"--continue", opts->continue_oper,
+					NULL);
+		} else {
+			this_oper = "--continue";
+			die_opt_incompatible(me, this_oper,
+					"--abort", opts->abort_oper,
+					NULL);
+			die_opt_incompatible(me, this_oper,
+					"--skip", opts->skip_oper,
+					NULL);
+		}
+		die_opt_incompatible(me, this_oper,
+				"--no-commit", opts->no_commit,
+				"--edit", opts->edit, "-r", noop,
+				"--signoff", opts->signoff,
+				"--mainline", opts->mainline,
+				"--strategy", opts->strategy ? 1 : 0,
+				"--strategy-option", opts->xopts ? 1 : 0,
+				"-x", opts->no_replay,
+				"--ff", opts->allow_ff,
+				NULL);
+	}
+
+	else if (opts->commit_argc < 2)
 		usage_with_options(usage_str, options);
 
 	if (opts->allow_ff)
-- 
1.7.5.GIT
