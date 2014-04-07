From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 07/27] update-ref --stdin: read the whole input at once
Date: Mon,  7 Apr 2014 15:47:58 +0200
Message-ID: <1396878498-19887-8-git-send-email-mhagger@alum.mit.edu>
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
	id 1WX9vD-0002r5-GE
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 15:49:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755372AbaDGNsv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2014 09:48:51 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:57526 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755347AbaDGNsj (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Apr 2014 09:48:39 -0400
X-AuditID: 12074411-f79ab6d000002f0e-88-5342acb5f2f7
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id E7.AF.12046.5BCA2435; Mon,  7 Apr 2014 09:48:37 -0400 (EDT)
Received: from michael.fritz.box (p5B156B1D.dip0.t-ipconnect.de [91.21.107.29])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s37DmJaE026029
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 7 Apr 2014 09:48:35 -0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1396878498-19887-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsUixO6iqLt1jVOwwYwFihY710lYdF3pZrJo
	6L3CbDHv7i4mi9sr5jNb/GjpYbb42LmA2YHd4+/7D0weO2fdZfe49PI7m8fHZ8vZPZ717mH0
	uHhJ2ePzJrkA9ihum6TEkrLgzPQ8fbsE7oyL37ezF7z1q5i7ZyVLA2OHfRcjJ4eEgInEpnk9
	zBC2mMSFe+vZuhi5OIQELjNKPO19ywjhHGOSeNN/jAWkik1AV2JRTzMTiC0ioCYxse0QC0gR
	s8AVRokrH7eDFQkLeEl0TXvKCGKzCKhKzH97ECzOK+Ai0T25lQlinZzEyWOTWUFsTgFXiRmH
	boHVCwHV3F9zjGUCI+8CRoZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRbqmermZJXqpKaWbGCHB
	J7iDccZJuUOMAhyMSjy8Kw45BguxJpYVV+YeYpTkYFIS5X2+zClYiC8pP6UyI7E4I76oNCe1
	+BCjBAezkggv12qgHG9KYmVValE+TEqag0VJnJdvibqfkEB6YklqdmpqQWoRTFaGg0NJgnc9
	SKNgUWp6akVaZk4JQpqJgxNkOJeUSHFqXkpqUWJpSUY8KDrii4HxAZLiAdo7F2xvcUFiLlAU
	ovUUo6KUOG8JSEIAJJFRmgc3FpZSXjGKA30pzLsBpIoHmI7gul8BDWYCGmzoCja4JBEhJdXA
	6Kuqx1N47tyBrX6rt17mNPHT61jufW/rD85tKhUtKe+X39oiGfzec9+qK1wBm2t6z916cfNl
	o6xhc4v4G4O7a4qtM/cYLlYWCdGd2920hXOrZ6DX459iamJ5W34vWL581SsRT6dI 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245843>

Read the whole input into a strbuf at once, and then parse it from
there.  This might also be a tad faster, but that is not the point.
The point is to decouple the parsing code from the input source (the
old parsing code had to read new data even in the middle of commands).
Add docstrings for the parsing functions.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/update-ref.c | 170 ++++++++++++++++++++++++++++++++-------------------
 1 file changed, 108 insertions(+), 62 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index a8a68e8..5f197fe 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -85,44 +85,70 @@ static const char *parse_arg(const char *next, struct strbuf *arg)
 	return next;
 }
 
-static const char *parse_first_arg(const char *next, struct strbuf *arg)
+/*
+ * Parse the argument immediately after "command SP".  If not -z, then
+ * handle C-quoting.  Write the argument to arg.  Set *next to point
+ * at the character that terminates the argument.  Die if C-quoting is
+ * malformed.
+ */
+static void parse_first_arg(struct strbuf *input, const char **next,
+			    struct strbuf *arg)
 {
-	/* Parse argument immediately after "command SP" */
 	strbuf_reset(arg);
 	if (line_termination) {
 		/* Without -z, use the next argument */
-		next = parse_arg(next, arg);
+		*next = parse_arg(*next, arg);
 	} else {
-		/* With -z, use rest of first NUL-terminated line */
-		strbuf_addstr(arg, next);
-		next = next + arg->len;
+		/* With -z, use everything up to the next NUL */
+		strbuf_addstr(arg, *next);
+		*next += arg->len;
 	}
-	return next;
 }
 
-static const char *parse_next_arg(const char *next, struct strbuf *arg)
+/*
+ * Parse a SP/NUL separator followed by the next SP- or NUL-terminated
+ * argument, if any.  If there is an argument, write it to arg, set
+ * *next to point at the character terminating the argument, and
+ * return 0.  If there is no argument at all (not even the empty
+ * string), return a non-zero result and leave *next unchanged.
+ */
+static int parse_next_arg(struct strbuf *input, const char **next,
+			  struct strbuf *arg)
 {
-	/* Parse next SP-terminated or NUL-terminated argument, if any */
 	strbuf_reset(arg);
 	if (line_termination) {
 		/* Without -z, consume SP and use next argument */
-		if (!*next)
-			return NULL;
-		if (*next != ' ')
-			die("expected SP but got: %s", next);
-		next = parse_arg(next + 1, arg);
+		if (!**next || **next == line_termination)
+			return -1;
+		if (**next != ' ')
+			die("expected SP but got: %s", *next);
+		(*next)++;
+		*next = parse_arg(*next, arg);
 	} else {
 		/* With -z, read the next NUL-terminated line */
-		if (*next)
-			die("expected NUL but got: %s", next);
-		if (strbuf_getline(arg, stdin, '\0') == EOF)
-			return NULL;
-		next = arg->buf + arg->len;
+		if (**next)
+			die("expected NUL but got: %s", *next);
+		(*next)++;
+		if (*next == input->buf + input->len)
+			return -1;
+		strbuf_addstr(arg, *next);
+		*next += arg->len;
 	}
-	return next;
+	return 0;
 }
 
-static void parse_cmd_update(const char *next)
+
+/*
+ * The following five parse_cmd_*() functions parse the corresponding
+ * command.  In each case, next points at the character following the
+ * command name and the following space.  They each return a pointer
+ * to the character terminating the command, and die with an
+ * explanatory message if there are any parsing problems.  All of
+ * these functions handle either text or binary format input,
+ * depending on how line_termination is set.
+ */
+
+static const char *parse_cmd_update(struct strbuf *input, const char *next)
 {
 	struct strbuf ref = STRBUF_INIT;
 	struct strbuf newvalue = STRBUF_INIT;
@@ -131,26 +157,28 @@ static void parse_cmd_update(const char *next)
 
 	update = update_alloc();
 
-	if ((next = parse_first_arg(next, &ref)) != NULL && ref.buf[0])
+	parse_first_arg(input, &next, &ref);
+	if (ref.buf[0])
 		update_store_ref_name(update, ref.buf);
 	else
 		die("update line missing <ref>");
 
-	if ((next = parse_next_arg(next, &newvalue)) != NULL)
+	if (!parse_next_arg(input, &next, &newvalue))
 		update_store_new_sha1(update, newvalue.buf);
 	else
 		die("update %s missing <newvalue>", ref.buf);
 
-	if ((next = parse_next_arg(next, &oldvalue)) != NULL)
+	if (!parse_next_arg(input, &next, &oldvalue)) {
 		update_store_old_sha1(update, oldvalue.buf);
-	else if(!line_termination)
+		if (*next != line_termination)
+			die("update %s has extra input: %s", ref.buf, next);
+	} else if (!line_termination)
 		die("update %s missing [<oldvalue>] NUL", ref.buf);
 
-	if (next && *next)
-		die("update %s has extra input: %s", ref.buf, next);
+	return next;
 }
 
-static void parse_cmd_create(const char *next)
+static const char *parse_cmd_create(struct strbuf *input, const char *next)
 {
 	struct strbuf ref = STRBUF_INIT;
 	struct strbuf newvalue = STRBUF_INIT;
@@ -158,23 +186,27 @@ static void parse_cmd_create(const char *next)
 
 	update = update_alloc();
 
-	if ((next = parse_first_arg(next, &ref)) != NULL && ref.buf[0])
+	parse_first_arg(input, &next, &ref);
+	if (ref.buf[0])
 		update_store_ref_name(update, ref.buf);
 	else
 		die("create line missing <ref>");
 
-	if ((next = parse_next_arg(next, &newvalue)) != NULL)
+	if (!parse_next_arg(input, &next, &newvalue))
 		update_store_new_sha1(update, newvalue.buf);
 	else
 		die("create %s missing <newvalue>", ref.buf);
+
 	if (is_null_sha1(update->new_sha1))
 		die("create %s given zero new value", ref.buf);
 
-	if (next && *next)
+	if (*next != line_termination)
 		die("create %s has extra input: %s", ref.buf, next);
+
+	return next;
 }
 
-static void parse_cmd_delete(const char *next)
+static const char *parse_cmd_delete(struct strbuf *input, const char *next)
 {
 	struct strbuf ref = STRBUF_INIT;
 	struct strbuf oldvalue = STRBUF_INIT;
@@ -182,23 +214,26 @@ static void parse_cmd_delete(const char *next)
 
 	update = update_alloc();
 
-	if ((next = parse_first_arg(next, &ref)) != NULL && ref.buf[0])
+	parse_first_arg(input, &next, &ref);
+	if (ref.buf[0])
 		update_store_ref_name(update, ref.buf);
 	else
 		die("delete line missing <ref>");
 
-	if ((next = parse_next_arg(next, &oldvalue)) != NULL)
+	if (!parse_next_arg(input, &next, &oldvalue)) {
 		update_store_old_sha1(update, oldvalue.buf);
-	else if(!line_termination)
+		if (update->have_old && is_null_sha1(update->old_sha1))
+			die("delete %s given zero old value", ref.buf);
+	} else if (!line_termination)
 		die("delete %s missing [<oldvalue>] NUL", ref.buf);
-	if (update->have_old && is_null_sha1(update->old_sha1))
-		die("delete %s given zero old value", ref.buf);
 
-	if (next && *next)
+	if (*next != line_termination)
 		die("delete %s has extra input: %s", ref.buf, next);
+
+	return next;
 }
 
-static void parse_cmd_verify(const char *next)
+static const char *parse_cmd_verify(struct strbuf *input, const char *next)
 {
 	struct strbuf ref = STRBUF_INIT;
 	struct strbuf value = STRBUF_INIT;
@@ -206,53 +241,64 @@ static void parse_cmd_verify(const char *next)
 
 	update = update_alloc();
 
-	if ((next = parse_first_arg(next, &ref)) != NULL && ref.buf[0])
+	parse_first_arg(input, &next, &ref);
+	if (ref.buf[0])
 		update_store_ref_name(update, ref.buf);
 	else
 		die("verify line missing <ref>");
 
-	if ((next = parse_next_arg(next, &value)) != NULL) {
+	if (!parse_next_arg(input, &next, &value)) {
 		update_store_old_sha1(update, value.buf);
 		update_store_new_sha1(update, value.buf);
-	} else if(!line_termination)
+	} else if (!line_termination)
 		die("verify %s missing [<oldvalue>] NUL", ref.buf);
 
-	if (next && *next)
+	if (*next != line_termination)
 		die("verify %s has extra input: %s", ref.buf, next);
+
+	return next;
 }
 
-static void parse_cmd_option(const char *next)
+static const char *parse_cmd_option(struct strbuf *input, const char *next)
 {
-	if (!strcmp(next, "no-deref"))
+	if (!strncmp(next, "no-deref", 8) && next[8] == line_termination)
 		update_flags |= REF_NODEREF;
 	else
 		die("option unknown: %s", next);
+	return next + 8;
 }
 
 static void update_refs_stdin(void)
 {
-	struct strbuf cmd = STRBUF_INIT;
+	struct strbuf input = STRBUF_INIT;
+	const char *next;
 
+	if (strbuf_read(&input, 0, 1000) < 0)
+		die_errno("could not read from stdin");
+	next = input.buf;
 	/* Read each line dispatch its command */
-	while (strbuf_getline(&cmd, stdin, line_termination) != EOF)
-		if (!cmd.buf[0])
+	while (next < input.buf + input.len) {
+		if (*next == line_termination)
 			die("empty command in input");
-		else if (isspace(*cmd.buf))
-			die("whitespace before command: %s", cmd.buf);
-		else if (starts_with(cmd.buf, "update "))
-			parse_cmd_update(cmd.buf + 7);
-		else if (starts_with(cmd.buf, "create "))
-			parse_cmd_create(cmd.buf + 7);
-		else if (starts_with(cmd.buf, "delete "))
-			parse_cmd_delete(cmd.buf + 7);
-		else if (starts_with(cmd.buf, "verify "))
-			parse_cmd_verify(cmd.buf + 7);
-		else if (starts_with(cmd.buf, "option "))
-			parse_cmd_option(cmd.buf + 7);
+		else if (isspace(*next))
+			die("whitespace before command: %s", next);
+		else if (starts_with(next, "update "))
+			next = parse_cmd_update(&input, next + 7);
+		else if (starts_with(next, "create "))
+			next = parse_cmd_create(&input, next + 7);
+		else if (starts_with(next, "delete "))
+			next = parse_cmd_delete(&input, next + 7);
+		else if (starts_with(next, "verify "))
+			next = parse_cmd_verify(&input, next + 7);
+		else if (starts_with(next, "option "))
+			next = parse_cmd_option(&input, next + 7);
 		else
-			die("unknown command: %s", cmd.buf);
+			die("unknown command: %s", next);
+
+		next++;
+	}
 
-	strbuf_release(&cmd);
+	strbuf_release(&input);
 }
 
 int cmd_update_ref(int argc, const char **argv, const char *prefix)
-- 
1.9.1
