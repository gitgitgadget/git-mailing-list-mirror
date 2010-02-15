From: Michael Lukashov <michael.lukashov@gmail.com>
Subject: [PATCH v2 1/4] Refactoring: remove duplicated code from builtin-send-pack.c and transport.c
Date: Mon, 15 Feb 2010 23:26:47 +0000
Message-ID: <1266276411-5796-2-git-send-email-michael.lukashov@gmail.com>
References: <1266276411-5796-1-git-send-email-michael.lukashov@gmail.com>
Cc: Michael Lukashov <michael.lukashov@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 00:35:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhATN-0001ns-6v
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 00:35:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932256Ab0BOXfT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2010 18:35:19 -0500
Received: from mail-bw0-f213.google.com ([209.85.218.213]:55999 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932090Ab0BOXfS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2010 18:35:18 -0500
Received: by bwz5 with SMTP id 5so1504300bwz.1
        for <git@vger.kernel.org>; Mon, 15 Feb 2010 15:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=B4GXiQv2rhB7kWHX0CsW56QkfVQMWcqodnWxFpmIl+s=;
        b=rm/6T07PzJeI8AbJkrVTz2b/C/ZGm5qLuU87tkF0+mC2W+FGT4JXF1jweRA3zR5SOP
         pzA69njw+G3QZFLEIjLUd0ApmU+lVQe4WzMb55rDcZInVkdPTNWvHIqyF1+MaOUgSur5
         aixecGE2D22FA6GVFumdBh7gFo8CweIDYTR+o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=kzhwvPM1FlYJUyk5bbNwsQmIkF3cMgYcZCPIvuUYeY4LV/j00MYR927BzIVJXEFDak
         hmTc1M0S3ta8sXzXYhsM5Q1pUmJ8DvmZYylSExeM6w/zqhv7WIqOmy2MkTWghnkrj3QX
         UTl7oa/yD/4pjES+iUrDEWHCCZaswN0/V/UtU=
Received: by 10.204.152.152 with SMTP id g24mr3408110bkw.205.1266276427630;
        Mon, 15 Feb 2010 15:27:07 -0800 (PST)
Received: from localhost (nat-nz.wwwcom.ru [195.62.62.242])
        by mx.google.com with ESMTPS id 15sm2867267bwz.8.2010.02.15.15.27.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 15 Feb 2010 15:27:07 -0800 (PST)
X-Mailer: git-send-email 1.7.0.14.g7e948
In-Reply-To: <1266276411-5796-1-git-send-email-michael.lukashov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140049>

The following functions are (almost) identical:

  verify_remote_names
  update_tracking_ref
  print_ref_status
  status_abbrev
  print_ok_ref_status
  print_one_push_status
  refs_pushed
  print_push_status

Move common versions of these functions to transport.c and rename them,
as suggested by Jeff King and Junio C Hamano

Also, move #define SUMMARY_WIDTH to transport.h and rename it TRANSPORT_SUMMARY_WIDTH
as it is used in builtin-fetch.c and transport.c

Signed-off-by: Michael Lukashov <michael.lukashov@gmail.com>
---
 builtin-fetch.c     |   20 +++---
 builtin-send-pack.c |  190 ++-------------------------------------------------
 transport.c         |   27 ++++----
 transport.h         |   11 +++
 4 files changed, 39 insertions(+), 209 deletions(-)

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
index 76c7206..b6e8948 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -169,156 +169,6 @@ static int receive_status(int in, struct ref *refs)
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
@@ -489,37 +339,6 @@ int send_pack(struct send_pack_args *args,
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
@@ -536,6 +355,7 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 	int send_all = 0;
 	const char *receivepack = "git-receive-pack";
 	int flags;
+	int nonfastforward = 0;
 
 	argv++;
 	for (i = 1; i < argc; i++, argv++) {
@@ -628,7 +448,7 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 	get_remote_heads(fd[0], &remote_refs, 0, NULL, REF_NORMAL,
 			 &extra_have);
 
-	verify_remote_names(nr_refspecs, refspecs);
+	transport_verify_remote_names(nr_refspecs, refspecs);
 
 	local_refs = get_local_heads();
 
@@ -657,15 +477,15 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
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
index 3846aac..0924288 100644
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
 
@@ -609,9 +609,8 @@ static void update_tracking_ref(struct remote *remote, struct ref *ref, int verb
 	}
 }
 
-#define SUMMARY_WIDTH (2 * DEFAULT_ABBREV + 3)
-
-static void print_ref_status(char flag, const char *summary, struct ref *to, struct ref *from, const char *msg, int porcelain)
+static void print_ref_status(char flag, const char *summary, struct ref *to,
+		  struct ref *from, const char *msg, int porcelain)
 {
 	if (porcelain) {
 		if (from)
@@ -623,7 +622,7 @@ static void print_ref_status(char flag, const char *summary, struct ref *to, str
 		else
 			fprintf(stdout, "%s\n", summary);
 	} else {
-		fprintf(stderr, " %c %-*s ", flag, SUMMARY_WIDTH, summary);
+		fprintf(stderr, " %c %-*s ", flag, TRANSPORT_SUMMARY_WIDTH, summary);
 		if (from)
 			fprintf(stderr, "%s -> %s", prettify_refname(from->name), prettify_refname(to->name));
 		else
@@ -687,7 +686,7 @@ static int print_one_push_status(struct ref *ref, const char *dest, int count, i
 		break;
 	case REF_STATUS_UPTODATE:
 		print_ref_status('=', "[up to date]", ref,
-						 ref->peer_ref, NULL, porcelain);
+				 ref->peer_ref, NULL, porcelain);
 		break;
 	case REF_STATUS_REJECT_NONFASTFORWARD:
 		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
@@ -711,8 +710,8 @@ static int print_one_push_status(struct ref *ref, const char *dest, int count, i
 	return 1;
 }
 
-static void print_push_status(const char *dest, struct ref *refs,
-			      int verbose, int porcelain, int * nonfastforward)
+void transport_print_push_status(const char *dest, struct ref *refs,
+		  int verbose, int porcelain, int *nonfastforward)
 {
 	struct ref *ref;
 	int n = 0;
@@ -738,7 +737,7 @@ static void print_push_status(const char *dest, struct ref *refs,
 	}
 }
 
-static void verify_remote_names(int nr_heads, const char **heads)
+void transport_verify_remote_names(int nr_heads, const char **heads)
 {
 	int i;
 
@@ -1018,7 +1017,7 @@ int transport_push(struct transport *transport,
 		   int *nonfastforward)
 {
 	*nonfastforward = 0;
-	verify_remote_names(refspec_nr, refspec);
+	transport_verify_remote_names(refspec_nr, refspec);
 
 	if (transport->push) {
 		/* Maybe FIXME. But no important transport uses this case. */
@@ -1057,7 +1056,7 @@ int transport_push(struct transport *transport,
 		ret |= err;
 
 		if (!quiet || err)
-			print_push_status(transport->url, remote_refs,
+			transport_print_push_status(transport->url, remote_refs,
 					verbose | porcelain, porcelain,
 					nonfastforward);
 
@@ -1067,10 +1066,10 @@ int transport_push(struct transport *transport,
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
