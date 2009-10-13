From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [RFC PATCH v2 05/16] Add multi_ack_2 capability to fetch-pack/upload-pack
Date: Mon, 12 Oct 2009 19:25:04 -0700
Message-ID: <1255400715-10508-6-git-send-email-spearce@spearce.org>
References: <1255400715-10508-1-git-send-email-spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 13 04:34:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxXDA-0004cs-5O
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 04:34:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758837AbZJMC0g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 22:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758831AbZJMC0f
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 22:26:35 -0400
Received: from george.spearce.org ([209.20.77.23]:56208 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758798AbZJMC0e (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 22:26:34 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 0588738268; Tue, 13 Oct 2009 02:25:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 9C3C1381FF
	for <git@vger.kernel.org>; Tue, 13 Oct 2009 02:25:17 +0000 (UTC)
X-Mailer: git-send-email 1.6.5.52.g0ff2e
In-Reply-To: <1255400715-10508-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130106>

When multi_ack_2 is enabled the ACK continue messages returned by the
remote upload-pack are broken out to describe the different states
within the peer.  This permits the client to better understand the
server's in-memory state.

The fetch-pack/upload-pack protocol now looks like:

NAK
---------------------------------
  Always sent in response to "done" if there was no common base
  selected from the "have" lines (or no have lines were sent).

  * no multi_ack or multi_ack_2:

    Sent when the client has sent a pkt-line flush ("0000") and
    the server has not yet found a common base object.

  * either multi_ack or multi_ack_2:

    Always sent in response to a pkt-line flush.

ACK %s
-----------------------------------
  * no multi_ack or multi_ack_2:

    Sent in response to "have" when the object exists on the remote
    side and is therefore an object in common between the peers.
    The argument is the SHA-1 of the common object.

  * either multi_ack or multi_ack_2:

    Sent in response to "done" if there are common objects.
    The argument is the last SHA-1 determined to be common.

ACK %s continue
-----------------------------------
  * multi_ack only:

    Sent in response to "have".

    The remote side wants the client to consider this object as
    common, and immediately stop transmitting additional "have"
    lines for objects that are reachable from it.  The reason
    the client should stop is not given, but is one of the two
    cases below available under multi_ack_2.

ACK %s common
-----------------------------------
  * multi_ack_2 only:

    Sent in response to "have".  Both sides have this object.
    Like with "ACK %s continue" above the client should stop
    sending have lines reachable for objects from the argument.

ACK %s ready
-----------------------------------
  * multi_ack_2 only:

    Sent in response to "have".

    The client should stop transmitting objects which are reachable
    from the argument, and send "done" soon to get the objects.

    If the remote side has the specified object, it should
    first send an "ACK %s common" message prior to sending
    "ACK %s ready".

    Clients may still submit additional "have" lines if there are
    more side branches for the client to explore that might be added
    to the common set and reduce the number of objects to transfer.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 builtin-fetch-pack.c |   41 ++++++++++++++++++++++++++++++++---------
 upload-pack.c        |   31 ++++++++++++++++++-------------
 2 files changed, 50 insertions(+), 22 deletions(-)

diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
index 7c09d46..b68b3eb 100644
--- a/builtin-fetch-pack.c
+++ b/builtin-fetch-pack.c
@@ -157,7 +157,15 @@ static const unsigned char *get_rev(void)
 	return commit->object.sha1;
 }
 
-static int get_ack(int fd, unsigned char *result_sha1)
+enum ack_type {
+	NAK = 0,
+	ACK,
+	ACK_continue,
+	ACK_common,
+	ACK_ready
+};
+
+static enum ack_type get_ack(int fd, unsigned char *result_sha1)
 {
 	static char line[1000];
 	int len = packet_read_line(fd, line, sizeof(line));
@@ -167,12 +175,16 @@ static int get_ack(int fd, unsigned char *result_sha1)
 	if (line[len-1] == '\n')
 		line[--len] = 0;
 	if (!strcmp(line, "NAK"))
-		return 0;
+		return NAK;
 	if (!prefixcmp(line, "ACK ")) {
 		if (!get_sha1_hex(line+4, result_sha1)) {
 			if (strstr(line+45, "continue"))
-				return 2;
-			return 1;
+				return ACK_continue;
+			if (strstr(line+45, "common"))
+				return ACK_common;
+			if (strstr(line+45, "ready"))
+				return ACK_ready;
+			return ACK;
 		}
 	}
 	die("git fetch_pack: expected ACK/NAK, got '%s'", line);
@@ -218,7 +230,8 @@ static int find_common(int fd[2], unsigned char *result_sha1,
 		remote_hex = sha1_to_hex(remote);
 		if (!fetching) {
 			struct strbuf c = STRBUF_INIT;
-			if (multi_ack)          strbuf_addstr(&c, " multi_ack");
+			if (multi_ack == 2)     strbuf_addstr(&c, " multi_ack_2");
+			if (multi_ack == 1)     strbuf_addstr(&c, " multi_ack");
 			if (use_sideband == 2)  strbuf_addstr(&c, " side-band-64k");
 			if (use_sideband == 1)  strbuf_addstr(&c, " side-band");
 			if (args.use_thin_pack) strbuf_addstr(&c, " thin-pack");
@@ -298,18 +311,23 @@ static int find_common(int fd[2], unsigned char *result_sha1,
 				if (args.verbose && ack)
 					fprintf(stderr, "got ack %d %s\n", ack,
 							sha1_to_hex(result_sha1));
-				if (ack == 1) {
+				switch (ack) {
+				case ACK:
 					flushes = 0;
 					multi_ack = 0;
 					retval = 0;
 					goto done;
-				} else if (ack == 2) {
+				case ACK_common:
+				case ACK_ready:
+				case ACK_continue: {
 					struct commit *commit =
 						lookup_commit(result_sha1);
 					mark_common(commit, 0, 1);
 					retval = 0;
 					in_vain = 0;
 					got_continue = 1;
+					break;
+					}
 				}
 			} while (ack);
 			flushes--;
@@ -336,7 +354,7 @@ done:
 			if (args.verbose)
 				fprintf(stderr, "got ack (%d) %s\n", ack,
 					sha1_to_hex(result_sha1));
-			if (ack == 1)
+			if (ack == ACK)
 				return 0;
 			multi_ack = 1;
 			continue;
@@ -618,7 +636,12 @@ static struct ref *do_fetch_pack(int fd[2],
 
 	if (is_repository_shallow() && !server_supports("shallow"))
 		die("Server does not support shallow clients");
-	if (server_supports("multi_ack")) {
+	if (server_supports("multi_ack_2")) {
+		if (args.verbose)
+			fprintf(stderr, "Server supports multi_ack_2\n");
+		multi_ack = 2;
+	}
+	else if (server_supports("multi_ack")) {
 		if (args.verbose)
 			fprintf(stderr, "Server supports multi_ack\n");
 		multi_ack = 1;
diff --git a/upload-pack.c b/upload-pack.c
index 38ddac2..5024b59 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -498,7 +498,7 @@ static int get_common_commits(void)
 {
 	static char line[1000];
 	unsigned char sha1[20];
-	char hex[41], last_hex[41];
+	char last_hex[41];
 
 	save_commit_buffer = 0;
 
@@ -515,19 +515,22 @@ static int get_common_commits(void)
 		if (!prefixcmp(line, "have ")) {
 			switch (got_sha1(line+5, sha1)) {
 			case -1: /* they have what we do not */
-				if (multi_ack && ok_to_give_up())
-					packet_write(1, "ACK %s continue\n",
-						     sha1_to_hex(sha1));
+				if (multi_ack && ok_to_give_up()) {
+					const char *hex = sha1_to_hex(sha1);
+					if (multi_ack == 2)
+						packet_write(1, "ACK %s ready\n", hex);
+					else
+						packet_write(1, "ACK %s continue\n", hex);
+				}
 				break;
 			default:
-				memcpy(hex, sha1_to_hex(sha1), 41);
-				if (multi_ack) {
-					const char *msg = "ACK %s continue\n";
-					packet_write(1, msg, hex);
-					memcpy(last_hex, hex, 41);
-				}
+				memcpy(last_hex, sha1_to_hex(sha1), 41);
+				if (multi_ack == 2)
+					packet_write(1, "ACK %s common\n", last_hex);
+				else if (multi_ack)
+					packet_write(1, "ACK %s continue\n", last_hex);
 				else if (have_obj.nr == 1)
-					packet_write(1, "ACK %s\n", hex);
+					packet_write(1, "ACK %s\n", last_hex);
 				break;
 			}
 			continue;
@@ -587,7 +590,9 @@ static void receive_needs(void)
 		    get_sha1_hex(line+5, sha1_buf))
 			die("git upload-pack: protocol error, "
 			    "expected to get sha, not '%s'", line);
-		if (strstr(line+45, "multi_ack"))
+		if (strstr(line+45, "multi_ack_2"))
+			multi_ack = 2;
+		else if (strstr(line+45, "multi_ack"))
 			multi_ack = 1;
 		if (strstr(line+45, "thin-pack"))
 			use_thin_pack = 1;
@@ -681,7 +686,7 @@ static int send_ref(const char *refname, const unsigned char *sha1, int flag, vo
 {
 	static const char *capabilities = "multi_ack thin-pack side-band"
 		" side-band-64k ofs-delta shallow no-progress"
-		" include-tag";
+		" include-tag multi_ack_2";
 	struct object *o = parse_object(sha1);
 
 	if (!o)
-- 
1.6.5.52.g0ff2e
