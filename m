From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 4/6] Add a library function normalize_refname()
Date: Fri,  9 Sep 2011 13:46:16 +0200
Message-ID: <1315568778-3592-5-git-send-email-mhagger@alum.mit.edu>
References: <1315568778-3592-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>, cmn@elego.de,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 09 13:47:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1zXu-0005nF-RK
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 13:46:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933511Ab1IILqp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 07:46:45 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:46253 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758776Ab1IILqm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Sep 2011 07:46:42 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1R1zTa-0002Qy-IH; Fri, 09 Sep 2011 13:42:30 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1315568778-3592-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181052>

Implement check_ref_format() using the new function.  Also use it to
replace collapse_slashes() in check-ref-format.c.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/check-ref-format.c  |   41 ++++-------------
 refs.c                      |  109 +++++++++++++++++++++++++++----------------
 refs.h                      |   24 +++++++---
 t/t1402-check-ref-format.sh |    3 +
 4 files changed, 98 insertions(+), 79 deletions(-)

diff --git a/builtin/check-ref-format.c b/builtin/check-ref-format.c
index c639400..4c202af 100644
--- a/builtin/check-ref-format.c
+++ b/builtin/check-ref-format.c
@@ -11,28 +11,6 @@ static const char builtin_check_ref_format_usage[] =
 "git check-ref-format [--print] [options] <refname>\n"
 "   or: git check-ref-format --branch <branchname-shorthand>";
 
-/*
- * Remove leading slashes and replace each run of adjacent slashes in
- * src with a single slash, and write the result to dst.
- *
- * This function is similar to normalize_path_copy(), but stripped down
- * to meet check_ref_format's simpler needs.
- */
-static void collapse_slashes(char *dst, const char *src)
-{
-	char ch;
-	char prev = '/';
-
-	while ((ch = *src++) != '\0') {
-		if (prev == '/' && ch == prev)
-			continue;
-
-		*dst++ = ch;
-		prev = ch;
-	}
-	*dst = '\0';
-}
-
 static int check_ref_format_branch(const char *arg)
 {
 	struct strbuf sb = STRBUF_INIT;
@@ -45,12 +23,15 @@ static int check_ref_format_branch(const char *arg)
 	return 0;
 }
 
-static void refname_format_print(const char *arg)
+static int check_ref_format_print(const char *arg, int flags)
 {
-	char *refname = xmalloc(strlen(arg) + 1);
+	int refnamelen = strlen(arg) + 1;
+	char *refname = xmalloc(refnamelen);
 
-	collapse_slashes(refname, arg);
+	if (normalize_refname(refname, refnamelen, arg, flags))
+		return 1;
 	printf("%s\n", refname);
+	return 0;
 }
 
 int cmd_check_ref_format(int argc, const char **argv, const char *prefix)
@@ -79,12 +60,8 @@ int cmd_check_ref_format(int argc, const char **argv, const char *prefix)
 	}
 	if (! (i == argc - 1))
 		usage(builtin_check_ref_format_usage);
-
-	if (check_ref_format(argv[i], flags))
-		return 1;
-
 	if (print)
-		refname_format_print(argv[i]);
-
-	return 0;
+		return check_ref_format_print(argv[i], flags);
+	else
+		return !!check_ref_format(argv[i], flags);
 }
diff --git a/refs.c b/refs.c
index a206a4c..372350e 100644
--- a/refs.c
+++ b/refs.c
@@ -872,55 +872,84 @@ static inline int bad_ref_char(int ch)
 	return 0;
 }
 
-int check_ref_format(const char *ref, int flags)
+int normalize_refname(char *dst, int dstlen, const char *ref, int flags)
 {
-	int ch, level, last;
-	const char *cp = ref;
-
-	level = 0;
-	while (1) {
-		while ((ch = *cp++) == '/')
-			; /* tolerate duplicated slashes */
-		if (!ch)
-			/* should not end with slashes */
-			return -1;
+	int ch, last, component_len, component_count = 0;
+	const char *cp = ref, *component;
 
-		/* we are at the beginning of the path component */
-		if (ch == '.')
-			return -1;
-		if (bad_ref_char(ch)) {
-			if ((flags & REFNAME_REFSPEC_PATTERN) && ch == '*' &&
-				(!*cp || *cp == '/'))
-				/* Accept one wildcard as a full refname component. */
-				flags &= ~REFNAME_REFSPEC_PATTERN;
-			else
-				return -1;
-		}
+	ch = *cp;
+	do {
+		while (ch == '/')
+			ch = *++cp; /* tolerate leading and repeated slashes */
 
-		last = ch;
-		/* scan the rest of the path component */
-		while ((ch = *cp++) != 0) {
-			if (bad_ref_char(ch))
-				return -1;
-			if (ch == '/')
-				break;
+		/*
+		 * We are at the start of a path component.  Record
+		 * its start for later reference.  If we are copying
+		 * to dst, use the copy there, because we might be
+		 * overwriting ref; otherwise, use the copy from the
+		 * input string.
+		 */
+		component = dst ? dst : cp;
+		component_len = 0;
+		last = '\0';
+		while (1) {
+			if (ch != 0 && bad_ref_char(ch)) {
+				if ((flags & REFNAME_REFSPEC_PATTERN) &&
+					ch == '*' &&
+					component_len == 0 &&
+					(cp[1] == 0 || cp[1] == '/')) {
+					/* Accept one wildcard as a full refname component. */
+					flags &= ~REFNAME_REFSPEC_PATTERN;
+				} else {
+					/* Illegal character in refname */
+					return -1;
+				}
+			}
 			if (last == '.' && ch == '.')
+				/* Refname must not contain "..". */
 				return -1;
 			if (last == '@' && ch == '{')
+				/* Refname must not contain "@{". */
 				return -1;
+			if (dst) {
+				if (dstlen-- <= 0)
+					/* Output array was too small. */
+					return -1;
+				*dst++ = ch;
+			}
+			if (ch == 0 || ch == '/')
+				break;
+			++component_len;
 			last = ch;
+			ch = *++cp;
 		}
-		level++;
-		if (!ch) {
-			if (ref <= cp - 2 && cp[-2] == '.')
-				return -1;
-			if (level < 2 && !(flags & REFNAME_ALLOW_ONELEVEL))
-				return -1;
-			if (has_extension(ref, ".lock"))
-				return -1;
-			return 0;
-		}
-	}
+
+		/* We are at the end of a path component. */
+		++component_count;
+		if (component_len == 0)
+			/* Either ref was zero length or it ended with slash. */
+			return -1;
+
+		if (component[0] == '.')
+			/* Components must not start with '.'. */
+			return -1;
+	} while (ch != 0);
+
+	if (last == '.')
+		/* Refname must not end with '.'. */
+		return -1;
+	if (component_len >= 5 && !memcmp(&component[component_len - 5], ".lock", 5))
+		/* Refname must not end with ".lock". */
+		return -1;
+	if (!(flags & REFNAME_ALLOW_ONELEVEL) && component_count < 2)
+		/* Refname must have at least two components. */
+		return -1;
+	return 0;
+}
+
+int check_ref_format(const char *ref, int flags)
+{
+	return normalize_refname(NULL, 0, ref, flags);
 }
 
 const char *prettify_refname(const char *name)
diff --git a/refs.h b/refs.h
index b248ce6..8a15f83 100644
--- a/refs.h
+++ b/refs.h
@@ -101,14 +101,24 @@ extern int for_each_reflog(each_ref_fn, void *);
 #define REFNAME_REFSPEC_PATTERN 2
 
 /*
- * Return 0 iff ref has the correct format for a refname according to
- * the rules described in Documentation/git-check-ref-format.txt.  If
- * REFNAME_ALLOW_ONELEVEL is set in flags, then accept one-level
- * reference names.  If REFNAME_REFSPEC_PATTERN is set in flags, then
- * allow a "*" wildcard character in place of one of the name
- * components.
+ * Check that ref is a valid refname according to the rules described
+ * in Documentation/git-check-ref-format.txt and normalize it by
+ * stripping out superfluous "/" characters.  If dst != NULL, write
+ * the normalized refname to dst, which must be an allocated character
+ * array with length dstlen (typically at least as long as ref).  dst
+ * may point at the same memory as ref.  Return 0 iff the refname was
+ * OK and fit into dst.  If REFNAME_ALLOW_ONELEVEL is set in flags,
+ * then accept one-level reference names.  If REFNAME_REFSPEC_PATTERN
+ * is set in flags, then allow a "*" wildcard characters in place of
+ * one of the name components.
  */
-extern int check_ref_format(const char *target, int flags);
+extern int normalize_refname(char *dst, int dstlen, const char *ref, int flags);
+
+/*
+ * Return 0 iff ref has the correct format for a refname.  See
+ * normalize_refname() for details.
+ */
+extern int check_ref_format(const char *ref, int flags);
 
 extern const char *prettify_refname(const char *refname);
 extern char *shorten_unambiguous_ref(const char *ref, int strict);
diff --git a/t/t1402-check-ref-format.sh b/t/t1402-check-ref-format.sh
index 6ac5025..20a7782 100755
--- a/t/t1402-check-ref-format.sh
+++ b/t/t1402-check-ref-format.sh
@@ -39,6 +39,7 @@ invalid_ref 'heads/foo..bar'
 invalid_ref 'heads/foo?bar'
 valid_ref 'foo./bar'
 invalid_ref 'heads/foo.lock'
+invalid_ref 'heads///foo.lock'
 valid_ref 'heads/foo@bar'
 invalid_ref 'heads/v@{ation'
 invalid_ref 'heads/foo\bar'
@@ -152,5 +153,7 @@ invalid_ref_normalized '/foo'
 invalid_ref_normalized 'heads/foo/../bar'
 invalid_ref_normalized 'heads/./foo'
 invalid_ref_normalized 'heads\foo'
+invalid_ref_normalized 'heads/foo.lock'
+invalid_ref_normalized 'heads///foo.lock'
 
 test_done
-- 
1.7.6.8.gd2879
