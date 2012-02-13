From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH 5/5] push/fetch/clone --no-progress suppresses progress output
Date: Mon, 13 Feb 2012 21:17:15 +0100
Message-ID: <1329164235-29955-6-git-send-email-drizzd@aon.at>
References: <7vhazobto3.fsf@alter.siamese.dyndns.org>
 <1329164235-29955-1-git-send-email-drizzd@aon.at>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 13 21:26:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rx2Th-0002oB-Kr
	for gcvg-git-2@plane.gmane.org; Mon, 13 Feb 2012 21:26:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757948Ab2BMUZ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Feb 2012 15:25:56 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:36813 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757967Ab2BMUZv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2012 15:25:51 -0500
Received: from localhost (p5B22E0DA.dip.t-dialin.net [91.34.224.218])
	by bsmtp.bon.at (Postfix) with ESMTP id 121592C4006;
	Mon, 13 Feb 2012 21:27:08 +0100 (CET)
X-Mailer: git-send-email 1.7.9
In-Reply-To: <1329164235-29955-1-git-send-email-drizzd@aon.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190662>

By default, progress output is disabled if stderr is not a terminal.
The --progress option can be used to force progress output anyways.
Conversely, --no-progress does not force progress output. In particular,
if stderr is a terminal, progress output is enabled.

This is unintuitive. Change --no-progress to force output off.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---
 builtin/clone.c          |    6 +++---
 builtin/fetch-pack.c     |    2 +-
 builtin/fetch.c          |    4 ++--
 builtin/push.c           |    4 ++--
 builtin/send-pack.c      |   12 +++++++-----
 t/t5523-push-upstream.sh |    3 ++-
 transport.c              |    6 +++++-
 7 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index c62d4b5..09dbb09 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -45,7 +45,7 @@ static char *option_branch = NULL;
 static const char *real_git_dir;
 static char *option_upload_pack = "git-upload-pack";
 static int option_verbosity;
-static int option_progress;
+static int option_progress = -1;
 static struct string_list option_config;
 static struct string_list option_reference;
 
@@ -60,8 +60,8 @@ static int opt_parse_reference(const struct option *opt, const char *arg, int un
 
 static struct option builtin_clone_options[] = {
 	OPT__VERBOSITY(&option_verbosity),
-	OPT_BOOLEAN(0, "progress", &option_progress,
-			"force progress reporting"),
+	OPT_BOOL(0, "progress", &option_progress,
+		 "force progress reporting"),
 	OPT_BOOLEAN('n', "no-checkout", &option_no_checkout,
 		    "don't create a checkout"),
 	OPT_BOOLEAN(0, "bare", &option_bare, "create a bare repository"),
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 6207ecd..a4d3e90 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -736,7 +736,7 @@ static int get_pack(int xd[2], char **pack_lockfile)
 	}
 	else {
 		*av++ = "unpack-objects";
-		if (args.quiet)
+		if (args.quiet || args.no_progress)
 			*av++ = "-q";
 	}
 	if (*hdr_arg)
diff --git a/builtin/fetch.c b/builtin/fetch.c
index ab18633..65f5f9b 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -30,7 +30,7 @@ enum {
 };
 
 static int all, append, dry_run, force, keep, multiple, prune, update_head_ok, verbosity;
-static int progress, recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
+static int progress = -1, recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
 static int tags = TAGS_DEFAULT;
 static const char *depth;
 static const char *upload_pack;
@@ -78,7 +78,7 @@ static struct option builtin_fetch_options[] = {
 	OPT_BOOLEAN('k', "keep", &keep, "keep downloaded pack"),
 	OPT_BOOLEAN('u', "update-head-ok", &update_head_ok,
 		    "allow updating of HEAD ref"),
-	OPT_BOOLEAN(0, "progress", &progress, "force progress reporting"),
+	OPT_BOOL(0, "progress", &progress, "force progress reporting"),
 	OPT_STRING(0, "depth", &depth, "depth",
 		   "deepen history of shallow clone"),
 	{ OPTION_STRING, 0, "submodule-prefix", &submodule_prefix, "dir",
diff --git a/builtin/push.c b/builtin/push.c
index 35cce53..6c373cf 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -19,7 +19,7 @@ static int thin;
 static int deleterefs;
 static const char *receivepack;
 static int verbosity;
-static int progress;
+static int progress = -1;
 
 static const char **refspec;
 static int refspec_nr;
@@ -260,7 +260,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		OPT_STRING( 0 , "exec", &receivepack, "receive-pack", "receive pack program"),
 		OPT_BIT('u', "set-upstream", &flags, "set upstream for git pull/status",
 			TRANSPORT_PUSH_SET_UPSTREAM),
-		OPT_BOOLEAN(0, "progress", &progress, "force progress reporting"),
+		OPT_BOOL(0, "progress", &progress, "force progress reporting"),
 		OPT_END()
 	};
 
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 7d514ca..8fc9789 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -58,7 +58,7 @@ static int pack_objects(int fd, struct ref *refs, struct extra_have_objects *ext
 		argv[i++] = "--thin";
 	if (args->use_ofs_delta)
 		argv[i++] = "--delta-base-offset";
-	if (args->quiet)
+	if (args->quiet || !args->progress)
 		argv[i++] = "-q";
 	if (args->progress)
 		argv[i++] = "--progress";
@@ -250,6 +250,7 @@ int send_pack(struct send_pack_args *args,
 	int allow_deleting_refs = 0;
 	int status_report = 0;
 	int use_sideband = 0;
+	int quiet_supported = 0;
 	unsigned cmds_sent = 0;
 	int ret;
 	struct async demux;
@@ -263,8 +264,8 @@ int send_pack(struct send_pack_args *args,
 		args->use_ofs_delta = 1;
 	if (server_supports("side-band-64k"))
 		use_sideband = 1;
-	if (!server_supports("quiet"))
-		args->quiet = 0;
+	if (server_supports("quiet"))
+		quiet_supported = 1;
 	if (server_supports("verify-refs"))
 		args->verify_refs = 1;
 
@@ -304,13 +305,14 @@ int send_pack(struct send_pack_args *args,
 		} else {
 			char *old_hex = sha1_to_hex(ref->old_sha1);
 			char *new_hex = sha1_to_hex(ref->new_sha1);
+			int quiet = quiet_supported && (args->quiet || !args->progress);
 
-			if (!cmds_sent && (status_report || use_sideband || args->quiet || args->verify_refs)) {
+			if (!cmds_sent && (status_report || use_sideband || quiet || args->verify_refs)) {
 				packet_buf_write(&req_buf, "%s %s %s%c%s%s%s%s",
 					old_hex, new_hex, ref->name, 0,
 					status_report ? " report-status" : "",
 					use_sideband ? " side-band-64k" : "",
-					args->quiet ? " quiet" : "",
+					quiet ? " quiet" : "",
 					args->verify_refs ? " verify-refs" : "");
 			}
 			else
diff --git a/t/t5523-push-upstream.sh b/t/t5523-push-upstream.sh
index 9ee52cf..3683df1 100755
--- a/t/t5523-push-upstream.sh
+++ b/t/t5523-push-upstream.sh
@@ -101,10 +101,11 @@ test_expect_success TTY 'push -q suppresses progress' '
 	! grep "Writing objects" err
 '
 
-test_expect_failure TTY 'push --no-progress suppresses progress' '
+test_expect_success TTY 'push --no-progress suppresses progress' '
 	ensure_fresh_upstream &&
 
 	test_terminal git push -u --no-progress upstream master >out 2>err &&
+	! grep "Unpacking objects" err &&
 	! grep "Writing objects" err
 '
 
diff --git a/transport.c b/transport.c
index cac0c06..6074ee9 100644
--- a/transport.c
+++ b/transport.c
@@ -994,10 +994,14 @@ void transport_set_verbosity(struct transport *transport, int verbosity,
 	 * when a rule is satisfied):
 	 *
 	 *   1. Report progress, if force_progress is 1 (ie. --progress).
+	 *   2. Don't report progress, if force_progress is 0 (ie. --no-progress).
 	 *   2. Don't report progress, if verbosity < 0 (ie. -q/--quiet ).
 	 *   3. Report progress if isatty(2) is 1.
 	 **/
-	transport->progress = force_progress || (verbosity >= 0 && isatty(2));
+	if (force_progress >= 0)
+		transport->progress = !!force_progress;
+	else
+		transport->progress = verbosity >= 0 && isatty(2);
 }
 
 int transport_push(struct transport *transport,
-- 
1.7.9
