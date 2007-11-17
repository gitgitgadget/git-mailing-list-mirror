From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] send-pack: track errors for each ref
Date: Sat, 17 Nov 2007 07:54:27 -0500
Message-ID: <20071117125426.GA23186@sigill.intra.peff.net>
References: <20071117125323.GA23125@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Alex Riesen <raa.lkml@gmail.com>,
	Pierre Habouzit <madcoder@debian.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 17 13:54:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItNCC-0003RQ-TQ
	for gcvg-git-2@gmane.org; Sat, 17 Nov 2007 13:54:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849AbXKQMyc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2007 07:54:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750739AbXKQMyc
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Nov 2007 07:54:32 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3865 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750794AbXKQMyb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2007 07:54:31 -0500
Received: (qmail 3880 invoked by uid 111); 17 Nov 2007 12:54:29 -0000
Received: from ppp-216-106-96-70.storm.ca (HELO sigill.intra.peff.net) (216.106.96.70)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sat, 17 Nov 2007 07:54:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 17 Nov 2007 07:54:27 -0500
Content-Disposition: inline
In-Reply-To: <20071117125323.GA23125@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65273>

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

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin-send-pack.c          |  225 +++++++++++++++++++++++++-----------------
 cache.h                      |   13 ++-
 t/t5404-tracking-branches.sh |   14 ++-
 3 files changed, 157 insertions(+), 95 deletions(-)

diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index 418925e..90ca2d3 100644
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
@@ -218,15 +219,105 @@ static const char *prettify_ref(const char *name)
 
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
+static const char *status_abbrev(unsigned char sha1[20])
+{
+	const char *abbrev;
+	abbrev = find_unique_abbrev(sha1, DEFAULT_ABBREV);
+	return abbrev ? abbrev : sha1_to_hex(sha1);
+}
+
+static void print_ok_ref_status(struct ref *ref)
+{
+	if (ref->deletion)
+		print_ref_status('-', "[deleted]", ref, NULL, NULL);
+	else if (is_null_sha1(ref->old_sha1))
+		print_ref_status('*',
+			(!prefixcmp(ref->name, "refs/tags/") ? "[new tag]" :
+			  "[new branch]"),
+			ref, ref->peer_ref, NULL);
+	else {
+		char quickref[83];
+		char type;
+		const char *msg;
+
+		strcpy(quickref, status_abbrev(ref->old_sha1));
+		if (ref->nonfastforward) {
+			strcat(quickref, "...");
+			type = '+';
+			msg = " (forced update)";
+		}
+		else {
+			strcat(quickref, "..");
+			type = ' ';
+			msg = NULL;
+		}
+		strcat(quickref, status_abbrev(ref->new_sha1));
+
+		print_ref_status(type, quickref, ref, ref->peer_ref, msg);
+	}
+}
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
+		case REF_STATUS_REJECT_NODELETE:
+			print_ref_status('!', "[rejected]", ref, NULL,
+					"remote does not support deleting refs");
+			break;
+		case REF_STATUS_UPTODATE:
+			print_ref_status('=', "[up to date]", ref,
+					ref->peer_ref, NULL);
+			break;
+		case REF_STATUS_REJECT_NONFASTFORWARD:
+			print_ref_status('!', "[rejected]", ref, ref->peer_ref,
+					"non-fast forward");
+			break;
+		case REF_STATUS_OK:
+			print_ok_ref_status(ref);
+			break;
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
 	int flags = MATCH_REFS_NONE;
 
 	if (args.send_all)
@@ -262,10 +353,6 @@ static int do_send_pack(int in, int out, struct remote *remote, const char *dest
 	 */
 	new_refs = 0;
 	for (ref = remote_refs; ref; ref = ref->next) {
-		char old_hex[60], *new_hex;
-		int will_delete_ref;
-		const char *pretty_ref;
-		const char *pretty_peer = NULL; /* only used when not deleting */
 		const unsigned char *new_sha1;
 
 		if (!ref->peer_ref) {
@@ -276,29 +363,15 @@ static int do_send_pack(int in, int out, struct remote *remote, const char *dest
 		else
 			new_sha1 = ref->peer_ref->new_sha1;
 
-		if (!shown_dest) {
-			fprintf(stderr, "To %s\n", dest);
-			shown_dest = 1;
-		}
-
-		will_delete_ref = is_null_sha1(new_sha1);
 
-		pretty_ref = prettify_ref(ref->name);
-		if (!will_delete_ref)
-			pretty_peer = prettify_ref(ref->peer_ref->name);
-
-		if (will_delete_ref && !allow_deleting_refs) {
-			fprintf(stderr, " ! %-*s %s (remote does not support deleting refs)\n",
-					SUMMARY_WIDTH, "[rejected]", pretty_ref);
-			ret = -2;
+		ref->deletion = is_null_sha1(new_sha1);
+		if (ref->deletion && !allow_deleting_refs) {
+			ref->status = REF_STATUS_REJECT_NODELETE;
 			continue;
 		}
-		if (!will_delete_ref &&
+		if (!ref->deletion &&
 		    !hashcmp(ref->old_sha1, new_sha1)) {
-			if (args.verbose)
-				fprintf(stderr, " = %-*s %s -> %s\n",
-					SUMMARY_WIDTH, "[up to date]",
-					pretty_peer, pretty_ref);
+			ref->status = REF_STATUS_UPTODATE;
 			continue;
 		}
 
@@ -321,33 +394,26 @@ static int do_send_pack(int in, int out, struct remote *remote, const char *dest
 		 *     always allowed.
 		 */
 
-		if (!args.force_update &&
-		    !will_delete_ref &&
+		ref->nonfastforward =
+		    !ref->deletion &&
 		    !is_null_sha1(ref->old_sha1) &&
-		    !ref->force) {
-			if (!has_sha1_file(ref->old_sha1) ||
-			    !ref_newer(new_sha1, ref->old_sha1)) {
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
+		      || !ref_newer(new_sha1, ref->old_sha1));
+
+		if (ref->nonfastforward && !ref->force && !args.force_update) {
+			ref->status = REF_STATUS_REJECT_NONFASTFORWARD;
+			continue;
 		}
+
 		hashcpy(ref->new_sha1, new_sha1);
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
@@ -359,64 +425,43 @@ static int do_send_pack(int in, int out, struct remote *remote, const char *dest
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
 			if (!is_null_sha1(ref->new_sha1))
 				update_tracking_ref(remote, ref);
 	}
 
-	if (!new_refs && ret == 0)
+	if (!new_refs)
 		fprintf(stderr, "Everything up-to-date\n");
-	return ret;
+	for (ref = remote_refs; ref; ref = ref->next) {
+		switch (ref->status) {
+		case REF_STATUS_NONE:
+		case REF_STATUS_UPTODATE:
+		case REF_STATUS_OK:
+			break;
+		default:
+			return -1;
+		}
+	}
+	return 0;
 }
 
 static void verify_remote_names(int nr_heads, const char **heads)
diff --git a/cache.h b/cache.h
index e9b3ce3..2768342 100644
--- a/cache.h
+++ b/cache.h
@@ -500,8 +500,17 @@ struct ref {
 	struct ref *next;
 	unsigned char old_sha1[20];
 	unsigned char new_sha1[20];
-	unsigned char force;
-	unsigned char merge;
+	unsigned char force : 1;
+	unsigned char merge : 1;
+	unsigned char nonfastforward : 1;
+	unsigned char deletion : 1;
+	enum {
+		REF_STATUS_NONE = 0,
+		REF_STATUS_OK,
+		REF_STATUS_REJECT_NONFASTFORWARD,
+		REF_STATUS_REJECT_NODELETE,
+		REF_STATUS_UPTODATE,
+	} status;
 	struct ref *peer_ref; /* when renaming */
 	char name[FLEX_ARRAY]; /* more */
 };
diff --git a/t/t5404-tracking-branches.sh b/t/t5404-tracking-branches.sh
index 20718d4..799e47e 100755
--- a/t/t5404-tracking-branches.sh
+++ b/t/t5404-tracking-branches.sh
@@ -19,7 +19,7 @@ test_expect_success 'setup' '
 	git commit -a -m b2
 '
 
-test_expect_success 'check tracking branches updated correctly after push' '
+test_expect_success 'prepare pushable branches' '
 	cd aa &&
 	b1=$(git rev-parse origin/b1) &&
 	b2=$(git rev-parse origin/b2) &&
@@ -31,8 +31,16 @@ test_expect_success 'check tracking branches updated correctly after push' '
 	git commit -a -m aa-b2 &&
 	git checkout master &&
 	echo aa-master >>file &&
-	git commit -a -m aa-master &&
-	git push &&
+	git commit -a -m aa-master
+'
+
+test_expect_success 'mixed-success push returns error' '! git push'
+
+test_expect_success 'check tracking branches updated correctly after push' '
+	test "$(git rev-parse origin/master)" = "$(git rev-parse master)"
+'
+
+test_expect_success 'check tracking branches not updated for failed refs' '
 	test "$(git rev-parse origin/b1)" = "$b1" &&
 	test "$(git rev-parse origin/b2)" = "$b2"
 '
-- 
1.5.3.5.1795.gf2a4e-dirty
