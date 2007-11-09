From: Andy Whitcroft <apw@shadowen.org>
Subject: [PATCH 1/4] Teach send-pack a mirror mode
Date: Fri, 9 Nov 2007 23:32:10 -0000
Message-ID: <1194651130.0@pinky>
References: <20071109233041.GC301@shadowen.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 10 00:32:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqdKo-00038a-Ll
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 00:32:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756958AbXKIXcB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 18:32:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755966AbXKIXcB
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 18:32:01 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:3506 "EHLO
	hellhawk.shadowen.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751420AbXKIXcA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 18:32:00 -0500
Received: from localhost ([127.0.0.1] helo=pinky)
	by hellhawk.shadowen.org with esmtp (Exim 4.63)
	(envelope-from <apw@shadowen.org>)
	id 1IqdKQ-0006cU-Mj
	for git@vger.kernel.org; Fri, 09 Nov 2007 23:31:58 +0000
InReply-To: <20071109233041.GC301@shadowen.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64278>


Existing "git push --all" is almost perfect for backing up to
another repository, except that "--all" only means "all
branches" in modern git, and it does not delete old branches and
tags that exist at the back-up repository that you have removed
from your local repository.

This teaches "git-send-pack" a new "--mirror" option.  The
difference from the "--all" option are that (1) it sends all
refs, not just branches, and (2) it deletes old refs you no
longer have on the local side from the remote side.

Original patch by Junio C Hamano.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
 builtin-send-pack.c |   46 ++++++++++++++++++++++++++++++++++------------
 http-push.c         |    4 ++--
 remote.c            |   15 ++++++++++-----
 remote.h            |    7 +++++++
 send-pack.h         |    1 +
 5 files changed, 54 insertions(+), 19 deletions(-)
diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index 5a0f5c6..d42164e 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -8,7 +8,7 @@
 #include "send-pack.h"
 
 static const char send_pack_usage[] =
-"git-send-pack [--all] [--dry-run] [--force] [--receive-pack=<git-receive-pack>] [--verbose] [--thin] [<host>:]<directory> [<ref>...]\n"
+"git-send-pack [--all | --mirror] [--dry-run] [--force] [--receive-pack=<git-receive-pack>] [--verbose] [--thin] [<host>:]<directory> [<ref>...]\n"
 "  --all and explicit <ref> specification are mutually exclusive.";
 
 static struct send_pack_args args = {
@@ -227,6 +227,12 @@ static int do_send_pack(int in, int out, struct remote *remote, const char *dest
 	int allow_deleting_refs = 0;
 	int expect_status_report = 0;
 	int shown_dest = 0;
+	int flags = MATCH_REFS_NONE;
+
+	if (args.send_all)
+		flags |= MATCH_REFS_ALL;
+	if (args.send_mirror)
+		flags |= MATCH_REFS_MIRROR;
 
 	/* No funny business with the matcher */
 	remote_tail = get_remote_heads(in, &remote_refs, 0, NULL, REF_NORMAL);
@@ -242,7 +248,7 @@ static int do_send_pack(int in, int out, struct remote *remote, const char *dest
 	if (!remote_tail)
 		remote_tail = &remote_refs;
 	if (match_refs(local_refs, remote_refs, &remote_tail,
-		       nr_refspec, refspec, args.send_all))
+					       nr_refspec, refspec, flags))
 		return -1;
 
 	if (!remote_refs) {
@@ -259,20 +265,28 @@ static int do_send_pack(int in, int out, struct remote *remote, const char *dest
 		char old_hex[60], *new_hex;
 		int will_delete_ref;
 		const char *pretty_ref;
-		const char *pretty_peer;
+		const char *pretty_peer = NULL; /* only used when not deleting */
+		const unsigned char *new_sha1;
 
-		if (!ref->peer_ref)
-			continue;
+		if (!ref->peer_ref) {
+			if (!args.send_mirror)
+				continue;
+			new_sha1 = null_sha1;
+		}
+		else
+			new_sha1 = ref->peer_ref->new_sha1;
 
 		if (!shown_dest) {
 			fprintf(stderr, "To %s\n", dest);
 			shown_dest = 1;
 		}
 
+		will_delete_ref = is_null_sha1(new_sha1);
+
 		pretty_ref = prettify_ref(ref->name);
-		pretty_peer = prettify_ref(ref->peer_ref->name);
+		if (!will_delete_ref)
+			pretty_peer = prettify_ref(ref->peer_ref->name);
 
-		will_delete_ref = is_null_sha1(ref->peer_ref->new_sha1);
 		if (will_delete_ref && !allow_deleting_refs) {
 			fprintf(stderr, " ! %-*s %s (remote does not support deleting refs)\n",
 					SUMMARY_WIDTH, "[rejected]", pretty_ref);
@@ -280,7 +294,7 @@ static int do_send_pack(int in, int out, struct remote *remote, const char *dest
 			continue;
 		}
 		if (!will_delete_ref &&
-		    !hashcmp(ref->old_sha1, ref->peer_ref->new_sha1)) {
+		    !hashcmp(ref->old_sha1, new_sha1)) {
 			if (args.verbose)
 				fprintf(stderr, " = %-*s %s -> %s\n",
 					SUMMARY_WIDTH, "[up to date]",
@@ -312,8 +326,7 @@ static int do_send_pack(int in, int out, struct remote *remote, const char *dest
 		    !is_null_sha1(ref->old_sha1) &&
 		    !ref->force) {
 			if (!has_sha1_file(ref->old_sha1) ||
-			    !ref_newer(ref->peer_ref->new_sha1,
-				       ref->old_sha1)) {
+			    !ref_newer(new_sha1, ref->old_sha1)) {
 				/* We do not have the remote ref, or
 				 * we know that the remote ref is not
 				 * an ancestor of what we are trying to
@@ -328,7 +341,7 @@ static int do_send_pack(int in, int out, struct remote *remote, const char *dest
 				continue;
 			}
 		}
-		hashcpy(ref->new_sha1, ref->peer_ref->new_sha1);
+		hashcpy(ref->new_sha1, new_sha1);
 		if (!will_delete_ref)
 			new_refs++;
 		strcpy(old_hex, sha1_to_hex(ref->old_sha1));
@@ -459,6 +472,10 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 				args.dry_run = 1;
 				continue;
 			}
+			if (!strcmp(arg, "--mirror")) {
+				args.send_mirror = 1;
+				continue;
+			}
 			if (!strcmp(arg, "--force")) {
 				args.force_update = 1;
 				continue;
@@ -483,7 +500,12 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 	}
 	if (!dest)
 		usage(send_pack_usage);
-	if (heads && args.send_all)
+	/*
+	 * --all and --mirror are incompatible; neither makes sense
+	 * with any refspecs.
+	 */
+	if ((heads && (args.send_all || args.send_mirror)) ||
+					(args.send_all && args.send_mirror))
 		usage(send_pack_usage);
 
 	if (remote_name) {
diff --git a/http-push.c b/http-push.c
index 99328f5..66b81f1 100644
--- a/http-push.c
+++ b/http-push.c
@@ -78,7 +78,7 @@ static struct curl_slist *no_pragma_header;
 static struct curl_slist *default_headers;
 
 static int push_verbosely;
-static int push_all;
+static int push_all = MATCH_REFS_NONE;
 static int force_all;
 static int dry_run;
 
@@ -2300,7 +2300,7 @@ int main(int argc, char **argv)
 
 		if (*arg == '-') {
 			if (!strcmp(arg, "--all")) {
-				push_all = 1;
+				push_all = MATCH_REFS_ALL;
 				continue;
 			}
 			if (!strcmp(arg, "--force")) {
diff --git a/remote.c b/remote.c
index 59defdb..09b7aad 100644
--- a/remote.c
+++ b/remote.c
@@ -722,10 +722,12 @@ static const struct refspec *check_pattern_match(const struct refspec *rs,
  * without thinking.
  */
 int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
-	       int nr_refspec, const char **refspec, int all)
+	       int nr_refspec, const char **refspec, int flags)
 {
 	struct refspec *rs =
 		parse_ref_spec(nr_refspec, (const char **) refspec);
+	int send_all = flags & MATCH_REFS_ALL;
+	int send_mirror = flags & MATCH_REFS_MIRROR;
 
 	if (match_explicit_refs(src, dst, dst_tail, rs, nr_refspec))
 		return -1;
@@ -742,7 +744,7 @@ int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
 			if (!pat)
 				continue;
 		}
-		else if (prefixcmp(src->name, "refs/heads/"))
+		else if (!send_mirror && prefixcmp(src->name, "refs/heads/"))
 			/*
 			 * "matching refs"; traditionally we pushed everything
 			 * including refs outside refs/heads/ hierarchy, but
@@ -763,10 +765,13 @@ int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
 		if (dst_peer && dst_peer->peer_ref)
 			/* We're already sending something to this ref. */
 			goto free_name;
-		if (!dst_peer && !nr_refspec && !all)
-			/* Remote doesn't have it, and we have no
+
+		if (!dst_peer && !nr_refspec && !(send_all || send_mirror))
+			/*
+			 * Remote doesn't have it, and we have no
 			 * explicit pattern, and we don't have
-			 * --all. */
+			 * --all nor --mirror.
+			 */
 			goto free_name;
 		if (!dst_peer) {
 			/* Create a new one and link it */
diff --git a/remote.h b/remote.h
index 6a4c7a0..b10036c 100644
--- a/remote.h
+++ b/remote.h
@@ -102,4 +102,11 @@ struct branch *branch_get(const char *name);
 int branch_has_merge_config(struct branch *branch);
 int branch_merge_matches(struct branch *, int n, const char *);
 
+/* Flags to match_refs. */
+enum match_refs_flags {
+	MATCH_REFS_NONE		= 0,
+	MATCH_REFS_ALL 		= (1 << 0),
+	MATCH_REFS_MIRROR	= (1 << 1),
+};
+
 #endif
diff --git a/send-pack.h b/send-pack.h
index 7a24f71..8ff1dc3 100644
--- a/send-pack.h
+++ b/send-pack.h
@@ -5,6 +5,7 @@ struct send_pack_args {
 	const char *receivepack;
 	unsigned verbose:1,
 		send_all:1,
+		send_mirror:1,
 		force_update:1,
 		use_thin_pack:1,
 		dry_run:1;
