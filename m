From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 08/26] update-ref --stdin: Read the whole input at once
Date: Mon, 10 Mar 2014 13:46:25 +0100
Message-ID: <1394455603-2968-9-git-send-email-mhagger@alum.mit.edu>
References: <1394455603-2968-1-git-send-email-mhagger@alum.mit.edu>
Cc: Brad King <brad.king@kitware.com>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 10 13:47:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WMzbu-0007N0-7U
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 13:47:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753548AbaCJMrJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 08:47:09 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:63693 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753538AbaCJMrF (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Mar 2014 08:47:05 -0400
X-AuditID: 12074414-f79d96d000002d2b-89-531db448503a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id C2.CF.11563.844BD135; Mon, 10 Mar 2014 08:47:04 -0400 (EDT)
Received: from michael.fritz.box (p57A2497B.dip0.t-ipconnect.de [87.162.73.123])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2ACkjwW025479
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 10 Mar 2014 08:47:03 -0400
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1394455603-2968-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPIsWRmVeSWpSXmKPExsUixO6iqOuxRTbY4Gi3pcXOdRIWXVe6mSwa
	eq8wW8y7u4vJ4vaK+cwWP1p6mC0+di5gdmD3+Pv+A5PHzll32T0uvfzO5vHx2XJ2j2e9exg9
	Ll5S9vi8SS6APYrbJimxpCw4Mz1P3y6BO2PTyhfsBVP9Kvp7ZzA1MB6162Lk4JAQMJH415zY
	xcgJZIpJXLi3nq2LkYtDSOAyo8SzG5tYIJwTTBKr+w4xgVSxCehKLOppBrNFBNQkJrYdAiti
	FrjCKPH56y92kISwgLvEs93rwWwWAVWJvw2HWEG28Qo4S/zfGgaxTU5iyu8FYCWcAi4S0688
	ALOFgEpe7mlmncDIu4CRYRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRroVebmaJXmpK6SZGSOCJ
	7GA8clLuEKMAB6MSD2/Ga5lgIdbEsuLK3EOMkhxMSqK8E9fKBgvxJeWnVGYkFmfEF5XmpBYf
	YpTgYFYS4c1cDJTjTUmsrEotyodJSXOwKInzflus7ickkJ5YkpqdmlqQWgSTleHgUJLgrd8M
	1ChYlJqeWpGWmVOCkGbi4AQZziUlUpyal5JalFhakhEPioz4YmBsgKR4gPZuA2nnLS5IzAWK
	QrSeYlSUEuedA5IQAElklObBjYWlk1eM4kBfCvO2glTxAFMRXPcroMFMQIObj0uBDC5JREhJ
	NTAaPuNjq2epXml/y++Twq942Qd+Waf2TtULl1qq1h6V80ZIz7LXeqPLk79h35oOPZc68d6g
	aJbjJZWZU2cunxkiVHhx/2HZ1yreaX/V335p2qQTo/P31pp7qhandoQz82XMOREl 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243735>

Decouple the parsing code from the input source (the old parsing code
had to read new data even in the middle of commands).  This might also
be a tad faster, but that is inconsequential.  Add docstrings for the
parsing functions.

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
1.9.0
