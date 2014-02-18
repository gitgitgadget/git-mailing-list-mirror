From: =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
Subject: [PATCH v2 3/3] revert.c Allow to override cherrypick.recordOrigin
Date: Tue, 18 Feb 2014 22:27:42 +0100
Message-ID: <9f4f6718ac3a4feadafc2c9a95173ee5c308b70e.1392758057.git.agx@sigxcpu.org>
References: <20140218192039.GC7855@google.com>
 <cover.1392758057.git.agx@sigxcpu.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 18 22:28:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFsDI-0004wn-I6
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 22:28:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751993AbaBRV2P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Feb 2014 16:28:15 -0500
Received: from xvm-169-183.ghst.net ([95.142.169.183]:44670 "EHLO
	photon.sigxcpu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751970AbaBRV2F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Feb 2014 16:28:05 -0500
Received: from honk.sigxcpu.org (localhost [IPv6:::1])
	by photon.sigxcpu.org (Postfix) with ESMTPS id 5AA6F695
	for <git@vger.kernel.org>; Tue, 18 Feb 2014 22:28:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by honk.sigxcpu.org (Postfix) with ESMTP id EAE53FB03
	for <git@vger.kernel.org>; Tue, 18 Feb 2014 22:28:03 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from honk.sigxcpu.org ([127.0.0.1])
	by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3EWALmJlSbIz for <git@vger.kernel.org>;
	Tue, 18 Feb 2014 22:28:03 +0100 (CET)
X-Mailer: git-send-email 1.9.0.rc3
In-Reply-To: <cover.1392758057.git.agx@sigxcpu.org>
In-Reply-To: <cover.1392758057.git.agx@sigxcpu.org>
References: <cover.1392758057.git.agx@sigxcpu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242358>

--no-record-origin can be used by scripts to be sure to not record
origin information when cherry-picking.
---
 Documentation/git-cherry-pick.txt | 4 ++++
 builtin/revert.c                  | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index 63db07d..b063b76 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -58,6 +58,7 @@ OPTIONS
 
 -x::
 --record-origin::
+--no-record-origin::
 	When recording the commit, append a line that says
 	"(cherry picked from commit ...)" to the original commit
 	message in order to indicate which commit this change was
@@ -70,6 +71,9 @@ OPTIONS
 	maintenance branch for an older release from a
 	development branch), adding this information can be
 	useful.
++
+Use `--no-record-origin` if you want to avoid recording the commit id
+even when the `cherrypick.recordOrigin` option is in effect.
 
 -r::
 	It used to be that the command defaulted to do `-x`
diff --git a/builtin/revert.c b/builtin/revert.c
index 899f3e4..14d90ba 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -76,6 +76,7 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 	const char * const * usage_str = revert_or_cherry_pick_usage(opts);
 	const char *me = action_name(opts);
 	int cmd = 0;
+	int no_record_origin = 0;
 	struct option options[] = {
 		OPT_CMDMODE(0, "quit", &cmd, N_("end revert or cherry-pick sequence"), 'q'),
 		OPT_CMDMODE(0, "continue", &cmd, N_("resume revert or cherry-pick sequence"), 'c'),
@@ -95,11 +96,13 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 		OPT_END(),
 		OPT_END(),
 		OPT_END(),
+		OPT_END(),
 	};
 
 	if (opts->action == REPLAY_PICK) {
 		struct option cp_extra[] = {
 			OPT_BOOL('x', "record-origin", &opts->record_origin, N_("append commit name")),
+			OPT_BOOL(0, "no-record-origin", &no_record_origin, N_("don't append commit name")),
 			OPT_BOOL(0, "ff", &opts->allow_ff, N_("allow fast-forward")),
 			OPT_BOOL(0, "allow-empty", &opts->allow_empty, N_("preserve initially empty commits")),
 			OPT_BOOL(0, "allow-empty-message", &opts->allow_empty_message, N_("allow commits with empty messages")),
@@ -118,6 +121,9 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 	if (opts->keep_redundant_commits)
 		opts->allow_empty = 1;
 
+	if (no_record_origin)
+		opts->record_origin = 0;
+
 	/* Set the subcommand */
 	if (cmd == 'q')
 		opts->subcommand = REPLAY_REMOVE_STATE;
-- 
1.9.0.rc3
