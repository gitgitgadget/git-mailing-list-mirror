From: Michael Lukashov <michael.lukashov@gmail.com>
Subject: [PATCH 1/4] Refactoring: remove duplicated code from transport.c and builtin-send-pack.c
Date: Sun, 14 Feb 2010 21:27:40 +0000
Message-ID: <1266182863-5048-1-git-send-email-michael.lukashov@gmail.com>
Cc: Michael Lukashov <michael.lukashov@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 14 22:28:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ngm0y-0000Ht-FN
	for gcvg-git-2@lo.gmane.org; Sun, 14 Feb 2010 22:28:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753354Ab0BNV2R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Feb 2010 16:28:17 -0500
Received: from mail-bw0-f216.google.com ([209.85.218.216]:61417 "EHLO
	mail-bw0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753021Ab0BNV2Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2010 16:28:16 -0500
Received: by bwz8 with SMTP id 8so2302841bwz.38
        for <git@vger.kernel.org>; Sun, 14 Feb 2010 13:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=3+u5RwYN34glcj8jE/UBhcBTwomsH7PZ0GqE9zPKUVw=;
        b=p1ELSy4or6KhaeuCuknFuq/bPAyXSnGtFOoMhcOL6dd5qKi1scoSOePhY5n0AOZCNC
         IxPJNwds4jSWiy3rrUsycIgrUWOwM8E6MevrLF50Fqh2wHXU/DhXldNWUQya47TQl/zx
         qHecKBT35Vu1/f6zbrs68megITIJrDkPXktX4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=FXd+zXo0ev2yf7J30SCpFTkllD9G55XMRHKce5gvBzz5N+Yr3+yuoqhKEiGXcHk54l
         bSbvOSo39gr/6hUo9uUE6xUFKl58H5mZsGmazslcKoBdoYbQkpSjdK+9FNj47AH5E8YL
         17vxz836ZLuTfErhdckkvW9iuwu9YbEVg2V3k=
Received: by 10.204.135.215 with SMTP id o23mr2610306bkt.140.1266182894094;
        Sun, 14 Feb 2010 13:28:14 -0800 (PST)
Received: from localhost (nat-nz.wwwcom.ru [195.62.62.242])
        by mx.google.com with ESMTPS id 16sm2380352bwz.7.2010.02.14.13.28.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Feb 2010 13:28:13 -0800 (PST)
X-Mailer: git-send-email 1.7.0.14.g7e948
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139938>

The following functions are duplicated:

  verify_remote_names
  update_tracking_ref
  print_ref_status
  status_abbrev
  print_ok_ref_status
  print_one_push_status
  refs_pushed
  print_push_status

Signed-off-by: Michael Lukashov <michael.lukashov@gmail.com>
---
 builtin-send-pack.c |   89 ++++++++++++++----------
 send-pack.h         |   20 +++++
 transport.c         |  196 ---------------------------------------------------
 3 files changed, 72 insertions(+), 233 deletions(-)

diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index 76c7206..616811a 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -169,7 +169,7 @@ static int receive_status(int in, struct ref *refs)
 	return ret;
 }
 
-static void update_tracking_ref(struct remote *remote, struct ref *ref)
+void update_tracking_ref(struct remote *remote, struct ref *ref, int verbose)
 {
 	struct refspec rs;
 
@@ -180,7 +180,7 @@ static void update_tracking_ref(struct remote *remote, struct ref *ref)
 	rs.dst = NULL;
 
 	if (!remote_find_tracking(remote, &rs)) {
-		if (args.verbose)
+		if (verbose)
 			fprintf(stderr, "updating local tracking ref '%s'\n", rs.dst);
 		if (ref->deletion) {
 			delete_ref(rs.dst, NULL, 0);
@@ -191,37 +191,47 @@ static void update_tracking_ref(struct remote *remote, struct ref *ref)
 	}
 }
 
-#define SUMMARY_WIDTH (2 * DEFAULT_ABBREV + 3)
-
-static void print_ref_status(char flag, const char *summary, struct ref *to, struct ref *from, const char *msg)
+void print_ref_status(char flag, const char *summary, struct ref *to,
+		  struct ref *from, const char *msg, int porcelain)
 {
-	fprintf(stderr, " %c %-*s ", flag, SUMMARY_WIDTH, summary);
-	if (from)
-		fprintf(stderr, "%s -> %s", prettify_refname(from->name), prettify_refname(to->name));
-	else
-		fputs(prettify_refname(to->name), stderr);
-	if (msg) {
-		fputs(" (", stderr);
-		fputs(msg, stderr);
-		fputc(')', stderr);
+	if (porcelain) {
+		if (from)
+			fprintf(stdout, "%c\t%s:%s\t", flag, from->name, to->name);
+		else
+			fprintf(stdout, "%c\t:%s\t", flag, to->name);
+		if (msg)
+			fprintf(stdout, "%s (%s)\n", summary, msg);
+		else
+			fprintf(stdout, "%s\n", summary);
+	} else {
+		fprintf(stderr, " %c %-*s ", flag, SUMMARY_WIDTH, summary);
+		if (from)
+			fprintf(stderr, "%s -> %s", prettify_refname(from->name), prettify_refname(to->name));
+		else
+			fputs(prettify_refname(to->name), stderr);
+		if (msg) {
+			fputs(" (", stderr);
+			fputs(msg, stderr);
+			fputc(')', stderr);
+		}
+		fputc('\n', stderr);
 	}
-	fputc('\n', stderr);
 }
 
-static const char *status_abbrev(unsigned char sha1[20])
+const char *status_abbrev(unsigned char sha1[20])
 {
 	return find_unique_abbrev(sha1, DEFAULT_ABBREV);
 }
 
-static void print_ok_ref_status(struct ref *ref)
+void print_ok_ref_status(struct ref *ref, int porcelain)
 {
 	if (ref->deletion)
-		print_ref_status('-', "[deleted]", ref, NULL, NULL);
+		print_ref_status('-', "[deleted]", ref, NULL, NULL, porcelain);
 	else if (is_null_sha1(ref->old_sha1))
 		print_ref_status('*',
 			(!prefixcmp(ref->name, "refs/tags/") ? "[new tag]" :
 			  "[new branch]"),
-			ref, ref->peer_ref, NULL);
+			ref, ref->peer_ref, NULL, porcelain);
 	else {
 		char quickref[84];
 		char type;
@@ -239,73 +249,77 @@ static void print_ok_ref_status(struct ref *ref)
 		}
 		strcat(quickref, status_abbrev(ref->new_sha1));
 
-		print_ref_status(type, quickref, ref, ref->peer_ref, msg);
+		print_ref_status(type, quickref, ref, ref->peer_ref, msg, porcelain);
 	}
 }
 
-static int print_one_push_status(struct ref *ref, const char *dest, int count)
+int print_one_push_status(struct ref *ref, const char *dest, int count, int porcelain)
 {
 	if (!count)
 		fprintf(stderr, "To %s\n", dest);
 
 	switch(ref->status) {
 	case REF_STATUS_NONE:
-		print_ref_status('X', "[no match]", ref, NULL, NULL);
+		print_ref_status('X', "[no match]", ref, NULL, NULL, porcelain);
 		break;
 	case REF_STATUS_REJECT_NODELETE:
 		print_ref_status('!', "[rejected]", ref, NULL,
-				"remote does not support deleting refs");
+				 "remote does not support deleting refs", porcelain);
 		break;
 	case REF_STATUS_UPTODATE:
 		print_ref_status('=', "[up to date]", ref,
-				ref->peer_ref, NULL);
+				 ref->peer_ref, NULL, porcelain);
 		break;
 	case REF_STATUS_REJECT_NONFASTFORWARD:
 		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
-				"non-fast-forward");
+				 "non-fast-forward", porcelain);
 		break;
 	case REF_STATUS_REMOTE_REJECT:
 		print_ref_status('!', "[remote rejected]", ref,
 				ref->deletion ? NULL : ref->peer_ref,
-				ref->remote_status);
+						 ref->remote_status, porcelain);
 		break;
 	case REF_STATUS_EXPECTING_REPORT:
 		print_ref_status('!', "[remote failure]", ref,
 				ref->deletion ? NULL : ref->peer_ref,
-				"remote failed to report status");
+				"remote failed to report status", porcelain);
 		break;
 	case REF_STATUS_OK:
-		print_ok_ref_status(ref);
+		print_ok_ref_status(ref, porcelain);
 		break;
 	}
 
 	return 1;
 }
 
-static void print_push_status(const char *dest, struct ref *refs)
+void print_push_status(const char *dest, struct ref *refs,
+		  int verbose, int porcelain, int *nonfastforward)
 {
 	struct ref *ref;
 	int n = 0;
 
-	if (args.verbose) {
+	if (verbose) {
 		for (ref = refs; ref; ref = ref->next)
 			if (ref->status == REF_STATUS_UPTODATE)
-				n += print_one_push_status(ref, dest, n);
+				n += print_one_push_status(ref, dest, n, porcelain);
 	}
 
 	for (ref = refs; ref; ref = ref->next)
 		if (ref->status == REF_STATUS_OK)
-			n += print_one_push_status(ref, dest, n);
+			n += print_one_push_status(ref, dest, n, porcelain);
 
+	*nonfastforward = 0;
 	for (ref = refs; ref; ref = ref->next) {
 		if (ref->status != REF_STATUS_NONE &&
 		    ref->status != REF_STATUS_UPTODATE &&
 		    ref->status != REF_STATUS_OK)
-			n += print_one_push_status(ref, dest, n);
+			n += print_one_push_status(ref, dest, n, porcelain);
+		if (ref->status == REF_STATUS_REJECT_NONFASTFORWARD)
+			*nonfastforward = 1;
 	}
 }
 
-static int refs_pushed(struct ref *ref)
+int refs_pushed(struct ref *ref)
 {
 	for (; ref; ref = ref->next) {
 		switch(ref->status) {
@@ -489,7 +503,7 @@ int send_pack(struct send_pack_args *args,
 	return 0;
 }
 
-static void verify_remote_names(int nr_heads, const char **heads)
+void verify_remote_names(int nr_heads, const char **heads)
 {
 	int i;
 
@@ -536,6 +550,7 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 	int send_all = 0;
 	const char *receivepack = "git-receive-pack";
 	int flags;
+	int nonfastforward = 0;
 
 	argv++;
 	for (i = 1; i < argc; i++, argv++) {
@@ -657,12 +672,12 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 	ret |= finish_connect(conn);
 
 	if (!helper_status)
-		print_push_status(dest, remote_refs);
+		print_push_status(dest, remote_refs, args.verbose, 0, &nonfastforward);
 
 	if (!args.dry_run && remote) {
 		struct ref *ref;
 		for (ref = remote_refs; ref; ref = ref->next)
-			update_tracking_ref(remote, ref);
+			update_tracking_ref(remote, ref, args.verbose);
 	}
 
 	if (!ret && !refs_pushed(remote_refs))
diff --git a/send-pack.h b/send-pack.h
index 28141ac..decc23c 100644
--- a/send-pack.h
+++ b/send-pack.h
@@ -16,4 +16,24 @@ int send_pack(struct send_pack_args *args,
 	      int fd[], struct child_process *conn,
 	      struct ref *remote_refs, struct extra_have_objects *extra_have);
 
+void verify_remote_names(int nr_heads, const char **heads);
+
+void update_tracking_ref(struct remote *remote, struct ref *ref, int verbose);
+
+#define SUMMARY_WIDTH (2 * DEFAULT_ABBREV + 3)
+
+void print_ref_status(char flag, const char *summary, struct ref *to,
+		  struct ref *from, const char *msg, int porcelain);
+
+const char *status_abbrev(unsigned char sha1[20]);
+
+void print_ok_ref_status(struct ref *ref, int porcelain);
+
+int print_one_push_status(struct ref *ref, const char *dest, int count, int porcelain);
+
+int refs_pushed(struct ref *ref);
+
+void print_push_status(const char *dest, struct ref *refs,
+		  int verbose, int porcelain, int *nonfastforward);
+
 #endif
diff --git a/transport.c b/transport.c
index 3846aac..aace286 100644
--- a/transport.c
+++ b/transport.c
@@ -573,202 +573,6 @@ static int push_had_errors(struct ref *ref)
 	return 0;
 }
 
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
-static void update_tracking_ref(struct remote *remote, struct ref *ref, int verbose)
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
-		if (verbose)
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
-static void print_ref_status(char flag, const char *summary, struct ref *to, struct ref *from, const char *msg, int porcelain)
-{
-	if (porcelain) {
-		if (from)
-			fprintf(stdout, "%c\t%s:%s\t", flag, from->name, to->name);
-		else
-			fprintf(stdout, "%c\t:%s\t", flag, to->name);
-		if (msg)
-			fprintf(stdout, "%s (%s)\n", summary, msg);
-		else
-			fprintf(stdout, "%s\n", summary);
-	} else {
-		fprintf(stderr, " %c %-*s ", flag, SUMMARY_WIDTH, summary);
-		if (from)
-			fprintf(stderr, "%s -> %s", prettify_refname(from->name), prettify_refname(to->name));
-		else
-			fputs(prettify_refname(to->name), stderr);
-		if (msg) {
-			fputs(" (", stderr);
-			fputs(msg, stderr);
-			fputc(')', stderr);
-		}
-		fputc('\n', stderr);
-	}
-}
-
-static const char *status_abbrev(unsigned char sha1[20])
-{
-	return find_unique_abbrev(sha1, DEFAULT_ABBREV);
-}
-
-static void print_ok_ref_status(struct ref *ref, int porcelain)
-{
-	if (ref->deletion)
-		print_ref_status('-', "[deleted]", ref, NULL, NULL, porcelain);
-	else if (is_null_sha1(ref->old_sha1))
-		print_ref_status('*',
-			(!prefixcmp(ref->name, "refs/tags/") ? "[new tag]" :
-			"[new branch]"),
-			ref, ref->peer_ref, NULL, porcelain);
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
-		print_ref_status(type, quickref, ref, ref->peer_ref, msg, porcelain);
-	}
-}
-
-static int print_one_push_status(struct ref *ref, const char *dest, int count, int porcelain)
-{
-	if (!count)
-		fprintf(stderr, "To %s\n", dest);
-
-	switch(ref->status) {
-	case REF_STATUS_NONE:
-		print_ref_status('X', "[no match]", ref, NULL, NULL, porcelain);
-		break;
-	case REF_STATUS_REJECT_NODELETE:
-		print_ref_status('!', "[rejected]", ref, NULL,
-						 "remote does not support deleting refs", porcelain);
-		break;
-	case REF_STATUS_UPTODATE:
-		print_ref_status('=', "[up to date]", ref,
-						 ref->peer_ref, NULL, porcelain);
-		break;
-	case REF_STATUS_REJECT_NONFASTFORWARD:
-		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
-						 "non-fast-forward", porcelain);
-		break;
-	case REF_STATUS_REMOTE_REJECT:
-		print_ref_status('!', "[remote rejected]", ref,
-						 ref->deletion ? NULL : ref->peer_ref,
-						 ref->remote_status, porcelain);
-		break;
-	case REF_STATUS_EXPECTING_REPORT:
-		print_ref_status('!', "[remote failure]", ref,
-						 ref->deletion ? NULL : ref->peer_ref,
-						 "remote failed to report status", porcelain);
-		break;
-	case REF_STATUS_OK:
-		print_ok_ref_status(ref, porcelain);
-		break;
-	}
-
-	return 1;
-}
-
-static void print_push_status(const char *dest, struct ref *refs,
-			      int verbose, int porcelain, int * nonfastforward)
-{
-	struct ref *ref;
-	int n = 0;
-
-	if (verbose) {
-		for (ref = refs; ref; ref = ref->next)
-			if (ref->status == REF_STATUS_UPTODATE)
-				n += print_one_push_status(ref, dest, n, porcelain);
-	}
-
-	for (ref = refs; ref; ref = ref->next)
-		if (ref->status == REF_STATUS_OK)
-			n += print_one_push_status(ref, dest, n, porcelain);
-
-	*nonfastforward = 0;
-	for (ref = refs; ref; ref = ref->next) {
-		if (ref->status != REF_STATUS_NONE &&
-		    ref->status != REF_STATUS_UPTODATE &&
-		    ref->status != REF_STATUS_OK)
-			n += print_one_push_status(ref, dest, n, porcelain);
-		if (ref->status == REF_STATUS_REJECT_NONFASTFORWARD)
-			*nonfastforward = 1;
-	}
-}
-
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
 static int git_transport_push(struct transport *transport, struct ref *remote_refs, int flags)
 {
 	struct git_transport_data *data = transport->data;
-- 
1.7.0.1571.g856c2
