From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 09/27] update-ref.c: extract a new function, parse_refname()
Date: Mon,  7 Apr 2014 15:48:00 +0200
Message-ID: <1396878498-19887-10-git-send-email-mhagger@alum.mit.edu>
References: <1396878498-19887-1-git-send-email-mhagger@alum.mit.edu>
Cc: Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 07 15:49:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WX9vE-0002r5-8L
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 15:49:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755379AbaDGNs5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2014 09:48:57 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:56682 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754790AbaDGNsm (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Apr 2014 09:48:42 -0400
X-AuditID: 1207440e-f79c76d000003e2c-28-5342acb9bb8f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 90.49.15916.9BCA2435; Mon,  7 Apr 2014 09:48:41 -0400 (EDT)
Received: from michael.fritz.box (p5B156B1D.dip0.t-ipconnect.de [91.21.107.29])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s37DmJaG026029
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 7 Apr 2014 09:48:39 -0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1396878498-19887-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPIsWRmVeSWpSXmKPExsUixO6iqLtzjVOwwfwNChY710lYdF3pZrJo
	6L3CbDHv7i4mi9sr5jNb/GjpYbb42LmA2YHd4+/7D0weO2fdZfe49PI7m8fHZ8vZPZ717mH0
	uHhJ2ePzJrkA9ihum6TEkrLgzPQ8fbsE7oypT50KdptUTJ+9k7GBcY9WFyMnh4SAicTHWXeY
	IWwxiQv31rN1MXJxCAlcZpRo/36BHcI5xiTx/l83C0gVm4CuxKKeZiYQW0RATWJi2yEWkCJm
	gSuMElc+bgcrEhbwl3g7r5sNxGYRUJV4/rcdqIGDg1fAVWLHp3SIbXISJ49NZgWxOYHCMw7d
	YgSxhQRcJO6vOcYygZF3ASPDKka5xJzSXN3cxMyc4tRk3eLkxLy81CJdY73czBK91JTSTYyQ
	wOPbwdi+XuYQowAHoxIP74pDjsFCrIllxZW5hxglOZiURHmfL3MKFuJLyk+pzEgszogvKs1J
	LT7EKMHBrCTCy7UaKMebklhZlVqUD5OS5mBREudVW6LuJySQnliSmp2aWpBaBJOV4eBQkuBd
	D9IoWJSanlqRlplTgpBm4uAEGc4lJVKcmpeSWpRYWpIRD4qM+GJgbICkeID2zgXbW1yQmAsU
	hWg9xagoJc5bApIQAElklObBjYWlk1eM4kBfCvM+B6niAaYiuO5XQIOZgAYbuoINLklESEk1
	MNr8ELquZi0z9buLeKfcp/4HsU3rDpxymdTxp7Y7zepy6uJ0jj7Z1LhZe9LuBGRGZnOnrnP0
	F756/biw9/1tUyO+hlifyPv7xTDuvrPQjJCgqCsHN6j8ua+wKD6b9ViUTsQMJf+l 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245844>

There is no reason to obscure the fact that parse_first_arg() always
parses refnames.  Form the new function by combining parse_first_arg()
and update_store_ref_name().

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/update-ref.c | 90 ++++++++++++++++++++++++----------------------------
 1 file changed, 41 insertions(+), 49 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 51adf2d..0dc2061 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -35,14 +35,6 @@ static struct ref_update *update_alloc(void)
 	return update;
 }
 
-static void update_store_ref_name(struct ref_update *update,
-				  const char *ref_name)
-{
-	if (check_refname_format(ref_name, REFNAME_ALLOW_ONELEVEL))
-		die("invalid ref format: %s", ref_name);
-	update->ref_name = xstrdup(ref_name);
-}
-
 static void update_store_new_sha1(struct ref_update *update,
 				  const char *newvalue)
 {
@@ -86,23 +78,35 @@ static const char *parse_arg(const char *next, struct strbuf *arg)
 }
 
 /*
- * Parse the argument immediately after "command SP".  If not -z, then
- * handle C-quoting.  Write the argument to arg.  Set *next to point
- * at the character that terminates the argument.  Die if C-quoting is
- * malformed.
+ * Parse the reference name immediately after "command SP".  If not
+ * -z, then handle C-quoting.  Return a pointer to a newly allocated
+ * string containing the name of the reference, or NULL if there was
+ * an error.  Update *next to point at the character that terminates
+ * the argument.  Die if C-quoting is malformed or the reference name
+ * is invalid.
  */
-static void parse_first_arg(struct strbuf *input, const char **next,
-			    struct strbuf *arg)
+static char *parse_refname(struct strbuf *input, const char **next)
 {
-	strbuf_reset(arg);
+	struct strbuf ref = STRBUF_INIT;
+
 	if (line_termination) {
 		/* Without -z, use the next argument */
-		*next = parse_arg(*next, arg);
+		*next = parse_arg(*next, &ref);
 	} else {
 		/* With -z, use everything up to the next NUL */
-		strbuf_addstr(arg, *next);
-		*next += arg->len;
+		strbuf_addstr(&ref, *next);
+		*next += ref.len;
+	}
+
+	if (!ref.len) {
+		strbuf_release(&ref);
+		return NULL;
 	}
+
+	if (check_refname_format(ref.buf, REFNAME_ALLOW_ONELEVEL))
+		die("invalid ref format: %s", ref.buf);
+
+	return strbuf_detach(&ref, NULL);
 }
 
 /*
@@ -150,111 +154,99 @@ static int parse_next_arg(struct strbuf *input, const char **next,
 
 static const char *parse_cmd_update(struct strbuf *input, const char *next)
 {
-	struct strbuf ref = STRBUF_INIT;
 	struct strbuf newvalue = STRBUF_INIT;
 	struct strbuf oldvalue = STRBUF_INIT;
 	struct ref_update *update;
 
 	update = update_alloc();
 
-	parse_first_arg(input, &next, &ref);
-	if (ref.buf[0])
-		update_store_ref_name(update, ref.buf);
-	else
+	update->ref_name = parse_refname(input, &next);
+	if (!update->ref_name)
 		die("update line missing <ref>");
 
 	if (!parse_next_arg(input, &next, &newvalue))
 		update_store_new_sha1(update, newvalue.buf);
 	else
-		die("update %s missing <newvalue>", ref.buf);
+		die("update %s missing <newvalue>", update->ref_name);
 
 	if (!parse_next_arg(input, &next, &oldvalue)) {
 		update_store_old_sha1(update, oldvalue.buf);
 		if (*next != line_termination)
-			die("update %s has extra input: %s", ref.buf, next);
+			die("update %s has extra input: %s", update->ref_name, next);
 	} else if (!line_termination)
-		die("update %s missing [<oldvalue>] NUL", ref.buf);
+		die("update %s missing [<oldvalue>] NUL", update->ref_name);
 
 	return next;
 }
 
 static const char *parse_cmd_create(struct strbuf *input, const char *next)
 {
-	struct strbuf ref = STRBUF_INIT;
 	struct strbuf newvalue = STRBUF_INIT;
 	struct ref_update *update;
 
 	update = update_alloc();
 
-	parse_first_arg(input, &next, &ref);
-	if (ref.buf[0])
-		update_store_ref_name(update, ref.buf);
-	else
+	update->ref_name = parse_refname(input, &next);
+	if (!update->ref_name)
 		die("create line missing <ref>");
 
 	if (!parse_next_arg(input, &next, &newvalue))
 		update_store_new_sha1(update, newvalue.buf);
 	else
-		die("create %s missing <newvalue>", ref.buf);
+		die("create %s missing <newvalue>", update->ref_name);
 
 	if (is_null_sha1(update->new_sha1))
-		die("create %s given zero new value", ref.buf);
+		die("create %s given zero new value", update->ref_name);
 
 	if (*next != line_termination)
-		die("create %s has extra input: %s", ref.buf, next);
+		die("create %s has extra input: %s", update->ref_name, next);
 
 	return next;
 }
 
 static const char *parse_cmd_delete(struct strbuf *input, const char *next)
 {
-	struct strbuf ref = STRBUF_INIT;
 	struct strbuf oldvalue = STRBUF_INIT;
 	struct ref_update *update;
 
 	update = update_alloc();
 
-	parse_first_arg(input, &next, &ref);
-	if (ref.buf[0])
-		update_store_ref_name(update, ref.buf);
-	else
+	update->ref_name = parse_refname(input, &next);
+	if (!update->ref_name)
 		die("delete line missing <ref>");
 
 	if (!parse_next_arg(input, &next, &oldvalue)) {
 		update_store_old_sha1(update, oldvalue.buf);
 		if (update->have_old && is_null_sha1(update->old_sha1))
-			die("delete %s given zero old value", ref.buf);
+			die("delete %s given zero old value", update->ref_name);
 	} else if (!line_termination)
-		die("delete %s missing [<oldvalue>] NUL", ref.buf);
+		die("delete %s missing [<oldvalue>] NUL", update->ref_name);
 
 	if (*next != line_termination)
-		die("delete %s has extra input: %s", ref.buf, next);
+		die("delete %s has extra input: %s", update->ref_name, next);
 
 	return next;
 }
 
 static const char *parse_cmd_verify(struct strbuf *input, const char *next)
 {
-	struct strbuf ref = STRBUF_INIT;
 	struct strbuf value = STRBUF_INIT;
 	struct ref_update *update;
 
 	update = update_alloc();
 
-	parse_first_arg(input, &next, &ref);
-	if (ref.buf[0])
-		update_store_ref_name(update, ref.buf);
-	else
+	update->ref_name = parse_refname(input, &next);
+	if (!update->ref_name)
 		die("verify line missing <ref>");
 
 	if (!parse_next_arg(input, &next, &value)) {
 		update_store_old_sha1(update, value.buf);
 		hashcpy(update->new_sha1, update->old_sha1);
 	} else if (!line_termination)
-		die("verify %s missing [<oldvalue>] NUL", ref.buf);
+		die("verify %s missing [<oldvalue>] NUL", update->ref_name);
 
 	if (*next != line_termination)
-		die("verify %s has extra input: %s", ref.buf, next);
+		die("verify %s has extra input: %s", update->ref_name, next);
 
 	return next;
 }
-- 
1.9.1
