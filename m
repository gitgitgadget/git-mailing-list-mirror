From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 18/26] update-ref --stdin: Reimplement using reference transactions
Date: Mon, 10 Mar 2014 13:46:35 +0100
Message-ID: <1394455603-2968-19-git-send-email-mhagger@alum.mit.edu>
References: <1394455603-2968-1-git-send-email-mhagger@alum.mit.edu>
Cc: Brad King <brad.king@kitware.com>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 10 13:47:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WMzcB-0007eS-U0
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 13:47:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753593AbaCJMr1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 08:47:27 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:57598 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753524AbaCJMrZ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Mar 2014 08:47:25 -0400
X-AuditID: 1207440d-f79d86d0000043db-84-531db45ced20
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id FC.47.17371.C54BD135; Mon, 10 Mar 2014 08:47:24 -0400 (EDT)
Received: from michael.fritz.box (p57A2497B.dip0.t-ipconnect.de [87.162.73.123])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2ACkjwg025479
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 10 Mar 2014 08:47:23 -0400
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1394455603-2968-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsUixO6iqBuzRTbY4MphU4ud6yQsuq50M1k0
	9F5htph3dxeTxe0V85ktfrT0MFt87FzA7MDu8ff9ByaPnbPusntcevmdzePjs+XsHs969zB6
	XLyk7PF5k1wAexS3TVJiSVlwZnqevl0Cd0bnojWMBWdMK05NtW9gXK7dxcjJISFgIvFwwWE2
	CFtM4sK99UA2F4eQwGVGibvfvzNBOCeYJO5dnANWxSagK7Gop5kJxBYRUJOY2HaIBaSIWeAK
	o8Tnr7/YQRLCAsESd+YeZgWxWQRUJQ6vmc8MYvMKuEjcPt3MDrFOTmLK7wVgNidQfPqVB2C2
	kICzxMs9zawTGHkXMDKsYpRLzCnN1c1NzMwpTk3WLU5OzMtLLdI10svNLNFLTSndxAgJPd4d
	jP/XyRxiFOBgVOLhPfBWJliINbGsuDL3EKMkB5OSKO/EtbLBQnxJ+SmVGYnFGfFFpTmpxYcY
	JTiYlUR4MxcD5XhTEiurUovyYVLSHCxK4rxqS9T9hATSE0tSs1NTC1KLYLIyHBxKErz1m4Ea
	BYtS01Mr0jJzShDSTBycIMO5pESKU/NSUosSS0sy4kGxEV8MjA6QFA/Q3m0g7bzFBYm5QFGI
	1lOMilLivHNAEgIgiYzSPLixsITyilEc6Eth3laQKh5gMoLrfgU0mAlocPNxKZDBJYkIKakG
	RkUe4Zxm/Tt/jlUIZmycw5pQWHZINEu03iXifSmrkf/UmgMac4zX30krEXdrETh14z/vrBW1
	CzfkmV6SSU7o/vB7kmvrX+PDIhOsU+f9a75dPTU+R1jKbDNf2ZG4upDl1Xr9hqn3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243740>

This change is mostly clerical: the parse_cmd_*() functions need to
use local variables rather than a struct ref_update to collect the
arguments needed for each update, and then call queue_*_ref() to queue
the change rather than building up the list of changes at the caller
side.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/update-ref.c | 142 +++++++++++++++++++++++++++------------------------
 1 file changed, 76 insertions(+), 66 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index ac41635..ffed061 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -12,29 +12,11 @@ static const char * const git_update_ref_usage[] = {
 	NULL
 };
 
-static int updates_alloc;
-static int updates_count;
-static struct ref_update **updates;
+static struct ref_transaction *transaction;
 
 static char line_termination = '\n';
 static int update_flags;
 
-static struct ref_update *update_alloc(void)
-{
-	struct ref_update *update;
-
-	/* Allocate and zero-init a struct ref_update */
-	update = xcalloc(1, sizeof(*update));
-	ALLOC_GROW(updates, updates_count + 1, updates_alloc);
-	updates[updates_count++] = update;
-
-	/* Store and reset accumulated options */
-	update->flags = update_flags;
-	update_flags = 0;
-
-	return update;
-}
-
 /*
  * Parse one whitespace- or NUL-terminated, possibly C-quoted argument
  * and append the result to arg.  Return a pointer to the terminator.
@@ -174,95 +156,118 @@ static int parse_next_sha1(struct strbuf *input, const char **next,
 
 static const char *parse_cmd_update(struct strbuf *input, const char *next)
 {
-	struct ref_update *update;
-
-	update = update_alloc();
+	char *refname;
+	unsigned char new_sha1[20];
+	unsigned char old_sha1[20];
+	int have_old;
 
-	update->ref_name = parse_refname(input, &next);
-	if (!update->ref_name)
+	refname = parse_refname(input, &next);
+	if (!refname)
 		die("update: missing <ref>");
 
-	if (parse_next_sha1(input, &next, update->new_sha1,
-			    "update", update->ref_name, 0))
-		die("update %s: missing <newvalue>", update->ref_name);
+	if (parse_next_sha1(input, &next, new_sha1,
+			    "update", refname, 0))
+		die("update %s: missing <newvalue>", refname);
 
-	update->have_old = !parse_next_sha1(input, &next, update->old_sha1,
-					    "update", update->ref_name, 1);
+	have_old = !parse_next_sha1(input, &next, old_sha1,
+				    "update", refname, 1);
 
 	if (*next != line_termination)
-		die("update %s: extra input: %s", update->ref_name, next);
+		die("update %s: extra input: %s", refname, next);
+
+	queue_update_ref(transaction, refname, new_sha1, old_sha1,
+			 update_flags, have_old);
+
+	update_flags = 0;
+	free(refname);
 
 	return next;
 }
 
 static const char *parse_cmd_create(struct strbuf *input, const char *next)
 {
-	struct ref_update *update;
-
-	update = update_alloc();
+	char *refname;
+	unsigned char new_sha1[20];
 
-	update->ref_name = parse_refname(input, &next);
-	if (!update->ref_name)
+	refname = parse_refname(input, &next);
+	if (!refname)
 		die("create: missing <ref>");
 
-	if (parse_next_sha1(input, &next, update->new_sha1,
-			    "create", update->ref_name, 0))
-		die("create %s: missing <newvalue>", update->ref_name);
+	if (parse_next_sha1(input, &next, new_sha1,
+			    "create", refname, 0))
+		die("create %s: missing <newvalue>", refname);
 
-	if (is_null_sha1(update->new_sha1))
-		die("create %s: zero <newvalue>", update->ref_name);
+	if (is_null_sha1(new_sha1))
+		die("create %s: zero <newvalue>", refname);
 
 	if (*next != line_termination)
-		die("create %s: extra input: %s", update->ref_name, next);
+		die("create %s: extra input: %s", refname, next);
+
+	queue_create_ref(transaction, refname, new_sha1, update_flags);
+
+	update_flags = 0;
+	free(refname);
 
 	return next;
 }
 
 static const char *parse_cmd_delete(struct strbuf *input, const char *next)
 {
-	struct ref_update *update;
+	char *refname;
+	unsigned char old_sha1[20];
+	int have_old;
 
-	update = update_alloc();
-
-	update->ref_name = parse_refname(input, &next);
-	if (!update->ref_name)
+	refname = parse_refname(input, &next);
+	if (!refname)
 		die("delete: missing <ref>");
 
-	if (parse_next_sha1(input, &next, update->old_sha1,
-			    "delete", update->ref_name, 1)) {
-		update->have_old = 0;
+	if (parse_next_sha1(input, &next, old_sha1, "delete", refname, 1)) {
+		have_old = 0;
 	} else {
-		if (is_null_sha1(update->old_sha1))
-			die("delete %s: zero <oldvalue>", update->ref_name);
-		update->have_old = 1;
+		if (is_null_sha1(old_sha1))
+			die("delete %s: zero <oldvalue>", refname);
+		have_old = 1;
 	}
 
 	if (*next != line_termination)
-		die("delete %s: extra input: %s", update->ref_name, next);
+		die("delete %s: extra input: %s", refname, next);
+
+	queue_delete_ref(transaction, refname, old_sha1, update_flags, have_old);
+
+	update_flags = 0;
+	free(refname);
 
 	return next;
 }
 
 static const char *parse_cmd_verify(struct strbuf *input, const char *next)
 {
-	struct ref_update *update;
-
-	update = update_alloc();
+	char *refname;
+	unsigned char new_sha1[20];
+	unsigned char old_sha1[20];
+	int have_old;
 
-	update->ref_name = parse_refname(input, &next);
-	if (!update->ref_name)
+	refname = parse_refname(input, &next);
+	if (!refname)
 		die("verify: missing <ref>");
 
-	if (parse_next_sha1(input, &next, update->old_sha1,
-			    "verify", update->ref_name, 1)) {
-		update->have_old = 0;
+	if (parse_next_sha1(input, &next, old_sha1,
+			    "verify", refname, 1)) {
+		hashclr(new_sha1);
+		have_old = 0;
 	} else {
-		hashcpy(update->new_sha1, update->old_sha1);
-		update->have_old = 1;
+		hashcpy(new_sha1, old_sha1);
+		have_old = 1;
 	}
 
 	if (*next != line_termination)
-		die("verify %s: extra input: %s", update->ref_name, next);
+		die("verify %s: extra input: %s", refname, next);
+
+	queue_update_ref(transaction, refname, new_sha1, old_sha1,
+			 update_flags, have_old);
+
+	update_flags = 0;
+	free(refname);
 
 	return next;
 }
@@ -331,13 +336,18 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 		die("Refusing to perform update with empty message.");
 
 	if (read_stdin) {
+		int ret;
+		transaction = create_ref_transaction();
+
 		if (delete || no_deref || argc > 0)
 			usage_with_options(git_update_ref_usage, options);
 		if (end_null)
 			line_termination = '\0';
 		update_refs_stdin();
-		return update_refs(msg, updates, updates_count,
-				   UPDATE_REFS_DIE_ON_ERR);
+		ret = commit_ref_transaction(transaction, msg,
+					     UPDATE_REFS_DIE_ON_ERR);
+		free_ref_transaction(transaction);
+		return ret;
 	}
 
 	if (end_null)
-- 
1.9.0
