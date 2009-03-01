From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 1/2] fetch-pack: rearrange main loop
Date: Sun,  1 Mar 2009 22:39:59 +0100
Message-ID: <1235943599-3739-1-git-send-email-trast@student.ethz.ch>
References: <1235942640-2370-1-git-send-email-trast@student.ethz.ch>
Cc: git@vger.kernel.org
To: Brent Goodrick <bgoodr@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 01 22:48:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdtVz-0002bw-Sn
	for gcvg-git-2@gmane.org; Sun, 01 Mar 2009 22:48:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755661AbZCAVkW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Mar 2009 16:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755488AbZCAVkW
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Mar 2009 16:40:22 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:11024 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754993AbZCAVkV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Mar 2009 16:40:21 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 1 Mar 2009 22:40:19 +0100
Received: from localhost.localdomain ([84.75.148.62]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 1 Mar 2009 22:40:18 +0100
X-Mailer: git-send-email 1.6.2.rc2.289.g2fa25
In-Reply-To: <1235942640-2370-1-git-send-email-trast@student.ethz.ch>
X-OriginalArrivalTime: 01 Mar 2009 21:40:18.0882 (UTC) FILETIME=[50E72220:01C99AB6]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111880>

This patch does not change the results (nor any of the semantics
except for the get_rev return type), but we need the changed layout
for the exponential-stride feature.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>

---
 builtin-fetch-pack.c |  108 +++++++++++++++++++++++++++++--------------------
 1 files changed, 64 insertions(+), 44 deletions(-)

diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
index 372bfa2..ae0a67a 100644
--- a/builtin-fetch-pack.c
+++ b/builtin-fetch-pack.c
@@ -111,7 +111,7 @@ static void mark_common(struct commit *commit,
   Get the next rev to send, ignoring the common.
 */
 
-static const unsigned char* get_rev(void)
+static struct commit* get_rev(void)
 {
 	struct commit *commit = NULL;
 
@@ -153,15 +153,41 @@ static void mark_common(struct commit *commit,
 		rev_list = rev_list->next;
 	}
 
-	return commit->object.sha1;
+	return commit;
 }
 
+/*
+ * Send 'have' for the next batch of revisions.  Returns 0 if we ran
+ * out of commits to send, 1 otherwise.
+ */
+
+static int send_have_lines(int fd[2], int *flushes, unsigned *in_vain)
+{
+	struct commit *commit;
+	int i;
+
+	for (i = 0; i < 32; i++) {
+		commit = get_rev();
+		if (!commit)
+			return 0;
+		packet_write(fd[1], "have %s\n",
+			     sha1_to_hex(commit->object.sha1));
+		if (args.verbose)
+			fprintf(stderr, "have %s\n",
+				sha1_to_hex(commit->object.sha1));
+	}
+	packet_flush(fd[1]);
+	*flushes += 1;
+	*in_vain += 32;
+	return 1;
+}
+
+
 static int find_common(int fd[2], unsigned char *result_sha1,
 		       struct ref *refs)
 {
 	int fetching;
 	int count = 0, flushes = 0, retval;
-	const unsigned char *sha1;
 	unsigned in_vain = 0;
 	int got_continue = 0;
 
@@ -243,51 +269,45 @@ static int find_common(int fd[2], unsigned char *result_sha1,
 
 	flushes = 0;
 	retval = -1;
-	while ((sha1 = get_rev())) {
-		packet_write(fd[1], "have %s\n", sha1_to_hex(sha1));
-		if (args.verbose)
-			fprintf(stderr, "have %s\n", sha1_to_hex(sha1));
-		in_vain++;
-		if (!(31 & ++count)) {
-			int ack;
 
-			packet_flush(fd[1]);
-			flushes++;
+	/*
+	 * We keep one window "ahead" of the other side, and
+	 * will wait for an ACK only on the next one
+	 */
+	if (!send_have_lines(fd, &flushes, &in_vain))
+		goto done;
 
-			/*
-			 * We keep one window "ahead" of the other side, and
-			 * will wait for an ACK only on the next one
-			 */
-			if (count == 32)
-				continue;
+	while (send_have_lines(fd, &flushes, &in_vain)) {
+		int ack;
+		int unwound = 0;
 
-			do {
-				ack = get_ack(fd[0], result_sha1);
-				if (args.verbose && ack)
-					fprintf(stderr, "got ack %d %s\n", ack,
-							sha1_to_hex(result_sha1));
-				if (ack == 1) {
-					flushes = 0;
-					multi_ack = 0;
-					retval = 0;
-					goto done;
-				} else if (ack == 2) {
-					struct commit *commit =
-						lookup_commit(result_sha1);
-					mark_common(commit, 0, 1);
-					retval = 0;
-					in_vain = 0;
-					got_continue = 1;
-				}
-			} while (ack);
-			flushes--;
-			if (got_continue && MAX_IN_VAIN < in_vain) {
-				if (args.verbose)
-					fprintf(stderr, "giving up\n");
-				break; /* give up */
+		do {
+			ack = get_ack(fd[0], result_sha1);
+			if (args.verbose && ack)
+				fprintf(stderr, "got ack %d %s\n", ack,
+					sha1_to_hex(result_sha1));
+			if (ack == 1) {
+				flushes = 0;
+				multi_ack = 0;
+				retval = 0;
+				goto done;
+			} else if (ack == 2) {
+				struct commit *commit =
+					lookup_commit(result_sha1);
+				mark_common(commit, 0, 1);
+				retval = 0;
+				in_vain = 0;
+				got_continue = 1;
 			}
+		} while (ack);
+		flushes--;
+		if (got_continue && MAX_IN_VAIN < in_vain) {
+			if (args.verbose)
+				fprintf(stderr, "giving up\n");
+			break; /* give up */
 		}
 	}
+
 done:
 	packet_write(fd[1], "done\n");
 	if (args.verbose)
-- 
tg: (7f705dc..) t/fp-refactor (depends on: origin/master)
