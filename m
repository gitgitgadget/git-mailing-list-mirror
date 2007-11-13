From: Jeff King <peff@peff.net>
Subject: [PATCH/RFC 3/3] send-pack: assign remote errors to each ref
Date: Tue, 13 Nov 2007 05:29:00 -0500
Message-ID: <20071113102900.GC2905@sigill.intra.peff.net>
References: <20071113102500.GA2767@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 13 11:29:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Irt1E-0007HU-Su
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 11:29:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751676AbXKMK3F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 05:29:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751697AbXKMK3E
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 05:29:04 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3694 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751620AbXKMK3B (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 05:29:01 -0500
Received: (qmail 19357 invoked by uid 111); 13 Nov 2007 10:29:00 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 13 Nov 2007 05:29:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Nov 2007 05:29:00 -0500
Content-Disposition: inline
In-Reply-To: <20071113102500.GA2767@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64786>

This lets us show remote errors (e.g., a denied hook) along
with the usual push output. There are two drawbacks to this
change:

  1. cross-referencing the incoming status with the ref list
     is worst case O(n^2) (where n = number of refs); this
     can be fixed with a smarter implementation

  2. the status parsing is not foolproof. We get a line like

         ng refs/heads/master arbitrary msg

     which cannot be parsed unambiguously in the face of
     refnames with spaces. We do a prefix-match so that
     you will only run into problems if you have two refs,
     one of which is a prefix match of the other, and the
     longer having a space right after the prefix.
---
 builtin-send-pack.c |   44 +++++++++++++++++++++++++++++++++++++-------
 cache.h             |    2 ++
 2 files changed, 39 insertions(+), 7 deletions(-)

diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index 2805c92..a2307fa 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -146,14 +146,34 @@ static void get_local_heads(void)
 	for_each_ref(one_local_ref, NULL);
 }
 
-static int receive_status(int in)
+static void set_ref_error(struct ref *refs, const char *line) {
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
+		return;
+	}
+}
+
+/* a return value of -1 indicates that an error occurred,
+ * but we were able to set individual ref errors. A return
+ * value of -2 means we couldn't even get that far. */
+static int receive_status(int in, struct ref *refs)
 {
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
@@ -171,7 +191,7 @@ static int receive_status(int in)
 		}
 		if (!memcmp(line, "ok", 2))
 			continue;
-		fputs(line, stderr);
+		set_ref_error(refs, line + 3);
 		ret = -1;
 	}
 	return ret;
@@ -258,6 +278,12 @@ static void print_push_status(const char *dest, struct ref *refs)
 		case REF_STATUS_NONFF:
 			print_ref_status('!', "[rejected]", ref, ref->peer_ref, "non-fast forward");
 			break;
+		case REF_STATUS_REMOTE_REJECT:
+			if (ref->deletion)
+				print_ref_status('!', "[remote rejected]", ref, NULL, ref->error);
+			else
+				print_ref_status('!', "[remote rejected]", ref, ref->peer_ref, ref->error);
+			break;
 		case REF_STATUS_OK:
 			if (ref->deletion)
 				print_ref_status('-', "[deleted]", ref, NULL, NULL);
@@ -296,6 +322,7 @@ static int do_send_pack(int in, int out, struct remote *remote, const char *dest
 	int ask_for_status_report = 0;
 	int allow_deleting_refs = 0;
 	int expect_status_report = 0;
+	int ret;
 
 	/* No funny business with the matcher */
 	remote_tail = get_remote_heads(in, &remote_refs, 0, NULL, REF_NORMAL);
@@ -400,12 +427,15 @@ static int do_send_pack(int in, int out, struct remote *remote, const char *dest
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
@@ -414,7 +444,7 @@ static int do_send_pack(int in, int out, struct remote *remote, const char *dest
 
 	if (!new_refs)
 		fprintf(stderr, "Everything up-to-date\n");
-	return 0;
+	return ret;
 }
 
 static void verify_remote_names(int nr_heads, const char **heads)
diff --git a/cache.h b/cache.h
index ca5d96d..082e03b 100644
--- a/cache.h
+++ b/cache.h
@@ -509,7 +509,9 @@ struct ref {
 		REF_STATUS_NONFF,
 		REF_STATUS_NODELETE,
 		REF_STATUS_UPTODATE,
+		REF_STATUS_REMOTE_REJECT,
 	} status;
+	char *error;
 	struct ref *peer_ref; /* when renaming */
 	char name[FLEX_ARRAY]; /* more */
 };
-- 
1.5.3.5.1704.g24d42-dirty
