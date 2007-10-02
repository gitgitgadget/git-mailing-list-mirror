From: Junio C Hamano <gitster@pobox.com>
Subject: mirror pushing
Date: Tue, 02 Oct 2007 00:55:45 -0700
Message-ID: <7vhclalzlq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 02 09:56:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iccbn-0002fl-PA
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 09:56:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752235AbXJBHzv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 03:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752342AbXJBHzv
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 03:55:51 -0400
Received: from rune.pobox.com ([208.210.124.79]:40531 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752222AbXJBHzu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 03:55:50 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id AFB8F1400DC;
	Tue,  2 Oct 2007 03:56:11 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id CF5841400DB;
	Tue,  2 Oct 2007 03:56:08 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59670>

Existing "git push --all" is almost perfect for backing up to
another repository, except that "--all" only means "all
branches" in modern git, and it does not delete old branches and
tags that exist at the back-up repository that you have removed
from your local repository.

This teaches "git-send-pack" a new "--mirror" option.  The
difference from the "--all" option are that (1) it sends all
refs, not just branches, and (2) it deletes old refs you no
longer have on the local side from the remote side.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This even applies to "maint", but it probably should be done
   on top of Daniel's remote.c changes.  Teaching this to "git
   push" wrapper is left as an exercise to the reader.

 remote.c    |   15 ++++++++++-----
 send-pack.c |   35 ++++++++++++++++++++++++-----------
 2 files changed, 34 insertions(+), 16 deletions(-)

diff --git a/remote.c b/remote.c
index bb774d0..a3aa5ad 100644
--- a/remote.c
+++ b/remote.c
@@ -574,10 +574,12 @@ static const struct refspec *check_pattern_match(const struct refspec *rs,
  * without thinking.
  */
 int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
-	       int nr_refspec, char **refspec, int all)
+	       int nr_refspec, char **refspec, int flags)
 {
 	struct refspec *rs =
 		parse_ref_spec(nr_refspec, (const char **) refspec);
+	int send_all = flags & 01;
+	int send_mirror = flags & 02;
 
 	if (match_explicit_refs(src, dst, dst_tail, rs, nr_refspec))
 		return -1;
@@ -594,7 +596,7 @@ int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
 			if (!pat)
 				continue;
 		}
-		else if (prefixcmp(src->name, "refs/heads/"))
+		else if (!send_mirror && prefixcmp(src->name, "refs/heads/"))
 			/*
 			 * "matching refs"; traditionally we pushed everything
 			 * including refs outside refs/heads/ hierarchy, but
@@ -615,10 +617,13 @@ int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
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
diff --git a/send-pack.c b/send-pack.c
index 9fc8a81..39b4b17 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -7,11 +7,12 @@
 #include "remote.h"
 
 static const char send_pack_usage[] =
-"git-send-pack [--all] [--force] [--receive-pack=<git-receive-pack>] [--verbose] [--thin] [<host>:]<directory> [<ref>...]\n"
+"git-send-pack [--all | --mirror] [--force] [--receive-pack=<git-receive-pack>] [--verbose] [--thin] [<host>:]<directory> [<ref>...]\n"
 "  --all and explicit <ref> specification are mutually exclusive.";
 static const char *receivepack = "git-receive-pack";
 static int verbose;
 static int send_all;
+static int send_mirror;
 static int force_update;
 static int use_thin_pack;
 
@@ -200,7 +201,7 @@ static int send_pack(int in, int out, struct remote *remote, int nr_refspec, cha
 	if (!remote_tail)
 		remote_tail = &remote_refs;
 	if (match_refs(local_refs, remote_refs, &remote_tail,
-		       nr_refspec, refspec, send_all))
+		       nr_refspec, refspec, (send_all | (send_mirror << 1))))
 		return -1;
 
 	if (!remote_refs) {
@@ -215,19 +216,24 @@ static int send_pack(int in, int out, struct remote *remote, int nr_refspec, cha
 	for (ref = remote_refs; ref; ref = ref->next) {
 		char old_hex[60], *new_hex;
 		int will_delete_ref;
+		const unsigned char *new_sha1;
 
-		if (!ref->peer_ref)
-			continue;
-
+		if (!ref->peer_ref) {
+			if (!send_mirror)
+				continue;
+			new_sha1 = null_sha1;
+		}
+		else
+			new_sha1 = ref->peer_ref->new_sha1;
 
-		will_delete_ref = is_null_sha1(ref->peer_ref->new_sha1);
+		will_delete_ref = is_null_sha1(new_sha1);
 		if (will_delete_ref && !allow_deleting_refs) {
 			error("remote does not support deleting refs");
 			ret = -2;
 			continue;
 		}
 		if (!will_delete_ref &&
-		    !hashcmp(ref->old_sha1, ref->peer_ref->new_sha1)) {
+		    !hashcmp(ref->old_sha1, new_sha1)) {
 			if (verbose)
 				fprintf(stderr, "'%s': up-to-date\n", ref->name);
 			continue;
@@ -257,8 +263,7 @@ static int send_pack(int in, int out, struct remote *remote, int nr_refspec, cha
 		    !is_null_sha1(ref->old_sha1) &&
 		    !ref->force) {
 			if (!has_sha1_file(ref->old_sha1) ||
-			    !ref_newer(ref->peer_ref->new_sha1,
-				       ref->old_sha1)) {
+			    !ref_newer(new_sha1, ref->old_sha1)) {
 				/* We do not have the remote ref, or
 				 * we know that the remote ref is not
 				 * an ancestor of what we are trying to
@@ -276,7 +281,7 @@ static int send_pack(int in, int out, struct remote *remote, int nr_refspec, cha
 				continue;
 			}
 		}
-		hashcpy(ref->new_sha1, ref->peer_ref->new_sha1);
+		hashcpy(ref->new_sha1, new_sha1);
 		if (!will_delete_ref)
 			new_refs++;
 		strcpy(old_hex, sha1_to_hex(ref->old_sha1));
@@ -396,6 +401,10 @@ int main(int argc, char **argv)
 				send_all = 1;
 				continue;
 			}
+			if (!strcmp(arg, "--mirror")) {
+				send_mirror = 1;
+				continue;
+			}
 			if (!strcmp(arg, "--force")) {
 				force_update = 1;
 				continue;
@@ -420,7 +429,11 @@ int main(int argc, char **argv)
 	}
 	if (!dest)
 		usage(send_pack_usage);
-	if (heads && send_all)
+	/*
+	 * --all and --mirror are incompatible; neither makes sense
+	 * with any refspecs.
+	 */
+	if ((heads && (send_all || send_mirror)) || (send_all && send_mirror))
 		usage(send_pack_usage);
 	verify_remote_names(nr_heads, heads);
 
