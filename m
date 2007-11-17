From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] send-pack: assign remote errors to each ref
Date: Sat, 17 Nov 2007 07:56:03 -0500
Message-ID: <20071117125602.GC23186@sigill.intra.peff.net>
References: <20071117125323.GA23125@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Alex Riesen <raa.lkml@gmail.com>,
	Pierre Habouzit <madcoder@debian.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 17 13:56:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItNDl-0003qT-Es
	for gcvg-git-2@gmane.org; Sat, 17 Nov 2007 13:56:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752420AbXKQM4J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2007 07:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752299AbXKQM4I
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Nov 2007 07:56:08 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3887 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751928AbXKQM4H (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2007 07:56:07 -0500
Received: (qmail 3945 invoked by uid 111); 17 Nov 2007 12:56:05 -0000
Received: from ppp-216-106-96-70.storm.ca (HELO sigill.intra.peff.net) (216.106.96.70)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sat, 17 Nov 2007 07:56:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 17 Nov 2007 07:56:03 -0500
Content-Disposition: inline
In-Reply-To: <20071117125323.GA23125@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65275>

This lets us show remote errors (e.g., a denied hook) along
with the usual push output.

There is a slightly clever optimization in receive_status
that bears explanation. We need to correlate the returned
status and our ref objects, which naively could be an O(m*n)
operation. However, since the current implementation of
receive-pack returns the errors to us in the same order that
we sent them, we optimistically look for the next ref to be
looked up to come after the last one we have found. So it
should be an O(m+n) merge if the receive-pack behavior
holds, but we fall back to a correct but slower behavior if
it should change.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin-send-pack.c       |   51 +++++++++++++++++++++++++++++++++++++++-----
 cache.h                   |    2 +
 t/t5406-remote-rejects.sh |   24 +++++++++++++++++++++
 3 files changed, 71 insertions(+), 6 deletions(-)
 create mode 100755 t/t5406-remote-rejects.sh

diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index c7d07aa..bcf7143 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -146,19 +146,43 @@ static void get_local_heads(void)
 	for_each_ref(one_local_ref, NULL);
 }
 
-static int receive_status(int in)
+static struct ref *set_ref_error(struct ref *refs, const char *line)
 {
+	struct ref *ref;
+
+	for (ref = refs; ref; ref = ref->next) {
+		const char *msg;
+		if (prefixcmp(line, ref->name))
+			continue;
+		msg = line + strlen(ref->name);
+		if (*msg++ != ' ')
+			continue;
+		ref->status = REF_STATUS_REMOTE_REJECT;
+		ref->error = xstrdup(msg);
+		ref->error[strlen(ref->error)-1] = '\0';
+		return ref;
+	}
+	return NULL;
+}
+
+/* a return value of -1 indicates that an error occurred,
+ * but we were able to set individual ref errors. A return
+ * value of -2 means we couldn't even get that far. */
+static int receive_status(int in, struct ref *refs)
+{
+	struct ref *hint;
 	char line[1000];
 	int ret = 0;
 	int len = packet_read_line(in, line, sizeof(line));
 	if (len < 10 || memcmp(line, "unpack ", 7)) {
 		fprintf(stderr, "did not receive status back\n");
-		return -1;
+		return -2;
 	}
 	if (memcmp(line, "unpack ok\n", 10)) {
 		fputs(line, stderr);
 		ret = -1;
 	}
+	hint = NULL;
 	while (1) {
 		len = packet_read_line(in, line, sizeof(line));
 		if (!len)
@@ -171,7 +195,10 @@ static int receive_status(int in)
 		}
 		if (!memcmp(line, "ok", 2))
 			continue;
-		fputs(line, stderr);
+		if (hint)
+			hint = set_ref_error(hint, line + 3);
+		if (!hint)
+			hint = set_ref_error(refs, line + 3);
 		ret = -1;
 	}
 	return ret;
@@ -297,6 +324,12 @@ static void print_push_status(const char *dest, struct ref *refs)
 			print_ref_status('!', "[rejected]", ref, ref->peer_ref,
 					"non-fast forward");
 			break;
+		case REF_STATUS_REMOTE_REJECT:
+			if (ref->deletion)
+				print_ref_status('!', "[remote rejected]", ref, NULL, ref->error);
+			else
+				print_ref_status('!', "[remote rejected]", ref, ref->peer_ref, ref->error);
+			break;
 		case REF_STATUS_OK:
 			print_ok_ref_status(ref);
 			break;
@@ -312,6 +345,7 @@ static int do_send_pack(int in, int out, struct remote *remote, const char *dest
 	int allow_deleting_refs = 0;
 	int expect_status_report = 0;
 	int flags = MATCH_REFS_NONE;
+	int ret;
 
 	if (args.send_all)
 		flags |= MATCH_REFS_ALL;
@@ -429,12 +463,15 @@ static int do_send_pack(int in, int out, struct remote *remote, const char *dest
 	}
 	close(out);
 
-	print_push_status(dest, remote_refs);
-
 	if (expect_status_report) {
-		if (receive_status(in))
+		ret = receive_status(in, remote_refs);
+		if (ret == -2)
 			return -1;
 	}
+	else
+		ret = 0;
+
+	print_push_status(dest, remote_refs);
 
 	if (!args.dry_run && remote) {
 		for (ref = remote_refs; ref; ref = ref->next)
@@ -443,6 +480,8 @@ static int do_send_pack(int in, int out, struct remote *remote, const char *dest
 
 	if (!new_refs)
 		fprintf(stderr, "Everything up-to-date\n");
+	if (ret < 0)
+		return ret;
 	for (ref = remote_refs; ref; ref = ref->next) {
 		switch (ref->status) {
 		case REF_STATUS_NONE:
diff --git a/cache.h b/cache.h
index 2768342..ba9178f 100644
--- a/cache.h
+++ b/cache.h
@@ -510,7 +510,9 @@ struct ref {
 		REF_STATUS_REJECT_NONFASTFORWARD,
 		REF_STATUS_REJECT_NODELETE,
 		REF_STATUS_UPTODATE,
+		REF_STATUS_REMOTE_REJECT,
 	} status;
+	char *error;
 	struct ref *peer_ref; /* when renaming */
 	char name[FLEX_ARRAY]; /* more */
 };
diff --git a/t/t5406-remote-rejects.sh b/t/t5406-remote-rejects.sh
new file mode 100755
index 0000000..46b2cb4
--- /dev/null
+++ b/t/t5406-remote-rejects.sh
@@ -0,0 +1,24 @@
+#!/bin/sh
+
+test_description='remote push rejects are reported by client'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	mkdir .git/hooks &&
+	(echo "#!/bin/sh" ; echo "exit 1") >.git/hooks/update &&
+	chmod +x .git/hooks/update &&
+	echo 1 >file &&
+	git add file &&
+	git commit -m 1 &&
+	git clone . child &&
+	cd child &&
+	echo 2 >file &&
+	git commit -a -m 2
+'
+
+test_expect_success 'push reports error' '! git push 2>stderr'
+
+test_expect_success 'individual ref reports error' 'grep rejected stderr'
+
+test_done
-- 
1.5.3.5.1795.gf2a4e-dirty
