From: Jeff King <peff@peff.net>
Subject: [PATCH/RFC 1/3] send-pack: track errors for each ref
Date: Tue, 13 Nov 2007 05:27:09 -0500
Message-ID: <20071113102709.GA2905@sigill.intra.peff.net>
References: <20071113102500.GA2767@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 13 11:27:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrszR-0006kw-Qa
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 11:27:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752009AbXKMK1O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 05:27:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751929AbXKMK1N
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 05:27:13 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3678 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751354AbXKMK1M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 05:27:12 -0500
Received: (qmail 19309 invoked by uid 111); 13 Nov 2007 10:27:10 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 13 Nov 2007 05:27:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Nov 2007 05:27:09 -0500
Content-Disposition: inline
In-Reply-To: <20071113102500.GA2767@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64784>

Instead of keeping the 'ret' variable, we instead have a
status flag for each ref that tracks what happened to it.
We then print the ref status after all of the refs have
been examined.

This paves the way for three improvements:
  - updating tracking refs only for non-error refs
  - incorporating remote rejection into the printed status
  - printing errors in a different order than we processed
    (e.g., consolidating non-ff errors near the end with
    a special message)
---
 builtin-send-pack.c |  201 ++++++++++++++++++++++++++++-----------------------
 cache.h             |   13 +++-
 2 files changed, 121 insertions(+), 93 deletions(-)

diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index 5a0f5c6..3ac2615 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -207,8 +207,9 @@ static void update_tracking_ref(struct remote *remote, struct ref *ref)
 	}
 }
 
-static const char *prettify_ref(const char *name)
+static const char *prettify_ref(const struct ref *ref)
 {
+	const char *name = ref->name;
 	return name + (
 		!prefixcmp(name, "refs/heads/") ? 11 :
 		!prefixcmp(name, "refs/tags/") ? 10 :
@@ -218,15 +219,90 @@ static const char *prettify_ref(const char *name)
 
 #define SUMMARY_WIDTH (2 * DEFAULT_ABBREV + 3)
 
+static void print_ref_status(char flag, const char *summary, struct ref *to, struct ref *from, const char *msg)
+{
+	fprintf(stderr, " %c %-*s ", flag, SUMMARY_WIDTH, summary);
+	if (from)
+		fprintf(stderr, "%s -> %s", prettify_ref(from), prettify_ref(to));
+	else
+		fputs(prettify_ref(to), stderr);
+	if (msg) {
+		fputs(" (", stderr);
+		fputs(msg, stderr);
+		fputc(')', stderr);
+	}
+	fputc('\n', stderr);
+}
+
+
+static void print_push_status(const char *dest, struct ref *refs)
+{
+	struct ref *ref;
+	int shown_dest = 0;
+
+	for (ref = refs; ref; ref = ref->next) {
+		if (!ref->status)
+			continue;
+		if (ref->status == REF_STATUS_UPTODATE && !args.verbose)
+			continue;
+
+		if (!shown_dest) {
+			fprintf(stderr, "To %s\n", dest);
+			shown_dest = 1;
+		}
+
+		switch(ref->status) {
+		case REF_STATUS_NONE:
+			print_ref_status('X', "[no match]", ref, NULL, NULL);
+			break;
+		case REF_STATUS_NODELETE:
+			print_ref_status('!', "[rejected]", ref, NULL,
+					"remote does not support deleting refs");
+			break;
+		case REF_STATUS_UPTODATE:
+			print_ref_status('=', "[up to date]", ref, ref->peer_ref, NULL);
+			break;
+		case REF_STATUS_NONFF:
+			print_ref_status('!', "[rejected]", ref, ref->peer_ref, "non-fast forward");
+			break;
+		case REF_STATUS_OK:
+			if (ref->deletion)
+				print_ref_status('-', "[deleted]", ref, NULL, NULL);
+			else if (is_null_sha1(ref->old_sha1))
+				print_ref_status('*',
+						(prefixcmp(ref->name, "refs/tags/") ?
+						  "[new branch]" : "[new tag]"),
+						ref, ref->peer_ref, NULL);
+			else {
+				char quickref[83];
+				char type = ' ';
+				const char *msg = NULL;
+				const char *old_abb;
+
+				old_abb = find_unique_abbrev(ref->old_sha1, DEFAULT_ABBREV);
+				strcpy(quickref, old_abb ? old_abb : sha1_to_hex(ref->old_sha1));
+				if (ref->nonff) {
+					strcat(quickref, "...");
+					type = '+';
+					msg = " (forced update)";
+				}
+				else
+					strcat(quickref, "..");
+				strcat(quickref, find_unique_abbrev(ref->new_sha1, DEFAULT_ABBREV));
+
+				print_ref_status(type, quickref, ref, ref->peer_ref, msg);
+			}
+		}
+	}
+}
+
 static int do_send_pack(int in, int out, struct remote *remote, const char *dest, int nr_refspec, const char **refspec)
 {
 	struct ref *ref;
 	int new_refs;
-	int ret = 0;
 	int ask_for_status_report = 0;
 	int allow_deleting_refs = 0;
 	int expect_status_report = 0;
-	int shown_dest = 0;
 
 	/* No funny business with the matcher */
 	remote_tail = get_remote_heads(in, &remote_refs, 0, NULL, REF_NORMAL);
@@ -256,35 +332,17 @@ static int do_send_pack(int in, int out, struct remote *remote, const char *dest
 	 */
 	new_refs = 0;
 	for (ref = remote_refs; ref; ref = ref->next) {
-		char old_hex[60], *new_hex;
-		int will_delete_ref;
-		const char *pretty_ref;
-		const char *pretty_peer;
-
 		if (!ref->peer_ref)
 			continue;
 
-		if (!shown_dest) {
-			fprintf(stderr, "To %s\n", dest);
-			shown_dest = 1;
-		}
-
-		pretty_ref = prettify_ref(ref->name);
-		pretty_peer = prettify_ref(ref->peer_ref->name);
-
-		will_delete_ref = is_null_sha1(ref->peer_ref->new_sha1);
-		if (will_delete_ref && !allow_deleting_refs) {
-			fprintf(stderr, " ! %-*s %s (remote does not support deleting refs)\n",
-					SUMMARY_WIDTH, "[rejected]", pretty_ref);
-			ret = -2;
+		ref->deletion = is_null_sha1(ref->peer_ref->new_sha1);
+		if (ref->deletion && !allow_deleting_refs) {
+			ref->status = REF_STATUS_NODELETE;
 			continue;
 		}
-		if (!will_delete_ref &&
+		if (!ref->deletion &&
 		    !hashcmp(ref->old_sha1, ref->peer_ref->new_sha1)) {
-			if (args.verbose)
-				fprintf(stderr, " = %-*s %s -> %s\n",
-					SUMMARY_WIDTH, "[up to date]",
-					pretty_peer, pretty_ref);
+			ref->status = REF_STATUS_UPTODATE;
 			continue;
 		}
 
@@ -307,34 +365,26 @@ static int do_send_pack(int in, int out, struct remote *remote, const char *dest
 		 *     always allowed.
 		 */
 
-		if (!args.force_update &&
-		    !will_delete_ref &&
+		ref->nonff =
+		    !ref->deletion &&
 		    !is_null_sha1(ref->old_sha1) &&
-		    !ref->force) {
-			if (!has_sha1_file(ref->old_sha1) ||
-			    !ref_newer(ref->peer_ref->new_sha1,
-				       ref->old_sha1)) {
-				/* We do not have the remote ref, or
-				 * we know that the remote ref is not
-				 * an ancestor of what we are trying to
-				 * push.  Either way this can be losing
-				 * commits at the remote end and likely
-				 * we were not up to date to begin with.
-				 */
-				fprintf(stderr, " ! %-*s %s -> %s (non-fast forward)\n",
-						SUMMARY_WIDTH, "[rejected]",
-						pretty_peer, pretty_ref);
-				ret = -2;
-				continue;
-			}
+		    (!has_sha1_file(ref->old_sha1)
+		      || !ref_newer(ref->peer_ref->new_sha1, ref->old_sha1));
+
+		if (ref->nonff && !ref->force && !args.force_update) {
+			ref->status = REF_STATUS_NONFF;
+			continue;
 		}
+
 		hashcpy(ref->new_sha1, ref->peer_ref->new_sha1);
-		if (!will_delete_ref)
+		if (!ref->deletion)
 			new_refs++;
-		strcpy(old_hex, sha1_to_hex(ref->old_sha1));
-		new_hex = sha1_to_hex(ref->new_sha1);
+		ref->status = REF_STATUS_OK;
 
 		if (!args.dry_run) {
+			char *old_hex = sha1_to_hex(ref->old_sha1);
+			char *new_hex = sha1_to_hex(ref->new_sha1);
+
 			if (ask_for_status_report) {
 				packet_write(out, "%s %s %s%c%s",
 					old_hex, new_hex, ref->name, 0,
@@ -346,63 +396,32 @@ static int do_send_pack(int in, int out, struct remote *remote, const char *dest
 				packet_write(out, "%s %s %s",
 					old_hex, new_hex, ref->name);
 		}
-		if (will_delete_ref)
-			fprintf(stderr, " - %-*s %s\n",
-				SUMMARY_WIDTH, "[deleting]",
-				pretty_ref);
-		else if (is_null_sha1(ref->old_sha1)) {
-			const char *msg;
-
-			if (!prefixcmp(ref->name, "refs/tags/"))
-				msg = "[new tag]";
-			else
-				msg = "[new branch]";
-			fprintf(stderr, " * %-*s %s -> %s\n",
-				SUMMARY_WIDTH, msg,
-				pretty_peer, pretty_ref);
-		}
-		else {
-			char quickref[83];
-			char type = ' ';
-			const char *msg = "";
-			const char *old_abb;
-			old_abb = find_unique_abbrev(ref->old_sha1, DEFAULT_ABBREV);
-			strcpy(quickref, old_abb ? old_abb : old_hex);
-			if (ref_newer(ref->peer_ref->new_sha1, ref->old_sha1))
-				strcat(quickref, "..");
-			else {
-				strcat(quickref, "...");
-				type = '+';
-				msg = " (forced update)";
-			}
-			strcat(quickref, find_unique_abbrev(ref->new_sha1, DEFAULT_ABBREV));
-
-			fprintf(stderr, " %c %-*s %s -> %s%s\n",
-				type,
-				SUMMARY_WIDTH, quickref,
-				pretty_peer, pretty_ref,
-				msg);
-		}
 	}
 
 	packet_flush(out);
-	if (new_refs && !args.dry_run)
-		ret = pack_objects(out, remote_refs);
+	if (new_refs && !args.dry_run) {
+		if (pack_objects(out, remote_refs) < 0) {
+			close(out);
+			return -1;
+		}
+	}
 	close(out);
 
+	print_push_status(dest, remote_refs);
+
 	if (expect_status_report) {
 		if (receive_status(in))
-			ret = -4;
+			return -1;
 	}
 
-	if (!args.dry_run && remote && ret == 0) {
+	if (!args.dry_run && remote) {
 		for (ref = remote_refs; ref; ref = ref->next)
 			update_tracking_ref(remote, ref);
 	}
 
-	if (!new_refs && ret == 0)
+	if (!new_refs)
 		fprintf(stderr, "Everything up-to-date\n");
-	return ret;
+	return 0;
 }
 
 static void verify_remote_names(int nr_heads, const char **heads)
diff --git a/cache.h b/cache.h
index 5f40e12..ca5d96d 100644
--- a/cache.h
+++ b/cache.h
@@ -499,8 +499,17 @@ struct ref {
 	struct ref *next;
 	unsigned char old_sha1[20];
 	unsigned char new_sha1[20];
-	unsigned char force;
-	unsigned char merge;
+	unsigned char force : 1;
+	unsigned char merge : 1;
+	unsigned char nonff : 1;
+	unsigned char deletion : 1;
+	enum {
+		REF_STATUS_NONE = 0,
+		REF_STATUS_OK,
+		REF_STATUS_NONFF,
+		REF_STATUS_NODELETE,
+		REF_STATUS_UPTODATE,
+	} status;
 	struct ref *peer_ref; /* when renaming */
 	char name[FLEX_ARRAY]; /* more */
 };
-- 
1.5.3.5.1704.g24d42-dirty
