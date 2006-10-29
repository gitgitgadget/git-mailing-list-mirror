X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] send-pack --keep: do not explode into loose objects on the receiving end.
Date: Sun, 29 Oct 2006 00:47:56 -0700
Message-ID: <7vwt6j4l77.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0610252333540.12418@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 29 Oct 2006 07:48:18 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0610252333540.12418@xanadu.home> (Nicolas Pitre's
	message of "Wed, 25 Oct 2006 23:44:12 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30417>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Ge5Ot-0005mK-SC for gcvg-git@gmane.org; Sun, 29 Oct
 2006 08:48:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965136AbWJ2Hr7 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 29 Oct 2006
 02:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965139AbWJ2Hr7
 (ORCPT <rfc822;git-outgoing>); Sun, 29 Oct 2006 02:47:59 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:40900 "EHLO
 fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP id S965136AbWJ2Hr5
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 29 Oct 2006 02:47:57 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao01.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061029074757.YNDG6077.fed1rmmtao01.cox.net@fed1rmimpo02.cox.net>; Sun, 29
 Oct 2006 02:47:57 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id g7o11V00Q1kojtg0000000 Sun, 29 Oct 2006
 02:48:02 -0500
To: Nicolas Pitre <nico@cam.org>
Sender: git-owner@vger.kernel.org

This adds "keep-pack" extension to send-pack vs receive pack protocol,
and makes the receiver invoke "index-pack --stdin --fix-thin".

With this, you can ask send-pack not to explode the result into
loose objects on the receiving end.

I've patched has_sha1_file() to re-check for added packs just
like is done in read_sha1_file() for now, but I think the static
"re-prepare" interface for packs was a mistake.  Creation of a
new pack inside a process that needs to read objects in them
back ought to be a rare event, so we are better off making the
callers (such as receive-pack that calls "index-pack --stdin
--fix-thin") explicitly call re-prepare.  That way we do not
have to penalize ordinary users of read_sha1_file() and
has_sha1_file().

We would need to fix this someday.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 receive-pack.c       |   19 ++++++++++++++++---
 send-pack.c          |   23 ++++++++++++++++++-----
 sha1_file.c          |    7 +++++--
 t/t5400-send-pack.sh |    9 +++++++++
 4 files changed, 48 insertions(+), 10 deletions(-)

diff --git a/receive-pack.c b/receive-pack.c
index ea2dbd4..ef50226 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -8,10 +8,14 @@
 static const char receive_pack_usage[] = "git-receive-pack <git-dir>";
 
 static const char *unpacker[] = { "unpack-objects", NULL };
+static const char *keep_packer[] = {
+	"index-pack", "--stdin", "--fix-thin", NULL
+};
 
 static int report_status;
+static int keep_pack;
 
-static char capabilities[] = "report-status";
+static char capabilities[] = "report-status keep-pack";
 static int capabilities_sent;
 
 static int show_ref(const char *path, const unsigned char *sha1)
@@ -261,6 +265,8 @@ static void read_head_info(void)
 		if (reflen + 82 < len) {
 			if (strstr(refname + reflen + 1, "report-status"))
 				report_status = 1;
+			if (strstr(refname + reflen + 1, "keep-pack"))
+				keep_pack = 1;
 		}
 		cmd = xmalloc(sizeof(struct command) + len - 80);
 		hashcpy(cmd->old_sha1, old_sha1);
@@ -275,7 +281,14 @@ static void read_head_info(void)
 
 static const char *unpack(int *error_code)
 {
-	int code = run_command_v_opt(1, unpacker, RUN_GIT_CMD);
+	int code;
+
+	if (keep_pack)
+		code = run_command_v_opt(ARRAY_SIZE(keep_packer) - 1,
+					 keep_packer, RUN_GIT_CMD);
+	else
+		code = run_command_v_opt(ARRAY_SIZE(unpacker) - 1,
+					 unpacker, RUN_GIT_CMD);
 
 	*error_code = 0;
 	switch (code) {
@@ -335,7 +348,7 @@ int main(int argc, char **argv)
 	if (!dir)
 		usage(receive_pack_usage);
 
-	if(!enter_repo(dir, 0))
+	if (!enter_repo(dir, 0))
 		die("'%s': unable to chdir or not a git archive", dir);
 
 	write_head_info();
diff --git a/send-pack.c b/send-pack.c
index 5bb123a..54d218c 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -6,13 +6,14 @@
 #include "exec_cmd.h"
 
 static const char send_pack_usage[] =
-"git-send-pack [--all] [--exec=git-receive-pack] <remote> [<head>...]\n"
+"git-send-pack [--all] [--keep] [--exec=git-receive-pack] <remote> [<head>...]\n"
 "  --all and explicit <head> specification are mutually exclusive.";
 static const char *exec = "git-receive-pack";
 static int verbose;
 static int send_all;
 static int force_update;
 static int use_thin_pack;
+static int keep_pack;
 
 static int is_zero_sha1(const unsigned char *sha1)
 {
@@ -270,6 +271,7 @@ static int send_pack(int in, int out, in
 	int new_refs;
 	int ret = 0;
 	int ask_for_status_report = 0;
+	int ask_to_keep_pack = 0;
 	int expect_status_report = 0;
 
 	/* No funny business with the matcher */
@@ -279,6 +281,8 @@ static int send_pack(int in, int out, in
 	/* Does the other end support the reporting? */
 	if (server_supports("report-status"))
 		ask_for_status_report = 1;
+	if (server_supports("keep-pack") && keep_pack)
+		ask_to_keep_pack = 1;
 
 	/* match them up */
 	if (!remote_tail)
@@ -355,12 +359,17 @@ static int send_pack(int in, int out, in
 		strcpy(old_hex, sha1_to_hex(ref->old_sha1));
 		new_hex = sha1_to_hex(ref->new_sha1);
 
-		if (ask_for_status_report) {
-			packet_write(out, "%s %s %s%c%s",
+		if (ask_for_status_report || ask_to_keep_pack) {
+			packet_write(out, "%s %s %s%c%s%s",
 				     old_hex, new_hex, ref->name, 0,
-				     "report-status");
+				     ask_for_status_report
+				     ? " report-status" : "",
+				     ask_to_keep_pack
+				     ? " keep-pack" : "");
+			if (ask_for_status_report)
+				expect_status_report = 1;
 			ask_for_status_report = 0;
-			expect_status_report = 1;
+			ask_to_keep_pack = 0;
 		}
 		else
 			packet_write(out, "%s %s %s",
@@ -419,6 +428,10 @@ int main(int argc, char **argv)
 				verbose = 1;
 				continue;
 			}
+			if (!strcmp(arg, "--keep")) {
+				keep_pack = 1;
+				continue;
+			}
 			if (!strcmp(arg, "--thin")) {
 				use_thin_pack = 1;
 				continue;
diff --git a/sha1_file.c b/sha1_file.c
index e89d24c..278ba2f 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1292,7 +1292,7 @@ static void *read_packed_sha1(const unsi
 	return unpack_entry(&e, type, size);
 }
 
-void * read_sha1_file(const unsigned char *sha1, char *type, unsigned long *size)
+void *read_sha1_file(const unsigned char *sha1, char *type, unsigned long *size)
 {
 	unsigned long mapsize;
 	void *map, *buf;
@@ -1757,7 +1757,10 @@ int has_sha1_file(const unsigned char *s
 
 	if (find_pack_entry(sha1, &e, NULL))
 		return 1;
-	return find_sha1_file(sha1, &st) ? 1 : 0;
+	if (find_sha1_file(sha1, &st))
+		return 1;
+	reprepare_packed_git();
+	return find_pack_entry(sha1, &e, NULL);
 }
 
 /*
diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index 8afb899..d831f8d 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -78,4 +78,13 @@ test_expect_success \
 	! diff -u .git/refs/heads/master victim/.git/refs/heads/master
 '
 
+test_expect_success 'push with --keep' '
+	t=`cd victim && git-rev-parse --verify refs/heads/master` &&
+	git-update-ref refs/heads/master $t &&
+	: > foo &&
+	git add foo &&
+	git commit -m "one more" &&
+	git-send-pack --keep ./victim/.git/ master
+'
+
 test_done
-- 
1.4.3.3.g7d63

