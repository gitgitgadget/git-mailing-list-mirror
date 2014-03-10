From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 10/26] update-ref.c: Extract a new function, parse_refname()
Date: Mon, 10 Mar 2014 13:46:27 +0100
Message-ID: <1394455603-2968-11-git-send-email-mhagger@alum.mit.edu>
References: <1394455603-2968-1-git-send-email-mhagger@alum.mit.edu>
Cc: Brad King <brad.king@kitware.com>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 10 13:48:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WMzd6-0000CV-TL
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 13:48:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753560AbaCJMrN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 08:47:13 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:49916 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753538AbaCJMrJ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Mar 2014 08:47:09 -0400
X-AuditID: 12074411-f79ab6d000002f0e-e4-531db44c2de4
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 54.DD.12046.C44BD135; Mon, 10 Mar 2014 08:47:08 -0400 (EDT)
Received: from michael.fritz.box (p57A2497B.dip0.t-ipconnect.de [87.162.73.123])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2ACkjwY025479
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 10 Mar 2014 08:47:07 -0400
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1394455603-2968-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsUixO6iqOuzRTbY4OtkI4ud6yQsuq50M1k0
	9F5htph3dxeTxe0V85ktfrT0MFt87FzA7MDu8ff9ByaPnbPusntcevmdzePjs+XsHs969zB6
	XLyk7PF5k1wAexS3TVJiSVlwZnqevl0Cd8aP5euYCnabVHS/WsfewLhHq4uRk0NCwETi4Z6P
	zBC2mMSFe+vZuhi5OIQELjNKbH48hRXCOcEkcWLmQSaQKjYBXYlFPc1gtoiAmsTEtkMsIEXM
	AlcYJT5//cUOkhAW8JH4tGwzK4jNIqAqcWXZO7A4r4CLxIMrn9gh1slJTPm9AMzmBIpPv/IA
	zBYScJZ4uaeZdQIj7wJGhlWMcok5pbm6uYmZOcWpybrFyYl5ealFuqZ6uZkleqkppZsYIcEn
	uINxxkm5Q4wCHIxKPLwH38oEC7EmlhVX5h5ilORgUhLlnbhWNliILyk/pTIjsTgjvqg0J7X4
	EKMEB7OSCG/mYqAcb0piZVVqUT5MSpqDRUmcl2+Jup+QQHpiSWp2ampBahFMVoaDQ0mCt34z
	UKNgUWp6akVaZk4JQpqJgxNkOJeUSHFqXkpqUWJpSUY8KDrii4HxAZLiAdq7DaSdt7ggMRco
	CtF6ilFRSpx3DkhCACSRUZoHNxaWUl4xigN9KczbClLFA0xHcN2vgAYzAQ1uPi4FMrgkESEl
	1cBYNNNqmzD/tGgz/tgP/5rNdbyPVZw36LqxcPXLuh1LznAo6k4ufr25sl84fvNEp+LUtBUO
	AXuL080kld65SQbwc/+arc0cmV7/bet5o+S4Y1+PHmTlmy/yTaZNcmv0DcGUz9Xv 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243750>

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
1.9.0
