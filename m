From: andy@petdance.com
Subject: [PATCH] Removed redundant static functions such as update_tracking_ref() and verify_remote_names() from builtin-send-pack.c, and made the ones in transport.c not be static so they can be used instead.
Date: Thu, 23 Apr 2009 23:13:52 -0500
Message-ID: <1240546432-26212-1-git-send-email-andy@petdance.com>
Cc: Andy Lester <andy@petdance.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Apr 24 06:15:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxCoy-000298-TL
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 06:15:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385AbZDXENz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 00:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751028AbZDXENy
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 00:13:54 -0400
Received: from uniqua.petdance.com ([64.81.227.163]:44277 "EHLO
	uniqua.petdance.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750733AbZDXENy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 00:13:54 -0400
Received: by uniqua.petdance.com (Postfix, from userid 500)
	id BC3005CD0103; Thu, 23 Apr 2009 23:13:52 -0500 (CDT)
X-Mailer: git-send-email 1.6.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117406>

From: Andy Lester <andy@petdance.com>

Added const to some function parameters.
---
 builtin-send-pack.c |  190 ++-------------------------------------------------
 remote.c            |    4 +-
 remote.h            |    2 +-
 send-pack.h         |    2 +-
 transport.c         |   18 +++---
 transport.h         |    5 ++
 6 files changed, 23 insertions(+), 198 deletions(-)

diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index d5a1c48..5c33f9d 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -5,6 +5,7 @@
 #include "run-command.h"
 #include "remote.h"
 #include "send-pack.h"
+#include "transport.h"
 
 static const char send_pack_usage[] =
 "git send-pack [--all | --mirror] [--dry-run] [--force] [--receive-pack=<git-receive-pack>] [--verbose] [--thin] [<host>:]<directory> [<ref>...]\n"
@@ -29,7 +30,7 @@ static int feed_object(const unsigned char *sha1, int fd, int negative)
 /*
  * Make a pack stream and spit it out into file descriptor fd
  */
-static int pack_objects(int fd, struct ref *refs, struct extra_have_objects *extra, struct send_pack_args *args)
+static int pack_objects(int fd, const struct ref *refs, const struct extra_have_objects *extra, const struct send_pack_args *args)
 {
 	/*
 	 * The child becomes pack-objects --revs; we feed
@@ -146,157 +147,7 @@ static int receive_status(int in, struct ref *refs)
 	return ret;
 }
 
-static void update_tracking_ref(struct remote *remote, struct ref *ref)
-{
-	struct refspec rs;
-
-	if (ref->status != REF_STATUS_OK && ref->status != REF_STATUS_UPTODATE)
-		return;
-
-	rs.src = ref->name;
-	rs.dst = NULL;
-
-	if (!remote_find_tracking(remote, &rs)) {
-		if (args.verbose)
-			fprintf(stderr, "updating local tracking ref '%s'\n", rs.dst);
-		if (ref->deletion) {
-			delete_ref(rs.dst, NULL, 0);
-		} else
-			update_ref("update by push", rs.dst,
-					ref->new_sha1, NULL, 0, 0);
-		free(rs.dst);
-	}
-}
-
-#define SUMMARY_WIDTH (2 * DEFAULT_ABBREV + 3)
-
-static void print_ref_status(char flag, const char *summary, struct ref *to, struct ref *from, const char *msg)
-{
-	fprintf(stderr, " %c %-*s ", flag, SUMMARY_WIDTH, summary);
-	if (from)
-		fprintf(stderr, "%s -> %s", prettify_ref(from), prettify_ref(to));
-	else
-		fputs(prettify_ref(to), stderr);
-	if (msg) {
-		fputs(" (", stderr);
-		fputs(msg, stderr);
-		fputc(')', stderr);
-	}
-	fputc('\n', stderr);
-}
-
-static const char *status_abbrev(unsigned char sha1[20])
-{
-	return find_unique_abbrev(sha1, DEFAULT_ABBREV);
-}
-
-static void print_ok_ref_status(struct ref *ref)
-{
-	if (ref->deletion)
-		print_ref_status('-', "[deleted]", ref, NULL, NULL);
-	else if (is_null_sha1(ref->old_sha1))
-		print_ref_status('*',
-			(!prefixcmp(ref->name, "refs/tags/") ? "[new tag]" :
-			  "[new branch]"),
-			ref, ref->peer_ref, NULL);
-	else {
-		char quickref[84];
-		char type;
-		const char *msg;
-
-		strcpy(quickref, status_abbrev(ref->old_sha1));
-		if (ref->nonfastforward) {
-			strcat(quickref, "...");
-			type = '+';
-			msg = "forced update";
-		} else {
-			strcat(quickref, "..");
-			type = ' ';
-			msg = NULL;
-		}
-		strcat(quickref, status_abbrev(ref->new_sha1));
-
-		print_ref_status(type, quickref, ref, ref->peer_ref, msg);
-	}
-}
-
-static int print_one_push_status(struct ref *ref, const char *dest, int count)
-{
-	if (!count)
-		fprintf(stderr, "To %s\n", dest);
-
-	switch(ref->status) {
-	case REF_STATUS_NONE:
-		print_ref_status('X', "[no match]", ref, NULL, NULL);
-		break;
-	case REF_STATUS_REJECT_NODELETE:
-		print_ref_status('!', "[rejected]", ref, NULL,
-				"remote does not support deleting refs");
-		break;
-	case REF_STATUS_UPTODATE:
-		print_ref_status('=', "[up to date]", ref,
-				ref->peer_ref, NULL);
-		break;
-	case REF_STATUS_REJECT_NONFASTFORWARD:
-		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
-				"non-fast forward");
-		break;
-	case REF_STATUS_REMOTE_REJECT:
-		print_ref_status('!', "[remote rejected]", ref,
-				ref->deletion ? NULL : ref->peer_ref,
-				ref->remote_status);
-		break;
-	case REF_STATUS_EXPECTING_REPORT:
-		print_ref_status('!', "[remote failure]", ref,
-				ref->deletion ? NULL : ref->peer_ref,
-				"remote failed to report status");
-		break;
-	case REF_STATUS_OK:
-		print_ok_ref_status(ref);
-		break;
-	}
-
-	return 1;
-}
-
-static void print_push_status(const char *dest, struct ref *refs)
-{
-	struct ref *ref;
-	int n = 0;
-
-	if (args.verbose) {
-		for (ref = refs; ref; ref = ref->next)
-			if (ref->status == REF_STATUS_UPTODATE)
-				n += print_one_push_status(ref, dest, n);
-	}
-
-	for (ref = refs; ref; ref = ref->next)
-		if (ref->status == REF_STATUS_OK)
-			n += print_one_push_status(ref, dest, n);
-
-	for (ref = refs; ref; ref = ref->next) {
-		if (ref->status != REF_STATUS_NONE &&
-		    ref->status != REF_STATUS_UPTODATE &&
-		    ref->status != REF_STATUS_OK)
-			n += print_one_push_status(ref, dest, n);
-	}
-}
-
-static int refs_pushed(struct ref *ref)
-{
-	for (; ref; ref = ref->next) {
-		switch(ref->status) {
-		case REF_STATUS_NONE:
-		case REF_STATUS_UPTODATE:
-			break;
-		default:
-			return 1;
-		}
-	}
-	return 0;
-}
-
-int send_pack(struct send_pack_args *args,
+int send_pack(const struct send_pack_args *args,
 	      int fd[], struct child_process *conn,
 	      struct ref *remote_refs,
 	      struct extra_have_objects *extra_have)
@@ -426,37 +277,6 @@ int send_pack(struct send_pack_args *args,
 	return 0;
 }
 
-static void verify_remote_names(int nr_heads, const char **heads)
-{
-	int i;
-
-	for (i = 0; i < nr_heads; i++) {
-		const char *local = heads[i];
-		const char *remote = strrchr(heads[i], ':');
-
-		if (*local == '+')
-			local++;
-
-		/* A matching refspec is okay.  */
-		if (remote == local && remote[1] == '\0')
-			continue;
-
-		remote = remote ? (remote + 1) : local;
-		switch (check_ref_format(remote)) {
-		case 0: /* ok */
-		case CHECK_REF_FORMAT_ONELEVEL:
-			/* ok but a single level -- that is fine for
-			 * a match pattern.
-			 */
-		case CHECK_REF_FORMAT_WILDCARD:
-			/* ok but ends with a pattern-match character */
-			continue;
-		}
-		die("remote part of refspec is not a valid name in %s",
-		    heads[i]);
-	}
-}
-
 int cmd_send_pack(int argc, const char **argv, const char *prefix)
 {
 	int i, nr_refspecs = 0;
@@ -576,12 +396,12 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 
 	ret |= finish_connect(conn);
 
-	print_push_status(dest, remote_refs);
+	print_push_status(dest, remote_refs, args.verbose);
 
 	if (!args.dry_run && remote) {
 		struct ref *ref;
 		for (ref = remote_refs; ref; ref = ref->next)
-			update_tracking_ref(remote, ref);
+			update_tracking_ref(remote, ref, args.verbose);
 	}
 
 	if (!ret && !refs_pushed(remote_refs))
diff --git a/remote.c b/remote.c
index 91f7485..f7a5c49 100644
--- a/remote.c
+++ b/remote.c
@@ -769,9 +769,9 @@ static int match_name_with_pattern(const char *key, const char *name,
 	return ret;
 }
 
-int remote_find_tracking(struct remote *remote, struct refspec *refspec)
+int remote_find_tracking(const struct remote *remote, struct refspec *refspec)
 {
-	int find_src = refspec->src == NULL;
+	const int find_src = (refspec->src == NULL);
 	char *needle, **result;
 	int i;
 
diff --git a/remote.h b/remote.h
index 99706a8..d624e08 100644
--- a/remote.h
+++ b/remote.h
@@ -108,7 +108,7 @@ struct ref *get_remote_ref(const struct ref *remote_refs, const char *name);
 /*
  * For the given remote, reads the refspec's src and sets the other fields.
  */
-int remote_find_tracking(struct remote *remote, struct refspec *refspec);
+int remote_find_tracking(const struct remote *remote, struct refspec *refspec);
 
 struct branch {
 	const char *name;
diff --git a/send-pack.h b/send-pack.h
index 83d76c7..88a407e 100644
--- a/send-pack.h
+++ b/send-pack.h
@@ -9,7 +9,7 @@ struct send_pack_args {
 		dry_run:1;
 };
 
-int send_pack(struct send_pack_args *args,
+int send_pack(const struct send_pack_args *args,
 	      int fd[], struct child_process *conn,
 	      struct ref *remote_refs, struct extra_have_objects *extra_have);
 
diff --git a/transport.c b/transport.c
index 3dfb03c..d50160b 100644
--- a/transport.c
+++ b/transport.c
@@ -690,7 +690,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 	return (refs ? 0 : -1);
 }
 
-static int refs_pushed(struct ref *ref)
+int refs_pushed(const struct ref *ref)
 {
 	for (; ref; ref = ref->next) {
 		switch(ref->status) {
@@ -704,7 +704,7 @@ static int refs_pushed(struct ref *ref)
 	return 0;
 }
 
-static void update_tracking_ref(struct remote *remote, struct ref *ref, int verbose)
+void update_tracking_ref(const struct remote *remote, struct ref *ref, int verbose)
 {
 	struct refspec rs;
 
@@ -728,7 +728,7 @@ static void update_tracking_ref(struct remote *remote, struct ref *ref, int verb
 
 #define SUMMARY_WIDTH (2 * DEFAULT_ABBREV + 3)
 
-static void print_ref_status(char flag, const char *summary, struct ref *to, struct ref *from, const char *msg)
+static void print_ref_status(char flag, const char *summary, const struct ref *to, const struct ref *from, const char *msg)
 {
 	fprintf(stderr, " %c %-*s ", flag, SUMMARY_WIDTH, summary);
 	if (from)
@@ -743,12 +743,12 @@ static void print_ref_status(char flag, const char *summary, struct ref *to, str
 	fputc('\n', stderr);
 }
 
-static const char *status_abbrev(unsigned char sha1[20])
+static const char *status_abbrev(const unsigned char *sha1)
 {
 	return find_unique_abbrev(sha1, DEFAULT_ABBREV);
 }
 
-static void print_ok_ref_status(struct ref *ref)
+static void print_ok_ref_status(const struct ref *ref)
 {
 	if (ref->deletion)
 		print_ref_status('-', "[deleted]", ref, NULL, NULL);
@@ -778,7 +778,7 @@ static void print_ok_ref_status(struct ref *ref)
 	}
 }
 
-static int print_one_push_status(struct ref *ref, const char *dest, int count)
+static int print_one_push_status(const struct ref *ref, const char *dest, int count)
 {
 	if (!count)
 		fprintf(stderr, "To %s\n", dest);
@@ -817,9 +817,9 @@ static int print_one_push_status(struct ref *ref, const char *dest, int count)
 	return 1;
 }
 
-static void print_push_status(const char *dest, struct ref *refs, int verbose)
+void print_push_status(const char *dest, const struct ref *refs, int verbose)
 {
-	struct ref *ref;
+	const struct ref *ref;
 	int n = 0;
 
 	if (verbose) {
@@ -840,7 +840,7 @@ static void print_push_status(const char *dest, struct ref *refs, int verbose)
 	}
 }
 
-static void verify_remote_names(int nr_heads, const char **heads)
+void verify_remote_names(int nr_heads, const char **heads)
 {
 	int i;
 
diff --git a/transport.h b/transport.h
index b1c2252..ea77c7c 100644
--- a/transport.h
+++ b/transport.h
@@ -75,4 +75,9 @@ int transport_fetch_refs(struct transport *transport, const struct ref *refs);
 void transport_unlock_pack(struct transport *transport);
 int transport_disconnect(struct transport *transport);
 
+void update_tracking_ref(const struct remote *remote, struct ref *ref, int verbose);
+void print_push_status(const char *dest, const struct ref *refs, int verbose);
+int refs_pushed(const struct ref *ref);
+void verify_remote_names(int nr_heads, const char **heads);
+
 #endif
-- 
1.6.2.4
