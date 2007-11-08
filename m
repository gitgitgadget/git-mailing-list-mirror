From: Andy Whitcroft <apw@shadowen.org>
Subject: [PATCH 1/4] mirror pushing
Date: Thu, 8 Nov 2007 17:00:57 -0000
Message-ID: <1194541257.0@pinky>
References: <20071108165801.GM9736@shadowen.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 08 18:02:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqAlV-0005gQ-Ai
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 18:02:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761587AbXKHRAt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 12:00:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761445AbXKHRAt
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 12:00:49 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:4165 "EHLO
	hellhawk.shadowen.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761579AbXKHRAs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 12:00:48 -0500
Received: from localhost ([127.0.0.1] helo=pinky)
	by hellhawk.shadowen.org with esmtp (Exim 4.50)
	id 1IqAkJ-0003tz-64
	for git@vger.kernel.org; Thu, 08 Nov 2007 17:00:47 +0000
InReply-To: <20071108165801.GM9736@shadowen.org>
Received-SPF: pass
X-SPF-Guess: pass
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64057>


From: Junio C Hamano <gitster@pobox.com>

Existing "git push --all" is almost perfect for backing up to
another repository, except that "--all" only means "all
branches" in modern git, and it does not delete old branches and
tags that exist at the back-up repository that you have removed
from your local repository.

This teaches "git-send-pack" a new "--mirror" option.  The
difference from the "--all" option are that (1) it sends all
refs, not just branches, and (2) it deletes old refs you no
longer have on the local side from the remote side.

[apw@shadowen.org: rebase to next post arguments update]
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
 builtin-send-pack.c |   40 ++++++++++++++++++++++++++++------------
 remote.c            |   15 ++++++++++-----
 send-pack.h         |    1 +
 3 files changed, 39 insertions(+), 17 deletions(-)
diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index 5a0f5c6..d5ead97 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -8,7 +8,7 @@
 #include "send-pack.h"
 
 static const char send_pack_usage[] =
-"git-send-pack [--all] [--dry-run] [--force] [--receive-pack=<git-receive-pack>] [--verbose] [--thin] [<host>:]<directory> [<ref>...]\n"
+"git-send-pack [--all | --mirror] [--dry-run] [--force] [--receive-pack=<git-receive-pack>] [--verbose] [--thin] [<host>:]<directory> [<ref>...]\n"
 "  --all and explicit <ref> specification are mutually exclusive.";
 
 static struct send_pack_args args = {
@@ -242,7 +242,7 @@ static int do_send_pack(int in, int out, struct remote *remote, const char *dest
 	if (!remote_tail)
 		remote_tail = &remote_refs;
 	if (match_refs(local_refs, remote_refs, &remote_tail,
-		       nr_refspec, refspec, args.send_all))
+		       nr_refspec, refspec, args.send_all | (args.send_mirror << 1)))
 		return -1;
 
 	if (!remote_refs) {
@@ -259,20 +259,28 @@ static int do_send_pack(int in, int out, struct remote *remote, const char *dest
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
@@ -280,7 +288,7 @@ static int do_send_pack(int in, int out, struct remote *remote, const char *dest
 			continue;
 		}
 		if (!will_delete_ref &&
-		    !hashcmp(ref->old_sha1, ref->peer_ref->new_sha1)) {
+		    !hashcmp(ref->old_sha1, new_sha1)) {
 			if (args.verbose)
 				fprintf(stderr, " = %-*s %s -> %s\n",
 					SUMMARY_WIDTH, "[up to date]",
@@ -312,8 +320,7 @@ static int do_send_pack(int in, int out, struct remote *remote, const char *dest
 		    !is_null_sha1(ref->old_sha1) &&
 		    !ref->force) {
 			if (!has_sha1_file(ref->old_sha1) ||
-			    !ref_newer(ref->peer_ref->new_sha1,
-				       ref->old_sha1)) {
+			    !ref_newer(new_sha1, ref->old_sha1)) {
 				/* We do not have the remote ref, or
 				 * we know that the remote ref is not
 				 * an ancestor of what we are trying to
@@ -328,7 +335,7 @@ static int do_send_pack(int in, int out, struct remote *remote, const char *dest
 				continue;
 			}
 		}
-		hashcpy(ref->new_sha1, ref->peer_ref->new_sha1);
+		hashcpy(ref->new_sha1, new_sha1);
 		if (!will_delete_ref)
 			new_refs++;
 		strcpy(old_hex, sha1_to_hex(ref->old_sha1));
@@ -459,6 +466,10 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
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
@@ -483,7 +494,12 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
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
diff --git a/remote.c b/remote.c
index 59defdb..45dd59b 100644
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
+	int send_all = flags & 01;
+	int send_mirror = flags & 02;
 
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
