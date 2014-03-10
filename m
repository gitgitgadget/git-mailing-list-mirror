From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 14/26] update-ref.c: Extract a new function, parse_next_sha1()
Date: Mon, 10 Mar 2014 13:46:31 +0100
Message-ID: <1394455603-2968-15-git-send-email-mhagger@alum.mit.edu>
References: <1394455603-2968-1-git-send-email-mhagger@alum.mit.edu>
Cc: Brad King <brad.king@kitware.com>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 10 13:48:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WMzd0-0008WT-Cd
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 13:48:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753638AbaCJMsP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 08:48:15 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:59259 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753555AbaCJMrR (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Mar 2014 08:47:17 -0400
X-AuditID: 12074413-f79076d000002d17-43-531db454ffa2
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 78.96.11543.454BD135; Mon, 10 Mar 2014 08:47:16 -0400 (EDT)
Received: from michael.fritz.box (p57A2497B.dip0.t-ipconnect.de [87.162.73.123])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2ACkjwc025479
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 10 Mar 2014 08:47:15 -0400
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1394455603-2968-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPIsWRmVeSWpSXmKPExsUixO6iqBuyRTbY4OQsU4ud6yQsuq50M1k0
	9F5htph3dxeTxe0V85ktfrT0MFt87FzA7MDu8ff9ByaPnbPusntcevmdzePjs+XsHs969zB6
	XLyk7PF5k1wAexS3TVJiSVlwZnqevl0Cd8b6nT+YC9Z4Vnx8upupgfGqVRcjJ4eEgInEvf3H
	mCFsMYkL99azdTFycQgJXGaUOHGogQUkISRwgkni+po8EJtNQFdiUU8zE4gtIqAmMbHtEAtI
	A7PAFUaJz19/sXcxcnAIC/hJHHnmCFLDIqAqsbH7P9gcXgEXiZuT3zBBLJOTmPJ7ATuIzQkU
	n37lATvELmeJl3uaWScw8i5gZFjFKJeYU5qrm5uYmVOcmqxbnJyYl5dapGuul5tZopeaUrqJ
	ERJ4wjsYd52UO8QowMGoxMN74K1MsBBrYllxZe4hRkkOJiVR3olrZYOF+JLyUyozEosz4otK
	c1KLDzFKcDArifBmLgbK8aYkVlalFuXDpKQ5WJTEedWWqPsJCaQnlqRmp6YWpBbBZGU4OJQk
	eA9vBmoULEpNT61Iy8wpQUgzcXCCDOeSEilOzUtJLUosLcmIB0VGfDEwNkBSPEB7t4G08xYX
	JOYCRSFaTzEqSonzzgFJCIAkMkrz4MbC0skrRnGgL4V5W0GqeICpCK77FdBgJqDBzcelQAaX
	JCKkpBoYmw3X/lFxeHX3d3ZJbKmYZc1RjvA5S71ifUqq3oWlPJTuOvs43HRJ23cRl5th9xtu
	3foov8Z/912ln0nzvqWbmeSujw3MDfL7F5txVuPrRTWm7e3HPym1fnBas4/p0leB 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243749>

Replace three functions, update_store_new_sha1(),
update_store_old_sha1(), and parse_next_arg(), with a single function,
parse_next_sha1().  The new function takes care of a whole argument,
including checking whether it is there, converting it to an SHA-1, and
emitting errors on EOF or for invalid values.  The return value
indicates whether the argument was present or absent, which requires
a bit of intelligence because absent values are represented
differently depending on whether "-z" was used.

The new interface means that the calling functions, parse_cmd_*(),
don't have to interpret the result differently based on the
line_termination mode that is in effect.  It also means that
parse_cmd_create() can distinguish unambiguously between an empty new
value and a zeros new value, which fixes a failure in t1400.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/update-ref.c  | 138 +++++++++++++++++++++++++++-----------------------
 t/t1400-update-ref.sh |   2 +-
 2 files changed, 77 insertions(+), 63 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index a9eb5fe..5937291 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -35,27 +35,6 @@ static struct ref_update *update_alloc(void)
 	return update;
 }
 
-static void update_store_new_sha1(const char *command,
-				  struct ref_update *update,
-				  const char *newvalue)
-{
-	if (*newvalue && get_sha1(newvalue, update->new_sha1))
-		die("%s %s: invalid <newvalue>: %s",
-		    command, update->ref_name, newvalue);
-}
-
-static void update_store_old_sha1(const char *command,
-				  struct ref_update *update,
-				  const char *oldvalue)
-{
-	if (*oldvalue && get_sha1(oldvalue, update->old_sha1))
-		die("%s %s: invalid <oldvalue>: %s",
-		    command, update->ref_name, oldvalue);
-
-	/* We have an old value if non-empty, or if empty without -z */
-	update->have_old = *oldvalue || line_termination;
-}
-
 /*
  * Parse one whitespace- or NUL-terminated, possibly C-quoted argument
  * and append the result to arg.  Return a pointer to the terminator.
@@ -112,35 +91,74 @@ static char *parse_refname(struct strbuf *input, const char **next)
 }
 
 /*
- * Parse a SP/NUL separator followed by the next SP- or NUL-terminated
- * argument, if any.  If there is an argument, write it to arg, set
- * *next to point at the character terminating the argument, and
+ * Parse an argument separator followed by the next argument, if any.
+ * If there is an argument, convert it to a SHA-1, write it to sha1,
+ * set *next to point at the character terminating the argument, and
  * return 0.  If there is no argument at all (not even the empty
- * string), return a non-zero result and leave *next unchanged.
+ * string), return 1 and leave *next unchanged.  If the value is
+ * provided but cannot be converted to a SHA-1, die.
  */
-static int parse_next_arg(struct strbuf *input, const char **next,
-			  struct strbuf *arg)
+static int parse_next_sha1(struct strbuf *input, const char **next,
+			   unsigned char *sha1,
+			   const char *command, const char *refname, int old)
 {
-	strbuf_reset(arg);
+	struct strbuf arg = STRBUF_INIT;
+	int ret = 0;
+
+	if (*next == input->buf + input->len)
+		goto eof;
+
 	if (line_termination) {
 		/* Without -z, consume SP and use next argument */
 		if (!**next || **next == line_termination)
-			return -1;
+			return 1;
 		if (**next != ' ')
-			die("expected SP but got: %s", *next);
+			die("%s %s: expected SP but got: %s",
+			    command, refname, *next);
 		(*next)++;
-		*next = parse_arg(*next, arg);
+		*next = parse_arg(*next, &arg);
+		if (arg.len) {
+			if (get_sha1(arg.buf, sha1))
+				goto invalid;
+		} else {
+			/* Without -z, an empty value means all zeros: */
+			hashclr(sha1);
+		}
 	} else {
 		/* With -z, read the next NUL-terminated line */
 		if (**next)
-			die("expected NUL but got: %s", *next);
+			die("%s %s: expected NUL but got: %s",
+			    command, refname, *next);
 		(*next)++;
 		if (*next == input->buf + input->len)
-			return -1;
-		strbuf_addstr(arg, *next);
-		*next += arg->len;
+			goto eof;
+		strbuf_addstr(&arg, *next);
+		*next += arg.len;
+
+		if (arg.len) {
+			if (get_sha1(arg.buf, sha1))
+				goto invalid;
+		} else {
+			/* With -z, an empty value means unspecified: */
+			ret = 1;
+		}
 	}
-	return 0;
+
+	strbuf_release(&arg);
+
+	return ret;
+
+ invalid:
+	die(old ?
+	    "%s %s: invalid <oldvalue>: %s" :
+	    "%s %s: invalid <newvalue>: %s",
+	    command, refname, arg.buf);
+
+ eof:
+	die(old ?
+	    "%s %s missing <oldvalue>" :
+	    "%s %s missing <newvalue>",
+	    command, refname);
 }
 
 
@@ -156,8 +174,6 @@ static int parse_next_arg(struct strbuf *input, const char **next,
 
 static const char *parse_cmd_update(struct strbuf *input, const char *next)
 {
-	struct strbuf newvalue = STRBUF_INIT;
-	struct strbuf oldvalue = STRBUF_INIT;
 	struct ref_update *update;
 
 	update = update_alloc();
@@ -166,24 +182,21 @@ static const char *parse_cmd_update(struct strbuf *input, const char *next)
 	if (!update->ref_name)
 		die("update line missing <ref>");
 
-	if (!parse_next_arg(input, &next, &newvalue))
-		update_store_new_sha1("update", update, newvalue.buf);
-	else
+	if (parse_next_sha1(input, &next, update->new_sha1,
+			    "update", update->ref_name, 0))
 		die("update %s missing <newvalue>", update->ref_name);
 
-	if (!parse_next_arg(input, &next, &oldvalue)) {
-		update_store_old_sha1("update", update, oldvalue.buf);
-		if (*next != line_termination)
-			die("update %s has extra input: %s", update->ref_name, next);
-	} else if (!line_termination)
-		die("update %s missing <oldvalue>", update->ref_name);
+	update->have_old = !parse_next_sha1(input, &next, update->old_sha1,
+					    "update", update->ref_name, 1);
+
+	if (*next != line_termination)
+		die("update %s has extra input: %s", update->ref_name, next);
 
 	return next;
 }
 
 static const char *parse_cmd_create(struct strbuf *input, const char *next)
 {
-	struct strbuf newvalue = STRBUF_INIT;
 	struct ref_update *update;
 
 	update = update_alloc();
@@ -192,9 +205,8 @@ static const char *parse_cmd_create(struct strbuf *input, const char *next)
 	if (!update->ref_name)
 		die("create line missing <ref>");
 
-	if (!parse_next_arg(input, &next, &newvalue))
-		update_store_new_sha1("create", update, newvalue.buf);
-	else
+	if (parse_next_sha1(input, &next, update->new_sha1,
+			    "create", update->ref_name, 0))
 		die("create %s missing <newvalue>", update->ref_name);
 
 	if (is_null_sha1(update->new_sha1))
@@ -208,7 +220,6 @@ static const char *parse_cmd_create(struct strbuf *input, const char *next)
 
 static const char *parse_cmd_delete(struct strbuf *input, const char *next)
 {
-	struct strbuf oldvalue = STRBUF_INIT;
 	struct ref_update *update;
 
 	update = update_alloc();
@@ -217,12 +228,14 @@ static const char *parse_cmd_delete(struct strbuf *input, const char *next)
 	if (!update->ref_name)
 		die("delete line missing <ref>");
 
-	if (!parse_next_arg(input, &next, &oldvalue)) {
-		update_store_old_sha1("delete", update, oldvalue.buf);
-		if (update->have_old && is_null_sha1(update->old_sha1))
+	if (parse_next_sha1(input, &next, update->old_sha1,
+			    "delete", update->ref_name, 1)) {
+		update->have_old = 0;
+	} else {
+		if (is_null_sha1(update->old_sha1))
 			die("delete %s given zero <oldvalue>", update->ref_name);
-	} else if (!line_termination)
-		die("delete %s missing <oldvalue>", update->ref_name);
+		update->have_old = 1;
+	}
 
 	if (*next != line_termination)
 		die("delete %s has extra input: %s", update->ref_name, next);
@@ -232,7 +245,6 @@ static const char *parse_cmd_delete(struct strbuf *input, const char *next)
 
 static const char *parse_cmd_verify(struct strbuf *input, const char *next)
 {
-	struct strbuf value = STRBUF_INIT;
 	struct ref_update *update;
 
 	update = update_alloc();
@@ -241,11 +253,13 @@ static const char *parse_cmd_verify(struct strbuf *input, const char *next)
 	if (!update->ref_name)
 		die("verify line missing <ref>");
 
-	if (!parse_next_arg(input, &next, &value)) {
-		update_store_old_sha1("verify", update, value.buf);
+	if (parse_next_sha1(input, &next, update->old_sha1,
+			    "verify", update->ref_name, 1)) {
+		update->have_old = 0;
+	} else {
 		hashcpy(update->new_sha1, update->old_sha1);
-	} else if (!line_termination)
-		die("verify %s missing <oldvalue>", update->ref_name);
+		update->have_old = 1;
+	}
 
 	if (*next != line_termination)
 		die("verify %s has extra input: %s", update->ref_name, next);
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 42fec4e..7332753 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -851,7 +851,7 @@ test_expect_success 'stdin -z create ref fails with bad new value' '
 	test_must_fail git rev-parse --verify -q $c
 '
 
-test_expect_failure 'stdin -z create ref fails with empty new value' '
+test_expect_success 'stdin -z create ref fails with empty new value' '
 	printf $F "create $c" "" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
 	grep "fatal: create $c missing <newvalue>" err &&
-- 
1.9.0
