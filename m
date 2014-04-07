From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 20/27] update-ref --stdin: reimplement using reference transactions
Date: Mon,  7 Apr 2014 15:48:11 +0200
Message-ID: <1396878498-19887-21-git-send-email-mhagger@alum.mit.edu>
References: <1396878498-19887-1-git-send-email-mhagger@alum.mit.edu>
Cc: Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 07 15:50:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WX9w1-0003S5-BU
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 15:50:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755414AbaDGNt5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2014 09:49:57 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:65450 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755386AbaDGNtF (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Apr 2014 09:49:05 -0400
X-AuditID: 12074412-f79d46d000002e58-94-5342accf61de
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id B2.ED.11864.FCCA2435; Mon,  7 Apr 2014 09:49:03 -0400 (EDT)
Received: from michael.fritz.box (p5B156B1D.dip0.t-ipconnect.de [91.21.107.29])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s37DmJaR026029
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 7 Apr 2014 09:49:01 -0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1396878498-19887-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsUixO6iqHt+jVOwwbejPBY710lYdF3pZrJo
	6L3CbDHv7i4mi9sr5jNb/GjpYbb42LmA2YHd4+/7D0weO2fdZfe49PI7m8fHZ8vZPZ717mH0
	uHhJ2ePzJrkA9ihum6TEkrLgzPQ8fbsE7ozjZ3YwFhwxq1g+tYW9gbFJp4uRk0NCwERizZfF
	jBC2mMSFe+vZuhi5OIQELjNKXD7awwThHGOS+Df3JDtIFZuArsSinmYmEFtEQE1iYtshFpAi
	ZoErjBJXPm5nAUkIC4RJ3GyfwAxiswioSiy7/hFsBa+Aq8ShOROh1slJnDw2mRXE5gSKzzh0
	CywuJOAicX/NMZYJjLwLGBlWMcol5pTm6uYmZuYUpybrFicn5uWlFuma6eVmluilppRuYoQE
	n9AOxvUn5Q4xCnAwKvHwrjjkGCzEmlhWXJl7iFGSg0lJlPf5MqdgIb6k/JTKjMTijPii0pzU
	4kOMEhzMSiK8XKuBcrwpiZVVqUX5MClpDhYlcd6fi9X9hATSE0tSs1NTC1KLYLIyHBxKEryN
	II2CRanpqRVpmTklCGkmDk6Q4VxSIsWpeSmpRYmlJRnxoOiILwbGB0iKB2jvXLC9xQWJuUBR
	iNZTjIpS4rwlIAkBkERGaR7cWFhKecUoDvSlMG8BSBUPMB3Bdb8CGswENNjQFWxwSSJCSqqB
	cdq1K11znRVsPGv4k2UM+HrtLbX/xFq03+I5ebj93mURlznHXl2xdWr3kTj61PNf6K3H8sGn
	136ueV34o7ip/ZrDBaM337buWXJFcI1PaHjx/e3Ft1TnnZlZFvp8yjWVurr0k3+k 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245857>

This change is mostly clerical: the parse_cmd_*() functions need to
use local variables rather than a struct ref_update to collect the
arguments needed for each update, and then call ref_transaction_*() to
queue the change rather than building up the list of changes at the
caller side.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/update-ref.c | 142 +++++++++++++++++++++++++++------------------------
 1 file changed, 75 insertions(+), 67 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 423c5c3..405267f 100644
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
@@ -196,97 +178,119 @@ static int parse_next_sha1(struct strbuf *input, const char **next,
 
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
-			    "update", update->ref_name,
+	if (parse_next_sha1(input, &next, new_sha1, "update", refname,
 			    PARSE_SHA1_ALLOW_EMPTY))
-		die("update %s: missing <newvalue>", update->ref_name);
+		die("update %s: missing <newvalue>", refname);
 
-	update->have_old = !parse_next_sha1(input, &next, update->old_sha1,
-					    "update", update->ref_name,
-					    PARSE_SHA1_OLD);
+	have_old = !parse_next_sha1(input, &next, old_sha1, "update", refname,
+				    PARSE_SHA1_OLD);
 
 	if (*next != line_termination)
-		die("update %s: extra input: %s", update->ref_name, next);
+		die("update %s: extra input: %s", refname, next);
+
+	ref_transaction_update(transaction, refname, new_sha1, old_sha1,
+			       update_flags, have_old);
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
+	if (parse_next_sha1(input, &next, new_sha1, "create", refname, 0))
+		die("create %s: missing <newvalue>", refname);
 
-	if (is_null_sha1(update->new_sha1))
-		die("create %s: zero <newvalue>", update->ref_name);
+	if (is_null_sha1(new_sha1))
+		die("create %s: zero <newvalue>", refname);
 
 	if (*next != line_termination)
-		die("create %s: extra input: %s", update->ref_name, next);
+		die("create %s: extra input: %s", refname, next);
+
+	ref_transaction_create(transaction, refname, new_sha1, update_flags);
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
-			    "delete", update->ref_name, PARSE_SHA1_OLD)) {
-		update->have_old = 0;
+	if (parse_next_sha1(input, &next, old_sha1, "delete", refname,
+			    PARSE_SHA1_OLD)) {
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
+	ref_transaction_delete(transaction, refname, old_sha1,
+			       update_flags, have_old);
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
-			    "verify", update->ref_name, PARSE_SHA1_OLD)) {
-		update->have_old = 0;
+	if (parse_next_sha1(input, &next, old_sha1, "verify", refname,
+			    PARSE_SHA1_OLD)) {
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
+	ref_transaction_update(transaction, refname, new_sha1, old_sha1,
+			       update_flags, have_old);
+
+	update_flags = 0;
+	free(refname);
 
 	return next;
 }
@@ -355,13 +359,17 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 		die("Refusing to perform update with empty message.");
 
 	if (read_stdin) {
+		int ret;
+		transaction = ref_transaction_begin();
+
 		if (delete || no_deref || argc > 0)
 			usage_with_options(git_update_ref_usage, options);
 		if (end_null)
 			line_termination = '\0';
 		update_refs_stdin();
-		return update_refs(msg, updates, updates_count,
-				   UPDATE_REFS_DIE_ON_ERR);
+		ret = ref_transaction_commit(transaction, msg,
+					     UPDATE_REFS_DIE_ON_ERR);
+		return ret;
 	}
 
 	if (end_null)
-- 
1.9.1
