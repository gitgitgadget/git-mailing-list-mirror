From: Michael Lukashov <michael.lukashov@gmail.com>
Subject: [PATCH v3 1/4] Refactoring: remove duplicated code from builtin-send-pack.c and transport.c
Date: Tue, 16 Feb 2010 23:42:52 +0000
Message-ID: <57f2a1b845f82f86709c71d1fbc530bb5fdb1a7f.1266360267.git.michael.lukashov@gmail.com>
References: <cover.1266360267.git.michael.lukashov@gmail.com>
Cc: Michael Lukashov <michael.lukashov@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 17 00:43:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhX55-0007Y0-E1
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 00:43:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933492Ab0BPXnZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 18:43:25 -0500
Received: from mail-bw0-f219.google.com ([209.85.218.219]:50258 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757060Ab0BPXnX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 18:43:23 -0500
Received: by bwz19 with SMTP id 19so5008472bwz.28
        for <git@vger.kernel.org>; Tue, 16 Feb 2010 15:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=IaU9R6Fr8RuxcuHmxnHeeo6UZSOFjIyaRetHE/KW5ww=;
        b=vN2ulF2BIWbZ086NOstpj+2vuYsEFxL3bGHORZV8GcciNbI5R8rXm8pHw9cCdCMNtp
         J5YEfqChKFlMPC/rOsLS27VI71fQmlA6oSHX7EE9rt5t6G/xVaZ79LixsynHu2jsUTn5
         m++oMjqheO/837X45KRbZzzyALL6HFXULbUtM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=o2zTeM3FXyOQmsX/T+C7AvbyjQGF2lk7AGHDF+wqy3o+CjGLZ45+BA14Ai0+SiAryT
         xmjg2k5V3LL0zlqcORKWXHSxm1NE2pGUfPGJVysoIAhQaEmlThNf21DNm6XuRUyYeDJ7
         fqxHK9ih6DcNn1A548hARZ0qhSIDSaM3R79Lo=
Received: by 10.204.131.208 with SMTP id y16mr4686766bks.137.1266363801054;
        Tue, 16 Feb 2010 15:43:21 -0800 (PST)
Received: from localhost (nat-nz.wwwcom.ru [195.62.62.242])
        by mx.google.com with ESMTPS id 14sm3374766bwz.1.2010.02.16.15.43.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 16 Feb 2010 15:43:20 -0800 (PST)
X-Mailer: git-send-email 1.7.0.14.g7e948
In-Reply-To: <cover.1266360267.git.michael.lukashov@gmail.com>
In-Reply-To: <cover.1266360267.git.michael.lukashov@gmail.com>
References: <cover.1266360267.git.michael.lukashov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140176>

The following functions are (almost) identical:

  verify_remote_names
  update_tracking_ref
  refs_pushed
  print_push_status

Move common versions of these functions to transport.c and rename them,
as suggested by Jeff King and Junio C Hamano.

The following functions have been removed entirely from builtin-send-pack.c,
since they are only used internally by print_push_status():

  print_ref_status
  status_abbrev
  print_ok_ref_status
  print_one_push_status

Also, move #define SUMMARY_WIDTH to transport.h and rename it TRANSPORT_SUMMARY_WIDTH
as it is used in builtin-fetch.c and transport.c

Signed-off-by: Michael Lukashov <michael.lukashov@gmail.com>
---
 builtin-fetch.c     |   20 +++---
 builtin-send-pack.c |  191 ++-------------------------------------------------
 transport.c         |   22 +++---
 transport.h         |   11 +++
 4 files changed, 37 insertions(+), 207 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index 8654fa7..d3b9d8a 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -11,6 +11,7 @@
 #include "run-command.h"
 #include "parse-options.h"
 #include "sigchain.h"
+#include "transport.h"
 
 static const char * const builtin_fetch_usage[] = {
 	"git fetch [options] [<repository> <refspec>...]",
@@ -205,7 +206,6 @@ static int s_update_ref(const char *action,
 	return 0;
 }
 
-#define SUMMARY_WIDTH (2 * DEFAULT_ABBREV + 3)
 #define REFCOL_WIDTH  10
 
 static int update_local_ref(struct ref *ref,
@@ -224,7 +224,7 @@ static int update_local_ref(struct ref *ref,
 
 	if (!hashcmp(ref->old_sha1, ref->new_sha1)) {
 		if (verbosity > 0)
-			sprintf(display, "= %-*s %-*s -> %s", SUMMARY_WIDTH,
+			sprintf(display, "= %-*s %-*s -> %s", TRANSPORT_SUMMARY_WIDTH,
 				"[up to date]", REFCOL_WIDTH, remote,
 				pretty_ref);
 		return 0;
@@ -239,7 +239,7 @@ static int update_local_ref(struct ref *ref,
 		 * the head, and the old value of the head isn't empty...
 		 */
 		sprintf(display, "! %-*s %-*s -> %s  (can't fetch in current branch)",
-			SUMMARY_WIDTH, "[rejected]", REFCOL_WIDTH, remote,
+			TRANSPORT_SUMMARY_WIDTH, "[rejected]", REFCOL_WIDTH, remote,
 			pretty_ref);
 		return 1;
 	}
@@ -249,7 +249,7 @@ static int update_local_ref(struct ref *ref,
 		int r;
 		r = s_update_ref("updating tag", ref, 0);
 		sprintf(display, "%c %-*s %-*s -> %s%s", r ? '!' : '-',
-			SUMMARY_WIDTH, "[tag update]", REFCOL_WIDTH, remote,
+			TRANSPORT_SUMMARY_WIDTH, "[tag update]", REFCOL_WIDTH, remote,
 			pretty_ref, r ? "  (unable to update local ref)" : "");
 		return r;
 	}
@@ -271,7 +271,7 @@ static int update_local_ref(struct ref *ref,
 
 		r = s_update_ref(msg, ref, 0);
 		sprintf(display, "%c %-*s %-*s -> %s%s", r ? '!' : '*',
-			SUMMARY_WIDTH, what, REFCOL_WIDTH, remote, pretty_ref,
+			TRANSPORT_SUMMARY_WIDTH, what, REFCOL_WIDTH, remote, pretty_ref,
 			r ? "  (unable to update local ref)" : "");
 		return r;
 	}
@@ -284,7 +284,7 @@ static int update_local_ref(struct ref *ref,
 		strcat(quickref, find_unique_abbrev(ref->new_sha1, DEFAULT_ABBREV));
 		r = s_update_ref("fast-forward", ref, 1);
 		sprintf(display, "%c %-*s %-*s -> %s%s", r ? '!' : ' ',
-			SUMMARY_WIDTH, quickref, REFCOL_WIDTH, remote,
+			TRANSPORT_SUMMARY_WIDTH, quickref, REFCOL_WIDTH, remote,
 			pretty_ref, r ? "  (unable to update local ref)" : "");
 		return r;
 	} else if (force || ref->force) {
@@ -295,13 +295,13 @@ static int update_local_ref(struct ref *ref,
 		strcat(quickref, find_unique_abbrev(ref->new_sha1, DEFAULT_ABBREV));
 		r = s_update_ref("forced-update", ref, 1);
 		sprintf(display, "%c %-*s %-*s -> %s  (%s)", r ? '!' : '+',
-			SUMMARY_WIDTH, quickref, REFCOL_WIDTH, remote,
+			TRANSPORT_SUMMARY_WIDTH, quickref, REFCOL_WIDTH, remote,
 			pretty_ref,
 			r ? "unable to update local ref" : "forced update");
 		return r;
 	} else {
 		sprintf(display, "! %-*s %-*s -> %s  (non-fast-forward)",
-			SUMMARY_WIDTH, "[rejected]", REFCOL_WIDTH, remote,
+			TRANSPORT_SUMMARY_WIDTH, "[rejected]", REFCOL_WIDTH, remote,
 			pretty_ref);
 		return 1;
 	}
@@ -393,7 +393,7 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 			rc |= update_local_ref(ref, what, note);
 		else
 			sprintf(note, "* %-*s %-*s -> FETCH_HEAD",
-				SUMMARY_WIDTH, *kind ? kind : "branch",
+				TRANSPORT_SUMMARY_WIDTH, *kind ? kind : "branch",
 				 REFCOL_WIDTH, *what ? what : "HEAD");
 		if (*note) {
 			if (verbosity >= 0 && !shown_url) {
@@ -514,7 +514,7 @@ static int prune_refs(struct transport *transport, struct ref *ref_map)
 			result |= delete_ref(ref->name, NULL, 0);
 		if (verbosity >= 0) {
 			fprintf(stderr, " x %-*s %-*s -> %s\n",
-				SUMMARY_WIDTH, "[deleted]",
+				TRANSPORT_SUMMARY_WIDTH, "[deleted]",
 				REFCOL_WIDTH, "(none)", prettify_refname(ref->name));
 			warn_dangling_symref(stderr, dangling_msg, ref->name);
 		}
diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index 76c7206..cbda311 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -7,6 +7,7 @@
 #include "remote.h"
 #include "send-pack.h"
 #include "quote.h"
+#include "transport.h"
 
 static const char send_pack_usage[] =
 "git send-pack [--all | --mirror] [--dry-run] [--force] [--receive-pack=<git-receive-pack>] [--verbose] [--thin] [<host>:]<directory> [<ref>...]\n"
@@ -169,156 +170,6 @@ static int receive_status(int in, struct ref *refs)
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
-		fprintf(stderr, "%s -> %s", prettify_refname(from->name), prettify_refname(to->name));
-	else
-		fputs(prettify_refname(to->name), stderr);
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
-				"non-fast-forward");
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
 static void print_helper_status(struct ref *ref)
 {
 	struct strbuf buf = STRBUF_INIT;
@@ -489,37 +340,6 @@ int send_pack(struct send_pack_args *args,
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
@@ -536,6 +356,7 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 	int send_all = 0;
 	const char *receivepack = "git-receive-pack";
 	int flags;
+	int nonfastforward = 0;
 
 	argv++;
 	for (i = 1; i < argc; i++, argv++) {
@@ -628,7 +449,7 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 	get_remote_heads(fd[0], &remote_refs, 0, NULL, REF_NORMAL,
 			 &extra_have);
 
-	verify_remote_names(nr_refspecs, refspecs);
+	transport_verify_remote_names(nr_refspecs, refspecs);
 
 	local_refs = get_local_heads();
 
@@ -657,15 +478,15 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 	ret |= finish_connect(conn);
 
 	if (!helper_status)
-		print_push_status(dest, remote_refs);
+		transport_print_push_status(dest, remote_refs, args.verbose, 0, &nonfastforward);
 
 	if (!args.dry_run && remote) {
 		struct ref *ref;
 		for (ref = remote_refs; ref; ref = ref->next)
-			update_tracking_ref(remote, ref);
+			transport_update_tracking_ref(remote, ref, args.verbose);
 	}
 
-	if (!ret && !refs_pushed(remote_refs))
+	if (!ret && !transport_refs_pushed(remote_refs))
 		fprintf(stderr, "Everything up-to-date\n");
 
 	return ret;
diff --git a/transport.c b/transport.c
index 3846aac..6d7a125 100644
--- a/transport.c
+++ b/transport.c
@@ -573,7 +573,7 @@ static int push_had_errors(struct ref *ref)
 	return 0;
 }
 
-static int refs_pushed(struct ref *ref)
+int transport_refs_pushed(struct ref *ref)
 {
 	for (; ref; ref = ref->next) {
 		switch(ref->status) {
@@ -587,7 +587,7 @@ static int refs_pushed(struct ref *ref)
 	return 0;
 }
 
-static void update_tracking_ref(struct remote *remote, struct ref *ref, int verbose)
+void transport_update_tracking_ref(struct remote *remote, struct ref *ref, int verbose)
 {
 	struct refspec rs;
 
@@ -609,8 +609,6 @@ static void update_tracking_ref(struct remote *remote, struct ref *ref, int verb
 	}
 }
 
-#define SUMMARY_WIDTH (2 * DEFAULT_ABBREV + 3)
-
 static void print_ref_status(char flag, const char *summary, struct ref *to, struct ref *from, const char *msg, int porcelain)
 {
 	if (porcelain) {
@@ -623,7 +621,7 @@ static void print_ref_status(char flag, const char *summary, struct ref *to, str
 		else
 			fprintf(stdout, "%s\n", summary);
 	} else {
-		fprintf(stderr, " %c %-*s ", flag, SUMMARY_WIDTH, summary);
+		fprintf(stderr, " %c %-*s ", flag, TRANSPORT_SUMMARY_WIDTH, summary);
 		if (from)
 			fprintf(stderr, "%s -> %s", prettify_refname(from->name), prettify_refname(to->name));
 		else
@@ -711,8 +709,8 @@ static int print_one_push_status(struct ref *ref, const char *dest, int count, i
 	return 1;
 }
 
-static void print_push_status(const char *dest, struct ref *refs,
-			      int verbose, int porcelain, int * nonfastforward)
+void transport_print_push_status(const char *dest, struct ref *refs,
+				  int verbose, int porcelain, int *nonfastforward)
 {
 	struct ref *ref;
 	int n = 0;
@@ -738,7 +736,7 @@ static void print_push_status(const char *dest, struct ref *refs,
 	}
 }
 
-static void verify_remote_names(int nr_heads, const char **heads)
+void transport_verify_remote_names(int nr_heads, const char **heads)
 {
 	int i;
 
@@ -1018,7 +1016,7 @@ int transport_push(struct transport *transport,
 		   int *nonfastforward)
 {
 	*nonfastforward = 0;
-	verify_remote_names(refspec_nr, refspec);
+	transport_verify_remote_names(refspec_nr, refspec);
 
 	if (transport->push) {
 		/* Maybe FIXME. But no important transport uses this case. */
@@ -1057,7 +1055,7 @@ int transport_push(struct transport *transport,
 		ret |= err;
 
 		if (!quiet || err)
-			print_push_status(transport->url, remote_refs,
+			transport_print_push_status(transport->url, remote_refs,
 					verbose | porcelain, porcelain,
 					nonfastforward);
 
@@ -1067,10 +1065,10 @@ int transport_push(struct transport *transport,
 		if (!(flags & TRANSPORT_PUSH_DRY_RUN)) {
 			struct ref *ref;
 			for (ref = remote_refs; ref; ref = ref->next)
-				update_tracking_ref(transport->remote, ref, verbose);
+				transport_update_tracking_ref(transport->remote, ref, verbose);
 		}
 
-		if (!quiet && !ret && !refs_pushed(remote_refs))
+		if (!quiet && !ret && !transport_refs_pushed(remote_refs))
 			fprintf(stderr, "Everything up-to-date\n");
 		return ret;
 	}
diff --git a/transport.h b/transport.h
index 7cea5cc..7a9bb57 100644
--- a/transport.h
+++ b/transport.h
@@ -92,6 +92,7 @@ struct transport {
 #define TRANSPORT_PUSH_PORCELAIN 32
 #define TRANSPORT_PUSH_QUIET 64
 #define TRANSPORT_PUSH_SET_UPSTREAM 128
+#define TRANSPORT_SUMMARY_WIDTH (2 * DEFAULT_ABBREV + 3)
 
 /* Returns a transport suitable for the url */
 struct transport *transport_get(struct remote *, const char *);
@@ -142,4 +143,14 @@ int transport_connect(struct transport *transport, const char *name,
 /* Transport methods defined outside transport.c */
 int transport_helper_init(struct transport *transport, const char *name);
 
+/* common methods used by transport.c and builtin-send-pack.c */
+void transport_verify_remote_names(int nr_heads, const char **heads);
+
+void transport_update_tracking_ref(struct remote *remote, struct ref *ref, int verbose);
+
+int transport_refs_pushed(struct ref *ref);
+
+void transport_print_push_status(const char *dest, struct ref *refs,
+		  int verbose, int porcelain, int *nonfastforward);
+
 #endif
-- 
1.7.0.1571.g856c2
