From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] more terse push output
Date: Mon, 5 Nov 2007 00:11:15 -0500
Message-ID: <20071105051114.GA13144@sigill.intra.peff.net>
References: <20071105050517.GA6244@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 05 06:11:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IouFI-0002Kp-3x
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 06:11:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234AbXKEFLS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 00:11:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751061AbXKEFLS
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 00:11:18 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4994 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751112AbXKEFLR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 00:11:17 -0500
Received: (qmail 21077 invoked by uid 111); 5 Nov 2007 05:11:16 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 05 Nov 2007 00:11:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Nov 2007 00:11:15 -0500
Content-Disposition: inline
In-Reply-To: <20071105050517.GA6244@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63484>

This changes the output of send-pack to match the new,
more terse fetch output. It looks like this:

To git://host.tld/path/to/repo
 + f3325dc...3b91d1c hasforce -> mirror/hasforce (forced update)
   f3325dc..bb022dc  master -> mirror/master
 ! [rejected]        needsforce -> mirror/needsforce (non-fast forward)
 * [new branch]      newbranch -> mirror/newbranch
 * [new tag]         v1.0 -> v1.0

instead of:

updating 'refs/heads/mirror/hasforce' using 'refs/heads/hasforce'
  from f3325dca9c4a34d74012c0e159254f454930cec7
  to   3b91d1c310ca9d7b547b85466dd876e143498304
updating 'refs/heads/mirror/master' using 'refs/heads/master'
  from f3325dca9c4a34d74012c0e159254f454930cec7
  to   bb022dc363d5c2aa9aa3026beb9706d44fbe1328
error: remote 'refs/heads/mirror/needsforce' is not an ancestor of
 local  'refs/heads/needsforce'.
 Maybe you are not up-to-date and need to pull first?
updating 'refs/heads/mirror/newbranch' using 'refs/heads/newbranch'
  from 0000000000000000000000000000000000000000
  to   3b91d1c310ca9d7b547b85466dd876e143498304
updating 'refs/tags/v1.0'
  from 0000000000000000000000000000000000000000
  to   bb022dc363d5c2aa9aa3026beb9706d44fbe1328

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin-send-pack.c |   81 ++++++++++++++++++++++++++++++++++++++++-----------
 1 files changed, 64 insertions(+), 17 deletions(-)

diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index 947c42b..d74cc3c 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -206,7 +206,18 @@ static void update_tracking_ref(struct remote *remote, struct ref *ref)
 	}
 }
 
-static int do_send_pack(int in, int out, struct remote *remote, int nr_refspec, const char **refspec)
+static const char *prettify_ref(const char *name)
+{
+	return name + (
+		!prefixcmp(name, "refs/heads/") ? 11 :
+		!prefixcmp(name, "refs/tags/") ? 10 :
+		!prefixcmp(name, "refs/remotes/") ? 13 :
+		0);
+}
+
+#define SUMMARY_WIDTH (2 * DEFAULT_ABBREV + 3)
+
+static int do_send_pack(int in, int out, struct remote *remote, const char *dest, int nr_refspec, const char **refspec)
 {
 	struct ref *ref;
 	int new_refs;
@@ -214,6 +225,7 @@ static int do_send_pack(int in, int out, struct remote *remote, int nr_refspec,
 	int ask_for_status_report = 0;
 	int allow_deleting_refs = 0;
 	int expect_status_report = 0;
+	int shown_dest = 0;
 
 	/* No funny business with the matcher */
 	remote_tail = get_remote_heads(in, &remote_refs, 0, NULL, REF_NORMAL);
@@ -245,21 +257,33 @@ static int do_send_pack(int in, int out, struct remote *remote, int nr_refspec,
 	for (ref = remote_refs; ref; ref = ref->next) {
 		char old_hex[60], *new_hex;
 		int will_delete_ref;
+		const char *pretty_ref;
+		const char *pretty_peer;
 
 		if (!ref->peer_ref)
 			continue;
 
+		if (!shown_dest) {
+			fprintf(stderr, "To %s\n", dest);
+			shown_dest = 1;
+		}
+
+		pretty_ref = prettify_ref(ref->name);
+		pretty_peer = prettify_ref(ref->peer_ref->name);
 
 		will_delete_ref = is_null_sha1(ref->peer_ref->new_sha1);
 		if (will_delete_ref && !allow_deleting_refs) {
-			error("remote does not support deleting refs");
+			fprintf(stderr, " ! %-*s %s (remote does not support deleting refs)\n",
+					SUMMARY_WIDTH, "[rejected]", pretty_ref);
 			ret = -2;
 			continue;
 		}
 		if (!will_delete_ref &&
 		    !hashcmp(ref->old_sha1, ref->peer_ref->new_sha1)) {
 			if (args.verbose)
-				fprintf(stderr, "'%s': up-to-date\n", ref->name);
+				fprintf(stderr, " = %-*s %s -> %s\n",
+					SUMMARY_WIDTH, "[up to date]",
+					pretty_peer, pretty_ref);
 			continue;
 		}
 
@@ -296,12 +320,9 @@ static int do_send_pack(int in, int out, struct remote *remote, int nr_refspec,
 				 * commits at the remote end and likely
 				 * we were not up to date to begin with.
 				 */
-				error("remote '%s' is not an ancestor of\n"
-				      " local  '%s'.\n"
-				      " Maybe you are not up-to-date and "
-				      "need to pull first?",
-				      ref->name,
-				      ref->peer_ref->name);
+				fprintf(stderr, " ! %-*s %s -> %s (non-fast forward)\n",
+						SUMMARY_WIDTH, "[rejected]",
+						pretty_peer, pretty_ref);
 				ret = -2;
 				continue;
 			}
@@ -325,14 +346,40 @@ static int do_send_pack(int in, int out, struct remote *remote, int nr_refspec,
 					old_hex, new_hex, ref->name);
 		}
 		if (will_delete_ref)
-			fprintf(stderr, "deleting '%s'\n", ref->name);
+			fprintf(stderr, " - %-*s %s\n",
+				SUMMARY_WIDTH, "[deleting]",
+				pretty_ref);
+		else if (is_null_sha1(ref->old_sha1)) {
+			const char *msg;
+
+			if (!prefixcmp(ref->name, "refs/tags/"))
+				msg = "[new tag]";
+			else
+				msg = "[new branch]";
+			fprintf(stderr, " * %-*s %s -> %s\n",
+				SUMMARY_WIDTH, msg,
+				pretty_peer, pretty_ref);
+		}
 		else {
-			fprintf(stderr, "updating '%s'", ref->name);
-			if (strcmp(ref->name, ref->peer_ref->name))
-				fprintf(stderr, " using '%s'",
-					ref->peer_ref->name);
-			fprintf(stderr, "\n  from %s\n  to   %s\n",
-				old_hex, new_hex);
+			char quickref[83];
+			char type = ' ';
+			const char *msg = "";
+
+			strcpy(quickref, find_unique_abbrev(ref->old_sha1, DEFAULT_ABBREV));
+			if (ref_newer(ref->peer_ref->new_sha1, ref->old_sha1))
+				strcat(quickref, "..");
+			else {
+				strcat(quickref, "...");
+				type = '+';
+				msg = " (forced update)";
+			}
+			strcat(quickref, find_unique_abbrev(ref->new_sha1, DEFAULT_ABBREV));
+
+			fprintf(stderr, " %c %-*s %s -> %s%s\n",
+				type,
+				SUMMARY_WIDTH, quickref,
+				pretty_peer, pretty_ref,
+				msg);
 		}
 	}
 
@@ -460,7 +507,7 @@ int send_pack(struct send_pack_args *my_args,
 	verify_remote_names(nr_heads, heads);
 
 	conn = git_connect(fd, dest, args.receivepack, args.verbose ? CONNECT_VERBOSE : 0);
-	ret = do_send_pack(fd[0], fd[1], remote, nr_heads, heads);
+	ret = do_send_pack(fd[0], fd[1], remote, dest, nr_heads, heads);
 	close(fd[0]);
 	close(fd[1]);
 	ret |= finish_connect(conn);
-- 
1.5.3.5.1530.g7353
