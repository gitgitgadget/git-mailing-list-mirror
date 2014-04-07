From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 14/27] update-ref.c: extract a new function, parse_next_sha1()
Date: Mon,  7 Apr 2014 15:48:05 +0200
Message-ID: <1396878498-19887-15-git-send-email-mhagger@alum.mit.edu>
References: <1396878498-19887-1-git-send-email-mhagger@alum.mit.edu>
Cc: Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 07 15:49:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WX9vN-0002x0-Qm
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 15:49:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755393AbaDGNtK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2014 09:49:10 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:65446 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755347AbaDGNsw (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Apr 2014 09:48:52 -0400
X-AuditID: 12074412-f79d46d000002e58-56-5342acc3e830
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id AE.DD.11864.3CCA2435; Mon,  7 Apr 2014 09:48:51 -0400 (EDT)
Received: from michael.fritz.box (p5B156B1D.dip0.t-ipconnect.de [91.21.107.29])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s37DmJaL026029
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 7 Apr 2014 09:48:49 -0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1396878498-19887-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsUixO6iqHt4jVOwwcdHkhY710lYdF3pZrJo
	6L3CbDHv7i4mi9sr5jNb/GjpYbb42LmA2YHd4+/7D0weO2fdZfe49PI7m8fHZ8vZPZ717mH0
	uHhJ2ePzJrkA9ihum6TEkrLgzPQ8fbsE7oxVLX9YCpr8K150PWRuYOy172Lk5JAQMJG4tmIW
	K4QtJnHh3nq2LkYuDiGBy4wSbWdmskI4x5gkzh/YxghSxSagK7Gop5kJxBYRUJOY2HaIBaSI
	WeAKo8SVj9tZQBLCAoES7ybPZgOxWQRUJab3ngaL8wq4Shx7844NYp2cxMljk8FWcwLFZxy6
	BbZASMBF4v6aYywTGHkXMDKsYpRLzCnN1c1NzMwpTk3WLU5OzMtLLdI108vNLNFLTSndxAgJ
	PqEdjOtPyh1iFOBgVOLhXXHIMViINbGsuDL3EKMkB5OSKO/zZU7BQnxJ+SmVGYnFGfFFpTmp
	xYcYJTiYlUR4uVYD5XhTEiurUovyYVLSHCxK4rw/F6v7CQmkJ5akZqemFqQWwWRlODiUJHgb
	QRoFi1LTUyvSMnNKENJMHJwgw7mkRIpT81JSixJLSzLiQdERXwyMD5AUD9DeuWB7iwsSc4Gi
	EK2nGBWlxHlLQBICIImM0jy4sbCU8opRHOhLYd4CkCoeYDqC634FNJgJaLChK9jgkkSElFQD
	44HfXx6tmsLBtEJH7ZlidfhOpUe8LF5/1z2NN2vbuXOHY7Lm78utz9snRReUKda+nvufLZmF
	LTXSyc6EI/Sx3LNLUV23mVn9vroLico/PmJU49O5RdpP/d2Hnvg/wpYnN10+mfRA 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245847>

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
 builtin/update-ref.c  | 160 +++++++++++++++++++++++++++++++-------------------
 t/t1400-update-ref.sh |   2 +-
 2 files changed, 99 insertions(+), 63 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index a9eb5fe..c61120f 100644
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
@@ -112,35 +91,94 @@ static char *parse_refname(struct strbuf *input, const char **next)
 }
 
 /*
- * Parse a SP/NUL separator followed by the next SP- or NUL-terminated
- * argument, if any.  If there is an argument, write it to arg, set
- * *next to point at the character terminating the argument, and
+ * The value being parsed is <oldvalue> (as opposed to <newvalue>; the
+ * difference affects which error messages are generated):
+ */
+#define PARSE_SHA1_OLD 0x01
+
+/*
+ * For backwards compatibility, accept an empty string for update's
+ * <newvalue> in binary mode to be equivalent to specifying zeros.
+ */
+#define PARSE_SHA1_ALLOW_EMPTY 0x02
+
+/*
+ * Parse an argument separator followed by the next argument, if any.
+ * If there is an argument, convert it to a SHA-1, write it to sha1,
+ * set *next to point at the character terminating the argument, and
  * return 0.  If there is no argument at all (not even the empty
- * string), return a non-zero result and leave *next unchanged.
+ * string), return 1 and leave *next unchanged.  If the value is
+ * provided but cannot be converted to a SHA-1, die.  flags can
+ * include PARSE_SHA1_OLD and/or PARSE_SHA1_ALLOW_EMPTY.
  */
-static int parse_next_arg(struct strbuf *input, const char **next,
-			  struct strbuf *arg)
+static int parse_next_sha1(struct strbuf *input, const char **next,
+			   unsigned char *sha1,
+			   const char *command, const char *refname,
+			   int flags)
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
+		} else if (flags & PARSE_SHA1_ALLOW_EMPTY) {
+			/* With -z, treat an empty value as all zeros: */
+			hashclr(sha1);
+		} else {
+			/*
+			 * With -z, an empty non-required value means
+			 * unspecified:
+			 */
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
+	die(flags & PARSE_SHA1_OLD ?
+	    "%s %s: invalid <oldvalue>: %s" :
+	    "%s %s: invalid <newvalue>: %s",
+	    command, refname, arg.buf);
+
+ eof:
+	die(flags & PARSE_SHA1_OLD ?
+	    "%s %s missing <oldvalue>" :
+	    "%s %s missing <newvalue>",
+	    command, refname);
 }
 
 
@@ -156,8 +194,6 @@ static int parse_next_arg(struct strbuf *input, const char **next,
 
 static const char *parse_cmd_update(struct strbuf *input, const char *next)
 {
-	struct strbuf newvalue = STRBUF_INIT;
-	struct strbuf oldvalue = STRBUF_INIT;
 	struct ref_update *update;
 
 	update = update_alloc();
@@ -166,24 +202,23 @@ static const char *parse_cmd_update(struct strbuf *input, const char *next)
 	if (!update->ref_name)
 		die("update line missing <ref>");
 
-	if (!parse_next_arg(input, &next, &newvalue))
-		update_store_new_sha1("update", update, newvalue.buf);
-	else
+	if (parse_next_sha1(input, &next, update->new_sha1,
+			    "update", update->ref_name,
+			    PARSE_SHA1_ALLOW_EMPTY))
 		die("update %s missing <newvalue>", update->ref_name);
 
-	if (!parse_next_arg(input, &next, &oldvalue)) {
-		update_store_old_sha1("update", update, oldvalue.buf);
-		if (*next != line_termination)
-			die("update %s has extra input: %s", update->ref_name, next);
-	} else if (!line_termination)
-		die("update %s missing <oldvalue>", update->ref_name);
+	update->have_old = !parse_next_sha1(input, &next, update->old_sha1,
+					    "update", update->ref_name,
+					    PARSE_SHA1_OLD);
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
@@ -192,9 +227,8 @@ static const char *parse_cmd_create(struct strbuf *input, const char *next)
 	if (!update->ref_name)
 		die("create line missing <ref>");
 
-	if (!parse_next_arg(input, &next, &newvalue))
-		update_store_new_sha1("create", update, newvalue.buf);
-	else
+	if (parse_next_sha1(input, &next, update->new_sha1,
+			    "create", update->ref_name, 0))
 		die("create %s missing <newvalue>", update->ref_name);
 
 	if (is_null_sha1(update->new_sha1))
@@ -208,7 +242,6 @@ static const char *parse_cmd_create(struct strbuf *input, const char *next)
 
 static const char *parse_cmd_delete(struct strbuf *input, const char *next)
 {
-	struct strbuf oldvalue = STRBUF_INIT;
 	struct ref_update *update;
 
 	update = update_alloc();
@@ -217,12 +250,14 @@ static const char *parse_cmd_delete(struct strbuf *input, const char *next)
 	if (!update->ref_name)
 		die("delete line missing <ref>");
 
-	if (!parse_next_arg(input, &next, &oldvalue)) {
-		update_store_old_sha1("delete", update, oldvalue.buf);
-		if (update->have_old && is_null_sha1(update->old_sha1))
+	if (parse_next_sha1(input, &next, update->old_sha1,
+			    "delete", update->ref_name, PARSE_SHA1_OLD)) {
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
@@ -232,7 +267,6 @@ static const char *parse_cmd_delete(struct strbuf *input, const char *next)
 
 static const char *parse_cmd_verify(struct strbuf *input, const char *next)
 {
-	struct strbuf value = STRBUF_INIT;
 	struct ref_update *update;
 
 	update = update_alloc();
@@ -241,11 +275,13 @@ static const char *parse_cmd_verify(struct strbuf *input, const char *next)
 	if (!update->ref_name)
 		die("verify line missing <ref>");
 
-	if (!parse_next_arg(input, &next, &value)) {
-		update_store_old_sha1("verify", update, value.buf);
+	if (parse_next_sha1(input, &next, update->old_sha1,
+			    "verify", update->ref_name, PARSE_SHA1_OLD)) {
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
index 208f56e..15f5bfd 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -858,7 +858,7 @@ test_expect_success 'stdin -z create ref fails with bad new value' '
 	test_must_fail git rev-parse --verify -q $c
 '
 
-test_expect_failure 'stdin -z create ref fails with empty new value' '
+test_expect_success 'stdin -z create ref fails with empty new value' '
 	printf $F "create $c" "" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
 	grep "fatal: create $c missing <newvalue>" err &&
-- 
1.9.1
