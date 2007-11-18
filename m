From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] send-pack: tighten remote error reporting
Date: Sun, 18 Nov 2007 02:16:52 -0500
Message-ID: <20071118071651.GB18467@sigill.intra.peff.net>
References: <20071118055804.GA19313@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 18 08:17:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IteP2-00018I-Lh
	for gcvg-git-2@gmane.org; Sun, 18 Nov 2007 08:17:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751343AbXKRHQ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2007 02:16:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbXKRHQ4
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Nov 2007 02:16:56 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1830 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751232AbXKRHQz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2007 02:16:55 -0500
Received: (qmail 8675 invoked by uid 111); 18 Nov 2007 07:16:54 -0000
Received: from ppp-216-106-96-70.storm.ca (HELO sigill.intra.peff.net) (216.106.96.70)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 18 Nov 2007 02:16:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 18 Nov 2007 02:16:52 -0500
Content-Disposition: inline
In-Reply-To: <20071118055804.GA19313@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65345>

Previously, we set all ref pushes to 'OK', and then marked
them as errors if the remote reported so. This has the
problem that if the remote dies or fails to report a ref, we
just assume it was OK.

Instead, we use a new non-OK state to indicate that we are
expecting status (if the remote doesn't support the
report-status feature, we fall back on the old behavior).
Thus we can flag refs for which we expected a status, but
got none (conversely, we now also print a warning for refs
for which we get a status, but weren't expecting one).

This also allows us to simplify the receive_status exit
code, since each ref is individually marked with failure
until we get a success response. We can just print the usual
status table, so the user still gets a sense of what we were
trying to do when the failure happened.

Signed-off-by: Jeff King <peff@peff.net>
---
This is a lot more robust, and I think the code is easier to follow. The
ref->error member is now ref->remote_status, which is hopefully a bit
more obvious as to when it is set.

The ref matching is also slightly more micro-optimized, Junio. :)

 builtin-send-pack.c |   94 ++++++++++++++++++++++++++++-----------------------
 cache.h             |    3 +-
 2 files changed, 54 insertions(+), 43 deletions(-)

diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index 5fadd0b..349e02f 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -146,60 +146,67 @@ static void get_local_heads(void)
 	for_each_ref(one_local_ref, NULL);
 }
 
-static struct ref *set_ref_error(struct ref *refs, const char *line)
-{
-	struct ref *ref;
-
-	for (ref = refs; ref; ref = ref->next) {
-		const char *msg;
-		if (prefixcmp(line, ref->name))
-			continue;
-		msg = line + strlen(ref->name);
-		if (*msg++ != ' ')
-			continue;
-		ref->status = REF_STATUS_REMOTE_REJECT;
-		ref->error = xstrdup(msg);
-		ref->error[strlen(ref->error)-1] = '\0';
-		return ref;
-	}
-	return NULL;
-}
-
-/* a return value of -1 indicates that an error occurred,
- * but we were able to set individual ref errors. A return
- * value of -2 means we couldn't even get that far. */
 static int receive_status(int in, struct ref *refs)
 {
 	struct ref *hint;
 	char line[1000];
 	int ret = 0;
 	int len = packet_read_line(in, line, sizeof(line));
-	if (len < 10 || memcmp(line, "unpack ", 7)) {
-		fprintf(stderr, "did not receive status back\n");
-		return -2;
-	}
+	if (len < 10 || memcmp(line, "unpack ", 7))
+		return error("did not receive remote status");
 	if (memcmp(line, "unpack ok\n", 10)) {
-		fputs(line, stderr);
+		char *p = line + strlen(line) - 1;
+		if (*p == '\n')
+			*p = '\0';
+		error("unpack failed: %s", line + 7);
 		ret = -1;
 	}
 	hint = NULL;
 	while (1) {
+		char *refname;
+		char *msg;
 		len = packet_read_line(in, line, sizeof(line));
 		if (!len)
 			break;
 		if (len < 3 ||
-		    (memcmp(line, "ok", 2) && memcmp(line, "ng", 2))) {
+		    (memcmp(line, "ok ", 3) && memcmp(line, "ng ", 3))) {
 			fprintf(stderr, "protocol error: %s\n", line);
 			ret = -1;
 			break;
 		}
-		if (!memcmp(line, "ok", 2))
-			continue;
+
+		line[strlen(line)-1] = '\0';
+		refname = line + 3;
+		msg = strchr(refname, ' ');
+		if (msg)
+			*msg++ = '\0';
+
+		/* first try searching at our hint, falling back to all refs */
 		if (hint)
-			hint = set_ref_error(hint, line + 3);
+			hint = find_ref_by_name(hint, refname);
 		if (!hint)
-			hint = set_ref_error(refs, line + 3);
-		ret = -1;
+			hint = find_ref_by_name(refs, refname);
+		if (!hint) {
+			warning("remote reported status on unknown ref: %s",
+					refname);
+			continue;
+		}
+		if (hint->status != REF_STATUS_EXPECTING_REPORT) {
+			warning("remote reported status on unexpected ref: %s",
+					refname);
+			continue;
+		}
+
+		if (line[0] == 'o' && line[1] == 'k')
+			hint->status = REF_STATUS_OK;
+		else {
+			hint->status = REF_STATUS_REMOTE_REJECT;
+			ret = -1;
+		}
+		if (msg)
+			hint->remote_status = xstrdup(msg);
+		/* start our next search from the next ref */
+		hint = hint->next;
 	}
 	return ret;
 }
@@ -324,10 +331,14 @@ static void print_push_status(const char *dest, struct ref *refs)
 					"non-fast forward");
 			break;
 		case REF_STATUS_REMOTE_REJECT:
-			if (ref->deletion)
-				print_ref_status('!', "[remote rejected]", ref, NULL, ref->error);
-			else
-				print_ref_status('!', "[remote rejected]", ref, ref->peer_ref, ref->error);
+			print_ref_status('!', "[remote rejected]", ref,
+					ref->deletion ? ref->peer_ref : NULL,
+					ref->remote_status);
+			break;
+		case REF_STATUS_EXPECTING_REPORT:
+			print_ref_status('!', "[remote failure]", ref,
+					ref->deletion ? ref->peer_ref : NULL,
+					"remote failed to report status");
 			break;
 		case REF_STATUS_OK:
 			print_ok_ref_status(ref);
@@ -434,7 +445,6 @@ static int do_send_pack(int in, int out, struct remote *remote, const char *dest
 		hashcpy(ref->new_sha1, new_sha1);
 		if (!ref->deletion)
 			new_refs++;
-		ref->status = REF_STATUS_OK;
 
 		if (!args.dry_run) {
 			char *old_hex = sha1_to_hex(ref->old_sha1);
@@ -451,6 +461,9 @@ static int do_send_pack(int in, int out, struct remote *remote, const char *dest
 				packet_write(out, "%s %s %s",
 					old_hex, new_hex, ref->name);
 		}
+		ref->status = expect_status_report ?
+			REF_STATUS_EXPECTING_REPORT :
+			REF_STATUS_OK;
 	}
 
 	packet_flush(out);
@@ -462,11 +475,8 @@ static int do_send_pack(int in, int out, struct remote *remote, const char *dest
 	}
 	close(out);
 
-	if (expect_status_report) {
+	if (expect_status_report)
 		ret = receive_status(in, remote_refs);
-		if (ret == -2)
-			return -1;
-	}
 	else
 		ret = 0;
 
diff --git a/cache.h b/cache.h
index 1f3f113..0dff61a 100644
--- a/cache.h
+++ b/cache.h
@@ -511,8 +511,9 @@ struct ref {
 		REF_STATUS_REJECT_NODELETE,
 		REF_STATUS_UPTODATE,
 		REF_STATUS_REMOTE_REJECT,
+		REF_STATUS_EXPECTING_REPORT,
 	} status;
-	char *error;
+	char *remote_status;
 	struct ref *peer_ref; /* when renaming */
 	char name[FLEX_ARRAY]; /* more */
 };
-- 
1.5.3.5.1817.g37c1a-dirty
