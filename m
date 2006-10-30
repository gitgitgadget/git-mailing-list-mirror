X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: [PATCH] Revert "send-pack --keep: do not explode into loose objects on the receiving end."
Date: Mon, 30 Oct 2006 17:35:51 -0500
Message-ID: <20061030223551.GG5775@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 30 Oct 2006 22:37:31 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30539>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gefjb-0003qH-Jk for gcvg-git@gmane.org; Mon, 30 Oct
 2006 23:36:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422705AbWJ3Wf4 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 30 Oct 2006
 17:35:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422707AbWJ3Wf4
 (ORCPT <rfc822;git-outgoing>); Mon, 30 Oct 2006 17:35:56 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:6283 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1422705AbWJ3Wfz
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2006 17:35:55 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GefjM-0008D7-Df; Mon, 30 Oct 2006 17:35:44 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 EDE9720FB0C; Mon, 30 Oct 2006 17:35:51 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

This reverts commit c7740a943ec896247ebc5514b6be02710caf3c53.

Both Nico and I feel that this is a local matter.   It should not
be decided by the pushing end of the connection.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 receive-pack.c       |   19 +++----------------
 send-pack.c          |   23 +++++------------------
 sha1_file.c          |    7 ++-----
 t/t5400-send-pack.sh |    9 ---------
 4 files changed, 10 insertions(+), 48 deletions(-)

diff --git a/receive-pack.c b/receive-pack.c
index e966148..7e154c5 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -8,15 +8,11 @@
 static const char receive_pack_usage[] = "git-receive-pack <git-dir>";
 
 static const char *unpacker[] = { "unpack-objects", NULL };
-static const char *keep_packer[] = {
-	"index-pack", "--stdin", "--fix-thin", NULL
-};
 
 static int deny_non_fast_forwards = 0;
 static int report_status;
-static int keep_pack;
 
-static char capabilities[] = "report-status keep-pack";
+static char capabilities[] = "report-status";
 static int capabilities_sent;
 
 static int receive_pack_config(const char *var, const char *value)
@@ -219,8 +215,6 @@ static void read_head_info(void)
 		if (reflen + 82 < len) {
 			if (strstr(refname + reflen + 1, "report-status"))
 				report_status = 1;
-			if (strstr(refname + reflen + 1, "keep-pack"))
-				keep_pack = 1;
 		}
 		cmd = xmalloc(sizeof(struct command) + len - 80);
 		hashcpy(cmd->old_sha1, old_sha1);
@@ -235,14 +229,7 @@ static void read_head_info(void)
 
 static const char *unpack()
 {
-	int code;
-
-	if (keep_pack)
-		code = run_command_v_opt(ARRAY_SIZE(keep_packer) - 1,
-					 keep_packer, RUN_GIT_CMD);
-	else
-		code = run_command_v_opt(ARRAY_SIZE(unpacker) - 1,
-					 unpacker, RUN_GIT_CMD);
+	int code = run_command_v_opt(1, unpacker, RUN_GIT_CMD);
 
 	switch (code) {
 	case 0:
@@ -300,7 +287,7 @@ int main(int argc, char **argv)
 	if (!dir)
 		usage(receive_pack_usage);
 
-	if (!enter_repo(dir, 0))
+	if(!enter_repo(dir, 0))
 		die("'%s': unable to chdir or not a git archive", dir);
 
 	setup_ident();
diff --git a/send-pack.c b/send-pack.c
index 0e90548..fbd792c 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -6,14 +6,13 @@
 #include "exec_cmd.h"
 
 static const char send_pack_usage[] =
-"git-send-pack [--all] [--keep] [--exec=git-receive-pack] <remote> [<head>...]\n"
+"git-send-pack [--all] [--exec=git-receive-pack] <remote> [<head>...]\n"
 "  --all and explicit <head> specification are mutually exclusive.";
 static const char *exec = "git-receive-pack";
 static int verbose;
 static int send_all;
 static int force_update;
 static int use_thin_pack;
-static int keep_pack;
 
 static int is_zero_sha1(const unsigned char *sha1)
 {
@@ -271,7 +270,6 @@ static int send_pack(int in, int out, in
 	int new_refs;
 	int ret = 0;
 	int ask_for_status_report = 0;
-	int ask_to_keep_pack = 0;
 	int expect_status_report = 0;
 
 	/* No funny business with the matcher */
@@ -281,8 +279,6 @@ static int send_pack(int in, int out, in
 	/* Does the other end support the reporting? */
 	if (server_supports("report-status"))
 		ask_for_status_report = 1;
-	if (server_supports("keep-pack") && keep_pack)
-		ask_to_keep_pack = 1;
 
 	/* match them up */
 	if (!remote_tail)
@@ -359,17 +355,12 @@ static int send_pack(int in, int out, in
 		strcpy(old_hex, sha1_to_hex(ref->old_sha1));
 		new_hex = sha1_to_hex(ref->new_sha1);
 
-		if (ask_for_status_report || ask_to_keep_pack) {
-			packet_write(out, "%s %s %s%c%s%s",
+		if (ask_for_status_report) {
+			packet_write(out, "%s %s %s%c%s",
 				     old_hex, new_hex, ref->name, 0,
-				     ask_for_status_report
-				     ? " report-status" : "",
-				     ask_to_keep_pack
-				     ? " keep-pack" : "");
-			if (ask_for_status_report)
-				expect_status_report = 1;
+				     "report-status");
 			ask_for_status_report = 0;
-			ask_to_keep_pack = 0;
+			expect_status_report = 1;
 		}
 		else
 			packet_write(out, "%s %s %s",
@@ -428,10 +419,6 @@ int main(int argc, char **argv)
 				verbose = 1;
 				continue;
 			}
-			if (!strcmp(arg, "--keep")) {
-				keep_pack = 1;
-				continue;
-			}
 			if (!strcmp(arg, "--thin")) {
 				use_thin_pack = 1;
 				continue;
diff --git a/sha1_file.c b/sha1_file.c
index 59883a9..5e6c8b8 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1310,7 +1310,7 @@ static void *read_packed_sha1(const unsi
 	return unpack_entry(&e, type, size);
 }
 
-void *read_sha1_file(const unsigned char *sha1, char *type, unsigned long *size)
+void * read_sha1_file(const unsigned char *sha1, char *type, unsigned long *size)
 {
 	unsigned long mapsize;
 	void *map, *buf;
@@ -1775,10 +1775,7 @@ int has_sha1_file(const unsigned char *s
 
 	if (find_pack_entry(sha1, &e, NULL))
 		return 1;
-	if (find_sha1_file(sha1, &st))
-		return 1;
-	reprepare_packed_git();
-	return find_pack_entry(sha1, &e, NULL);
+	return find_sha1_file(sha1, &st) ? 1 : 0;
 }
 
 /*
diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index d831f8d..8afb899 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -78,13 +78,4 @@ test_expect_success \
 	! diff -u .git/refs/heads/master victim/.git/refs/heads/master
 '
 
-test_expect_success 'push with --keep' '
-	t=`cd victim && git-rev-parse --verify refs/heads/master` &&
-	git-update-ref refs/heads/master $t &&
-	: > foo &&
-	git add foo &&
-	git commit -m "one more" &&
-	git-send-pack --keep ./victim/.git/ master
-'
-
 test_done
-- 
1.4.3.3.g7d63
